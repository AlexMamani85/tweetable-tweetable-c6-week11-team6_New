Every single required task have been sucessfully implemented, with the only exception of fully testing every API endpoint through Rspec. However, all API endpoints have, in fact, been tested through Insomnia, and thus, its collection has been included.


### Good to know: 

Instead of doing `has_many` associations between tweets & likes and users & likes, we went for a `has_many_through` association, as in, a tweet has many users (that have liked it) through "like model" and a user has many tweets (that he/she has liked) through "like model". So, in order to avoid a conflict in `user.tweets` (tweets created by user / tweets liked by user), we used a `class_name` for the tweets authored by a user and "renamed" it to `user.tweets_created`. 

To sum things up, our models associations allows to do:

- `user.tweets_created` for tweets created by user
- `user.tweets` for tweets liked by a user
- `user.likes` for likes given by a user (like model)
- `tweet.likes` for likes given to a tweet (like model)
- `tweet.user` for a tweets' author
- `tweet.users` for users that have liked a tweet

Also, authentication for the API has been implemented through `bcrypt`, although we have made a lot of *"tweaks"* to get it rolling. We would've liked to implement a `devise`-only solution though.
