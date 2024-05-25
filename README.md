# README

This is a dummy Rails 7 project created as a bad example of code to be refactored.

## Setup

```sh
asdf shell ruby 3.3.0
asdf shell nodejs 20.11.0

bundle

yarn

bundle exec rails app:update:bin

bin/rails db:create db:migrate db:seed
```


## Start the project

```sh
bin/dev
```

## Run specs

```sh
bin/rails db:create db:migrate RAILS_ENV=test

bundle exec rspec
```

## Enable cache
```sh
bin/rails dev:cache
```

## Start Redis
```sh
sudo service redis-server start
```
## Sidekiq
```sh
localhost:3000/sidekiq
```
![image](https://github.com/matiasarenhard/ledger/assets/14844393/0f0b2545-4f30-4373-b71d-b1678a85024e)

## Rails Performance
```sh
localhost:3000/rails/performance
```
![image](https://github.com/matiasarenhard/ledger/assets/14844393/95966d27-c2e7-47e6-9abf-b51a997d079e)

## Letters
```sh
localhost:3000/emails
```
![image](https://github.com/matiasarenhard/ledger/assets/14844393/2b74bb8d-06ee-454c-b6a9-2f33c6adc6d8)




