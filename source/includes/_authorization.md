# Authorization

In order to make authorized calls to Todoist APIs, your application must first obtain an access token from the users. This section describes the different ways of obtaining such a token.

Note that we encourage your application to use the [OAuth](http://en.wikipedia.org/wiki/OAuth) protocol to obtain the access token from the user, as the other authentication methods (`login` and `login_with_google`) are scheduled for deprecation.

## OAuth

External applications could obtain a user authorized API token via the OAuth2 protocol. Before getting started, developers need to create their applications in App Management Console and configure a valid OAuth redirect URL. A registered Todoist application is assigned a unique Client ID and Client Secret which are needed for the OAuth2 flow.

This procedure is comprised of 3 steps, which will be described below.

### Step 1: The authorization request

> An example of redirecting a user to the authorization URL:

```shell
$ curl "https://todoist.com/oauth/authorize" \
    -d "client_id=0123456789abcdef" \
    -d "scope=data:read,data:delete" \
    -d "state=secretstring"
```

Redirect users to the authorization URL at the endpoint `https://todoist.com/oauth/authorize`, with the specified request parameters.

Here follow the required parameters:

Name | Description
---- | -----------
client_id | The unique Client ID of the Todoist application that you registered.
scope | A comma separated list of permissions that you would like the users to grant to your application. See below a table with more details about this.
state | A unique and unguessable string. It is used to protect you against cross-site request forgery attacks.


Here are the scope parameters mentioned before:

Name | Description
---- | -----------
task:add | Grants permission to add tasks to the Inbox project (the application cannot read tasks data). This is only used by the helper method of [adding an item](#add-item).
data:read | Grants read-only access to application data, including tasks, projects, labels, and filters.
data:read_write | Grants read and write access to application data, including tasks, projects, labels, and filters. This scope includes `task:add` and `data:read` scopes.
data:delete | Grants permission to delete application data, including tasks, labels, and filters.
project:delete | Grants permission to delete projects.

And here are some common errors that you may encounter:

Error | Description
----- | -----------
User Rejected Authorization Request | When the user denies your authorization request, Todoist will redirect the user to the configured redirect URI with the `error` parameter: `http://example.com?error=access_denied`.
Redirect URI Not Configured | This JSON error will be returned to the requester (your user's browser) if redirect URI is not configured in the App Management Console.
Invalid Application Status | When your application exceeds the maximum token limit or when your application is being suspended due to abuse, Todoist will redirect the user to the configured redirect URI with the `error` parameter: `http://example.com?error=invalid_application_status`.
Invalid Scope | When the `scope` parameter is invalid, Todoist will redirect the user to the configured redirect URI with `error` parameter: `http://example.com?error=invalid_scope`.

### Step 2: The redirection to your application site

When the user grants your authorization request , the user will be redirected to the redirect URL configured in your application setting. The redirect request will come with two query parameters attached: `code` and `state`.

The `code` parameter contains the authorization code that you will use to exchange for an access token. The `state` parameter should match the `state` parameter that you supplied in the previous step.  If the `state` is unmatched, your request has been compromised by other parties, and the process should be aborted.

### Step 3: The token exchange

> An example of exchanging the token:

```shell
$ curl "https://todoist.com/oauth/access_token" \
    -d "client_id=0123456789abcdef" \
    -d "client_secret=secret" \
    -d "code=abcdef" \
    -d "redirect_uri=https://example.com"
```

> On success, Todoist returns HTTP 200 with token in JSON object format:

```json
{
  "access_token": "0123456789abcdef0123456789abcdef01234567",
  "token_type": "Bearer"
}
```

Once you have the authorization `code`, you can exchange it for the access token at the endpoint `POST https://todoist.com/oauth/access_token`.

Here follow the required parameters:

Name | Description
---- | -----------
client_id | The unique Client ID of the Todoist application that you registered.
client_secret | The unique Client Secret of the Todoist application that you registered.
code | The unique string code that you obtained in the previous step.

And here are some common errors that you may encounter (all the error responses will be in JSON format):

Error | Description
----- | -----------
Bad Authorization Code Error | Occurs when the `code` parameter does not match the code that is given in the redirect request: `{"error": "bad_authorization_code"}`
Incorrect Client Credentials Error | Occurs when the `client_id` or `client_secret` parameters are incorrect: `{"error": "incorrect_application_credentials"}`


## Revoke Access Tokens

Access tokens obtained via OAuth could be revoked making a JSON request (HTTP POST) to the following endpoint:
```
https://todoist.com/api/access_tokens/revoke
```


```shell
curl https://todoist.com/api/access_tokens/revoke -H "Content-Type: application/json" -X POST -d '{"client_id":"xyz", "client_secret":"xyz", "access_token":"xyz"}'
```

### Required parameters:

Name | Description
---- | -----------
client_id | The unique Client ID of the Todoist application that you registered.
client_secret | The unique Client Secret of the Todoist application that you registered.
access_token | Access token obtained from the OAuth authentication

Upon successful request, a HTTP 204 response will be returned.


## Migrate Personal Tokens to OAuth Tokens

Tokens obtained via the old email/password authentication method could
be migrated to the new OAuth access token. Migrating your users' personal tokens will allow users to see your app in their Todoist Setting page and give them the ability to manage their app authorization.

Migration API endpoint (HTTP POST, with JSON request parameters):
```
https://todoist.com/api/access_tokens/migrate_personal_token
```

```shell
curl https://todoist.com/api/access_tokens/migrate_personal_token -H "Content-Type: application/json" -X POST -d '{"client_id":"xyz", "client_secret":"xyz", "personal_token":"xyz", "scope": "data:read"}'

{"access_token": "....", "token_type": "Bearer"}
```

### Required parameters:

Name | Description
---- | -----------
client_id | The unique Client ID of the Todoist application that you registered.
client_secret | The unique Client Secret of the Todoist application that you registered.
personal_token | Token obtained from the email/password authentication
scope | Scopes of the OAuth token. Please refer to the [OAuth](https://developer.todoist.com/#oauth) section for the detailed list of available scopes.

Upon succesful request, a HTTP 200 response will be returned with a new OAuth token in JSON format:
```
{"access_token": "....", "token_type": "Bearer"}
```


## Cross Origin Resource Sharing

All API endpoints support Cross Origin Resource Sharing (CORS) for 
requests from any origin. The header `Access-Control-Allow-Origin: *` 
is set for successfully authenticated requests.

> CORS headers example:

```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -H 'Origin: http://example.com'
HTTP/1.1 200 OK
Access-Control-Allow-Credentials: false
Access-Control-Allow-Origin: *
```


```python
>>> import requests
>>> requests.post('https://todoist.com/api/v7/sync', 
...               data={'token': '0123456789abcdef0123456789abcdef01234567'}, 
...               headers={'Origin': 'https://example.com'}).headers

{'Access-Control-Allow-Credentials': 'false', 'Access-Control-Allow-Origin': '*', <...>}
```
