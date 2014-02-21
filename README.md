![Babieca](https://s3-eu-west-1.amazonaws.com/uploads-eu.hipchat.com/20667/97004/nvXkUGXA0G4zpsS/photo.png)

# Babieca

**Babieca** is a very light and lightning fast service that provides a crossplatform resume playback method that can be attached to a current API, website or making requests separatedly in an asynchronous way.

## Theory

With just a few lines of code, storing the data in `Redis` or using something like `Save` in Node.js (storing the data in the server memory, making it faster but less reliable), you'll be able record constantly the user's position on a content with an outstanding performance, relegating the logic of this feature to each client instead of your CDN or playback system components.

The functionality is managed by just 4 elements:

- **id**: Each position will have a unique ID so the client must save this data on the session or retrieve it through its method to be able to send a new position of a concrete content.
- **position**: The main character of this short film; an integer that represents the seconds where a content were left, stopped or paused.
- **user_id**: A user can have a lot of contents started and in extension, with a position stored.
- **content_id**: Strictly related with the `user_id` so a user can have a lot of contents and a content can be played by a lot of users.

With this components you'll be able to capture all the resumes within a playback by adding a heartbeat on your client. `The recommendation is a ratio of 1 beat per 30 seconds`, but regarding your systems configuration you can decrease it or increase it, do what you want but be careful with the amount of requests you may generate.

## API methods

### GET /:user_id/:content_id

Returns the `id` and the `position` on a concrete content of a concrete user if the user has played the content. If the return is empty, then you should POST a new position, but if there's a correct answer with the expected data, you should update the position with a PUT.

### POST /position

*Parameters:*

- **user_id**: The user's identification to relate it with the content.
- **content_id**: The content's number reference to relate it with a user.
- **position**: The lapse of time played on a content in seconds.

### PUT /position

*Parameters:*

- **id**: The position ID retrieved in first place with the GET method, so you can updated directly by its unique identification.
- **position**: The lapse of time played on a content in seconds.
