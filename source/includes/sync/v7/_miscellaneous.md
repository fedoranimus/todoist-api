# Miscellaneous

## Get productivity stats

> An example of getting the user's productivity stats:

```shell
$ curl https://todoist.com/api/v7/completed/get_stats \
    -d token=0123456789abcdef0123456789abcdef01234567

{
  "karma_last_update": 50.0,
  "karma_trend": "up",
  "days_items": [
    { "date": "2014-11-03",
      "items": [],
      "total_completed": 0 },
  ],
  "completed_count": 0,
  "karma_update_reasons": [
    { "positive_karma_reasons": [4],
      "new_karma": 50.0,
      "negative_karma": 0.0,
      "positive_karma": 50.0,
      "negative_karma_reasons": [],
      "time": "Mon 20 Oct 2014 12:06:52"}
  ],
  "karma": 50.0,
  "week_items": [
    { "date": "2014-11-03\/2014-11-09",
      "items": [],
      "total_completed": 0 },
  ],
  "project_colors": {},
  "karma_graph": "https:\/\/todoist.com\/chart?cht=lc&chs=255x70&chd=s:A9&chco=dd4b39&chf=bg,s,ffffff&chxt=x,y&chxl=0:%7cMo%2C%2020%7c%7c1:%7c0%7c50&chxs=0,999999%7c1,999999",
  "goals": {
    "karma_disabled": 0,
    "user_id": 4,
    "max_weekly_streak": {
      "count": 0,
      "start": "",
      "end": ""
    },
    "ignore_days": [6, 7],
    "vacation_mode": 0,
    "current_weekly_streak": {
      "count": 0,
      "start": "",
      "end": ""
    },
    "current_daily_streak": {
      "count": 0,
      "start": "",
      "end": ""
    },
    "weekly_goal": 25,
    "max_daily_streak": {
      "count": 0,
      "start": "",
      "end": ""
    },
    "daily_goal": 5
  }
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.completed.get_stats()
{
  'karma_last_update': 50.0,
  'karma_trend': 'up',
  'days_items': [
    { 'date': '2014-11-03',
      'items': [],
      'total_completed': 0}
  ],
  'completed_count': 0,
  'karma_update_reasons': [
    { 'positive_karma_reasons': [4],
      'new_karma': 50.0,
      'negative_karma': 0.0,
      'positive_karma': 50.0,
      'negative_karma_reasons': [],
      'time': 'Mon 20 Oct 2014 12:06:52' }
  ],
  'karma': 50.0,
  'week_items': [
    { 'date': '2014-11-03/2014-11-09',
      'items': [],
      'total_completed': 0 },
  ],
  'project_colors': {},
  'karma_graph': 'https://todoist.com/chart?cht=lc&chs=255x70&chd=s:A9&chco=dd4b39&chf=bg,s,ffffff&chxt=x,y&chxl=0:%7cMo%2C%2020%7c%7c1:%7c0%7c50&chxs=0,999999%7c1,999999',
  'goals': {
    'karma_disabled': 0,
    'user_id': 4,
    'max_weekly_streak': {
      'count': 0,
      'start': '',
      'end': ''
    },
    'ignore_days': [6, 7],
    'vacation_mode': 0,
    'current_weekly_streak': {
      'count': 0,
      'start': '',
      'end': ''
    },
    'current_daily_streak': {
      'count': 0,
      'start': '',
      'end': ''
    },
    'weekly_goal': 25,
    'max_daily_streak': {
      'count': 0,
      'start': '',
      'end': ''
    },
    'daily_goal': 5
  }
}

```

Get the user's productivity stats.


## Get all completed items

> An example of getting the user's completed tasks

```shell
$ curl https://todoist.com/api/v7/completed/get_all \
    -d token=0123456789abcdef0123456789abcdef01234567

{
  "items": [
    { "content": "Item11",
      "meta_data": null,
      "user_id": 1855589,
      "task_id": 33511505,
      "note_count": 0,
      "project_id": 128501470,
      "completed_date": "Tue 17 Feb 2015 15:40:41 +0000",
      "id": 33511505
    }
  ],
  "projects": {
    "128501470":
    { "color": 7,
      "collapsed": 0,
      "indent": 1,
      "is_deleted": 0,
      "id": 128501470,
      "user_id": 1855589,
      "name": "Project1",
      "item_order": 36,
      "is_archived": 0 }
  }
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.completed.get_all()
{
  'items': [
    { 'user_id': 1855589,
      'task_id': 33511505,
      'note_count': 0,
      'completed_date': 'Tue 17 Feb 2015 15:40:41 +0000',
      'content': 'Item1',
      'meta_data': None,
      'project_id': 128501470,
      'id': 33511505},
  ],
  'projects': {
    '128501470':
      { 'name': 'Inbox',
        'user_id': 1855589,
        'color': 7,
        'is_deleted': 0,
        'collapsed': 0,
        'inbox_project': True,
        'item_order': 36,
        'is_archived': 0,
        'indent': 1,
        'id': 128501470 }
  }
}
```

