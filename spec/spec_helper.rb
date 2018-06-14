require_relative('./test_helpers')

RSpec.configure do |config|
  config.color = true
  config.include TestHelpers
end
