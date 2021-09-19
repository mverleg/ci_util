
# Python clean

Format and lint Python code without installing packages, by simply running this Docker image:

    docker run --rm -v "$(pwd):/code" -it mverleg/python_clean 

Uses:

* `expand` to replace tabs by 4 spaces
* `black` for formatting
* `isort` for organizing dependencies
* `autopep8` to fix some pep8 issues
* `flake8` to find (but no fix) potential problems