*Only available for Todoist Premium users.*

Get all the user's completed items (tasks).

### Parameters

Parameter | Required | Description
--------- | -------- | -----------
project_id *Integer* | No | Filter the tasks by project id.
limit *Integer* | No | The number of items to return (where the default is `30`, and the maximum is `50`).
offset *Integer* | No | Can be used for pagination, when more than the `limit` number of tasks are returned.
until *String* | No | Return items with a completed date same or older than `until` (a string value formatted as `2007-4-29T10:13`).
since *String* | No | Return items with a completed date newer than `since` (a string value formatted as `2007-4-29T10:13`).
annotate_notes *Boolean* | No | Return notes together with the completed items (a `true` or `false` value).

## Get archived projects

> An example of getting the user's archived projects

```shell
$ curl https://todoist.com/api/v7/projects/get_archived \
    -d token=0123456789abcdef0123456789abcdef01234567

[
  {
    "id" : 150977840,
    "name" : "Project1",
    "item_order" : 1,
    "indent" : 1,
    "color" : 7,
    "collapsed" : 0
    "is_archived" : 1,
    "is_deleted" : 0,
  }
]
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.projects.get_archived()
[
  {
    'id' : 150977840,
    'name' : 'Project1',
    'item_order' : 1,
    'indent' : 1,
    'color' : 7,
    'collapsed' : 0
    'is_archived' : 1,
    'is_deleted' : 0,
  }
]
```

Get the user's archived projects.


## Add item

> An example of adding a task:

```shell
$ curl https://todoist.com/api/v7/items/add \
    -d token=0123456789abcdef0123456789abcdef01234567
    -d content=Task1

{
  "assigned_by_uid": 1855589,
  "is_archived": 0,
  "labels": [],
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
  "responsible_uid": null,
  "project_id": 128501411,
  "collapsed": 0,
  "checked": 0,
  "date_string": ""
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.add_item("Task1")
{
  'is_archived': 0,
  'labels': [],
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
  'responsible_uid': None
}
```

Add a new task to a project. Note, that this is provided as a helper
method, a shortcut, to quickly add a task without going through the
`Sync workflow` described in a previous section.

### Parameters

