module TudeTester
  class Step < ApplicationRecord
    INDENT = " " * 6
    has_many :scenario_steps, class_name: "TudeTester::ScenarioStep", foreign_key: "tude_tester_step_id"
    has_many :scenarios, through: :scenario_steps
  end
end
