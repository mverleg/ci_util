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

printf '\n\033[0;35mSTEP 1: black formatting\033[0m\n\n'
black .

printf '\n\033[0;35mSTEP 2: isort import sorting\033[0m\n\n'
isort .

printf '\n\033[0;35mSTEP 3: flake8 linting\033[0m\n\n'
flake8 .

if [ -d .git ] && [ -n "$(git status --porcelain)" ]; then
    printf '\n\033[0;35mall done\033[0m, do not forget to commit\n'
else
    printf '\n\033[0;35mall done\033[0m\n'
fi

