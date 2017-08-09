# Tasks

> Task object sample

```shell
{
  "comment_count": 10, 
  "completed": true, 
  "content": "My task", 
  "due": {
    "date": "2016-09-01", 
    "recurring": true,
    "datetime": "2016-09-01T09:00:00Z", 
    "string": "tomorrow at 12", 
    "timezone": "Europe/Moscow"
  }, 
  "id": 1234, 
  "indent": 1, 
  "label_ids": [
    124, 
    125, 
    128
  ], 
  "order": 123, 
  "priority": 1, 
  "project_id": 2345, 
  "url": "https://todoist.com/showTask?id=12345&sync_id=56789"
}
```

```python
{
  "comment_count": 10, 
  "completed": true, 
  "content": "My task", 
  "due": {
    "date": "2016-09-01", 
    "recurring": true,
    "datetime": "2016-09-01T09:00:00Z", 
    "string": "tomorrow at 12", 
    "timezone": "Europe/Moscow"
  }, 
  "id": 1234, 
  "indent": 1, 
  "label_ids": [
    124, 
    125, 
    128
  ], 
  "order": 123, 
  "priority": 1, 
  "project_id": 2345, 
  "url": "https://todoist.com/showTask?id=12345&sync_id=56789"
}
```

### Properties

Property | Description
----------|------------
id *Integer* | Task id
project_id *Integer* | Tasks's project id
content *String* | Task content
completed *Boolean* | Flag to mark completed tasks
label_ids *List of Integers* | Array of label ids, associated with a task
order *Integer* | Position in the project (read-only)
indent *Integer* | Task indentation level from 1 to 5 (read-only)
priority *Integer* | Task priority from 1 (normal, default value) to 4 (urgent)
due *Object* | object representing task due date/time (described below)
url *String* | URL to access this task in Todoist web interface
comment_count *Integer* | Number of task comments

### Due object