Parameter | Required | Description
--------- | -------- | -----------
content *String* | Yes | The text of the task.
project_id *Integer* | No | The id of the project to add the task to, while the default is the user's `Inbox` project.
date_string *String* | No | The date of the task, added in free form text, for example it can be `every day @ 10` (or `null` or an empty string to unset). Look at our reference to see [which formats are supported](https://todoist.com/Help/DatesTimes).
priority *Integer* | No | The priority of the task (a number between `1` and `4`, `4` for very urgent and `1` for natural). <br>**Note**: Keep in mind that `very urgent` is the priority 1 on clients. So, `p1` will return `4` in the API.
indent *Integer* | No | The indent of the task (between `1` and `4`, where `1` is top-level).
item_order *Integer* | No | The order of the task inside a project (where the smallest value would place the task at the top).
labels *Array of Integer* | No | The task's labels (a list of label ids such as `[2324,2525]`).
assigned_by_uid *Integer* | No | The id of the user who assigns the current task. This makes sense for shared projects only. Accepts `0` or any user id from the list of project collaborators. If this value is unset or invalid, it will automatically be set up to your uid.
responsible_uid *Integer* | No | The id of user who is responsible for accomplishing the current task. This makes sense for shared projects only. Accepts `0` or any user id from the list of project collaborators. If this value is unset or invalid, it will automatically be set to `null`.
note *String* | No | Add a note directly to the task (a string value that will become the content of the note).
auto_reminder *Boolean* | No | When this option is enabled, the default reminder will be added to the new item if it has a due date with time set.  See also the [auto_reminder user option](#user) for more info about the default reminder.

## Get item info

> An example of getting an item's info:

```shell
$ curl https://todoist.com/api/v7/items/get \
    -d token=0123456789abcdef0123456789abcdef01234567
    -d item_id=466

{
  "project": {
    "name": "Inbox",
    "color": 7,
    "is_deleted": 0,
    "collapsed": 0,
    "inbox_project": true,
    "item_order": 0,
    "indent": 1,
    "id": 1,
    "shared": false,
    "is_archived": 0
  },
  "item": {
    "assigned_by_uid": 1,
    "due_date_utc": null,
    "is_archived": 0,
    "labels": [],
    "sync_id": null,
    "in_history": 0,
    "date_added": "Tue 22 Mar 2016 16:00:00 +0000",
    "checked": 0,
    "date_lang": "en",
    "id": 466,
    "content": "foo",
    "indent": 1,
    "user_id": 1,
    "is_deleted": 0,
    "priority": 1,
    "item_order": 1,
    "responsible_uid": null,
    "project_id": 1,
    "collapsed": 0,
    "date_string": null
  },
  "notes": [
    {
      "is_deleted": 0,
      "is_archived": 0,
      "file_attachment": null,
      "content": "1",
      "posted_uid": 1,
      "uids_to_notify": null,
      "item_id": 466,
      "project_id": 1,
      "id": 36,
      "posted": "Wed 18 May 2016 16:45:00 +0000"
    },
    {
      "is_deleted": 0,
      "is_archived": 0,
      "file_attachment": null,
      "content": "2",
      "posted_uid": 1,
      "uids_to_notify": null,
      "item_id": 466,
      "project_id": 1,
      "id": 37,
      "posted": "Wed 18 May 2016 16:45:00 +0000"
    },
    {
      "is_deleted": 0,
      "is_archived": 0,
      "file_attachment": null,
      "content": "3",
      "posted_uid": 1,
      "uids_to_notify": null,
      "item_id": 466,
      "project_id": 1,
      "id": 38,
      "posted": "Wed 18 May 2016 16:45:00 +0000"
    }
  ]
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.items.get(466)
{
  'project': {
    'name': 'Inbox',
    'color': 7,
    'is_deleted': 0,
    'collapsed': 0,
    'inbox_project': true,
    'item_order': 0,
    'indent': 1,
    'id': 1,
    'shared': false,
    'is_archived': 0
  },
  'item': {
    'assigned_by_uid': 1,
    'due_date_utc': null,
    'is_archived': 0,
    'labels': [],
    'sync_id': null,
    'in_history': 0,
    'date_added': 'Tue 22 Mar 2016 16:00:00 +0000',
    'checked': 0,
    'date_lang': 'en',
    'id': 466,
    'content': 'foo',
    'indent': 1,
    'user_id': 1,
    'is_deleted': 0,
    'priority': 1,
    'item_order': 1,
    'responsible_uid': null,
    'project_id': 1,
    'collapsed': 0,
    'date_string': null
  },
  'notes': [
    {
      'is_deleted': 0,
      'is_archived': 0,
      'file_attachment': null,
      'content': '1',
      'posted_uid': 1,
      'uids_to_notify': null,
      'item_id': 466,
      'project_id': 1,
      'id': 36,
      'posted': 'Wed 18 May 2016 16:45:00 +0000'
    },
    {
      'is_deleted': 0,
      'is_archived': 0,
      'file_attachment': null,
      'content': '2',
      'posted_uid': 1,
      'uids_to_notify': null,
      'item_id': 466,
      'project_id': 1,
      'id': 37,
      'posted': 'Wed 18 May 2016 16:45:00 +0000'
    },
    {
      'is_deleted': 0,
      'is_archived': 0,
      'file_attachment': null,
      'content': '3',
      'posted_uid': 1,
      'uids_to_notify': null,
      'item_id': 466,
      'project_id': 1,
      'id': 38,
      'posted': 'Wed 18 May 2016 16:45:00 +0000'
    }
  ]
}
```

This function is used to extract detailed information about the item,
including all the notes.

It's especially important, because on initial load we return back no more than
10 last notes, and if client wants to get more, they can be downloaded with
`get_item` endpoint.

It returns a JSON object with the `item`, and optionally the `project`
and `notes` attributes.

### Parameters

Parameter | Required | Description
--------- | -------- | -----------
item_id *Integer* | Yes | The item's unique id.
all_data *Boolean* | No | Whether to return the parent project and notes of the item (a `true` or `false` value, while the default is `true`).

## Get project info

> An example of getting a project's info:

```shell
$ curl https://todoist.com/api/v7/projects/get \
    -d token=0123456789abcdef0123456789abcdef01234567
    -d project_id=128501682

{
  "project" : {
    "id": 128501682,
    "name": "Project1",
    "color": 1,
    "indent": 1,
    "item_order": 36,
    "collapsed": 0,
    "shared": false,
    "is_deleted": 0,
    "is_archived": 0,
  },
  "notes" : [
    {
      "is_deleted": 0,
      "is_archived": 0,
      "file_attachment": null,
      "content": "Note1",
      "posted_uid": 1,
      "uids_to_notify": null,
      "project_id": 128501682,
      "id": 17299568,
      "posted": "Wed 18 May 2016 16:45:00 +0000"
    },
  ]
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.projects.get(128501682)
{
  "project" : {
    'id': 128501682,
    'name': 'Project1',
    'color': 1,
    'indent': 1,
    'item_order': 36,
    'collapsed': 0,
    'shared': false,
    'is_deleted': 0,
    'is_archived': 0,
  },
  "notes" : [
    {
      'is_deleted': 0,
      'is_archived': 0,
      'file_attachment': null,
      'content': 'Note1',
      'posted_uid': 1,
      'uids_to_notify': null,
      'project_id': 128501682,
      'id': 17299568,
      'posted': 'Wed 18 May 2016 16:45:00 +0000'
    },
  ]
}
```

This function is used to extract detailed information about the
project, including all the notes.

It's especially important, because on initial load we return back no more than
10 last notes, and if client wants to get more, they can be downloaded with
`get_project` endpoint.

It returns a JSON object with the `project`, and optionally the `notes` attributes.

### Parameters

Parameter | Required | Description
--------- | -------- | -----------
project_id *Integer* | Yes | The projects's unique id.
all_data *Boolean* | No | Whether to return the notes of the project (a `true` or `false` value, while the default is `true`).


## Get project data

> An example of getting a project's data:

```shell
$ curl https://todoist.com/api/v7/projects/get_data \
    -d token=0123456789abcdef0123456789abcdef01234567
    -d project_id=128501682

{
  "project" : {
    "item_order" : 4,
    "user_id" : 1855589,
    "is_archived" : 0,
    "is_deleted" : 0,
    "id" : 175655925,
    "archived_date" : null,
    "collapsed" : 0,
    "indent" : 1,
    "archived_timestamp" : 0,
    "color" : 7,
    "name" : "Project1"
  },
  "items" : [
    {
      "is_deleted" : 0,
      "date_string" : "",
      "date_added" : "Tue 19 Jul 2016 12:50:49 +0000",
      "item_order" : 1,
      "responsible_uid" : null,
      "due_date" : null,
      "content" : "Task1",
      "id" : 101964377,
      "user_id" : 1855589,
      "date_lang" : "en",
      "assigned_by_uid" : 1855589,
      "in_history" : 0,
      "is_archived" : 0,
      "project_id" : 175655925,
      "sync_id" : null,
      "collapsed" : 0,
      "due_date_utc" : null,
      "indent" : 1,
      "labels" : [],
      "checked" : 0,
      "priority" : 1
    }
  ]
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.projects.get_data(128501682)
{
  'project' : {
    'item_order' : 4,
    'user_id' : 1855589,
    'is_archived' : 0,
    'is_deleted' : 0,
    'id' : 175655925,
    'archived_date' : None,
    'collapsed' : 0,
    'indent' : 1,
    'archived_timestamp' : 0,
    'color' : 7,
    'name' : 'Project1'
  },
  'items' : [
    {
      'is_deleted' : 0,
      'date_string' : '',
      'date_added' : 'Tue 19 Jul 2016 12:50:49 +0000',
      'item_order' : 1,
      'responsible_uid' : None,
      'due_date' : None,
      'content' : 'Task1',
      'id' : 101964377,
      'user_id' : 1855589,
      'date_lang' : 'en',
      'assigned_by_uid' : 1855589,
      'in_history' : 0,
      'is_archived' : 0,
      'project_id' : 175655925,
      'sync_id' : None,
      'collapsed' : 0,
      'due_date_utc' : None,
      'indent' : 1,
      'labels' : [],
      'checked' : 0,
      'priority' : 1
    }
  ]
}
```

Get a project's uncompleted items.

### Parameters

Parameter | Required | Description
--------- | -------- | -----------
project_id *Integer* | Yes | The projects's unique id.
