# Items

> A item in Todoist is a JSON object. The dates will be in UTC timezone. Typically a item object will look like:

```shell
{
  "id": 33511505,
  "user_id": 1855589,
  "project_id": 128501470,
  "content": "Task1",
  "date_string": "",
  "date_lang": "en",
  "due_date_utc": null,
  "due_date": null,
  "indent": 1,
  "priority": 1,
  "item_order": 1,
  "day_order": -1,
  "collapsed": 0,
  "children": null,
  "labels": [],
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

```python
{
  'id': 33511505,
  'user_id': 1855589,
  'project_id': 128501470,
  'content': 'Task1',
  'date_string': '',
  'date_lang': 'en',
  'due_date_utc': None,
  'due_date': None,
  'priority': 1,
  'indent': 1,
  'item_order': 1,
  'day_order': -1,
  'collapsed': 0,
  'children': None,
  'labels': [],
  'assigned_by_uid': 1855589,
  'responsible_uid': None,
  'checked': 0,
  'in_history': 0,
  'is_deleted': 0,
  'is_archived': 0,
  'sync_id': None,
  'date_added': 'Fri 26 Sep 2014 08:25:05 +0000'
}
```

### Properties

Property | Description
-------- | -----------
id | The id of the task (a unique number).
user_id | The owner of the task (a unique number).
project_id | The id of the project to add the task to (a unique number).
content | The text of the task (a string value).
date_string | The date of the task, added in free form text, for example it can be `every day @ 10`. Look at our reference to see [which formats are supported](https://todoist.com/Help/DatesTimes).
date_lang | The language of the date_string (valid languages are: `en`, `da`, `pl`, `zh`, `ko`, `de`, `pt`, `ja`, `it`, `fr`, `sv`, `ru`, `es`, `nl`).
due_date_utc | The date of the task in a format like `Mon 07 Aug 2006 12:34:56 +0100` (or `null` if not set).
priority | The priority of the task (a number between `1` and `4`, `4` for very urgent and `1` for natural).
indent | The indent of the task (a number between `1` and `4`, where `1` is top-level).
item_order | The order of the task inside a project (a number, where the smallest value would place the task at the top).
day_order | The order of the task inside the `Today` or `Next 7 days` view (a number, where the smallest value would place the task at the top).
collapsed | Whether the task's sub-tasks are collapsed (where `1` is true and `0` is false).
children | The task's child tasks (will always be `null`, as this is deprecated).
labels | The tasks labels (a list of label ids such as `[2324,2525]`).
assigned_by_uid | The id of user who assigns the current task. This makes sense for shared projects only. Accepts `0` or any user id from the list of project collaborators. If this value is unset or invalid, it will automatically be set up to your uid.
responsible_uid | The id of user who is responsible for accomplishing the current task. This makes sense for shared projects only. Accepts `0` or any user id from the list of project collaborators. If this value is unset or invalid, it will automatically be set to `null`.
checked | Whether the task is marked as completed (where `1` is true and `0` is false).
in_history | Whether the task has been marked as completed and is marked to be moved to history, because all the child tasks of its parent are also marked as completed (where `1` is true and `0` is false)
is_deleted | Whether the task is marked as deleted (where `1` is true and `0` is false).
is_archived | Whether the task is marked as archived (where `1` is true and `0` is false).
sync_id | A special id for shared tasks (a number or `null` if not set).
date_added | The date when the task was created.


## Add an item

> An example of adding a task:

```shell
$ curl https://todoist.com/API/v6/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "item_add", "temp_id": "43f7ed23-a038-46b5-b2c9-4abda9097ffa", "uuid": "997d4b43-55f1-48a9-9e66-de5785dfd69b", "args": {"content": "Task1", "project_id": 128501470}}]'
{ ...
  "SyncStatus": {"997d4b43-55f1-48a9-9e66-de5785dfd69b": "ok"},
  "TempIdMapping": {"43f7ed23-a038-46b5-b2c9-4abda9097ffa": 33548400},
  ... }
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> item = api.items.add('Task1', 128501470)
>>> api.commit()
```

Add a new task to a project.

### Required arguments

Argument | Description
-------- | -----------
project_id | The id of the project to add the task to (a number or a temp id).
content | The text of the task (a string value).

### Optional arguments

Argument | Description
-------- | -----------
date_string | The date of the task, added in free form text, for example it can be `every day @ 10`. Look at our reference to see [which formats are supported](https://todoist.com/Help/DatesTimes).
date_lang | The language of the date_string (valid languages are: `en`, `da`, `pl`, `zh`, `ko`, `de`, `pt`, `ja`, `it`, `fr`, `sv`, `ru`, `es`, `nl`).
due_date_utc | The date of the task in the format `YYYY-MM-DDTHH:MM` (for example: `2012-3-24T23:59`). The value of `due_date_utc` must be in UTC. If you want to pass in due dates, note that `date_string` is required, while `due_date_utc` can be omitted. If date_string is provided, it will be parsed as local timestamp, and converted to UTC internally, according to the user's profile settings.
priority | The priority of the task (a number between `1` and `4`, `4` for very urgent and `1` for natural).
indent | The indent of the task (a number between `1` and `4`, where `1` is top-level).
item_order | The order of the task inside a project (a number, where the smallest value would place the task at the top).
day_order | The order of the task inside the `Today` or `Next 7 days` view (a number, where the smallest value would place the task at the top).
collapsed | Whether the task's sub-tasks are collapsed (where `1` is true and `0` is false).
children | The task's child tasks (will always be `null`, as this is deprecated).
labels | The tasks labels (a list of label ids such as `[2324,2525]`).
assigned_by_uid | The id of user who assigns the current task. This makes sense for shared projects only. Accepts `0` or any user id from the list of project collaborators. If this value is unset or invalid, it will automatically be set up to your uid.
responsible_uid | The id of user who is responsible for accomplishing the current task. This makes sense for shared projects only. Accepts `0` or any user id from the list of project collaborators. If this value is unset or invalid, it will automatically be set to `null`.
note | Add a note directly to the task (a string value that will become the content of the note).

## Update an item

> An example of updating a task:

```shell
$ curl https://todoist.com/API/v6/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "item_update", "uuid": "318d16a7-0c88-46e0-9eb5-cde6c72477c8", "args": {"id": 33548400, "priority": 2}}]'
{ ...
  "SyncStatus": {"318d16a7-0c88-46e0-9eb5-cde6c72477c8": "ok"},
  ... }
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> item = api.items.get_by_id(33548400)
>>> item.update(priority=2)
>>> api.commit()
```

Update an existing task.

### Required arguments
Argument | Description
-------- | -----------
id | The id of the task (a number).

### Optional arguments

Argument | Description
-------- | -----------
content | The text of the task (a string value).
date_string | The date of the task, added in free form text, for example it can be `every day @ 10`. Look at our reference to see [which formats are supported](https://todoist.com/Help/DatesTimes).
date_lang | The language of the date_string (valid languages are: `en`, `da`, `pl`, `zh`, `ko`, `de`, `pt`, `ja`, `it`, `fr`, `sv`, `ru`, `es`, `nl`).
due_date_utc | The date of the task in the format `YYYY-MM-DDTHH:MM` (for example: `2012-3-24T23:59`). The value of `due_date_utc` must be in UTC. If you want to pass in due dates, note that `date_string` is required, while `due_date_utc` can be omitted. If date_string is provided, it will be parsed as local timestamp, and converted to UTC internally, according to the user's profile settings.
due_date | The same as `due_date_utc` (to be deprecated).
priority | The priority of the task (a number between `1` and `4`, `4` for very urgent and `1` for natural).
indent | The indent of the task (a number between `1` and `4`, where `1` is top-level).
item_order | The order of the task inside a project (a number, where the smallest value would place the task at the top).
day_order | The order of the task inside the `Today` or `Next 7 days` view (a number, where the smallest value would place the task at the top).
collapsed | Whether the task's sub-tasks are collapsed (where `1` is true and `0` is false).
children | The task's child tasks (will always be `null`, as this is deprecated).
labels | The tasks labels (a list of label ids such as `[2324,2525]`).
aassigned_by_uid | The id of user who assigns the current task. This makes sense for shared projects only. Accepts `0` or any user id from the list of project collaborators. If this value is unset or invalid, it will automatically be set up to your uid.
responsible_uid | The id of user who is responsible for accomplishing the current task. This makes sense for shared projects only. Accepts `0` or any user id from the list of project collaborators. If this value is unset or invalid, it will automatically be set to `null`.
note | Add a note directly to the task (a string value that will become the content of the note).

## Delete items

> An example of deleting a task:

```shell
$ curl https://todoist.com/API/v6/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "item_delete", "uuid": "f8539c77-7fd7-4846-afad-3b201f0be8a5", "args": {"ids": [33548400]}}]'
{ ...
  "SyncStatus": {"f8539c77-7fd7-4846-afad-3b201f0be8a5": {"33548400": "ok"}},
  ... }
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> item = api.items.get_by_id(33548400)
>>> item.delete()
>>> api.commit()
```

Delete an existing task.

### Required arguments

Argument | Description
-------- | -----------
ids | List of the ids of the tasks to delete (numbers or temp ids).

## Move an item

> An example of moving of a task from one project to another project:

```shell
$ curl https://todoist.com/API/v6/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "item_move", "uuid": "818f108a-36d3-423d-857f-62837c245f3b", "args": {"project_items": {"128501470": [33548400]}, "to_project": 128501607}}]'
{ ...
  "SyncStatus": {"818f108a-36d3-423d-857f-62837c245f3b": {"33548400": "ok"}},
  ... }

