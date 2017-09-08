# bank_rack_api

## Getting started

This project uses bundler

```ruby
gem install bundler
```
Then run `bundle install`

Create a config/database.yml file (there is an example at config folder)

Next, run this task to set things up:

```console
$ rake db:prepare
```

This will run all migrations and populate the database with one test user.