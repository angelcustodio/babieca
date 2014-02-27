![Babieca](https://s3-eu-west-1.amazonaws.com/uploads-eu.hipchat.com/20667/97004/nvXkUGXA0G4zpsS/photo.png)

# Babieca

**Babieca** is a lightweight and lightning fast service that provides a crossplatform resume playback method that can be attached to a current API, website or making requests separatedly in an asynchronous way.

## Theory

With just a few lines of code, storing the data in `Redis`, `Mongo` or using something like `Save` (storing the data in the server memory, making it faster but less reliable), you'll be able record constantly the user's position on a content with an outstanding performance, relegating the logic of this feature to each client instead of your CDN or playback system components.

The functionality is managed with this elements:

- **id**: Each position will have a unique ID so the client must save this data on the session or retrieve it through its method to be able to send a new position of a concrete content.
- **lapse**: The main 'character' of this short film; an integer that represents the seconds where a content were left, stopped or paused.
- **user_id**: A user can have a lot of contents started and in extension, with a position stored.
- **content_id**: Strictly related with the `user_id` so a user can have a lot of contents and a content can be played by a lot of users.
- **content_type**: To help differenciate contents that can share ids on your database.
- **transaction_type** `rental`, `purchase` or `subscription`
- **beats** A count of all the positions/lapses sended to some content per user.
- **firstbeat_date** _selfexplanatory_
- **lastbeat_date** _selfexplanatory_
- **_expirations_**: There are various dates posted on each document with different expirations to handle the data during the time depending on the `transaction_type`

With this components you'll be able to capture all the resumes within a playback by adding a heartbeat on your client. `The recommendation is a ratio of 1 beat per 30 seconds`, but regarding your systems configuration you can decrease it or increase it, do what you want but be careful with the amount of requests you may generate.

## API methods

### GET /positions

Shows all the positions stored. This request is going to be deprecated in the near future or turned into something private. You can use it now for testing/development purposes.

### GET /user/:user_id

Shows all the contents that a concrete user has started to play.

### GET /content/:content_id

Shows all the users that has started to play a concrete content.

### GET /position/:user_id/:content_id

Returns the `id` for an stored position. If the return is empty, then you should POST a new position, but if there's a correct answer with the expected data, you should update the position with a PUT.

### POST /position

Creates a new position if there's no response within the GET.

*Parameters:*

- **user_id**: The user's identification to relate it with the content.
- **content_id**: The content's number reference to relate it with a user.
- **content_type**: `movie` or `episode`; to differenciate between contents with the same id.
- **transaction_type**: `rental`, `purchase` or `subscription`; to manage the expiration of the documents.
- **lapse**: The lapse of time played on a content in seconds.

### PUT /position/:id

If the GET method responses with a `lapse`, you can update it by this method using the `id`.

*Parameters:*

- **lapse**: The amount of time played on a content in seconds.

#### Note

All the request must include `application/json` as its `Content-Type`.
