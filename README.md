# MyContentful

This is a really cool code test for a really cool company.
## Running the application

```sh
docker-compose up --build
```

[Link to your localhost:3000](http://localhost:3000)

## Database setup

```sh
docker-compose web run rails db:create && rails db:migrate
```

## Running the tests

```sh
docker-compose web run bundle exec rspec
```