Parameter | Optional | Description
--------- | -------- | -----------
string *String* | No | Human defined date in arbitrary format
date *String* | No | Date in format `YYYY-MM-DD` corrected to user's timezone
datetime *String* | Yes | Only returned if exact due time set (i.e. it's not a whole-day task), date and time in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) format in UTC;
timezone *String* | Yes | only returned if exact due time set, user's timezone definition either in tzdata-compatible format ("Europe/Berlin") or as a string specifying east of UTC offset as "UTC±HH:MM" (i.e. "UTC-01:00");

## Get tasks

> Get tasks

```shell
curl "https://beta.todoist.com/API/v8/tasks?token=$token"

[
  {
    "id": 123,
    "project_id": 234,
    "content": "Inbox",
    "comment_count": 10,
    "order": 1,
    "indent": 1,
    "priority": 1,
    "url": "https://todoist.com/showTask?id=123"
  },
  ...
]
```

```python
import requests
requests.get("https://beta.todoist.com/API/v8/tasks", params={"token": token, "project_id": 123}).json()

[
  {
    "id": 123,
    "project_id": 234,
    "content": "Inbox",
    "comment_count": 10,
    "order": 1,
    "indent": 1,
    "priority": 1,
    "url": "https://todoist.com/showTask?id=123"
  },
  ...
]

```

Return a JSON-encoded array containing all user tasks


### Parameters

Parameter | Required | Description
--------- | -------- | -----------
project_id *Integer* | No | Filter tasks by project id
label_id *Integer* | No | Filter tasks by label
filter *String* | No | Filter by any [supported filter](https://support.todoist.com/hc/en-us/articles/205248842)
lang *String* | No | IETF language tag defining what language filter is written in, if differs from default English

Note that **filters are premium-only feature**, if used for non-premium users,
server would return 402 Payment Required.


## Create a new task

> Create a new task

```shell
curl "https://beta.todoist.com/API/v8/tasks?token=$token" \
    -X POST \
    --data '{"content": "Appointment with Maria", "due_string": "tomorrow at 12:00", "due_lang": "en", "priority": 4}' \
    -H "Content-Type: application/json" \
    -H "X-Request-Id: $(uuidgen)"

{
    "comment_count": 0,
    "completed": false,
    "content": "Appointment with Maria",
    "due": {
        "date": "2016-09-01",
        "datetime": "2016-09-01T11:00:00Z",
        "string": "2017-07-01 12:00",
        "timezone": "Europe/Lisbon"
    },
    "id": 123,
    "order": 20,
    "priority": 4,
    "project_id": 234,
    "url": "https://todoist.com/showTask?id=123"
}
```

```python
import uuid, requests, json
requests.post("https://beta.todoist.com/API/v8/tasks",
    params={"token": token},
    data=json.dumps({"content": "Appointment with Maria",
                     "due_string": "tomorrow at 12:00",
                     "due_lang": "en",
                     "priority": 4}),
    headers={
        "Content-Type": "application/json",
        "X-Request-Id": str(uuid.uuid4()),
    }
).json()

{
    "comment_count": 0,
    "completed": false,
    "content": "Appointment with Maria",
    "due": {
        "date": "2016-09-01",
        "datetime": "2016-09-01T11:00:00Z",
        "string": "2017-07-01 12:00",
        "timezone": "Europe/Lisbon"
    },
    "id": 123,
    "order": 20,
    "priority": 4,
    "project_id": 234,
    "url": "https://todoist.com/showTask?id=123"
}
```

Create a new tasks and return the JSON object according for it.


### JSON body parameters

Parameter | Required | Description
--------- | -------- | -----------
content *String* | Yes | Task content
project_id *Integer* | No | Task project id. If not set, task is put to user's Inbox
order *Integer* | No | Non-zero integer value used by clients to sort tasks inside project
label_ids *List of Integers* | No | Ids of labels associated with the task
priority *Integer* | No | Task priority from 1 (normal) to 4 (urgent)
due_string *String* | No | [human-defined](https://todoist.com/Help/DatesTimes) task due date (ex.: "next Monday", "Tomorrow"). Value is set using local (not UTC) time.
due_date *String* | No | Specific date in `YYYY-MM-DD` format relative to user’s timezone
due_datetime *String* | No | specific date and time in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) format in UTC
due_lang *String* | No | 2-letter code specifying language in case `due_string` is not written in English

Please note that you can only use one of the `due_*` fields can be used at
once (`due_lang` is a special case).

## Get one specific task

> Get one specific task

```shell
curl "https://beta.todoist.com/API/v8/tasks/1234?token=$token"

{
    "comment_count": 0,
    "completed": false,
    "content": "Appointment with Maria",
    "due": {
        "date": "2016-09-01",
        "datetime": "2016-09-01T11:00:00Z",
        "string": "2017-07-01 12:00",
        "timezone": "Europe/Lisbon"
    },
    "id": 1234,
    "order": 20,
    "indent": 1,
    "priority": 4,
    "project_id": 234,
    "url": "https://todoist.com/showTask?id=123"
}

```

```python
import requests
requests.get("https://beta.todoist.com/API/v8/tasks/1234", params={"token": token}).json()

{
    "comment_count": 0,
    "completed": false,
    "content": "Appointment with Maria",
    "due": {
        "date": "2016-09-01",
        "datetime": "2016-09-01T11:00:00Z",
        "string": "2017-07-01 12:00",
        "timezone": "Europe/Lisbon"
    },
    "id": 1234,
    "order": 20,
    "indent": 1,
    "priority": 4,
    "project_id": 234,
    "url": "https://todoist.com/showTask?id=123"
}

```

Return a task by id


## Update a task

> Update a task

```shell
curl "https://beta.todoist.com/API/v8/tasks/1234?token=$token" \
    -X POST \
    --data '{"content": "Movies to watch"}' \
    -H "Content-Type: application/json" \
    -H "X-Request-Id: $(uuidgen)"
```

```python
import uuid, requests, json
requests.post("https://beta.todoist.com/API/v8/tasks/1234",
    params={"token": token},
    data=json.dumps({"content": "Movies to watch"}),
    headers={
        "Content-Type": "application/json",
        "X-Request-Id": str(uuid.uuid4()),
    }
)
```

Update a task and return an empty body with the HTTP status code 204

### JSON body parameters

Parameter | Required | Description
--------- | -------- | -----------
content *String* | Yes | Task content
project_id *Integer* | No | Task project id. If not set, task is put to user's Inbox
order *Integer* | No | Non-zero integer value used by clients to sort tasks inside project
label_ids *List of Integers* | No | Ids of labels associated with the task
priority *Integer* | No | Task priority from 1 (normal) to 4 (urgent)
due_string *String* | No | [human-defined](https://todoist.com/Help/DatesTimes) task due date (ex.: "next Monday", "Tomorrow"). Value is set using local (not UTC) time.
due_date *String* | No | Specific date in `YYYY-MM-DD` format relative to user’s timezone
due_datetime *String* | No | specific date and time in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) format in UTC
due_lang *String* | No | 2-letter code specifying language in case `due_string` is not written in English

Please note that you can only use one of the `due_*` fields can be used at
once (`due_lang` is a special case).


## Close a task

> Close a task

```shell
curl -X POST "https://beta.todoist.com/API/v8/tasks/1234/close?token=$token"
```

```python
import requests
requests.post("https://beta.todoist.com/API/v8/tasks/1234/close", params={"token": token})
```

Close a task and return an empty body with a HTTP status code 204.

The command does exactly what official clients do when you close a task. Regular
tasks are completed and moved to history, subtasks are checked (marked as done,
but not moved to history), recurring task is moved forward (due date is updated).


## Reopen a task

> Reopen a task

```shell
curl -X POST "https://beta.todoist.com/API/v8/tasks/1234/reopen?token=$token"
```

```python
import requests
requests.post("https://beta.todoist.com/API/v8/tasks/1234/reopen", params={"token": token})
```

Reopen a tasks and return an empty body with a HTTP status code 204.

This command reopens a previously closed task. Works both with checked tasks in
user's workspace and tasks moved to history. The behaviour varies for different
types of tasks (the command follows the behaviour of official clients when tasks
are uncompleted or extracted from the history)

- Regular tasks are extracted from the history and added back to the user
  workspace as normal unchecked tasks (without their subtasks though).
- Completed subtasks of a non-completed task simply marked as uncompleted.
- Moved to history subtasks added back to the workspace as first-level tasks.
- Non-completed recurring tasks ignored.


## Delete a task

> Delete a task

```shell
curl -X DELETE "https://beta.todoist.com/API/v8/tasks/1234?token=$token"
```

```python
import requests
requests.delete("https://beta.todoist.com/API/v8/tasks/1234", params={"token": token})
```

Delete a task and return an empty body with a HTTP status 204.
