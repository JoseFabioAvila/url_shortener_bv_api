# BV URL Shortener API

## Description
This repository contains a URL Shortener API. This API shortens your URL and retrieves the top 100 most visited sites. Developed with Rails 6 with MariaDB, Redis, and Resque. It uses a bootstrapped environment with Docker.


## Docker
- Intial Setup
```
    docker-compose build
    docker-compose run short-app rails db:setup && rails db:migrate
```

- To run the specs
```
    docker-compose -f docker-compose-test.yml run short-app-rspec
```

- To run migrations
```
    docker-compose run short-app rails db:migrate
    docker-compose -f docker-compose-test.yml run short-app-rspec rails db:test:prepare
```

- Run the web server
```
    docker-compose up
```

## Curl

- Adding a URL
```
    curl -X POST -d "full_url=https://google.com" http://localhost:3000/short_urls.json
```

- Getting the top 100
```
    curl localhost:3000
```

- Checking your short URL redirect
```
    curl -I localhost:3000/abc
```