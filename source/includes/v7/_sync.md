# Sync

Todoist API (also known as the "Sync API") is specially designed for efficient
data sync between clients (e.g. our mobile apps) and Todoist.

All Sync API requests share the same endpoint URL:
**https://todoist.com/api/v7/sync**

Sync API requests should be made in HTTP POST
(application/x-www-form-urlencoded). Sync API responses, including errors, will
be returned in JSON.

Sync API supports the following features:

+ Batching: reading and writing of multiple resources can be done in a single
  HTTP request. Batch requests help clients reduce the number of network calls
  needed to sync resources.
+ Incremental sync: You only retrieve data that are updated since the last time
  you performed a sync request.

## Read resources

> An example response of a read request.

```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d sync_token='*' \
    -d resource_types='["all"]'

{
  "collaborators": [ ... ],
  "collaborator_states": [ ... ],
  "day_orders": { ... },
  "filters": [ ... ],
  "full_sync" : true,
  "items": [ ... ],
  "labels": [ ... ],
  "live_notifications": [ ... ],
  "live_notifications_last_read_id": 0,
  "notes": [ ... ],
  "project_notes": [ ... ],
  "projects": [ ... ],
  "reminders": [ ... ],
  'settings_notifications: { ... },
  "sync_token": "JLlaPv840mDQK4PLl6-hmjYMbP2h_RHsfPmIXuqmJI_zRiQHFww9olfDvSSpw74nrdvS",
  "temp_id_mapping": { ... },
  "user": { ... }
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.sync()
{
  'collaborators': [ ... ],
  'collaborator_states': [ ... ],
  'day_orders': { ... },
  'filters': [ ... ],
  'full_sync' : True,
  'items': [ ... ],
  'labels': [ ... ],
  'live_notifications': [ ... ],
  'live_notifications_last_read_id': 0,
  'notes': [ ... ],
  'project_notes': [ ... ],
  'projects': [ ... ],
  'reminders': [ ... ],
  'settings_notifications: { ... },
  'sync_token': 'JLlaPv840mDQK4PLl6-hmjYMbP2h_RHsfPmIXuqmJI_zRiQHFww9olfDvSSpw74nrdvS',
  'temp_id_mapping': { ... },
  'user': { ... }
}
```

*Note that the following parameters mostly make sense when sending commands in
the shell with curl, and not with the Python library, as man y things are
automated there. For example by default the Python library fetches all resource
types and then always does incremental syncs, so there's no need to specify most
of the following parameters.*

To retrieve your user resources, make a Sync API request with the following
parameters:


### Required parameters

Parameter | Description
--------- | -----------
token *String* | User's API token
sync_token *String* | A special string, used to allow the client to perform incremental sync.  Pass `*` to retrieve all active resource data.  More details about this below.
resource_types *JSON array of strings* | Used to specify what resources to fetch from the server.  It should be a JSON-encoded array of str
ings. Here is a list of available resource types: `labels`, `projects`,`items`, `notes`, `filters`, `reminders`, `locations`, `user`, `live_
notifications`, `collaborators`, `notification_settings`. You may use `all` to include all the resource types.


### Incremental sync

*Note that the Python library always does incremental syncs under the hood, so
there's no reason to worry about them if you use it.*

The Sync API allows clients to retrieve only updated resources, and this is done
by using the "synchronization token", `sync_token`, in your Sync API request.

On your initial sync request, specify `sync_token=*` in your request, and all
the user's active resource data will be returned.  Todoist API server will also
return a new `sync_token` in the Sync API response.

In your subsequent Sync request, use the `sync_token` that you received from
your previous sync response, and the Todoist API server will return only the
updated resource data.


### Response

When the request succeeds, an HTTP 200 response will be returned with a JSON
object containing the requested resources and also a new `sync_token`.


Field | Description
---- | -----------
sync_token | A new synchronization token. Used by the client in the next sync request to perform an incremental sync.
full_sync | Whether the response contains all data (a full synchronization) or just a part of them since the last sync.
user | A user object.
projects |  An array of project objects.
items | A array of item objects.
labels | An array of label objects.
filters | A array of filter objects.
day_orders |  A JSON object specifying the order of items in daily agenda.
reminders |  An array of reminder objects.
collaborators | A JSON object containing all collaborators for all shared projects. The `projects` field contains the list of all shared projects, where the user acts as one of collaborators.
collaborators_states | An array specifying the state of each collaborator in each project. The state can be invited, active, inactive, deleted.
live_notifications | An array of live_notification objects
live_notifications_last_read | What is the last live notification the user has seen? This is used to implement unread notifications.
settings_notifications | User's notification setting, used by clients that support native notifications.


## Write resources

> Example API call that creates a new project.

```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "project_add", "temp_id": "381e601f-0ef3-4ed6-bf95-58f896d1a314", "uuid": "ed1ce597-e4c7-4a88-ba48-e048d827c067", "args": {"name": "Project1", "item_order": 1, "indent": 1, "color": 1}}]'

{
  "sync_token": "JLlaPv840mDQK4PLl6-hmjYMbP2h_RHsfPmIXuqmJI_zRiQHFww9olfDvSSpw74nrdvS",
  "sync_status": {"ed1ce597-e4c7-4a88-ba48-e048d827c067": "ok"},
  "temp_id_mapping": {"381e601f-0ef3-4ed6-bf95-58f896d1a314": 128501470}
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.sync(commands=[{'type': 'project_add', 'temp_id': '381e601f-0ef3-4ed6-bf95-58f896d1a314', 'uuid': 'ed1ce597-e4c7-4a88-ba48-e048d827c067', 'args': {'name': 'Project1', 'item_order': 1, 'indent': 1, 'color': 1}}]
{
  'sync_status': {'ed1ce597-e4c7-4a88-ba48-e048d827c067': 'ok'},
  'temp_id_mapping': {'381e601f-0ef3-4ed6-bf95-58f896d1a314': 128501470},
  'sync_token': 'JLlaPv840mDQK4PLl6-hmjYMbP2h_RHsfPmIXuqmJI_zRiQHFww9olfDvSSpw74nrdvS'
}
```

