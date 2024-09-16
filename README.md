# README
## How to run

To run the project, you will need first to build the image with

```
docker build -f dev.Dockerfile -t app .
```

Once it finishes, it is possible to run it using

```
docker run -p 3000:3000 -v $(pwd):/rails app
```

The following endpoints will now be available through `localhost:3000`:

* Users endpoints (GET)
    * `/users`
    * `/users/:id`
    * `/users/import`
* Teams endpoints (GET)
    * `/teams`
    * `/teams/:id`
    * `/teams/import`
* Roles endpoints (GET/POST)
    * `/roles (params: name)`
* Enrollments endpoints (GET/POST)
    * `/enrollments`
    * `/enrollments/find (params: user_id, team_id)`
    * `/enrollments (params: user_id, team_id, role_id)`

## Considerations on the approach

I chose to keep it as simple as possible, so I want to start by highlighting what I would change/add to the solution I proposed in this project.

To begin with, as I stated in the routes section of the code, I wouldn't have a GET request to import the users/teams. In order to do that, a complete approach would be to have the `UserFetcher` and `TeamFetcher` services running through some kind of cron job, which would run once a day, once a week, or any frequency that would be fit to the scenario. This would solve the problem of a final user being able to spam a request to the endpoint, which could be a disaster if the number of users returned is too large.

Another point of change would be in the specs, where I could add some factories for the models I created. I also could add VCR for the external requests so we can test the controllers with data that is more close to what we want to get as response in the Service methods. I would also add a DatabaseCleaner.

Finally, another thing you can see in this project as well is the fact that I simply used `rails new` and kept basically everything. In a real project, I would remove all the unnecessary stuff like mailers, assets, etc.

## Considerations on the external endpoints

The first thing I noticed is the fact that there is no pattern in the endpoints for the same models, for instance, the `users` data are different between the `index` and `show` endpoints. So the first thing I would change is to return the same data in both, so if an user have `id`, `firstname` and `lastname`, the endpoints should both have these.

The same thing I noticed for the `teams` endpoints, so I would do the same there.

For those endpoints, this change shouldn't be an issue since both have only a few fields to return, so it wouldn't cause performance problems.