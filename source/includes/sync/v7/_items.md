# Items

> An example item object

```json
{
  "id": 33511505,
  "user_id": 1855589,
  "project_id": 128501470,
  "content": "Task1",
  "date_string": "",
  "date_lang": "en",
  "due_date_utc": null,
  "indent": 1,
  "priority": 1,
  "item_order": 1,
  "day_order": -1,
  "collapsed": 0,
  "children": null,
  "labels": [12839231, 18391839],
  "assigned_by_uid": 1855589,
  "responsible_uid": null,
  "checked": 0,
  "in_history": 0,
  "is_deleted": 0,
  "is_archived": 0,
  "sync_id": null,
  "date_added": "Fri 26 Sep 2014 08:25:05 +0000"
}
```

### Properties

Property | Description
-------- | -----------
id  *Integer* | The id of the task.
user_id *Integer* | The owner of the task.
project_id *Integer* | Project that the task resides in
content *String* | The text of the task
date_string *String* | The date of the task, added in free form text, for example it can be `every day @ 10` (or `null` or an empty string if not set). Look at our reference to see [which formats are supported](https://todoist.com/Help/DatesTimes).
date_lang *String* | The language of the `date_string` (valid languages are: `en`, `da`, `pl`, `zh`, `ko`, `de`, `pt`, `ja`, `it`, `fr`, `sv`, `ru`, `es`, `nl`).
due_date_utc *String* | The date of the task in the format `Mon 07 Aug 2006 12:34:56 +0000` (or `null` if not set). For all day task (i.e. task due "Today"), the time part will be set as xx:xx:59.
priority *Integer* | The priority of the task (a number between `1` and `4`, `4` for very urgent and `1` for natural). <br>**Note**: Keep in mind that `very urgent` is the priority 1 on clients. So, `p1` will return `4` in the API.
indent *Integer* | The indent of the task (a number between `1` and `4`, where `1` is top-level).
item_order *Integer* | The order of the task inside a project (the smallest value would place the task at the top).
day_order *Integer* | The order of the task inside the `Today` or `Next 7 days` view (a number, where the smallest value would place the task at the top).
collapsed *Integer* | Whether the task's sub-tasks are collapsed (where `1` is true and `0` is false).
labels *Array of Integer* | The tasks labels (a list of label ids such as `[2324,2525]`).
assigned_by_uid *Integer* | The id of the user who assigns the current task. This makes sense for shared projects only. Accepts `0` or any user id from the list of project collaborators. If this value is unset or invalid, it will automatically be set up to your uid.
responsible_uid *Integer* | The id of user who is responsible for accomplishing the current task. This makes sense for shared projects only. Accepts any user id from the list of project collaborators or `null` or an empty string to unset.
checked *Integer* | Whether the task is marked as completed (where `1` is true and `0` is false).
in_history *Integer* | Whether the task has been marked as completed and is marked to be moved to history, because all the child tasks of its parent are also marked as completed (where `1` is true and `0` is false)
is_deleted *Integer* | Whether the task is marked as deleted (where `1` is true and `0` is false).
is_archived *Integer* | Whether the task is marked as archived (where `1` is true and `0` is false).
sync_id *Integer* | A special id for shared tasks (a number or `null` if not set). Used internally and can be ignored.
date_added *String* | The date when the task was created.


## Add an item

```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "item_add", "temp_id": "43f7ed23-a038-46b5-b2c9-4abda9097ffa", "uuid": "997d4b43-55f1-48a9-9e66-de5785dfd69b", "args": {"content": "Task1", "project_id": 128501470}}]'

{
  ...
  "sync_status": {"997d4b43-55f1-48a9-9e66-de5785dfd69b": "ok"},
  "temp_id_mapping": {"43f7ed23-a038-46b5-b2c9-4abda9097ffa": 33548400},
  ...
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> item = api.items.add('Task1', 128501470)
>>> api.commit()
```

Add a new task to a project.

### Command arguments

Parameter | Required | Description
--------- | -------- | -----------
content *String* | Yes | The text of the task.
project_id  *Integer or String (temp id)* | No | The id of the project to add the task to (a number or a temp id).  By default the task is added to the user’s `Inbox` project.
date_string *String* | No | The date of the task, added in free form text, for example it can be `every day @ 10` (or `null` or an empty string to unset). Look at our reference to see [which formats are supported](https://todoist.com/Help/DatesTimes).
date_lang *String* | No | The language of the `date_string` (valid languages are: `en`, `da`, `pl`, `zh`, `ko`, `de`, `pt`, `ja`, `it`, `fr`, `sv`, `ru`, `es`, `nl`).
due_date_utc *String* | No | The date of the task in the format `YYYY-MM-DDTHH:MM` (for example: `2012-3-24T23:59`). The value of `due_date_utc` must be in UTC. Note that, when the `due_date_utc` argument is specified, the `date_string` is required and has to specified as well, and also, the `date_string` argument will be parsed as local timestamp, and converted to UTC internally, according to the user's profile settings.
priority *Integer* | No | The priority of the task (a number between `1` and `4`, `4` for very urgent and `1` for natural). <br>**Note**: Keep in mind that `very urgent` is the priority 1 on clients. So, `p1` will return `4` in the API.
indent *Integer* | No | The indent of the task (a number between `1` and `4`, where `1` is top-level).
item_order *Integer* | No | The order of the task inside a project (a number, where the smallest value would place the task at the top).
day_order *Integer* | No | The order of the task inside the `Today` or `Next 7 days` view (a number, where the smallest value would place the task at the top).
collapsed *Integer* | No | Whether the task's sub-tasks are collapsed (where `1` is true and `0` is false).
labels *Array of Integer* | No | The tasks labels (a list of label ids such as `[2324,2525]`).
assigned_by_uid *Integer* | No | The id of user who assigns the current task. This makes sense for shared projects only. Accepts `0` or any user id from the list of project collaborators. If this value is unset or invalid, it will be automatically setup to your uid.
responsible_uid *Integer* | No | The id of user who is responsible for accomplishing the current task. This makes sense for shared projects only. Accepts any user id from the list of project collaborators or `null` or an empty string to unset.
auto_reminder *Boolean* | No | When this option is enabled, the default reminder will be added to the new item if it has a due date with time set.  See also the [auto_reminder user option](#user) for more info about the default reminder.

## Update an item

```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "item_update", "uuid": "318d16a7-0c88-46e0-9eb5-cde6c72477c8", "args": {"id": 33548400, "priority": 2}}]'

{
  ...
  "sync_status": {"318d16a7-0c88-46e0-9eb5-cde6c72477c8": "ok"},
  ...
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> item = api.items.get_by_id(33548400)
>>> item.update(priority=2)
>>> api.commit()
```

Updates an item for the user related to the API credentials.

### Command arguments

Parameter | Required | Description
--------- | -------- | -----------
id *Integer or String (temp id)* | Yes | The id of the task.
content *String* | No | The text of the task.
date_string *String* | No | The date of the task, added in free form text, for example it can be `every day @ 10` (or `null` or an empty string to unset). Look at our reference to see [which formats are supported](https://todoist.com/Help/DatesTimes).
date_lang  *String* | No | The language of the `date_string` (valid languages are: `en`, `da`, `pl`, `zh`, `ko`, `de`, `pt`, `ja`, `it`, `fr`, `sv`, `ru`, `es`, `nl`).
due_date_utc  *String* | No | The date of the task in the format `YYYY-MM-DDTHH:MM` (for example: `2012-3-24T23:59`). The value of `due_date_utc` must be in UTC. Note that, when the `due_date_utc` argument is specified, the `date_string` is required and has to specified as well, and also, the `date_string` argument will be parsed as local timestamp, and converted to UTC internally, according to the user's profile settings.
priority *Integer* | No | The priority of the task (a number between `1` and `4`, `4` for very urgent and `1` for natural). <br>**Note**: Keep in mind that `very urgent` is the priority 1 on clients. So, `p1` will return `4` in the API.
indent  *Integer* | No | The indent of the task (a number between `1` and `4`, where `1` is top-level).
item_order  *Integer* | No | The order of the task inside a project (a number, where the smallest value would place the task at the top).
day_order  *Integer* | No | The order of the task inside the `Today` or `Next 7 days` view (a number, where the smallest value would place the task at the top).
collapsed *Integer* | No | Whether the task's sub-tasks are collapsed (where `1` is true and `0` is false).
labels  *Array of Integer* | No | The tasks labels (a list of label ids such as `[2324,2525]`).
assigned_by_uid *Integer* | No | The id of the user who assigns the current task. This makes sense for shared projects only. Accepts `0` or any user id from the list of project collaborators. If this value is unset or invalid, it will be automatically setup to your uid.
responsible_uid *Integer* | No | The id of user who is responsible for accomplishing the current task. This makes sense for shared projects only. Accepts any user id from the list of project collaborators or `null` or an empty string to unset.

## Delete items

```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "item_delete", "uuid": "f8539c77-7fd7-4846-afad-3b201f0be8a5", "args": {"ids": [33548400]}}]'

{
  ...
  "sync_status": {"f8539c77-7fd7-4846-afad-3b201f0be8a5": "ok"},
  ...
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> item = api.items.get_by_id(33548400)
>>> item.delete()
>>> api.commit()
```

Delete an existing task.

### Command arguments

Parameter | Required | Description
--------- | -------- | -----------
ids  *Array of Integer (id) or String (temp id)* | Yes | List of the ids of the tasks to delete.

## Move an item

```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "item_move", "uuid": "818f108a-36d3-423d-857f-62837c245f3b", "args": {"project_items": {"128501470": [33548400]}, "to_project": 128501607}}]'

{
  ...
  "sync_status": {"818f108a-36d3-423d-857f-62837c245f3b": "ok"},
  ...
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.items.get_by_id(33548400)
>>> item.move(128501607)
>>> api.commit()
```

Move a task from one project to another project.

### Command arguments

Parameter | Required | Description
--------- | -------- | -----------
project_items *Object* | Yes | A JSON mapping telling Todoist where the items are currently found. From project ids to item ids, for example `{"1523":["9637423"]}`, where `1523` is the project id and `9637423` is the item id.
to_project *Integer* | Yes | The project id that the tasks should be moved to, for example `1245`.

## Complete items

```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "item_complete", "uuid": "a74bfb5c-5f1d-4d14-baea-b7415446a871", "args": {"ids": [33548400]}}]'

{ 
  ...
  "sync_status": {"a74bfb5c-5f1d-4d14-baea-b7415446a871": "ok"},
  ...
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.items.get_by_id(33548400)
>>> item.complete()
>>> api.commit()
```

Complete tasks and optionally move them to history. See also `item_close` for a
simplified version of the command.

### Command arguments

Parameter | Required | Description
--------- | -------- | -----------
ids *Array of Integer or String (temp id)* | Yes | A JSON list of ids to complete (numbers or temp ids).
force_history *Integer* | No | Whether these tasks should be moved to history (where `1` is true and `0` is false, and the default is `1`) This is useful when checking off sub tasks.

## Uncomplete items

```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "item_uncomplete", "uuid": "710a60e1-174a-4313-bb9f-4df01e0349fd", "args": {"ids": [33548400]}}]'

{
  ...
  "sync_status": {"710a60e1-174a-4313-bb9f-4df01e0349fd": "ok"},
  ...
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.items.get_by_id(33548400)
>>> item.uncomplete()
>>> api.commit()
```

Uncomplete tasks and move them to the active projects.

### Command arguments

Parameter | Required | Description
--------- | -------- | -----------
ids *Array of Integer or String (temp id)*| Yes | A list of items to uncomplete.
restore_state *Object* | No | A dictionary object, where the item id is the key, and its value is a list of four elements, whether the item is in history, whether it is checked, its order and indent - `item_id: [in_history, checked, item_order, indent]`


## Complete a recurring task


```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "item_update_date_complete", "uuid": "c5888360-96b1-46be-aaac-b49b1135feab", "args": {"id": 33548400, "new_date_utc": "2014-10-30T23:59", "date_string": "every day", "is_forward": 1}}]'

{
  ...
  "sync_status": {"c5888360-96b1-46be-aaac-b49b1135feab": "ok"},
  ...
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.items.update_date_complete(33548400, '2014-10-30T23:59', 'every day', 1)
>>> api.commit()
```

Complete a recurring task, and the reason why this is a special case is because
we need to mark a recurring completion (and using `item_update` won't do
this). See also `item_close` for a simplified version of the command.

### Command arguments

Parameter | Required | Description
--------- | -------- | -----------
id *Integer or String* | Yes | The id of the item to update (a number or a temp id).
new_date_utc *String* | No | The date of the task in the format `YYYY-MM-DDTHH:MM` (for example: `2012-3-24T23:59`). The value of `new_date_utc` must be in UTC. Note that, when the `new_date_utc` argument is specified, the `date_string` is required and has to specified as well, and also, the `date_string` argument will be parsed as local timestamp, and converted to UTC internally, according to the user's profile settings.
date_string  *String* | No | The date of the task, added in free form text, for example it can be `every day @ 10` (or `null` or an empty string to unset). Look at our reference to see [which formats are supported](https://todoist.com/Help/DatesTimes).
is_forward  *Integer* | No | Whether the task is to be completed (value `1`) or uncompleted (value `0`), while the default is `1`.


## Close item

```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "item_close", "uuid": "c5888360-96b1-46be-aaac-b49b1135feab", "args": {"id": 33548400}}]'

{
  ...
  "sync_status": {"c5888360-96b1-46be-aaac-b49b1135feab": "ok"},
  ...
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.items.get_by_id(33548400)
>>> item.close()
>>> api.commit()
```

A simplified version of `item_complete` / `item_update_date_complete`. The command
does exactly what official clients do when you close a task: regular task is
completed and moved to history, subtask is checked (marked as done, but not moved
to history), recurring task is moved forward (due date is updated).

### Command arguments

Parameter | Required | Description
--------- | -------- | -----------
id *Integer or String (temp id)* | Yes | The id of the item to close (a number or a temp id).


## Update multiple orders/indents

```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "item_update_orders_indents", "uuid": "a2bf0c06-f834-4442-99ab-b86fdfc66ed5", "args": {"ids_to_orders_indents": {"33548400": [1, 1]}}}]'

{
  ...
  "sync_status": {"a2bf0c06-f834-4442-99ab-b86fdfc66ed5": "ok"},
  ...
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.items.update_orders_indents({33548400: [1, 1]})
>>> api.commit()
```

Update the orders and indents of multiple items at once.

### Command arguments

Parameter | Required | Description
--------- | -------- | -----------
ids_to_orders_indents *Object* | Yes | A dictionary, where an item id is the key, and a list with two elements, the order and the indent, are its value: `item_id: [item_order, indent]`.


## Update day orders

```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "item_update_day_orders", "uuid": "dbeb40fc-905f-4d8a-8bae-547d3bbd6e91", "args": {"ids_to_orders": {"33548400": 1}}}]'

{
  ...
  "sync_status": {"dbeb40fc-905f-4d8a-8bae-547d3bbd6e91": "ok"},
  ...
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.items.update_day_orders({33548400: 1})
>>> api.commit()
```

Update the day orders of multiple items at once.

### Command arguments

Parameter | Required | Description
--------- | -------- | -----------
ids_to_orders *Object* | Yes | A dictionary, where an item id is the key, and the day order its value: `item_id: day_order`.
