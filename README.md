# PKB

A web API for the personal knowledge base.

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
4. [Install Helm v3.](https://helm.sh/docs/intro/install/)
5. Add Helm repositories which contain the dependencies for the app.
```bash
# Add Prometheus Helm repository.
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts && helm repo update prometheus-community
# Add Grafana Helm repository.
helm repo add grafana https://grafana.github.io/helm-charts && helm repo update grafana
```
6. Install secrets.
```bash
kubectl apply -f ./secrets.yaml
```
7. Install the PKB chart.
```bash
# Load dependencies.
(cd pkb && helm dependency build )
# Install the app.
helm install pkb ./pkb
```
8. Add new DNS entry to /etc/hosts so it looks like the app is hosted on http://pkb.local.

**Do not forget to remove the entry when you're done with the app!**

```bash
echo "$( minikube ip ) pkb.local pkb.grafana.local" | sudo tee -a /etc/hosts
```
10. Wait a bit until the whole thing is up. If you want you can monitor it with the minikube dashboard:
```bash
minikube dashboard
```
11. Test the API.
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
