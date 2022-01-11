# Github actions

These are reusable Github Actions that can be used in other projects, either manually or automatically.

* `bump-dependencies.yml`

  * Updates Dockerfiles and Cargo dependencies.
  * Self-updates to get newest version.
  * Creates a pull request to test and merge the updates.

* `check-dependencies.yml` / `.Dockerfile`

  * Validate licenses
  * Check security warnings
  * ...more to come

