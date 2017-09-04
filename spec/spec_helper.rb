require 'webmock/rspec'

RSpec.configure do |config|
  config.expose_dsl_globally = false

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Use `focus: true` to run specific tests.
  config.filter_run_when_matching focus: true

  config.example_status_persistence_file_path = "spec/example_statuses.txt"

  config.mock_with :rspec do |mocks|
    # When set to true, partial mocks will be verified the same as object doubles.
    # Any stubs will have their arguments checked against the original method, and
    # methods that do not exist cannot be stubbed.
    mocks.verify_partial_doubles = true

    mocks.syntax = :expect
  end

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
    expectations.on_potential_false_positives = :raise
  end
end
