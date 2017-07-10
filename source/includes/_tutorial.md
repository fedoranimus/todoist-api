# Getting started

In this section we will do some common things, that many of our users ask for
help on accomplishing them. We will mostly use the `sync` call, which is
described in detailed at the [Sync](#sync) section, but for now you can just
consider it just an endpoint, and you will soon figure some of the things it can
do, just by having a look at some examples.

## Get all projects

> The example of how we get all projects:

```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d sync_token=* \
    -d resource_types='["projects"]'

{
   "projects" : [
      {
         "is_archived" : 0,
         "color" : 7,
         "shared" : false,
         "inbox_project" : true,
         "id" : 176637162,
         "collapsed" : 0,
         "item_order" : 0,
         "name" : "Inbox",
         "is_deleted" : 0,
         "indent" : 1
      }
   ],
   "full_sync" : true,
   "temp_id_mapping" : {},
   "sync_token" : "aLGJg_2qwBE_kE3j9_Gn6uoKQtvQeyjm7UEz_aVwF8KdriDxw7e_InFZK61h"
}
```

```python
>>> from todoist.api import TodoistAPI
>>> api = TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.sync()
>>> print(api.state['projects'])
[
  Project({
    'collapsed': 0,
    'color': 7,
    'id': 176637162,
    'inbox_project': True,
    'indent': 1,
    'is_archived': 0, 2
    'is_deleted': 0,
    'item_order': 0,
    'name': 'Inbox',
    'shared': False
  })
]
```

First, let's see how we can get all projects a user has.

### Using curl

We send a request to the `sync` endpoint, and then specify the following
arguments:

+ The user's API token, which here is set to
  `token=0123456789abcdef0123456789abcdef01234567`.  You can find out your token
  from the Todoist Web app, at `Todoist Settings -> Account -> API token`.
+ A special sync token, which denotes that we want a full sync, in contrast to
  an incremental sync, which is denoted with the `*` symbol, so we set
  `sync_token=*`.
+ That we want to get back only the `projects`, and not any other data, so we
  set `resource_types='["projects"]'`.

In the results we get back, we notice the following data:

+ All the user's projects, which in in this case it's only the `Inbox` project.
+ A special flag `full_sync` which is set to `true` here, and denotes we did a
  full sync.
+ A new `sync_token` which we can use later on, in order to do incremental
  syncs.
+ The `temp_id_mapping` object which will be explained later on, and which it's
  empty now.

### Using the Python library

We need to import the `TodoistAPI` class from the `todoist` module, create a
`TodoistAPI` object which we store to the `api` variable, and specify our user
API `token`, that is `0123456789abcdef0123456789abcdef01234567`.

After that we can just do a sync by calling `api.sync()`, and we can access the
user's projects through the `api.state` object, so for projects that is
`api.state['projects']`.

## Add a new project

> The example of how we create a new project:

```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d sync_token="aLGJg_2qwBE_kE3j9_Gn6uoKQtvQeyjm7UEz_aVwF8KdriDxw7e_InFZK61h" \
    -d resource_types='["projects"]' \
    -d commands='[
        { "type": "project_add",
          "temp_id": "24a193a7-46f7-4314-b984-27b707bd2331",
          "uuid": "e23db5ec-2f73-478a-a008-1cb4178d2fd1",
          "args": { "name": "Project1" } }
      ]'

{
   "projects" : [
      {
         "is_deleted" : 0,
         "indent" : 1,
         "item_order" : 1,
         "name" : "Project1",
         "collapsed" : 0,
         "shared" : false,
         "id" : 176637191,
         "is_archived" : 0,
         "color" : 7
      }
   ],
   "temp_id_mapping" : {
      "24a193a7-46f7-4314-b984-27b707bd2331" : 176637191
   },
   "sync_status" : {
      "e23db5ec-2f73-478a-a008-1cb4178d2fd1" : "ok"
   },
   "sync_token" : "VRyFHr0Qo3Hr--pzINyT6nax4vW7X2YG5RQlw3lB-6eYOPbSZVJepa62EVhO",
   "full_sync" : false
}
```

```python
>>> project1 = api.projects.add('Project1')
>>> api.commit()
>>> print(project1)
Project({
  'collapsed': 0,
  'color': 7,
  'id': 176637191,
  'indent': 1,
  'is_archived': 0,
  'is_deleted': 0,
  'item_order': 1,
  'name': 'Project1',
  'shared': False})
```

Let's create a new project, and observe the result of our action.

### Using curl

We use the `sync` call, and then specify the following arguments:

+ The user's API token which is set to
  `token=0123456789abcdef0123456789abcdef01234567`.
+ The sync token that we received on the reply of our previous request, and
  which denotes that we want an incremental sync, so we set
  `sync_token="aLGJg_2qwBE_kE3j9_Gn6uoKQtvQeyjm7UEz_aVwF8KdriDxw7e_InFZK61h"`.
+ That we want to get back only the `projects`, and not any other data, so we
  set `resource_types='["projects"]'`.
+ We send a single `project_add` command that will create a new project, and we
  specify as the only argument to that command the `name` of the project which
  is set to `Project1`.
+ We also need to specify 2 UUIDs: the `uuid` that that will uniquely identify
  our command, and the `temp_id` which is a temporary ID we set to our new
  project, and we can use that later on to identify it to the server, without a
  need to know its real ID, which is assigned at the time of creation on the
  server.  Note that in these examples we're using UUID values, but you could
  also use a shorter strings containing letters and/or numbers, but you need to
  make sure they will be random and unique.

In the results we get back, we notice the following data:

+ The new project we added is returned as part of the user's `projects`.
+ The `temp_id_mapping` object which tells us that the new object with UUID
  `24a193a7-46f7-4314-b984-27b707bd2331` has a real ID `176637191`. Notice that
  we can use both of these IDs to refer to that project, and while the latter
  should be used whenever possible, the former can be also utilized on a
  temporary basis.
+ The `sync_status` object which tells us whether our command with UUID
  `e23db5ec-2f73-478a-a008-1cb4178d2fd1` was succesful, or in case of error what
  exactly was the problem.
+ The special flag `full_sync` which is set to `false` here, and denotes we did
  an incremental sync.
+ A new `sync_token` which we can use later on to continue doing incremental syncs.

### Using the Python library

We call the `api.projects.add()` call, supplying the name of the new project,
and as a return value we get a new project object.  This object holds the newly
created project, and we store it in the `project1` variable.

This object is only temporary, it only exists on our local state, so in order to
ask the server to add it remotely on the system, too, we use the `api.commit()`
call, which does all the work of sending the request to add the project, and
getting back the new project's properties.

Finally we print the new `project1` object.

## Add two new tasks

> The example of how we create two new tasks:

```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d sync_token="VRyFHr0Qo3Hr--pzINyT6nax4vW7X2YG5RQlw3lB-6eYOPbSZVJepa62EVhO" \
    -d resource_types='["projects", "items"]' \
    -d commands='[
        { "type": "item_add",
          "temp_id": "fdef5d16-a40a-475e-bd4a-0ccbd6fd8c3f",
          "uuid": "a3aa2f44-23b4-4986-b513-ef7663bbb752",
          "args": { "project_id": "24a193a7-46f7-4314-b984-27b707bd2331", "content": "Task1" } },
        { "type": "item_add",
          "temp_id": "6f5e0b50-af7a-4133-bfc0-e8c041b819d2",
          "uuid": "d16ad84a-e10b-4894-af7d-93ba6adf7a1e",
          "args": { "project_id": 176637191, "content": "Task2" } },
      ]'

{
  "projecs": [],
  "items" : [
    {
       "collapsed" : 0,
       "date_added" : "Mon 01 Aug 2016 13:19:45 +0000",
       "item_order" : 2,
       "is_archived" : 0,
       "indent" : 1,
       "all_day" : false,
       "day_order" : 1,
       "assigned_by_uid" : 1,
       "responsible_uid" : null,
       "sync_id" : null,
       "checked" : 0,
       "date_lang" : "en",
       "user_id" : 1,
       "labels" : [],
       "is_deleted" : 0,
       "date_string" : "",
       "project_id" : 176637191,
       "due_date_utc" : null,
       "in_history" : 0,
       "content" : "Task2",
       "id" : 102835617,
       "priority" : 1
    },
    {
       "priority" : 1,
       "id" : 102835615,
       "content" : "Task1",
       "in_history" : 0,
       "is_deleted" : 0,
       "date_string" : "",
       "project_id" : 176637191,
       "due_date_utc" : null,
       "checked" : 0,
       "labels" : [],
       "date_lang" : "en",
       "user_id" : 1,
       "responsible_uid" : null,
       "sync_id" : null,
       "assigned_by_uid" : 1,
       "day_order" : -1,
       "indent" : 1,
       "all_day" : false,
       "item_order" : 1,
       "is_archived" : 0,
       "collapsed" : 0,
       "date_added" : "Mon 01 Aug 2016 13:19:45 +0000"
    }
  ],
  "temp_id_mapping" : {
     "1c0f8453-32f0-4bf1-8c31-2faf8fa59ef1" : 176637191,
     "6f5e0b50-af7a-4133-bfc0-e8c041b819d2" : 102835617,
     "fdef5d16-a40a-475e-bd4a-0ccbd6fd8c3f" : 102835615
  },
  "sync_status" : {,
     "a3aa2f44-23b4-4986-b513-ef7663bbb752" : "ok",
     "d16ad84a-e10b-4894-af7d-93ba6adf7a1e" : "ok"
  },
  "sync_token" : "Gm7DEx2RBn-mW9xGIJhAPOGRPWSlewfxGm0aY_W6IhThCp_8DDXmPU8ERu8u",
  "full_sync" : false
}
```

```python
>>> project1 = api.projects.add('Project1')
>>> taks1 = api.items.add('Task1', project1['id'])
>>> task2 = api.items.add('Task2', project1['id'])
>>> api.commit()
>>> print(task1, task2)
(
  Item({
    'all_day': False,
    'assigned_by_uid': 1,
    'checked': 0,
    'collapsed': 0,
    'content': 'Task1',
    'date_added': 'Mon 01 Aug 2016 13:19:45 +0000',
    'date_lang': 'en',
    'date_string': '',
    'day_order': -1,
    'due_date_utc': None,
    'id': 102835615,
    'in_history': 0,
    'indent': 1,
    'is_archived': 0,
    'is_deleted': 0,
    'item_order': 1,
    'labels': [],
    'priority': 1,
    'project_id': 176637191,
    'responsible_uid': None,
    'sync_id': None,
    'user_id': 1
  }),
  Item({
    'all_day': False,
    'assigned_by_uid': 1,
    'checked': 0,
    'collapsed': 0,
    'content': 'Task2',
    'date_added': 'Mon 01 Aug 2016 13:19:45 +0000',
    'date_lang': 'en',
    'date_string': '',
    'day_order': 1,
    'due_date_utc': None,
    'id': 102835617,
    'in_history': 0,
    'indent': 1,
    'is_archived': 0,
    'is_deleted': 0,
    'item_order': 2,
    'labels': [],
    'priority': 1,
    'project_id': 176637191,
    'responsible_uid': None,
    'sync_id': None,
    'user_id': 1
  })
)
```

Let's create two new tasks in one go, and observe the result of our action.

### Using curl

We use the `sync` call, and then specify the following arguments:

+ The user's API token, same as on the previous requests.
+ The sync token that we received as reply on our previous request.
+ For this example we get back both projects and items changed since last sync,
  so we set `resource_types='["projects", "items"]'`.
+ We send two `item_add` commands that will create a new task each, and we also
  specify the `project_id` and the `content` of each new task, and for one of
  the tasks we use the `temp_id` of the previously created project, while for
  the other task we use the project's real ID, and we do that just to show that
  it has the same result.
+ We also need to specify the `uuid` and `temp_id`, for the two commands and the
  two new tasks respectively.

In the results we get back, we notice the following:

+ An empty `projects` array, which is expected as no new projects were added by
  our commands.
+ The new tasks we added are returned as part of the user's `items` array.
+ The `temp_id_mapping` object which tells us the real IDs of the new tasks, for
  each of the `temp_id`s we sent.
+ The `sync_status` object which tells us whether each command was successful.
+ The special flag `full_sync` which is set to `false` here, and denotes we did
  an incremental sync.
+ A new `sync_token` which we can use later on to do more incremental syncs.

### Using the Python library

We call the `api.items.add()` call, supplying the content of each new task and
the project it should be added to, and as a return value we get a new item
object, that holds the new task, and which we store to a variable.  Notice that
we can get the project ID from the `project1` object we created on the previous
step, and specifically from the `project1['id']` value.

In order to actually add the tasks on the server, we do an `api.commit()` call,
and so both item objects are populated with the properties these new tasks have.

Finally we print the new `task1` and `task2` objects.

## Update the content and due date of a task

> The example of how we update the content and due date of a task:

```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d sync_token="Gm7DEx2RBn-mW9xGIJhAPOGRPWSlewfxGm0aY_W6IhThCp_8DDXmPU8ERu8u" \
    -d resource_types='["items"]' \
    -d commands='[
        { "type": "item_update",
          "uuid": "aca17834-da6f-4605-bde0-bd10be228878",
          "args": { "id": "102835615", "content": "NewTask1", "date_string": "tomorrow at 10:00" } },
      ]'

{
  "items" : [
    {
      "sync_id" : null,
      "project_id" : 176637191,
      "date_lang" : "en",
      "labels" : [],
      "is_deleted" : 0,
      "is_archived" : 0,
      "item_order" : 1,
      "checked" : 0,
      "priority" : 1,
      "id" : 102835615,
      "due_date_utc" : "Fri 05 Aug 2016 07:00:00 +0000",
      "assigned_by_uid" : 1,
      "all_day" : false,
      "day_order" : -1,
      "collapsed" : 0,
      "date_string" : "5 Aug 10:00 AM",
      "responsible_uid" : null,
      "content" : "NewTask1",
      "user_id" : 1,
      "in_history" : 0,
      "indent" : 1,
      "date_added" : "Mon 01 Aug 2016 13:19:45 +0000"
    }
  ],
  "sync_status" : {
     "aca17834-da6f-4605-bde0-bd10be228878" : "ok"
  },
  "temp_id_mapping" : {}
  "sync_token" : "Zs1ahJjWROqjBMIJGCAmsToOXOEP-wa9x3HiuBEyr6ymUYoyAyhIHeXkS9HE9HfFXcAO",
  "full_sync" : false,
}
```

```python
>>> task2 = api.items.add('Task2', project1['id'])
>>> task1.update(content='NewTask1', date_string='tomorrow at 10:00')
>>> api.commit()
>>> print(task1)
Item({
  'all_day': False,
  'assigned_by_uid': 1,
  'checked': 0,
  'collapsed': 0,
  'content': 'NewTask1',
  'date_added': 'Mon 01 Aug 2016 13:19:45 +0000',
  'date_lang': 'en',
  'date_string' : '5 Aug 10:00 AM',
  'day_order': -1,
  'due_date_utc' : 'Fri 05 Aug 2016 07:00:00 +0000',
  'id': 102835615,
  'in_history': 0,
  'indent': 1,
  'is_archived': 0,
  'is_deleted': 0,
  'item_order': 1,
  'labels': [],
  'priority': 1,
  'project_id': 176637191,
  'responsible_uid': None,
  'sync_id': None,
  'user_id': 1
})
```

Let's update the content and due date of the first task we created in the
previous step.

### Using curl

We use the `sync` call, and then specify the following arguments:

+ The user's API token same as on the previous requests.
+ The sync token that we received as reply on our previous request.
+ For this example lets get back only items changed since our last sync, so we
  set `resource_types='["items"]'`.
+ We send an `item_update` command that will update the task we created earlier,
  so we specify the `id` of the task, its new `content`, and its new due date by
  setting the `date_string` property.
+ We also need to specify the `uuid` for this command.

In the results we get back, we notice the following:

+ The updates to all items since our last sync are returned as part of the
  user's `items` array.
+ The `temp_id_mapping` here is empty since no new object was created.
+ The `sync_status` object which tells us whether our command was successful.
+ The special flag `full_sync` which is set to `false` here, and denotes we did
  an incremental sync.
+ A new `sync_token` which we can use later on to do more incremental syncs.

### Using the Python library

We call the `update()` call on the `task1` object that we got in the previous
step, so we call `task1.update()`, and we specify the new `content=NewTask1` and
`date_string='tomorrow at 10:00` parameters, in order to change these specific
properties of the task.

In order to update the task on the server, we do an `api.commit()` call.

Finally we print the `task1` object, which has now its properties automatically
updated.

## Complete a task and delete another task

> The example of how we complete a task an delete another task:

```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d sync_token="Gm7DEx2RBn-mW9xGIJhAPOGRPWSlewfxGm0aY_W6IhThCp_8DDXmPU8ERu8u" \
    -d resource_types='["items"]' \
    -d commands='[
        { "type": "item_complete",
          "uuid": "7d9355c5-bd28-4d39-8b8b-0b7a7682eaa2",
          "args": { "ids": ["102835615"] } },
        { "type": "item_delete",
          "uuid": "c27ee0dd-71b8-4725-af5c-3f6327bacdb4",
          "args": { "ids": ["102835617"] } },
      ]'

{
  "items" : [
    {
      "date_added" : "Mon 01 Aug 2016 13:19:45 +0000",
      "assigned_by_uid" : 1,
      "priority" : 1,
      "user_id" : 1,
      "all_day" : false,
      "responsible_uid" : null,
      "labels" : [],
      "date_string" : "",
      "checked" : 0,
      "day_order" : -1,
      "project_id" : 176637191,
      "due_date_utc" : null,
      "item_order" : 2,
      "collapsed" : 0,
      "in_history" : 0,
      "indent" : 1,
      "content" : "Task2",
      "sync_id" : null,
      "is_archived" : 0,
      "date_lang" : "en",
      "id": 102835617,
      "is_deleted" : 1
    },
    {
      "date_added" : "Mon 01 Aug 2016 13:19:45 +0000"
      "date_string" : "5 Aug 10:00 AM",
      "labels" : [],
      "responsible_uid" : null,
      "all_day" : false,
      "assigned_by_uid" : 1,
      "priority" : 1,
      "user_id" : 1,
      "indent" : 1,
      "in_history" : 1,
      "collapsed" : 0,
      "item_order" : 32,
      "due_date_utc" : "Fri 05 Aug 2016 07:00:00 +0000",
      "project_id" : 176637191,
      "day_order" : 0,
      "checked" : 1,
      "is_deleted" : 0,
      "id": 102835615,
      "date_lang" : "en",
      "is_archived" : 0,
      "content" : "NewTask1",
      "sync_id" : null
    }
  ],
  "sync_status" : {
     "7d9355c5-bd28-4d39-8b8b-0b7a7682eaa2" : "ok"
     "c27ee0dd-71b8-4725-af5c-3f6327bacdb4" : "ok"
  },
  "temp_id_mapping" : {}
  "sync_token" : "zjx5pDbKKJGYFZ1VBYlLvvBdZOBvrY_8QNKaMXoE4Vcp_WyLevfDJ4ebsFiu",
  "full_sync" : false,
}
```

```python
>>> task1.complete()
>>> task2.delete()
>>> api.commit()
>>> print(task1, task2)
(
  Item({
    'all_day': False,
    'assigned_by_uid': 1,
    'checked': 1,
    'collapsed': 0,
    'content': 'NewTask1',
    'date_added' : 'Mon 01 Aug 2016 13:19:45 +0000'
    'date_lang': 'en',
    'date_string' : '5 Aug 10:00 AM',
    'day_order': 0,
    'due_date_utc' : 'Fri 05 Aug 2016 07:00:00 +0000',
    'id': 102835615,
    'in_history': 1,
    'indent': 1,
    'is_archived': 0,
    'is_deleted': 0,
    'item_order': 2,
    'labels': [],
    'priority': 1,
    'project_id' : 176637191,
    'responsible_uid': None,
    'sync_id': None,
    'user_id': 1
  }),
  Item({
    'all_day': False,
    'assigned_by_uid': 1,
    'checked': 0,
    'collapsed': 0,
    'content': 'Task2',
    'date_added' : 'Mon 01 Aug 2016 13:19:45 +0000',
    'date_lang': 'en',
    'date_string': '',
    'day_order': 1,
    'due_date_utc': None,
    'id': 102835617,
    'in_history': 0,
    'indent': 1,
    'is_archived': 0,
    'is_deleted': 1,
    'item_order': 2,
    'labels': [],
    'priority': 1,
    'project_id' : 176637191,
    'responsible_uid': None,
    'sync_id': None,
    'user_id': 1
  })
)
```

Let's complete the task we updated in the previous step, and delete the task we
created earlier.

### Using curl

We use the `sync` call, and then specify the following arguments:

+ The user's API token same as on the previous requests.
+ The sync token that we received as reply on our previous request.
+ For this example lets get back only items changed since last sync, so we set
  `resource_types='["items"]'`.
+ We send an `item_complete` command that will completed the task, and we
  specify only the `ids` parameter with the ID of the task, and also we send an
  `item_delete` command that will delete the other task, and this command also
  expects an `ids` parameter.
+ We also need to specify the `uuid`s for these commands.

In the results we get back, we notice the following:

+ The updates to all items since our last sync are returned as part of the
  user's `items` array, where we can observe that the task we completed has a
  `checked=1` property which denotes it's now completed, while the other task
  has a `is_deleted=1` property which denotes it's now deleted.
+ The `temp_id_mapping` here is empty since no new object was created.
+ The `sync_status` object which tells us whether our command was successful.
+ The special flag `full_sync` which is set to `false` here, and denotes we did
  an incremental sync.
+ A new `sync_token` which we can use later on to do more incremental syncs.

### Using the Python library

We call the `complete()` method on the `task1` object that we have already
stored from earlier, and also the `delete()` method on the `task2` object.

In order to actually complete and delete the tasks on the server, we do an
`api.commit()` call.

Finally we print the `task1` and `task2` objects, and we can observe that their
`checked=1` and `is_deleted=1` properties have been set accordingly.

## Add a new task with a note and a reminder

> The example of how we create a new task with a note and a reminder:

```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d sync_token="VRyFHr0Qo3Hr--pzINyT6nax4vW7X2YG5RQlw3lB-6eYOPbSZVJepa62EVhO" \
    -d resource_types='["projects", "items"]' \
    -d commands='[
        { "type": "item_add",
          "temp_id": "160070ed-79a9-4e6b-988b-169052e9ef22",
          "uuid": "cf6c3ef7-5579-40c2-87e1-b30a1f3cbefe",
          "args": { "project_id": "176637191", "content": "Task3", "date_string": "monday 11am"} },
        { "type": "note_add",
          "temp_id": "7f4de51a-3b12-4364-a98b-26f041293eba",
          "uuid": "0d9a0925-067e-47fb-9a86-c0cf359afd9f",
          "args": { "item_id": "160070ed-79a9-4e6b-988b-169052e9ef22", "content": "Comment3" } },
        { "type": "reminder_add",
          "temp_id": "cda5ffcd-5035-47d9-a683-5dddce096811",
          "uuid": "843a5719-b204-4f6e-9ff3-f55cb9140ba1",
          "args": { "item_id": "160070ed-79a9-4e6b-988b-169052e9ef22", "date_string": "monday 10:45am"} },
      ]'

{
  "items" : [
    {
      "date_added" : "Fri 05 Aug 2016 11:47:58 +0000",
      "all_day" : false,
      "day_order" : 2,
      "user_id" : 1,
      "due_date_utc" : "Mon 08 Aug 2016 08:00:00 +0000",
      "project_id" : 176637191,
      "sync_id" : null,
      "responsible_uid" : null,
      "indent" : 1,
      "content" : "Task3",
      "date_lang" : "en",
      "collapsed" : 0,
      "in_history" : 0,
      "labels" : [],
      "item_order" : 1,
      "date_string" : "8 Aug 11:00 AM",
      "id" : 103184669,
      "checked" : 0,
      "is_archived" : 0,
      "assigned_by_uid" : 1,
      "priority" : 1,
      "is_deleted" : 0
    }
  ],
  "notes" : [
    {
      "project_id" : 176637191,
      "content" : "Comment3",
      "posted_uid" : 1,
      "file_attachment" : null,
      "is_deleted" : 0,
      "is_archived" : 0,
      "id" : 24124658,
      "posted" : "Fri 05 Aug 2016 11:47:58 +0000",
      "uids_to_notify" : null,
      "item_id" : 103184669
    }
  ],
  "reminders" : [
    {
      "mm_offset" : 180,
      "due_date_utc" : "Mon 08 Aug 2016 07:45:00 +0000",
      "date_lang" : "en",
      "notify_uid" : 1,
      "service" : "email",
      "is_deleted" : 0,
      "type" : "absolute",
      "id" : 29173254,
      "date_string" : "8 Aug 10:45 AM",
      "item_id" : 103184669
    }
  ],
  "temp_id_mapping" : {
    "160070ed-79a9-4e6b-988b-169052e9ef22" : 103184669,
    "cda5ffcd-5035-47d9-a683-5dddce096811" : 29173254,
    "7f4de51a-3b12-4364-a98b-26f041293eba" : 24124658,
  },
  "sync_status" : {
    "cf6c3ef7-5579-40c2-87e1-b30a1f3cbefe" : "ok",
    "0d9a0925-067e-47fb-9a86-c0cf359afd9f" : "ok",
    "843a5719-b204-4f6e-9ff3-f55cb9140ba1" : "ok"
  },
  "full_sync" : false,
  "sync_token" : "Fg9VYMugYcPg2PPLDQMyFuvI3XxeL3moh5NsrakQbhpU8ld0AdN6KbZJhwrz",
}
```

```shell
# quick/add
$ curl https://todoist.com/api/v7/quick/add \
    -d token=0123456789abcdef0123456789abcdef01234567
    -d content="Task3 Monday 11am" \
    -d note="Comment3" \
    -d reminder="Monday 10:45am"
```

```python
>>> task3 = api.items.add('Task3', project1['id'], date_string='Monday 11am')
>>> comment3 = api.notes.add(task3['id'], 'Comment3')
>>> reminder3 = api.reminders(task3['id'], date_string='Monday 10:45am')
>>> api.commit()
print(task3, comment3, reminder3)
(
  Item({
    'all_day': False,
    'assigned_by_uid': 1,
    'checked': 0,
    'collapsed': 0,
    'content': 'Task3',
    'date_added' : 'Fri 05 Aug 2016 11:47:58 +0000',
    'date_lang': 'en',
    'date_string': '8 Aug 11:00 AM',
    'day_order': -1,
    'due_date_utc' : 'Mon 08 Aug 2016 08:00:00 +0000',
    'id' : 103184669,
    'in_history': 0,
    'indent': 1,
    'is_archived': 0,
    'is_deleted': 0,
    'item_order': 1,
    'labels': [],
    'priority': 1,
    'project_id' : 176637191,
    'responsible_uid': None,
    'sync_id': None,
    'user_id': 1
  }),
  Note({
    'content': 'Comment3',
    'file_attachment': None,
    'id' : 24124658,
    'is_archived': 0,
    'is_deleted': 0,
    'item_id': 103184669,
    'posted' : 'Fri 05 Aug 2016 11:47:58 +0000',
    'posted_uid': 1,
    'project_id' : 176637191,
    'uids_to_notify': None
  }),
  Reminder({
    'date_lang': 'en',
    'date_string': '8 Aug 10:45 AM',
    'due_date_utc': 'Mon 08 Aug 2016 07:45:00 +0000'
    'id' : 29173254,
    'is_deleted': 0,
    'item_id': 103184669,
    'mm_offset': 180,
    'notify_uid': 1,
    'service': 'email',
    'type': 'absolute'
  })
)
```

Let's create a new task, but with add to it a new comment, and also set a
reminder based on its due date.

### Using curl

We use the `sync` call, and then specify the following arguments:

+ The user's API token same as on the previous requests.
+ The sync token that we received as reply on our previous request.
+ For this example lets get back items, notes and reminders, changed since last
  sync, so we set `resource_types='["items", "notes", "reminders"]'`.
+ We send an `item_add` command that will add the new task, a `note_add` command
  that will add a note to the new task, and we do that by specifying the
  `temp_id` of the new task as the `item_id` for the `note_add` command, and a
  `reminder_add` command that will create a reminder for our task, again using
  the `temp_id` of the task as the `item_id` of the `reminder_add` command.
+ We also need to specify the `uuid` for all commands.

In the results we get back, we notice the following:

+ The updates to all items, notes and reminders since our last sync, are
  returned as the equivalent arrays, and we can observe all three new objects
  created.
+ The `temp_id_mapping` here contains the real IDs of the task, note and
  reminder.
+ The `sync_status` object which tells us whether our commands were successful.
+ The special flag `full_sync` which is set to `false` here, and denotes we did
  an incremental sync.
+ A new `sync_token` which we can use later on to do more incremental syncs.

### Using the Python library

We call the `api.items.add()` method to create the new task. and we store the
object in the `task3` variable. We then use the value of `task3['id']` as the
argument to the `api.notes.add()` and `api.reminders.add()` methods that create
the new note and reminder respectively. And we store the results to the
`comment3` and `reminder3` variables.

In order to actually create all the objects on the server, we do an
`api.commit()` call.

Finally we print the `task3`, `comment3` and `reminder3` objects.
