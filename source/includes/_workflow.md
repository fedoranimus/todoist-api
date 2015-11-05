# Sync workflow

## Read data

> An example of the JSON object returned, of a new user's empty account complete data:

```shell
$ curl https://todoist.com/API/v6/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d seq_no=0 \
    -d resource_types='["all"]'

{
  "Collaborators": [],
  "DayOrdersTimestamp": "1344642991.1",
  "Notes": [],
  "Labels": [],
  "UserId": 1855589,
  "CollaboratorStates": [],
  "DayOrders": {},
  "LiveNotifications": [],
  "seq_no": 2180537512,
  "WebStaticVersion": 305,
  "LiveNotificationsLastRead": 0,
  "User": {
    ...
  },
  "Filters": [
    ...
  ],
  "Items": [
    ...
  ],
  "Reminders": [
    ...
  ],
  "Projects": [
    ...
  ],
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.sync(resource_types=['all'])
{ 
  'CollaboratorStates': [],
  'Collaborators': [],
  'DayOrders': {},
  'DayOrdersTimestamp': '1344642991.1',
  'LiveNotificationsLastRead': 0,
  'UserId': 1855589,
  'WebStaticVersion': 305,
  'seq_no': 2180537512L,
  'Filters': [],
  'Items': [],
  'Labels': [],
  'LiveNotifications': [],
  'Notes': [],
  'Projects': [],
  'Reminders': [],
  'User': {
    ...
  }
}
```

The `sync` API call is used to retrieve data (both all and only updated).

### Required parameters

Parameter | Description
--------- | -----------
token | User's API token (returned on successful login). Else the session cookie is used.
seq_no | Sequence number. On the initial request you should pass `0`. On all other requests you should pass the last `seq_no` you received from the server.
resource_types | This parameter controls which resources to fetch from the server.  It can be useful for speeding up the load of most important user's data (like the list of projects and tasks) and to get the rest of the data asynchronously later on. It should be a JSON-encoded list of strings. For example, `["projects", "labels", "filters"]`. Below is the list of recognizable values for strings: `projects` for the list of projects, `items` for list of tasks, `labels` for the list of labels, `notes` for the list of notes, `filters` for the list of filters, `reminders` for the list of reminders, `locations` for the list of locations, `user` for the user's details, `live_notifications` for the list of live notifications, `day_orders` for the list of day orders, `collaborators` for the list of collaborators, and `all` for all the above.  In order to include the notification settings (that is needed on platforms that implement native notifications), the `notification_settings` has to explicitly be included in the list of resource types.

### Optional parameters

Parameter | Description
--------- | -----------
day_orders_timestamp | The `sync` API requests return `DayOrdersTimestamp` that specifies when the day orders were last updated. If you omit `day_orders_timestamp` then none of then will be fetched. If you specify `day_orders_timestamp` then day orders will be returned if your timestamp is different from the servers. If you send `day_orders_timestamp` and the day orders have not been updated then the server won't return the `DayOrders` entry at all.
chaos_monkey | Use chaos_monkey to simulate errors. Should be an integer between 0 and 100. `chaos_monkey` set to 50 will randomly return errors on 50% of the commands

### Explanation of data returned

A brief explanation of what each object returned contains, while each of them will be later described in more detail.

Data | Description
---- | -----------
Users | A JSON object with a user's information.
Projects |  A list of JSON objects of projects.
Items | A JSON list of objects of items.
Labels | A JSON list of objects (including things like color, id etc.)
Filters | A JSON list of custom filters.
DayOrders |  A JSON object specifying the order of items in daily agenda. If `DayOrdersTimestamp` is sent and day orders have not been updated then `DayOrders` won't be returned at all!
DayOrdersTimestamp | A string specifying when day orders where last updated. Use this to not fetch day orders on every request.
Reminders |  A JSON list containing all reminders for all items in the project.
Collaborators | A JSON object containing all collaborators for all shared projects. The `projects` field contains the list of all shared projects, where the user acts as one of collaborators.
CollaboratorsStates | A JSON list specifying the state of each collaborator in each project. The state can be invited, active, inactive, deleted.
LiveNotifications | A JSON list of notifications for the user.
LiveNotificationsLastRead | What is the last live notification the user has seen? This is used to implement unread notifications.
SettingsNotifications | This is needed on platforms that implement native notifications.

## Write data

> Example of creating a new project, where an HTTP 200 OK with a JSON object of temporary id to real id mappings is returned (this will be explained later):

```shell
$ curl https://todoist.com/API/v6/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "project_add", "temp_id": "381e601f-0ef3-4ed6-bf95-58f896d1a314", "uuid": "ed1ce597-e4c7-4a88-ba48-e048d827c067", "args": {"name": "Project1", "item_order": 1, "indent": 1, "color": 1}}]'
{
  "UserId": 1855589,
  "seq_no": 2180537513,
  "SyncStatus": {"ed1ce597-e4c7-4a88-ba48-e048d827c067": "ok"},
  "TempIdMapping": {"381e601f-0ef3-4ed6-bf95-58f896d1a314": 128501470}
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.sync(commands=[{'type': 'project_add', 'temp_id': '381e601f-0ef3-4ed6-bf95-58f896d1a314', 'uuid': 'ed1ce597-e4c7-4a88-ba48-e048d827c067', 'args': {'name': 'Project1', 'item_order': 1, 'indent': 1, 'color': 1}}]
{ 
  'SyncStatus': {'ed1ce597-e4c7-4a88-ba48-e048d827c067': 'ok'},
  'TempIdMapping': {'381e601f-0ef3-4ed6-bf95-58f896d1a314': 128501470},
  'UserId': 1855589,
  'seq_no': 2180537513L
}
```

