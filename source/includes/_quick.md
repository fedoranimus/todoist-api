# Quick

## Quick add task

> An example of quick add task:

```shell
$ curl https://todoist.com/API/v7/quick/add \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d text='Task1 @Label1 #Project1 +ExampleUser'
{
  "assigned_by_uid": 1855589,
  "is_archived": 0,
  "labels": [
    874,
  ],
  "sync_id": null,
  "in_history": 0,
  "date_added": "Wed 18 Feb 2015 11:09:11 +0000",
  "indent": 1,
  "children": null,
  "content": "Task1",
  "is_deleted": 0,
  "user_id": 1855589,
  "due_date_utc": null,
  "id": 33548400,
  "priority": 4,
  "item_order": 1,
  "responsible_uid": 1855589,
  "project_id": 128501411,
  "collapsed": 0,
  "checked": 0,
  "date_string": ""
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.quick.add('Task1 @Label1 #Project1 +ExampleUser')
{
  'is_archived': 0,
  'labels': [
    874
  ],
  'sync_id': None,
  'in_history': 0,
  'checked': 0,
  'id': 33548400,
  'priority': 4,
  'user_id': 1855589,
  'date_added': 'Wed 18 Feb 2015 11:09:11 +0000',
  'children': None,
  'content': 'Task1',
  'item_order': 1,
  'project_id': 128501411,
  'date_string': '',
  'assigned_by_uid': 1855589,
  'collapsed': 0,
  'indent': 1,
  'is_deleted': 0,
  'due_date_utc': None,
  'responsible_uid': 1855589,
}
```

Implementation of the Quick Add Task available in the official clients.

### Required parameters

Parameter | Description
--------- | -----------
token *String* | The user's token received on login.
text *String* | The text of the task that is parsed.  It can include a due date in free form text, a project name starting with the `#` character, a label starting with the `@` character, and an assignee starting with the `+` character.

### Optional parameters

Parameter | Description
--------- | -----------
note *String* | The content of the note.
reminder *String* | The date of the reminder, added in free form text.
