# Activity

*Activity log is only available for Todoist Premium.*

The activity log makes it easy to see everything that is happening across projects, items and notes.

### Logged events

Currently the official Todoist clients present only the most important events
that most users are interested in, but actually everything that has to do with
projects, items and notes, is stored in our DB, and can be accessed by using our
API.

The following events are logged for items:

- items added
- items updated (only changes to `content`, `due_data` and `responsible_uid`)
- items deleted
- items completed
- items uncompleted

The following events are logged for notes:

- notes added
- notes updated (only changes to `content` or `file_name` if the former is empty)
- notes deleted

The following events are logged for projects:

- projects added
- projects updated (only changes to `name`)
- projects deleted
- projects archived
- projects unarchived
- projects shared
- projects left

### Event properties

> An example of an activity log event:

```shell
{
  "id" : 955333384,
  "object_type" : "item",
  "object_id" : 101157918,
  "event_type" : "added",
  "event_date" : "Fri 01 Jul 2016 14:24:59 +0000",
  "parent_project_id" : 174361513,
  "parent_item_id" : null,
  "initiator_id" : null,
  "extra_data" : {
    "content" : "Task1",
    "client" : "Mozilla/5.0; Todoist/830"
  }
}
```

```python
{
  'id': 955333384,
  'object_type': 'item',
  'object_id': 101157918,
  'event_type': 'added',
  'event_date': 'Fri 01 Jul 2016 14:24:59 +0000',
  'parent_project_id': 174361513,
  'parent_item_id': None,
  'initiator_id': None,
  'extra_data': {
    'content': 'Task1',
    'client' : 'Mozilla/5.0; Todoist/830'
  }
}
```

Property | Description
-------- | -----------
id *Integer* | The id of the event.
object_type *String* | The type of object, one of `item`, `note` or `project`.
object_id *Integer* | The id of the object.
event_type *String* | The type of event, one of `added`, `updated`, `deleted`, `completed`, `uncompleted`, `archived`, `unarchived`, `shared`, `left`.
event_date *String* | The date and time when the event took place.
parent_project_id *Integer* | The id of the item's or note's parent project, otherwise `null`.
parent_item_id *Integer* | The id of the note's parent item, otherwise `null`.
initiator_id *Integer* | The id of the user who is responsible for the event, which only makes sense in shared projects, items and notes, and is `null` for non-shared objects.
extra_data *Object* | This object contains at least the `name` of the project, or the `content` of an item or note, and optionally the `last_name` if a projects was renamed, the `last_content` if an item or note was renamed, the `due_date` and `last_due_date` if an item's due date changed, the `responsible_uid` and `last_responsible_uid` if an item's responsible uid changed, and the `client` that caused the logging of the event.

## Get activity logs

> An example of getting the activity logs:

```shell
$ curl https://todoist.com/api/v7/activity/get \
    -d token=0123456789abcdef0123456789abcdef01234567 \
[
  {
    "id" : 955344370,
    "object_type" : "item",
    "object_id" : 101157918,
    "event_type" : "updated",
    "event_date" : "Fri 01 Jul 2016 14:28:37 +0000",
    "parent_project_id" : 174361513,
    "parent_item_id" : null,
    "initiator_id" : null,
    "extra_data" : {
      "last_due_date" : null,
      "due_date" : "Sat 02 Jul 2016 20:59:59 +0000",
      "content" : "Task1",
      "client" : "Mozilla/5.0; Todoist/830"
    }
  },
  {
    "id" : 955333751,
    "object_type" : "note",
    "object_id" : 23685068,
    "event_type" : "added",
    "event_date" : "Fri 01 Jul 2016 14:25:04 +0000",
    "parent_project_id" : 174361513,
    "parent_item_id" : 101157918,
    "initiator_id" : null,
    "extra_data" : {
      "content" : "Note1",
      "client": "Todoist/11.2.1"

    }
  },
  {
    "id" : 955333384,
    "object_type" : "item",
    "object_id" : 101157918,
    "event_type" : "added",
    "event_date" : "Fri 01 Jul 2016 14:24:59 +0000",
    "parent_project_id" : 174361513,
    "parent_item_id" : null,
    "initiator_id" : null,
    "extra_data" : {
      "content" : "Task1",
      "client": "Todoist 2051"
    }
  },
  {
    "id" : 955333239,
    "object_type" : "project",
    "object_id" : 174361513,
    "event_type" : "added",
    "event_date" : "Fri 01 Jul 2016 14:24:56 +0000",
    "parent_project_id" : null,
    "parent_item_id" : null,
    "initiator_id" : null,
    "extra_data" : {
      "name" : "Project1",
      "client": "TodoistForWindows10"
    }
  }
]
```


