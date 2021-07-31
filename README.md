# LINK SHORTENER

This Ruby on Rails application shortens long URLs and redirects users to the original URL when shortened URLs are visited.

## System Dependencies

* Ruby 3.0.2

* Rails 6.1.x

* Postgres 13.x

* Yarn 1.22.x

## Configuration

Database configurations are in `config/database.yml`
To use the same settings, following SQL queries can be run:

```SQL
CREATE DATABASE link_shortener;
CREATE USER link_shortener WITH ENCRYPTED PASSWORD 'link_shortener';
ALTER ROLE link_shortener WITH CREATEDB;
CREATE DATABASE link_shortener_test;
GRANT ALL PRIVILEGES ON DATABASE link_shortener TO link_shortener;
GRANT ALL PRIVILEGES ON DATABASE link_shortener_test TO link_shortener;
ALTER DATABASE link_shortener_test OWNER TO link_shortener;
```

## Test Procedure

Unit tests are implemented with RSpec. To run all the tests at once,

`$ rspec`

