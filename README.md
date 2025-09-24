# PKB

A personal knowledge base web app.

### Services

- `users`. The API provides endpoints to manage users and handle authentication.
- `notes`. The API provides endpoints to manage notes and tags.

### Run locally

```bash
# Build and start containers.
docker-compose up

# Create new user with name "my user" and password "my password".
curl -X POST --url http://0.0.0.0:8080/api/v1/users -H "Content-Type: application/json" --data '{"name": "my user", "password": "my password"}'

# Create new access token with user credentials. The result contains an object with the "access_token" property.
curl -X POST --url http://0.0.0.0:8080/api/v1/access-token -H "Content-Type: application/json" --data '{"name": "my user", "password": "my password"}'

# Read my user info.
curl -X GET --url http://0.0.0.0:8080/api/v1/users/me -H "Content-Type: application/json" -H "Authorization: Bearer replace-with-access-token"

# Create new note.
curl -X POST --url http://0.0.0.0:8080/api/v1/notes/ \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer replace-with-access-token" \
    --data '{"name": "My first note", "content": "The content of my first note.", "tags": ["example"]}'

# Update note.
curl -X PATCH --url http://0.0.0.0:8080/api/v1/notes/replace-with-note-id \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer replace-with-access-token" \
    --data '{"content": "The content of my first note. Updated!"}'

# Read note info.
curl -X GET --url http://0.0.0.0:8080/api/v1/notes/replace-with-note-id \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer replace-with-access-token"

# Update tag.
curl -X PATCH --url http://0.0.0.0:8080/api/v1/tags/replace-with-tag-id \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer replace-with-access-token" \
    --data '{"name": "new tag name"}'

# Read tag info.
curl -X GET --url http://0.0.0.0:8080/api/v1/tags/replace-with-tag-id \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer replace-with-access-token"

# Delete tag.
curl -X DELETE --url http://0.0.0.0:8080/api/v1/tags/replace-with-tag-id \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer replace-with-access-token"

# Delete note.
curl -X DELETE --url http://0.0.0.0:8080/api/v1/notes/replace-with-note-id \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer replace-with-access-token"
```
