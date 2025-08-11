## About

This is a take home project that is an educational portal example where Users (students and admins) can login to the portal, view analytica about the portal, purchase and enroll in terms/courses. Each school has many students, terms. Each term has many courses.

## Notes

1) This is a Ruby on Rails application using SQLite as a DB for storage.
2) For authentication the app uses [devise](https://github.com/heartcombo/devise).
3) For authorization the app uses [pundit](https://github.com/varvet/pundit).
4) A combination of vibe coding and real human coding was used to create this app.
5) Due to a time constraints I made a deliberate choice to focus on features and code optimization development, and reduce efforts in writing tests and making UI pretty (the Rails way).
6) The payment processing is mocked in this application and is there only for the purpose of demonstration how such concept could be used.

## Installation

1) Clone this repo.
2) Navigate to `educational_portal` folder.
3) Run `bundle install` to install required packages.
4) Run `bin/rails db:reset` to create development database and seed it.
5) Run `bin/rails server` to start the server.
6) Navigate to the URL that you get as an output of previous command (example, `http://127.0.0.1:3000`).

## Features

There are two separate type of users of the application:
1) Admin - can view dashboard for the portal and see things like how many schools there are, how many courses, terms, and so on.
2) Student - can purchase courses and terms using either credit card method or a license code method. A term purchase automatically allows to enroll in any course of that term. A course purcahse only allows to enroll in that one course.

To login as Admin user use `admin@example.com:password123` combination.
To login as Student use `student1/2/3/4@example.com:password123` combinations.

## TODO list

1) Write more tests.
2) Optimize queries and views to have less DB hits.
3) Improve UI and navigations.
4) Reorganize views to render partials potentially.