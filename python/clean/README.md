
# Python clean

Format and lint Python code without installing packages, by simply running this Docker image:

    docker run --rm -v "$(pwd):/code" -it mverleg/python_clean 

Uses:

* `black` for formatting
* `isort` for organizing dependencies
* `flake8` to find potential problems (which you will usually have to resolve yourself)

