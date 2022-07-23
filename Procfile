web: bundle exec rails server -p $PORT
release: bundle exec rails db:migrate
worker: QUEUE=* bundle exec rake environment resque:work
