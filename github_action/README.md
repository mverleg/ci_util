# Github actions

These are reusable Github Actions that can be used in other projects, either manually or automatically.

* `test-lint.yml`

  * Run all unit tests
  * Clippy linting
  * Rustfmt validation

* `bump-dependencies.yml`

  * Updates Dockerfiles and Cargo dependencies.
  * Self-updates to get newest version.
  * Creates a pull request to test and merge the updates.

* `check-dependencies.yml` / `.Dockerfile`

  * Validate licenses
  * Check security warnings
  * Reject duplicate deps with different versions
  * ...more to come

