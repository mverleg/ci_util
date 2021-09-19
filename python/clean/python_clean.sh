#!/usr/bin/env sh

if ! find . -mindepth 1 -maxdepth 1 | read; then
   printf 'error: did not find any files\n' 1>&2
   printf 'make sure to mount or copy your workspace into the /code directory\n' 1>&2
   exit 1
fi

if [ -d .git ]; then
    if [ -n "$(git status --porcelain)" ]; then
        printf 'error: git working directory not clean\n' 1>&2
        printf 'to not mix functional and style changes, it is necessary to make sure your local changes are committed (or stashed) in git\n' 1>&2
        exit 1
    fi
else
   printf 'git not detected; not checking for pending changes\n' 1>&2
fi

printf '\n\033[0;35mSTEP 1: tabs to spaces\033[0m\n\n'
find . -name '*.py' ! -type d -exec bash -c 'expand --initial --tabs 4 "$0" > /reindent.tmp; if ! cmp --silent "$0" /reindent.tmp ; then printf "$0\n"; mv /reindent.tmp "$0"; fi' {} \;

printf '\n\033[0;35mSTEP 2: black formatting\033[0m\n\n'
black .

printf '\n\033[0;35mSTEP 3: isort import sorting\033[0m\n\n'
isort .

printf '\n\033[0;35mSTEP 4: autopep8 fix some lint issues\033[0m\n\n'
autopep8 --in-place --aggressive --aggressive --max-line-length 120 --recursive .

printf '\n\033[0;35mSTEP 5: flake8 linting\033[0m\n\n'
flake8 --max-line-length 120 .
status=$?

if [ "$status" -eq "0" ]; then
    if [ -d .git ]; then
        if [ -n "$(git status --porcelain)" ]; then
            printf '\n\033[0;35mcommitting\033[0m\n'
            git add :/ --all
            git commit -m 'Automatic reformatting & linting\n\nExecuted black, isort, autopep8 and flake8 using mverleg/python_clean docker image'
            printf '\n\033[0;35mall done\033[0m, check the commit\n'
        else
            printf '\n\033[0;35mall done\033[0m, no changes\n'
        fi
    else
        printf '\n\033[0;35mall done\033[0m, not committing because git is not found\n'
    fi
    exit 0
else
    printf '\n\033[0;35mall done\033[0m, but there are issues remaining that have to be fixed by hand\n'
    exit 1
fi

