require_relative "../lib/snowsafe"

FIXTURE_DIR = File.dirname(__FILE__) + "/fixtures"

require_relative "support/helpers"
require_relative "support/matchers"

RSpec.configure do |config|
  config.include TestHelpers
  config.before do
    clear_fixtures!
  end
end
