<!--
This file is generated automatically from .yml data file and _template.mako.

Please don't modify it, and modify source files instead. To compile the
file, ensure you have Python and Mako installed, and build all .md files
with Makefile (as simple as "make -C source/includes")
-->
# Tasks

## Task object

> Task object sample

```shell
{
  "comment_count": 10, 
  "completed": true, 
  "content": "My task", 
  "due": {
    "date": "2016-09-01", 
    "date_lang": "en", 
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
    "date_lang": "en", 
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


Attribute | Description
----------|------------
id | Task id
project_id | Tasks's project id
content | Task content
completed | Flag to mark completed tasks
label_ids | Array of label ids, associated with a task
order | Task order (read-only, position in project)
indent | Task indentation level (read-only, value from 1 to 5)
priority | task priority from 1 (normal, default value) to 4 (urgent)
due | object representing task due date/time.<br>	- `string` (string) — human defined date in arbitrary format;<br>	- `date` (string) — date in format `YYYY-MM-DD` corrected to user's time<br>	  zone;<br>	- `datetime` (optional, string) — only returned if exact due time set<br>	  (i.e. it's not a whole-day task), date and time in RFC3339 format in<br>	  UTC;<br>	- `timezone` (optional, string) — only returned if exact due time set,<br>	  user's timezone definition either in tzdata-compatible format<br>	  ("Europe/Berlin") or as a string specifying east of UTC offset as<br>	  "UTC±HH:MM" (i.e. "UTC-01:00");
url | URL to access this task in Todoist web interface
comment_count | Number of task comments




## Get all tasks

> Get all tasks

```shell
# command
curl -X GET "$root/tasks?token=$my_token&project_id=234"

# output
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
  }
]

```

```python
# command
>>> print requests.get(root + "/tasks", args={"token": my_token, "project_id": 234}).json()

# output
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
  }
]

```



### HTTP Request
`GET https://beta.todoist.com/API/v8/tasks` returns JSON-encoded array of all user tasks, optionally filtered by project or by label

### Request GET arguments

Attribute | Description
----------|------------
project_id | Project id to filter
label_id | Label id to filter


## Create new task

> Create new task

```shell
# command
curl -X POST "$root/tasks?token=$my_token"
    --data '{"content": "Appointment with Maria", "project_id": 2345, "due_string": "tomorrow at 12:00", "due_lang": "en", "priority": 4}'
    -H "Content-Type: application/json"
    -H "X-Request-Id: 29290B91-F437-42EB-8AA9-C6814CAF16B5"

# output
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
# command
requests.post(root + "/tasks",
    args={"token": my_token},
    data=json.dumps({"content": "Appointment with Maria",
                     "project_id": 2345,
                     "due_string": "tomorrow at 12:00",
                     "due_lang": "en",
                     "priority": 4}),
    headers={
        "Content-Type": "application/json",
        "X-Request-Id": "29290B91-F437-42EB-8AA9-C6814CAF16B5",
    }
).json()

# output
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



### HTTP Request
`POST https://beta.todoist.com/API/v8/tasks` returns newly created task


### Request body attributes

