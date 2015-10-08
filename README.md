#Bucketlist API

This is an API that allows users to create bucketlists and add items to the bucketlists.
It uses Token Based Authentication to ensure security by allowing Users only interact with endpoints they have access to using an auth_token.
This API was built using Ruby on Rails.

#Implementation

The Bucketlist can simply be created using a name and adding items to the bucketlist

|    Endpoint              | Functionality                      | Public Access         |
| -------------            | -------------                      | -------------         |
| POST /auth/login         | Logs a user in                     |        TRUE           |
| GET /auth/logout         | Logs a user out                    |        FALSE          |
| POST /bucketlists/       | Create a new bucket list           |        FALSE          |
| GET /bucketlists/        | List all the created bucket lists  |        TRUE           |
| GET /bucketlists/<id>    | Get single bucket list             |        FALSE          |
| POST /bucketlists/<id>   | Add a new item to this bucket list |        FALSE          |
| PUT /bucketlists/<id>    | Update this bucket list            |        FALSE          |
| DELETE /bucketlists/<id> | Delete this single bucket list     |        FALSE          |

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
#Copyright

Copyright (c) 2015, Daisi Sowemimo, Andela
