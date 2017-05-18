require 'test_helper'

module TudeTester
  class ScenarioTest < ActiveSupport::TestCase
    test "#to_s" do
      scenario = tude_tester_scenarios(:one)
      assert_equal script_output_basic, scenario.to_s
    end

    private

    def script_output_basic
      <<-EOF
    test "Scenario One" do
      # Action: Click on element
      click_on "element"

      # Action: visit path
      visit path

      # Assertion: assert text
      assert_selector "h1", text: "text"

    end
EOF
    end
  end
end