*Note that the Python example is only there to show what is the equivalent for
sending commands, but actually there's no need to use that with the Python
library, as it has its own object oriented API which is a lot easier to do
various things, so many of the parameters mentione d below do not make much
sense for the Python library, and instead you can just use the methods described
in the following sections.*

To write to your user's Todoist resources, make a Sync API request with the
following parameters


### Required parameters

Parameter | Description
--------- | -----------
commands *JSON* | A JSON array of Command object. Each command will be processed in the specified order.
token *String* | API token


### Command object

Field | Description
------| -----------
type *String* | The type of the command.
args *Object* | The arguments of this specific command.
uuid *String* | Command UUID. More details about this below.
temp_id *String* | Temporary resource ID, Optional. Only specified for commands that create new resource ("item_add" command). More details about this below.

## Command UUID

*Note that the Python library takes care of sending UUIDs, so there's no need to
worry about them if you use it.*

API clients should generate a unique string ID for each command and specify it
in the `uuid` field. The Command UUID will be used for two purposes:

1. Command result mapping: Each command's result will be stored in the
   `sync_status` field of the response JSON object. The `sync_status` object has
   its key mapped to a command's `uuid` and its value containing the result of a
   command.
2. Command idempotency: Todoist will not execute command that has same UUID as
   the previously executed commands. This will allow clients to safely retry
   each command without accidentally performing the command twice.


## Temporary resource id

> An example that shows how temporary ids can be used and referenced:

```json
[
  { "type": "project_add",
    "temp_id": "c7beb07f-b226-4eb1-bf63-30d782b07b1a",
    "args": {
      "name": "Test Project"
    },
    "uuid": "ac417051-1cdc-4dc3-b4f8-14526d5bfd16"
  },
  {
    "type": "item_add",
    "temp_id": "43f7ed23-a038-46b5-b2c9-4abda9097ffa",
    "args": {
      "content": "This is a test task",
      "project_id": "c7beb07f-b226-4eb1-bf63-30d782b07b1a"
    },
    "uuid": "849fff4e-8551-4abb-bd2a-838d092775d7"
  }
]
```

>  You can see that the project_add command specified a temp_id property
>  ("c7beb07f-b226-4eb1-bf63-30d782b07b1a") as placeholder of the actual
>  project_id. The item_add command can refrence to this temporary project
>  id. The API will automatically resolve these ids.

*Note that the Python library takes care of handling temporary ids, so there's
no reason to worry about them if you use it.*

Some commands depend on the result of previous command. For instance, you have a
command sequence: `"project_add"` and `"item_add"` which first creates a project
and then add a new task to the newly created project. In order to run the later
`item_add` command, we need to obtain the project ID returned from the previous
command. Therefore, the normal approach would be to run these two commands in
two separate HTTP requests.

The temporary resource ID feature allows you to run two or more dependent
commands in a single HTTP request.  For commands that are related to creation of
resources (i.e. `item_add`, `project_add`), you can specify an extra `temp_id`
as a placeholder for the actual ID of the resource. The other commands in the
same sequence could directly refer to `temp_id` if needed.


## Response / Error

The result of command executions will be stored in the following response JSON
object field:

Data | Description
---- | -----------
temp_id_mapping *Object* | A dictionary object that maps temporary resource ids to real resource ids.
sync_status *Object* | A dictionary object containing result of each command execution. The key will be the command's `uuid` field and the value will be the result status of the command execution.


> An example of a single request sync return value:

```json
{
  "sync_status": {"863aca2c-65b4-480a-90ae-af160129abbd": "ok"}
}
```

> An example of a multiple requests sync return value:

```json
{
  "sync_status": {
    "32eaa699-e9d7-47ed-91ea-e58d475791f1": "ok",
    "bec5b356-3cc1-462a-9887-fe145e3e1ebf": {"error_code": 15, "error": "Invalid temporary id"}
  }
}
```

The status result of each command execution is in the `sync_status` dictionary
object. The key is a command `uuid` and the value will be the result status of
the command execution. There are two possible values for each command status -

+ an "ok" string which signals success of the command
+ an error object containings error information of a command.

Please see the adjacent code examples for the possible format of the
`sync_status`.


## Response status codes

The server uses the HTTP status codes to indicate the success or failure of a
request. And as is customary in web servers, a 2xx code indicates - success, a
4xx code - an error due to incorrect user provided information, and a 5xx code -
an internal, possibly temporary, error.

Status code | Description
------------|------------
200 OK | The request was processed successfully.
400 Bad Request | The request was incorrect.
401 Unauthorized | Authentication is required, and has failed, or has not yet been provided.
403 Forbidden | The request was valid, but for something that is forbidden.
404 Not Found | The requested resource could not be found.
429 Too Many Requests | The user has sent too many requests in a given amount of time.
500 Internal Server Error | The request failed due to a server error.
503 Service Unavailable | The server is currently unable to handle the request.


## Limits

The maximum number of commands is 100 per request, and this is done to prevent
timeouts and other problems when dealing with big requests.

There's also a maximum number of 50 sync requests per minute for each user, in
order to prevent clients from accidentally overloading our servers.
