## AdMatcher
Ruby Grape application for REST API with ActiveRecord, RSpec, Swagger
### Description:
The application mathes statuses.
### Dependencies:
- Ruby 2.4.2
- PostgreSQL

### Installation:

###  Using Docker:
To run application on docker:

- Please install Docker and Docker-Compose
- Clone the project

- To create the database.yml please run  the following script on the project root:
```shell
$ cp config/database.yml.sample config/database.yml
```
- Run following commands on the project root:

```shell
$ docker-compose build
$ docker-compose up

# Open another terminal and run:
$ docker-compose run web bundle exec rake db:create db:migrate
```

##### Tests:

To execute tests, run following commands:
 
```shell
 $ docker-compose run web bundle exec rake db:migrate RACK_ENV=test #(the first time only)
 $ docker-compose run web bundle exec rspec
```
### Regular Installation:
- Clone poject
- Run bundler:

 ```shell
 $ bundle install
 ```
Create database.yml:
```shell
$ cp config/database.yml.sample config/database.yml
```
##### Important: 
Before the next step please change the host value in config/database.yml from `db` to `your_host_url`
- Create database and run migrations:

 ```shell
 $ bundle exec rake db:create db:migrate
 ```
 
- Run application:

 ```shell
 $ rackup -p 3000
 ```

##### Tests:

To execute tests, run following commands:
 
```shell
 $ bundle exec rake db:migrate RACK_ENV=test #(the first time only)
 $ bundle exec rspec
```
### Swagger Documentation

Enter the root application address in the browser:

```shell
http://localhost:3000
```

### License

The software is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
