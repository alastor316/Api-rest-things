rake db:migrate && rm schema.rb && rake db:drop && rake db:setup || true  && rake db:migrate  && rake db:setup