```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.items.get_by_id(33548400)
>>> item.move(128501607)
>>> api.commit()
```

Move a task from one project to another project.

### Required arguments
Argument | Description
-------- | -----------
project_items | A JSON mapping telling Todoist where the items are currently found. From project ids to item ids, could be like this `{"1523":["9637423"]}`, where `1523` is project id and `9637423` is the item id.
to_project | A project id that the tasks should be moved, for example `1245`.

## Complete items

> An example of completing a task:

```shell
$ curl https://todoist.com/API/v6/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "item_complete", "uuid": "a74bfb5c-5f1d-4d14-baea-b7415446a871", "args": {"project_id": 128501470, "ids": [33548400]}}]'
{ ...
  "SyncStatus": {"a74bfb5c-5f1d-4d14-baea-b7415446a871": {"33548400": "ok"}},
  ... }
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.items.get_by_id(33548400)
>>> item.complete()
>>> api.commit()
```

Complete tasks and move them to history.

### Required arguments

Argument | Description
-------- | -----------
project_id | The id of the project which the items are part of (a number or a temp id).
ids | A JSON list of ids to complete (numbers or temp ids).

### Optional arguments

Argument | Description
-------- | -----------
force_history | Whether these tasks should be moved to history (where `1` is true and `0` is false, and the default is `1`) This is useful when checking off sub tasks.

