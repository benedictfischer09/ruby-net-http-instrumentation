Changelog
=========

## 1.3.0 02/21/2020

  * Bump min rubocop to 0.79 and address breaking change ([rubocop-hq/rubocop#7542](https://github.com/rubocop-hq/rubocop/pull/7542)

## 1.2.0 12/03/2019

  * Bump min rubocop to 0.77 and address breaking change ([rubocop-hq/rubocop#7469](https://github.com/rubocop-hq/rubocop/pull/7469))

## 1.1.3 11/25/2019

  * Be more specific regarding dependency versions, as the latest rubocop-rails dependency isn't respecting inheritance
    so we need to stay on version 2.2.x until this is solved (original issue at
    [[rubocop-rails#122](https://github.com/rubocop-hq/rubocop-rails/issues/122)])
  * Update development depencies

## 1.1.2 11/20/2019

  * Publish gem on Nexus, and fetch gems from Nexus

## 1.1.1 07/09/2019
  * Add more cops (Rails, RSpec, performance)

## 1.1.0 07/09/2019
  * Allow use of access modifiers in `concerning` blocks
  * Updates and upgrades

## 1.0.29 02/27/2019
  * Fix gem deployment on CI

## 1.0.28 02/26/2019
  * Adding changelog
  * Release on JFrog using gem-publisher CircleCI Orb
  * Build doc and make it available on CircleCI's build artifacts
  * Run Rubocop on dox-style (inception!)
  * Using standard ci: rake task like other gems
  * Packing gems
  * Adding rspec_junit_formatter
