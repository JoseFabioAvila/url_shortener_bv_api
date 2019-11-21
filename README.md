# BV URL Shortener API

## Description
This repository contains a URL Shortener API. This API shortens your URL, retrieves the top 100 most visited sites and you can been redirect to them.

## Requirements
It was developed with Rails 6 with MariaDB, Redis, and Resque using a bootstrapped environment with Docker. So, you need to have docker and docker compose on your machine.

First, you have to install Docker and Docker compose. Then you can clone this project and follow the next commands:

- Intial Setup
```
    docker-compose build
    docker-compose run short-app rails db:setup && rails db:migrate
```

Next, in order to have everything ready you have to run the DB migrations by using the following commands:

- To run migrations
```
    docker-compose run short-app rails db:migrate
    docker-compose -f docker-compose-test.yml run short-app-rspec rails db:test:prepare
```

Finally, you can start using the API by running the following command:

```
    docker-compose up
```

If you want to run the specs, you might use the next command:

```
    docker-compose -f docker-compose-test.yml run short-app-rspec
```

If you want to test the API on curl you can do it accesing with the following curl commands

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
## URL Shortening Algorithm

Investigating about the best way to aboard the algorithm, I have found that the best approach is by using th base 62 encoding. It consists on converting a given ID (Type Integer) to base 62 (Type String), which contains characters in the ranges of 'a' to 'z', 'A' to 'Z' and '0' to '9'. So that, in the data base we only store the shortened code that points to that unique ID. 
When a user entered the shortened Url, the API is going to decode this shortened url to find the object on data base by ID resulting. Then, the API will redirects to the full url stored on this object.

Some urls that I have read:
- https://www.kerstner.at/2012/07/shortening-strings-using-base-62-encoding/
- https://www.geeksforgeeks.org/how-to-design-a-tiny-url-or-url-shortener/
- https://medium.com/@harpermaddox/how-to-build-a-custom-url-shortener-5e8b454c58ae

