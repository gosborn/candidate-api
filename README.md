# Candidate App

Built with Rails 5.2.0, Ruby 2.4.0. Uses sqlite3.

## Purpose
A simple app demonstrating a Candidate approval API for a job.

/candidates provides full CRUD for the Candidate Model. The database is seeded with a variety of Candidates.

`GET /candidates` can be filtered by `reviewed` status with a query param of `?reviewed=true/false`. Additionally this endpoint can be ordered by any attribute on the model ex: `?order=-year_exp,name` to order by Years Experience descending and Name ascending.

`POST /candidates` is used to create a new candidate. A Candidate may not have more than 50 years of experience.

The editable attributes of a Candidate are:
- name (string)
- years_exp (integer)
- status (string: must be pending/accepted/rejected)
- description (text)

`PUT /candidates/<candidate id>` is used to update and change the status of a Candidate. If the status is changed to `accepted` or `rejected`, the Candidate is marked as `reviewed`. A 'reviewed Candidate' cannot be set back to `pending`.

`DELETE /candates/<candidate id>` to delete a Candidate object.


## Getting started:

This project requires ruby to be installed. If not installed, follow directions at https://www.ruby-lang.org/en/documentation/installation/ to install for your machine.

Bundler is also required. Directions for installation are located at: http://bundler.io/.

Run `bundle install` to install the dependencies for the project.

Run pending migrations and seed the database by running `rake db:setup`.

To start server run `rails s -p <desired port number, defaults to 3000>`
