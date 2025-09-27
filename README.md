# PKB

A personal knowledge base web app.

### Services

- `users`. The API provides endpoints to manage users and handle authentication.
- `notes`. The API provides endpoints to manage notes and tags.

### Run locally

1. [Install minikube.](https://minikube.sigs.k8s.io/docs/start)
2. Start minikube.
```bash
minikube start
```
3. Enable ingress.
```bash
minikube addons enable ingress
```
4. Add a DNS entry so it looks like the app is hosted on http://pkb.com.
```bash
echo "$( minikube ip ) pkb.com" | sudo tee -a /etc/hosts
```
5. Deploy the app.
```bash
./run
```
6. Run migrations.
```bash
./migrate
```
7. Test the API.
```bash
# Create new user with name "my user" and password "my password".
curl -X POST --url http://pkb.local/api/v1/users -H "Content-Type: application/json" --data '{"name": "my user", "password": "my password"}'

# Create new access token with user credentials. The result contains an object with the "access_token" property.
curl -X POST --url http://pkb.local/api/v1/access-token -H "Content-Type: application/json" --data '{"name": "my user", "password": "my password"}'

# Read my user info.
curl -X GET --url http://pkb.local/api/v1/users/me -H "Content-Type: application/json" -H "Authorization: Bearer replace-with-access-token"

# Create new note.
curl -X POST --url http://pkb.local/api/v1/notes/ \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer replace-with-access-token" \
    --data '{"name": "My first note", "content": "The content of my first note.", "tags": ["example"]}'

# Update note.
curl -X PATCH --url http://pkb.local/api/v1/notes/replace-with-note-id \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer replace-with-access-token" \
    --data '{"content": "The content of my first note. Updated!"}'

# Read note info.
curl -X GET --url http://pkb.local/api/v1/notes/replace-with-note-id \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer replace-with-access-token"

# Update tag.
curl -X PATCH --url http://pkb.local/api/v1/tags/replace-with-tag-id \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer replace-with-access-token" \
    --data '{"name": "new tag name"}'

# Read tag info.
curl -X GET --url http://pkb.local/api/v1/tags/replace-with-tag-id \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer replace-with-access-token"

# Delete tag.
curl -X DELETE --url http://pkb.local/api/v1/tags/replace-with-tag-id \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer replace-with-access-token"

# Delete note.
curl -X DELETE --url http://pkb.local/api/v1/notes/replace-with-note-id \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer replace-with-access-token"
```
