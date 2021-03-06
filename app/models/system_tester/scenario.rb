module SystemTester
  class Scenario < ApplicationRecord
    include SystemTester::TitleValidatable
    validates_uniqueness_of :title, scope: :system_tester_feature_id

    INDENT = " " * 4
    belongs_to :feature, class_name: "SystemTester::Feature", foreign_key: "system_tester_feature_id"
    has_many :scenario_steps,
             -> { order 'position asc' },
             class_name: "SystemTester::ScenarioStep",
             foreign_key: "system_tester_scenario_id",
             dependent: :destroy
    has_many :steps, -> { order 'position asc' }, through: :scenario_steps

    after_commit do
      feature.touch if feature.present?
    end

    def to_s
      str = ""
      str << open
      str << steps.map(&:to_s).join("")
      str << close
      str
    end

    def line_number
      lines = feature.to_s.split("\n")
      lines.index { |line| open.chomp === line } + 1
    end
  
    private
    
    def open
      "#{INDENT}test \"#{title}\" do\n"
    end

    def close
      "#{INDENT}end\n"
    end
  end
end
