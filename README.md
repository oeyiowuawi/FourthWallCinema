## Introduction 
Wanna get the latest details about the Fast and Furious franchise?I bet you do. You can get all the information you need here.
​

## Getting Started

To run this application locally, you will need to either clone this repository or fork it. You can also download the entire repository as a zip package and run locally.

## Features

You can get the details about a fast and furious movie. You can leave a review. You can check the showtimes and prices. If you are an admin, you can update prices and showtimes

For an admin, you need to create an account and you need to sign in and you will get a JSON Web Token.
This token is used to authenticate subsequent requests to the API.

## API EndPoints

The following endpoints are available

| EndPoint                                           |   Functionality                                 |
| ---------------------------------------            |------------------------------------------------:|
| PUT /admin/movies/:movie_id/show_times/:id         | update show times and prices                    |
| POST /admin/sessions                               | Logs a user in                                  |
| POST /customer/v1/movies/:movie_id/reviews         | Creates a review                                |
| GET /customer/v1/movies                            | Lists all available movies and their showtimes  |
| GET /customer/v1/movies/:id                        | Get movie detail                                |

## Dependencies

This application runs on Rails which is a Ruby powered framework built to make developing web applications faster. If you intend to run this application locally, you must make sure you have the following installed:

* [Install Ruby](http://www.ruby-lang.org)
* [Install Rails](http://rubyonrails.org)
* [Install Rails API](https://github.com/rails-api/rails-api)
* [Install RubyGems](https://rubygems.org/pages/download)
* [Install Bundler](http://bundler.io/)

That should get you all set up for running locally. If you run into any issues installing any of the above, your safest bet is to google it as there is already a solution online.

Once you have a copy of this project and it's dependencies installed, you are good to go. run `bundle install` to install all the required external dependencies.

## Database Setup

Run the following command from the terminal:
```
rake db:create db:migrate
```
Create the database for the test environment as well:
```
rake db:create db:migrate RAILS_ENV=test
```

## Running the tests

Run the following command from the terminal to get all tests running
```
rspec spec
```


## API Documentation

The full documentation for the API and all available endpoints is explained [here](http://e-list.herokuapp.com)