## Uncomplete items

> An example of uncompleting a task:

```shell
$ curl https://todoist.com/API/v6/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "item_uncomplete", "uuid": "710a60e1-174a-4313-bb9f-4df01e0349fd", "args": {"project_id": 128501470, "ids": [33548400]}}]'
{ ...
  "SyncStatus": {"710a60e1-174a-4313-bb9f-4df01e0349fd": {"33548400": "ok"}},
  ... }
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.items.get_by_id(33548400)
>>> item.uncomplete()
>>> api.commit()
```

Uncomplete tasks and move them to the active projects.

### Required arguments

Argument | Description
-------- | -----------
project_id | The id of the project to which the items will be moved to (a number or a temp id).
ids | A JSON list of ids to uncomplete (numbers or temp ids).

### Optional arguments

Argument | Description
-------- | -----------
update_item_orders | Whether the item orders should be updated (where `1` is true and `0` is false, and the default is `1`).
restore_state | A dictionary, where the item id is the key, and its value is a list of four elements, whether the item is in history, whether it is checked, its order and indent: `item_id: [in_history, checked, item_order, indent]`


## Complete a recurring task

> An example of completing a recurring task:

```shell
$ curl https://todoist.com/API/v6/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "item_update_date_complete", "uuid": "c5888360-96b1-46be-aaac-b49b1135feab", "args": {"id": 33548400, "new_date_utc": "2014-10-30T23:59", "date_string": "every day", "is_forward": 1}}]'
{ ...
  "SyncStatus": {"c5888360-96b1-46be-aaac-b49b1135feab": "ok"},
  ... }
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.items.update_date_complete(33548400, '2014-10-30T23:59', 'every day', 1)
>>> api.commit()
```

Complete a recurring task, and the reason why this is a special case is because we need to mark a recurring completion (and using `item_update` won't do this).

### Required arguments

Argument | Description
-------- | -----------
id | The id of the item to update (a number or a temp id).

### Optional arguments

Argument | Description
-------- | -----------
new_date_utc | The date of the task in the format `YYYY-MM-DDTHH:MM` (for example: `2012-3-24T23:59`). The value of `due_date_utc` must be in UTC. If you want to pass in due dates, note that `date_string` is required, while `due_date_utc` can be omitted. If date_string is provided, it will be parsed as local timestamp, and converted to UTC internally, according to the user's profile settings.
date_string | The date of the task, added in free form text, for example it can be `every day @ 10`. Look at our reference to see [which formats are supported](https://todoist.com/Help/DatesTimes).
is_forward | Whether the task is to be completed (value `1`) or uncompleted (value `0`), while the default is `1`.

## Update multiple orders/indents

> An example of updating the orders and indents of multiple items at once:

```shell
$ curl https://todoist.com/API/v6/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "item_update_orders_indents", "uuid": "a2bf0c06-f834-4442-99ab-b86fdfc66ed5", "args": {"ids_to_orders_indents": {"33548400": [1, 1]}}}]'
{ ...
  "SyncStatus": {"a2bf0c06-f834-4442-99ab-b86fdfc66ed5": {"33548400": "ok"}},
  ... }
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.items.update_orders_indents({33548400: [1, 1]})
>>> api.commit()
```

Update the orders and indents of multiple items at once.

### Required arguments

Argument | Description
-------- | -----------
ids_to_orders_indents | A dictionary, where an item id is the key, and a list with two elements, the order and the indent, are its value: `item_id: [item_order, indent]`.

## Update day orders

> An example of updating the day orders of multiple items at once:

```shell
$ curl https://todoist.com/API/v6/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "item_update_day_orders", "uuid": "dbeb40fc-905f-4d8a-8bae-547d3bbd6e91", "args": {"ids_to_orders": {"33548400": 1}}}]'
{ ...
  "SyncStatus": {"dbeb40fc-905f-4d8a-8bae-547d3bbd6e91": {"33548400": "ok"}},
  ... }
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.items.update_day_orders({33548400: 1})
>>> api.commit()
```

Update the day orders of multiple items at once.

### Required arguments

Argument | Description
-------- | -----------
ids_to_orders | A dictionary, where an item id is the key, and the day order its value: `item_id: day_order`.
