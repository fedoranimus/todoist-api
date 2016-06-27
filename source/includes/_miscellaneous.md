# Miscellaneous

## Get productivity stats

> An example of getting the user's productivity stats:

```shell
$ curl https://todoist.com/API/v7/get_productivity_stats \
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
>>> api.get_productivity_stats()
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

### Required parameters

Parameter | Description
--------- | -----------
token | The user's token received on login (a string hash value).

## Update notification settings

> An example of updating the user's notification settings

```shell
$ curl https://todoist.com/API/v7/update_notification_setting \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d notification_type=item_completed \
    -d service=email \
    -d dont_notify=1
{
  "user_left_project": {
    "notify_push": true,
    "notify_email": true
  },
  "biz_trial_will_end": {
    "notify_push": true,
    "notify_email": true
  },
  "biz_trial_enter_cc": {
    "notify_push": true,
    "notify_email": true
  },
  "item_completed": {
    "notify_push": true,
    "notify_email": false
  },
  "share_invitation_rejected": {
    "notify_push": true,
    "notify_email": true
  },
  "note_added": {
    "notify_push": true,
    "notify_email": true
  },
  "biz_account_disabled": {
    "notify_push": true,
    "notify_email": true
  },
  "biz_invitation_rejected": {
    "notify_push": true,
    "notify_email": true
  },
  "item_uncompleted": {
    "notify_push": true,
    "notify_email": true
  },
  "item_assigned": {
    "notify_push": true,
    "notify_email": true
  },
  "share_invitation_accepted": {
    "notify_push": true,
    "notify_email": true
  },
  "user_removed_from_project": {
    "notify_push": true,
    "notify_email": true
  },
  "biz_invitation_accepted": {
    "notify_push": true,
    "notify_email": true
  },
  "biz_payment_failed": {
    "notify_push": true,
    "notify_email": true
  }
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.update_notification_setting('item_completed', 'email', 1)
{
  'biz_invitation_rejected': {
    'notify_push': True,
    'notify_email': True
  },
  'user_left_project': {
    'notify_push': True,
    'notify_email': True
  },
  'note_added': {
    'notify_push': True,
    'notify_email': True
  },
  'biz_trial_enter_cc': {
    'notify_push': True,
    'notify_email': True
  },
  'item_completed': {
    'notify_push': True,
    'notify_email': False
  },
  'biz_trial_will_end': {
    'notify_push': True,
    'notify_email': True
  },
  'biz_account_disabled': {
    'notify_push': True,
    'notify_email': True
  },
  'share_invitation_rejected': {
    'notify_push': True,
    'notify_email': True
  },
  'item_uncompleted': {
    'notify_push': True,
    'notify_email': True
  },
  'item_assigned': {
    'notify_push': True,
    'notify_email': True
  },
  'share_invitation_accepted': {
    'notify_push': True,
    'notify_email': True
  },
  'user_removed_from_project': {
    'notify_push': True,
    'notify_email': True
  },
  'biz_invitation_accepted': {
    'notify_push': True,
    'notify_email': True
  },
  'biz_payment_failed': {
    'notify_push': True,
    'notify_email': True
  }
}
```

Update the user's notification settings.

### Required parameters

Parameter | Description
--------- | -----------
token | The user's token received on login (a string hash value).
notification_type | The notification type (a string value).  For a list of notifications have a look at the `Live Notifications` section.
service | The service type, which can take the values: `email` or `push`.
dont_notify | Whether notifications of this service should be notified (`1` to not notify, and `0` to nofify).

## Get all completed items

> An example of getting the user's completed tasks

```shell
$ curl https://todoist.com/API/v7/get_all_completed_items \
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
>>> api.get_all_completed_items()
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

Get all the user's completed items (tasks). Only available for Todoist Premium users.

### Required parameters

Parameter | Description
--------- | -----------
token | The user's token received on login (a string hash value).

### Optional parameters

Parameter | Description
--------- | -----------
project_id | Filter the tasks by project id (a unique number).
limit | The number of items to return (a number, where the default is `30`, and the maximum is `50`).
offset | Can be used for pagination, when more than the `limit` number of tasks are returned (a number).
until | Return items with a completed date same or older than `until` (a string value formatted as `2007-4-29T10:13`).
since | Return items with a completed date newer than `since` (a string value formatted as `2007-4-29T10:13`).
annotate_notes | Return notes together with the completed items (a `true` or `false` value).

## Get archived projects

> An example of getting the user's archived projects

```shell
$ curl https://todoist.com/API/v7/projects/get_archived \
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
>>> api.get_archived_projects()
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

### Required parameters

Parameter | Description
--------- | -----------
token | The user's token received on login (a string hash value).

## Add item

> An example of adding a task:

```shell
$ curl https://todoist.com/API/v7/add_item \
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
  "date_string": "" }
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.add_item("Task1")
{ 'is_archived': 0,
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
  'responsible_uid': None }
```

Add a new task to a project.  Note, that this is provided as a helper method, a shortcut, to quickly add a task without going through the `Sync workflow` described in a previous section.

### Required parameters

Parameter | Description
--------- | -----------
token | The user's token received on login (a string hash value).
content | The text of the task (a string value).

### Optional parameters

Parameter | Description
--------- | -----------
project_id | The id of the project to add the task to (a unique number), while the default is the user's `Inbox` project.
date_string | The date of the task, added in free form text, for example it can be `every day @ 10` (or `null` or an empty string to unset). Look at our reference to see [which formats are supported](https://todoist.com/Help/DatesTimes).
priority | The priority of the task (a number between `1` and `4`, `4` for very urgent and `1` for natural).
indent | The indent of the task (a number between `1` and `4`, where `1` is top-level).
item_order | The order of the task inside a project (a number, where the smallest value would place the task at the top).
labels | The task's labels (a list of label ids such as `[2324,2525]`).
assigned_by_uid | The id of the user who assigns the current task. This makes sense for shared projects only. Accepts `0` or any user id from the list of project collaborators. If this value is unset or invalid, it will automatically be set up to your uid.
responsible_uid | The id of user who is responsible for accomplishing the current task. This makes sense for shared projects only. Accepts `0` or any user id from the list of project collaborators. If this value is unset or invalid, it will automatically be set to `null`.
note | Add a note directly to the task (a string value that will become the content of the note).

## Get item info

> An example of getting an item's info:

```shell
$ curl https://todoist.com/API/v7/get_item \
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
>>> api.get_item(466)
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

This function is used to extract detailed information about the item, including all the notes.

It's especially important, because on initial load we return back no more than
10 last notes, and if client wants to get more, they can be downloaded with
`get_item` endpoint.

It returns a JSON object with `project`, `item` and `notes` attributes.

### Required parameters

Parameter | Description
--------- | -----------
token *String* | The user's token received on login.
item_id *Integer* | The item's unique id.

## Get project info

> An example of getting a project's info:

```shell
$ curl https://todoist.com/API/v7/get_project \
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
>>> api.get_project(128501682)
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

This function is used to extract detailed information about the project, including all the notes.

It's especially important, because on initial load we return back no more than
10 last notes, and if client wants to get more, they can be downloaded with
`get_project` endpoint.

It returns a JSON object with `project` and `notes` attributes.

### Required parameters

Parameter | Description
--------- | -----------
token *String* | The user's token received on login.
project_id *Integer* | The projects's unique id.
