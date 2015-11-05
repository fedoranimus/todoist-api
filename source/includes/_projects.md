# Projects

> An example project object

```json
{
  "id": 128501470,
  "user_id": 1855589,
  "name": "Project1",
  "color": 1,
  "indent": 1,
  "item_order": 36,
  "collapsed": 0,
  "shared": false,
  "is_deleted": 0,
  "is_archived": 0,
  "archived_date": null,
  "archived_timestamp": 0
}
```


A project in Todoist is a JSON object. Typically a project will have the following properties:

### Properties

Property | Description
-------- | -----------
id | The id of the project (a unique number).
user_id | The id of the user that owns the project (a unique number).
name | The name of the project (a string value).
color | The color of the project (a number between `0` and `11`, or between `0` and `21` for premium users).  The color codes corresponding to these numbers are: `#95ef63`, `#ff8581`, `#ffc471`, `#f9ec75`, `#a8c8e4`, `#d2b8a3`, `#e2a8e4`, `#cccccc`, `#fb886e`, `#ffcc00`, `#74e8d3`, `#3bd5fb`.  And for the additional colors of the premium users: `#dc4fad`, `#ac193d`, `#d24726`, `#82ba00`, `#03b3b2`, `#008299`, `#5db2ff`, `#0072c6`, `#000000`, `#777777`.
indent | The indent of the item (a number between `1` and `4`, where `1` is top-level).
item_order | Project's order in the project list (a number, where the smallest value should place the project at the top).
collapsed | Whether the project's sub-projects are collapsed (where `1` is true and `0` is false).
shared | Whether the project is shared (a `true` or `false` value).
is_deleted | Whether the project is marked as deleted (where `1` is true and `0` is false).
is_archived | Whether the project is marked as archived (where `1` is true and `0` is false).
archived_date | The date when the project was archived (`null` if not set).
archived_timestamp | The timestamp of when the project was archived (`0` if not set).
inbox_project | Whether the project is `Inbox` (`true` or otherwise this property is not sent).
team_inbox | Whether the project is `TeamInbox` (`true` or otherwise this property is not sent).


## Add a project

> An example of adding a project:

```shell
$ curl https://todoist.com/API/v6/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "project_add", "temp_id": "4ff1e388-5ca6-453a-b0e8-662ebf373b6b", "uuid": "32774db9-a1da-4550-8d9d-910372124fa4", "args": {"name": "Project4"}}]'
{ ...
  "SyncStatus": {"32774db9-a1da-4550-8d9d-910372124fa4": "ok"},
  "TempIdMapping": {"4ff1e388-5ca6-453a-b0e8-662ebf373b6b": 128501815},
  ... }
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> project = api.projects.add('Project4')
>>> api.commit()
```

Add a new project.

### Required arguments

Argument | Description
-------- | -----------
name | The name of the project (a string value).

### Optional arguments

Argument | Description
-------- | -----------
color | The color of the project (a number between `0` and `11`, or between `0` and `21` for premium users).
indent | The indent of the item (a number between `1` and `4`, where `1` is top-level).
item_order | Project's order in the project list (a number, where the smallest value should place the project at the top).

## Update a project

> An example of updating a project:

```shell
$ curl https://todoist.com/API/v6/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands=[{"type": "project_update", "uuid": "1ca42128-d12f-4a66-8413-4d6ff2838fde", "args": {"id": 128501815, "indent": 2}}]'
{ ...
  "SyncStatus": {"1ca42128-d12f-4a66-8413-4d6ff2838fde": "ok"},
  ... }
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> project = api.projects.get_by_id(128501815)
>>> project.update(indent=2)
>>> api.commit()
```

Update an existing project.

### Required parameters

Argument | Description
-------- | -----------
id | The id of the project (a number or a temp id).

### Optional arguments

Argument | Description
-------- | -----------
name | The name of the project (a string value).
color | The color of the project (a number between `0` and `11`, or between `0` and `21` for premium users).
indent | The indent of the item (a number between `1` and `4`, where `1` is top-level).
item_order | Project's order in the project list (a number, where the smallest value should place the project at the top).
collapsed | Whether the project's sub-projects are collapsed (where `1` is true and `0` is false).


## Delete projects

> An example of deleting a project:

```shell

$ curl https://todoist.com/API/v6/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands=[{"type": "project_delete", "uuid": "367182ba-125f-4dbb-bff6-c1343fd751e4", "args": {"ids": [128501815]}}]'
{ ...
  "SyncStatus": {"367182ba-125f-4dbb-bff6-c1343fd751e4": {"128501815": "ok"}},
  ... }
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> project = api.projects.get_by_id(128501815)
>>> project.delete()
>>> api.commit()
```

Delete an existing project.

### Required arguments

Argument | Description
-------- | -----------
ids | List of the ids of the projects to delete (numbers or temp ids).


## Archive a project

> An example of archiving a project:

```shell
$ curl https://todoist.com/API/v6/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands=[{"type": "project_archive", "uuid": "bbec1a60-2bdd-48ac-a623-c8eb968e1697", "args": {"ids": [128501682]}}]'
{ ...
  "SyncStatus": {"bbec1a60-2bdd-48ac-a623-c8eb968e1697": {"128501682": "ok"}},
  ... }
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> project = api.projects.get_by_id(128501682)
>>> project.archive()
>>> api.commit()
```

Archive project and its children. Only available for Todoist Premium users.

### Required arguments

Argument | Description
-------- | -----------
ids | List of the ids of the projects to archive (numbers or temp ids).

## Unarchive a project

> An example of unarchiving a project:

```shell
$ curl https://todoist.com/API/v6/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands=[{"type": "project_unarchive", "uuid": "7d86f042-e098-4fa6-9c1f-a61fe8c39d74", "args": {"ids": [128501682]}}]'
{ ...
  "SyncStatus": {"7d86f042-e098-4fa6-9c1f-a61fe8c39d74": {"128501682": "ok"}},
  ... }
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> project = api.projects.get_by_id(128501815)
>>> project.unarchive()
>>> api.commit()
```

Unarchive project and its children. Only available for Todoist Premium users.

### Required arguments

Argument | Description
-------- | -----------
ids | List of the ids of the projects to unarchive (numbers or temp ids).

## Update multiple orders/indents

> An example of updating the orders and indents of multiple projects at once:

```shell
$ curl https://todoist.com/API/v6/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands=[{"type": "project_update_orders_indents", "uuid": "bf0855a3-0138-4b76-b895-88cad8db9edc", "args": {"ids_to_orders_indents": {"128501470": [42, 1], "128501607": [43, 1]}}}]'
{ ...
  "SyncStatus": {
    "bf0855a3-0138-4b76-b895-88cad8db9edc": {
      "128501470": "ok",
      "128501607": "ok"
    },
  },
  ... }
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.projects.update_orders_indents({128501470: [42, 1], 128501607: [43, 1]})
>>> api.commit()
```

Update the orders and indents of multiple projects at once.

### Required arguments

Argument | Description
-------- | -----------
ids_to_orders_indents | A dictionary, where a project id is the key, and a list with two elements, the order and the indent, are its value: `project_id: [item_order, indent]`
