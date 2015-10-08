#Bucketlist API

This is an API that allows users to create bucketlists and add items to the bucketlists.
It uses Token Based Authentication to ensure security by allowing Users only interact with endpoints they have access to using an auth_token.
This API was built using Ruby on Rails.

#Implementation

The Bucketlist can simply be created using a name and adding items to the bucketlist.
Below is an example of a Bucketlist and the items it has.
```
{
  bucketlist_id: 3,
  name: "Things I gotta do",
  items: [
  {
    item_id: 8,
    name: "Bungee Jump",
    done: false,
    created_at: "2015-10-05T10:11:59.105Z",
    updated_at: "2015-10-05T10:11:59.131Z",
    bucketlist_id: 3
  },
  {
    item_id: 9,
    name: "Snorkling",
    done: true,
    created_at: "2015-10-05T10:13:31.892Z",
    updated_at: "2015-10-05T10:13:31.910Z",
    bucketlist_id: 3
  }
  ],
  date_created: "2015-10-05T09:38:42.945Z",
  date_modified: "2015-10-05T09:38:42.945Z",
  created_by: "daisi"
}


```

#Authentication

Users are authenticated using an auth_token. This ensures that only authenticated users can interact with non public endpoints.
The table below shows a list of the endpoints and their access restrictions.

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

#Test
All test were written using RSpec
For full details of test coverage visit [Here](http://andela-dsowemimo.github.io/Bucketlist_API_Coverage)

[![Coverage Badge](/coverage/coverage-badge.png)](http://andela-dsowemimo.github.io/Bucketlist_API_Coverage)



#Copyright

Copyright (c) 2015, Daisi Sowemimo, Andela
