# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron


#whenever --update-crontab store
#bundle exec whenever
#crontab -l


#fijarse en la ruta
#set :path,'/home/kai/Escritorio/PHINEAL/phineal'
#set :output, '/home/kai/Escritorio/PHINEAL/phineal/log/cron.log'
#def wrap_with_lockrun command
#{}"/usr/bin/lockrun --lockfile=/tmp/jobname.lockrun -- sh -c "cd /data/appname/current && bundle exec rake RAILS_ENV=production some:task""
#end

#set :output, "./log/cron_log.log"

set :environment, "development"

job_type :sidekiq,  "cd :path && bin/rails runner -e :environment ':task' :output"
#job_type :lockrun_sidekiq, '/usr/bin/lockrun --lockfile=/tmp/jobname.lockrun -- sh -c "cd /home/kai/MEGA/MEGAsync/PHINEAL/phineal && bundle exec rake RAILS_ENV=production :task"'

every 1.minutes do
 # command "/usr/bin/some_great_command"
 
  sidekiq "HardWorker.perform_async"


 #  rake "some:great:rake:task"
end



#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