```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.activity.get()
[
  {
    'id': 955344370,
    'object_type': 'item',
    'object_id': 101157918,
    'event_type': 'updated',
    'event_date': 'Fri 01 Jul 2016 14:28:37 +0000',
    'parent_project_id': 174361513,
    'parent_item_id': None,
    'initiator_id': None,
    'extra_data': {
      'content': 'Task1',
      'due_date': 'Sat 02 Jul 2016 20:59:59 +0000',
      'last_due_date': None,
      'client' : 'Mozilla/5.0; Todoist/830'
    }
  },
  {
    'id': 955333751,
    'object_type': 'note',
    'object_id': 23685068,
    'event_type': 'added',
    'event_date': 'Fri 01 Jul 2016 14:25:04 +0000',
    'parent_project_id': 174361513,
    'parent_item_id': 101157918,
    'initiator_id': None,
    'extra_data': {
      'content': 'Note1',
      'client': 'Todoist/11.2.1'
    }
  },
  {
    'id': 955333384,
    'object_type': 'item',
    'object_id': 101157918,
    'event_type': 'added',
    'event_date': 'Fri 01 Jul 2016 14:24:59 +0000',
    'parent_project_id': 174361513,
    'parent_item_id': None,
    'initiator_id': None,
    'extra_data': {
      'content': 'Task1',
      'client': 'Todoist 2051'
    }
  },
  {
    'id': 955333239,
    'object_type': 'project',
    'object_id': 174361513,
    'event_type': 'added',
    'event_date': 'Fri 01 Jul 2016 14:24:56 +0000',
    'parent_project_id': None,
    'parent_item_id': None,
    'initiator_id': None,
    'extra_data': {
      'name': 'Project1',
      'client': 'TodoistForWindows10'
    }
  }
]
```

### Parameters

Parameter | Required | Description
--------- | -------- | -----------
token *String* | Yes | The user's API token
object_type *String* | No | Filters events by a specific object type.
object_id *Integer* | No | Filters events by a specific object id, but only if the `object_type` has been also specified.
event_type *String* | No | Filters events by a specific event type.
object_event_types *Array of Strings* | No | An alternative way to filter by multiple object and event types.  This takes a list of strings of the form `[object_type]:[event_type]` (where either `object_type` part or the `event_type` part can be omitted), such as for example `["item:", "note:added"]`.  When this parameter is specified the `object_type`, `event_type` and `object_id` parameters are ignored.
parent_project_id *Integer* | No | Filters object events by the id of the project they belong to, so this implicitly limits the results to items and notes.
parent_item_id *Integer* | No | Filters object events by the id of the item they belong, so this implicitly limits the results to notes.
initiator_id *Integer* | No | Filters event by the id of the initiator.
since *String* | No | Filters events to those that took place after the specified date and time, formatted as for example `2016-06-28T12:00`.
until *String* | No | Filters events to those that took place before the specified date and time, formatted as `2016-06-28T12:00`.
limit *Integer* | No | The number of events to return, where the default is `30`, and the maximum is `100`.
offset *Integer* | No | The number of events to skip, which can be used for pagination in order to get more events than those returned by the previous call.
