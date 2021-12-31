set :environment, :production
set :output, {:error => "log/cronerror.log", :standard => "log/cron.log"}
# ENV['DISPLAY'] = ":0"
# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

every :day, at: '12:20am', roles: [:batch] do
  begin
    rake 'scraper:scrap_flights'
  rescue StandardError => e
    Rails.logger.error("aborted rake task")
    raise e
  end
end