The `sync` API call can also take a list of JSON object commands which specify which changes should be done to the model. These changes could be adding projects, deleting tasks, adding notes etc.

It supports two big features which can make syncing easier: temporary ids, that is the ability to use and resolve temporary ids, and duplication protection which ensures that a command isn't run two times.

### Required parameters

Parameter | Description
--------- | -----------
commands | A list of JSON object commands, which will be processed by the server in the same order as specified in this list (so special care should be taken on this order).  The available commands to sent are described later in the documentation.
token | User's API token (returned on successful login). Else the session cookie is used.

### Commands parameters

Parameter | Description
--------- | -----------
type | The type of the command sent.
args | The arguments of this specific command.
uuid | A universal unique identifier (UUID) that is used for duplication protection, ie. to ensure that the same command isn't executed twice.
temp_id | Only for commands creating a new object, a unique temporary id.


### Temporary ids

> An example that shows how temporary ids can be used and referenced:

```json
[
  { "type": "project_add",
    "temp_id": "c7beb07f-b226-4eb1-bf63-30d782b07b1a",
    "args": {
      "name": "Project3",
      "item_order": 1,
      "indent": 1,
      "color": 1
    },
    "uuid": "ac417051-1cdc-4dc3-b4f8-14526d5bfd16"
  },
  {
    "type": "project_update",
    "args": {
      "id": "c7beb07f-b226-4eb1-bf63-30d782b07b1a",
      "color": 2
    },
    "uuid": "849fff4e-8551-4abb-bd2a-838d092775d7"
  }
]
```

>  You can see that the project_add command has a temp_id property, which specifies which temporary id this new project has. The project_update command later references this temporary id. The API will automatically resolve these ids. Additionally `sync` will return the real id in the result. Remember to update your local model with these real ids e.g.:

```json
{"c7beb07f-b226-4eb1-bf63-30d782b07b1a": 128501682}
```

Your application will use temporary ids and the Sync API has special support for them.  We suggest that you use UUIDs to generate these ids to give them uniqueness.

While the system remembers temporary ids and their mappings to real ids, it's important to use real ids when they are available to you (typically after a sync). This is important since the API only remembers the last 500 temporary ids for each user!

### Explanation of extra data returned

When there are commands to be sent to the server, some extra data are returned.

Data | Description
---- | -----------
TempIdMapping | A JSON list containing all the temporary ids mapped to real ids.
SyncStatus | A JSON list containing the return value of each of the commands sent.

### Limits

The maximum number of commands is 100 per request, and this is done to prevent timeouts and other problems when dealing with big requests.

There's also a maximum number of 50 sync requests per minute for each user, in order to prevent clients from accidentally overloading our servers.


## Errors

The server uses the HTTP status codes to indicate result or failure of a
request.  And as is usually customary in web servers, a 2xx code indicates
success, a 4xx code an error due to incorrect user provided information, and a
5xx code an internal, possibly temporary, error.

### Status codes

Status code | Description
------------|------------
200 OK | The request was processed successfuly.
400 Bad Request | The request was incorrect.
401 Unauthorized | Authentication is required, and has failed, or has not yet been provided.
403 Forbidden | The request was valid, but for something that is forbidden.
404 Not Found | The requested resource could not be found.
429 Too Many Requests | The user has sent too many requests in a given amount of time.
500 Internal Server Error | The request failed due to a server error.
503 Service Unavailable | The server is currently unable to handle the request.

### Return values

> An example of an error return value:

```json
{"error_code": 18, "error": "Required argument is missing: name"}
```

In any case, a JSON object is always returned.  So if the request was succesful, a JSON object with the relevant to the request data is returned or if there is no data to return a simple `"ok"`, while if the request failed, a JSON object of the format `{"error_code": error_code, "error": error_string}` is returned (where `error_code` is a number, and `error_string` a description).

> An example of a single request sync return value:

```json
{
  "SyncStatus": {"863aca2c-65b4-480a-90ae-af160129abbd": "ok"}
}
```

> An example of a multiple requests sync return value:

```json
{
  "SyncStatus": {
    "32eaa699-e9d7-47ed-91ea-e58d475791f1": "ok",
    "bec5b356-3cc1-462a-9887-fe145e3e1ebf": {"error_code": 15, "error": "Invalid temporary id"}
  }
}
```

> An example of a single request operating on multiple objects return value:

```json
{
  "SyncStatus": {
    "66386321-fb87-4f95-9dfe-7bf5c3823e85" : {
        "128501470": "ok",
        "128501607": {"error_code": 20, "error": "Project not found"}
    }
  }
}
```

Also, specifically for the case of the `sync` request, where multiple requests can be sent with a single call by the client, there is a special object reserved for indicating the return value of each specific request, the `SyncStatus`.

The `SyncStatus` is a dictionary of the return values of each of the multiple requests.  Each key/value pair in this dictionary is the `uuid` field which matches the UUID of each request, and actual return value of each request.

If one or more of the multiple requests operate in multiple objects, then the value part is itself a dictionary of return values one for each of the multiple objects, where each object is distinguished by its id.
