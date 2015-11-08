# API Overview

Todoist API (also known as the "Sync API") is specially designed for efficient data sync between 
clients (i.e. our mobile apps) and Todoist. 

All Sync API requests shared the same endpoint URL:
**https://todoist.com/API/v6/sync**

Sync API requests should be made in HTTP POST (application/x-www-form-urlencoded). Sync API responses, including error, will be returned in JSON. 

Sync API supports the following features:

- Batching: reading and writing of multiple resources can be done in a single HTTP request. Batch request s help clients reduce the number of network calls needed to sync resources.

- Incremental sync: You can only retrive datas that are updated since the last time you perform sync request.


<br/><br/>
<script type="text/javascript" src="//www.apichangelog.com/static/widget/follow.js" api="todoist"></script>


## Read Resources

> An example response of a read request.

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


To retrive your user resources, make a Sync API request with the following parameters: 



### Required parameters

Parameter | Description
--------- | -----------
token *String* | User's API token
seq_no *Integer* | Sequence number, used to allow client to perform incremental sync. Pass `0` to retrieve all active resource datas. More detail about it below.
resource_types *JSON array of string* | Used to specify what resources to fetch from the server.  It should be a JSON-encoded array of strings. Here is a list of avaialbe resource types: `labels`, `items`, `notes`, `filters`, `reminders`, `locations`, `user`, `live_notifications`, `day_orders`, `collaborators`, `notification_settings`. You may use `all` to include all the resource types



### Optional parameters

Parameter | Description
--------- | -----------
day_orders_timestamp | The Sync API requests return `DayOrdersTimestamp` that specifies when the day orders were last updated. If you omit `day_orders_timestamp` then none of then will be fetched. If you specify `day_orders_timestamp` then day orders will be returned if your timestamp is different from the servers. If you send `day_orders_timestamp` and the day orders have not been updated then the server won't return the `DayOrders` entry at all.



### Incremental sync (`seq_no` usage)

Sync API allow clients to retrive only updated resources, and this is done by using the "sequence number", `seq_no`, in your Sync API request.

On your initial sync request, specify `seq_no=0` in your request, and the user's all active resources datas will be returned. 
Todoist API server will also return a new `seq_no` in the Sync API response. 

In your subsequent Sync request, use the `seq_no` that you receive from your previous Sync response, 
and the Todoist API server will return only the updated resource datas.






### Response

When the request succeeded, a HTTP 200 response will be returned with a JSON object containning the requested resources and also a new `seq_no`.


Field | Description
---- | -----------
seq_no | A new sequence number. Used by the client in the next sync request to perform incremental sync.
User | An User object.
Projects |  An array of Project objects.
Items | A array of Item objects.
Labels | A array of Label objects
Filters | A array of Filter objects.
DayOrders |  A JSON object specifying the order of items in daily agenda. If `DayOrdersTimestamp` is sent and day orders have not been updated then `DayOrders` won't be returned at all!
DayOrdersTimestamp | A string specifying when day orders where last updated. Use this to not fetch day orders on every request.
Reminders |  A array of Reminder objects
Collaborators | A JSON object containing all collaborators for all shared projects. The `projects` field contains the list of all shared projects, where the user acts as one of collaborators.
CollaboratorsStates | A array specifying the state of each collaborator in each project. The state can be invited, active, inactive, deleted.
LiveNotifications | A array of LiveNotification object
LiveNotificationsLastRead | What is the last live notification the user has seen? This is used to implement unread notifications.
SettingsNotifications | User's notification setting, used by clients that support native notifications.


## Write Resources

> Example API call that creating a new project.

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


To write to your user's Todoist resources, make a Sync API request with the following parameters


### Required parameters

Parameter | Description
--------- | -----------
commands | A JSON array of Command object. Each command will be processed in the specified order.
token | API token


### Command object

Field | Description
--------- | -----------
type *String* | The type of the command.
args *Object* | The arguments of this specific command.
uuid *String* | Command UUID. More detail about it below.
temp_id *String* | Temporary resource ID, Optional. Only specified for commands that create new resource ("item_add" command). More detail about it below.


### Command UUID

API clients should generate a unique string ID for each command and specify it in the `uuid` field. The Command UUID will be used for two purposes:

1. Command result mapping: Each command's result will be stored in the `SyncStatus` field of the response JSON object. The `SyncStatus` object has its key mapped to a command's `uuid` and its value containing the result of 
a command.


2. Command idempotency: Todoist will not execute command that has same UUID as the previously executed commands. This will allow clients to safely retry each command without accidentally performing the command twice.





### Temporary resource id

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

>  You can see that the project_add command specified a temp_id property ("c7beb07f-b226-4eb1-bf63-30d782b07b1a") as placeholder of the actual project_id. The item_add command can refrence to this temporary project id. The API will automatically resolve these ids.
```

Some commands depends on the result of previous commands. For instance, you have a command sequence: `"project_add"` and `"item_add"` which first creates a project and then add a new task to the newly created project. In order to run the later `item_add` command, we need to obtain the project ID returned from the previous command. Therefore, the normal approach would be to run these two commands in two separate HTTP requests.

The temporary resource ID feature allows you two run two or more dependent commands in a single HTTP request.
For commands that are related to creation of resources (i.e. `item_add`, `project_add`), you can 
specify a extra `temp_id` as a placeholder for the actual ID of the resource. The other commands in 
the same sequence could directly refer to `temp_id` if needed.





### Response

The result of commands execution will be stored in the following response JSON object field:

Data | Description
---- | -----------
TempIdMapping *Object* | A dictionary object that maps temporary resource ids to real resource ids.
SyncStatus *Object* | A dictionary object containing result of each command execution. The key will be the command's `uuid` field and the value will be the result status of the command execution.


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

The status result of each command execution is in the `SyncStatus` dictionary object. The key is a command `uuid` and the value will be the result status of the command execution. There are two possible value for each command status

- a "ok" string which signals success of the command

- an error object containings error information of a command



### Limits

The maximum number of commands is 100 per request, and this is done to prevent timeouts and other problems when dealing with big requests.

There's also a maximum number of 50 sync requests per minute for each user, in order to prevent clients from accidentally overloading our servers.



## Responsse status codes

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




## Client libraries

### Python

> Install Todoist Python library via pip:

```
$ pip install todoist-python
```

[Todoist Python API library](https://github.com/Doist/todoist-python) ([library Doc] (http://todoist-python.readthedocs.org/en/latest/))


