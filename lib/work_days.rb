require 'date'

require_relative 'work_days/version'
require_relative 'work_days/calculation_methods'
require_relative 'work_days/holiday_methods'
require_relative 'work_days/work_schedules/default'
require_relative 'work_days/work_schedules/bank'
require_relative 'work_days/ext/date'
require_relative 'work_days/ext/time'
require_relative 'work_days/ext/date_time'
require_relative 'work_days/ext/range'

module WorkDays
  def self.work_schedule=(schedule)
    @work_schedule = schedule
  end

  def self.work_schedule
    @work_schedule ||= WorkDays::WorkSchedules::Default.new
  end

  def self.respond_to_missing?(method_name, include_private = false)
    work_schedule.respond_to?(method_name)
  end

  def self.method_missing(name, *args, &block)
    if work_schedule.respond_to?(name)
      work_schedule.public_send(name, *args, &block)
    else
      super
    end
  end
end