Attribute | Description
----------|------------
content | Task content
project_id | Task project id (optional). If not set, task is put to user's Inbox
order | non-zero integer value to set the "order" task field (optional, used by clients to sort tasks inside project)
label_ids | ids of labels associated with the task (optional, list of integers)
priority | optional priority value, from 1 (normal) to 4 (urgent)
due_string | Optional [human-defined](https://todoist.com/Help/DatesTimes) task due date (ex.: "next Monday", "Tomorrow", "every monday at 12:00"). Value is set using local (not UTC) time.
due_date | Alternative optional way to set task due date. Should be the string in `YYYY-MM-DD`
due_datetime | Another optinal alternative to set a specific date and time in RFC3339 format in UTC;
due_lang | If value of `due_string` is not in English, this attribute can be provided with 2-letter code specifying the language.

## Get specific task

> Get specific task

```shell
# command
curl -X GET "$root/tasks/1234?token=$my_token"

# output
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
    "indent": 1,
    "priority": 4,
    "project_id": 234,
    "url": "https://todoist.com/showTask?id=123"
}

```

```python
# command
requests.get(root + "/tasks/1234", args={"token": my_token}).json()

# output
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
    "indent": 1,
    "priority": 4,
    "project_id": 234,
    "url": "https://todoist.com/showTask?id=123"
}

```



### HTTP Request
`GET https://beta.todoist.com/API/v8/tasks/<task_id>` returns task by id



## Update specific task

> Update specific task

```shell
# command
curl -X POST "$root/tasks/1234?token=$my_token"
    --data '{"name": "Movies to watch"}'
    -H "Content-Type: application/json"
    -H "X-Request-Id: 29290B91-F437-42EB-8AA9-C6814CAF16B5"

```

```python
# command
requests.post(root + "/tasks/1234",
    args={"token": my_token},
    data=json.dumps({"name": "Movies to watch"}),
    headers={
        "Content-Type": "application/json",
        "X-Request-Id": "29290B91-F437-42EB-8AA9-C6814CAF16B5",
    }
)

```



### HTTP Request
`POST https://beta.todoist.com/API/v8/tasks/<task_id>` returns HTTP status code 204 and empty body


### Request body attributes

Attribute | Description
----------|------------
content | Task content
label_ids | ids of labels associated with the task (optional, list of integers)
priority | optional priority value, from 1 (normal) to 4 (urgent)
due_string | Optional [human-defined](https://todoist.com/Help/DatesTimes) task due date (ex.: "next Monday", "Tomorrow", "every monday at 12:00"). Value is set using local (not UTC) time.
due_date | Alternative optional way to set task due date. Should be the string in `YYYY-MM-DD`
due_datetime | Another optinal alternative to set a specific date and time in RFC3339 format in UTC;
due_lang | If value of `due_string` is not in English, this attribute can be provided with 2-letter code specifying the language.

## Close specifc task

> Close specifc task

```shell
# command
curl -X POST "$root/tasks/1234/close?token=$my_token"

```

```python
# command
requests.delete(root + "/tasks/1234/close", args={"token": my_token})

```

The command does exactly what official clients do when you close a task: r egular task is completed and moved to history, subtask is checked (marked as done, but not moved to history), recurring task is moved forward (due date is updated)


### HTTP Request
`POST https://beta.todoist.com/API/v8/tasks/<task_id>/close` returns HTTP status code 204 and empty body



## Reopen specific task

> Reopen specific task

```shell
# command
curl -X POST "$root/tasks/1234/reopen?token=$my_token"

```

```python
# command
requests.delete(root + "/tasks/1234/reopen", args={"token": my_token})

```

This command reopens a previously closed task. Works both with checked tasks in user's workspace and tasks moved to history. The behaviour varies for different types of tasks (the command follows the behaviour of official clients when tasks uncompleted or extracted from the history)

- Regular tasks extracted from the history and added back to the workspace as normal unchecked tasks (without their subtasks though).
- Completed subtasks of a non-completed task simply marked as uncompleted.
- Moved to history subtasks added back to the workspace as first-level tasks.
- Non-completed recurring tasks ignored.


### HTTP Request
`POST https://beta.todoist.com/API/v8/tasks/<task_id>/reopen` returns HTTP status code 204 and empty body if task was found, or 404 it task is not found either in workspace, or in history.




## Delete specific task

> Delete specific task

```shell
# command
curl -X DELETE "$root/tasks/1234?token=$my_token"

```

```python
# command
requests.delete(root + "/tasks/1234", args={"token": my_token})

```



### HTTP Request
`DELETE https://beta.todoist.com/API/v8/tasks/<task_id>` returns empty response




