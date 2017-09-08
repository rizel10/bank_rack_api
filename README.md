# bank_rack_api

## Getting started

This project uses bundler

```ruby
gem install bundler
```
Then run `bundle install`

Create a `config/database.yml` file (there is an example at config folder) and a database for the application

Next, run this task to set things up:

```console
$ rake db:prepare
```

This will run all migrations and populate the database with one test user.

### Navigating through the api

I Used Postman (https://www.getpostman.com/) to navigate and perform tests on the API.

Here is the published Postman [Documentation](https://documenter.getpostman.com/view/630023/bank-rack/6taZ4tG) and [Collection](https://www.getpostman.com/collections/a50aab55b0d7e4196500)

## Pros and Cons
### Pros
* Close to MVC pattern
* Data integrity ensured using database features and Model Validations
* Project is good enough to add functionality (with new models, actions and etc) and/or change behaviour
* API routes are easy and makes sense to the application
* Returned objects are always serialized (good to keep sensitive information only on the server and reduce network traffic)
* Properly used HTTP 1.1 verbs and status codes
### Cons
* Controllers are a bit clogged up
  * Responsability of inexistent objects were delegated to the controllers, which is terrible on OO
  * Hard to understand controllers code
* Pretty sure the API is vulnerable to [timing attacks](https://en.wikipedia.org/wiki/Timing_attack) because auth_token is not securely compared
* Operations list is not paginated and not properly ordered (inverse_of: created_at)
## Overall
The API itself is good (disregarding performance, which I know it's not bad), although some part of the code is messy. I decided to use Sequel as an ORM on this project for the first time and it took more time for me to learn everything I needed then I thought, which left me with not enough time to build everything I wanted the way I planned. Or maybe the structure I planned to built my API upon was more complicated than necessary. Either way, I'm satisfied with the result since it contains a good solution to the problem, and it is not that hard to fix the issues it contains.

