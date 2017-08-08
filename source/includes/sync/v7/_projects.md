# Projects

> An example project object

```json
{
  "id": 128501470,
  "name": "Project1",
  "color": 1,
  "indent": 1,
  "item_order": 36,
  "collapsed": 0,
  "shared": false,
  "is_deleted": 0,
  "is_archived": 0,
}
```

### Properties

Property | Description
-------- | -----------
id *Integer* | The id of the project.
name  *String* | The name of the project.
color *Integer* | The color of the project (a number between `0` and `11`, or between `0` and `21` for premium users).  The color codes corresponding to these numbers are: `#95ef63`, `#ff8581`, `#ffc471`, `#f9ec75`, `#a8c8e4`, `#d2b8a3`, `#e2a8e4`, `#cccccc`, `#fb886e`, `#ffcc00`, `#74e8d3`, `#3bd5fb`.  And for the additional colors of the premium users: `#dc4fad`, `#ac193d`, `#d24726`, `#82ba00`, `#03b3b2`, `#008299`, `#5db2ff`, `#0072c6`, `#000000`, `#777777`.
indent *Integer* | The indent of the item (a number between `1` and `4`, where `1` is top-level).
item_order *Integer* | Project's order in the project list (a number, where the smallest value should place the project at the top).
collapsed  *Integer* | Whether the project's sub-projects are collapsed (where `1` is true and `0` is false).
shared  *Boolean* | Whether the project is shared (a `true` or `false` value).
is_deleted *Integer* | Whether the project is marked as deleted (where `1` is true and `0` is false).
is_archived *Integer* | Whether the project is marked as archived (where `1` is true and `0` is false).
inbox_project *Boolean* | Whether the project is `Inbox` (`true` or otherwise this property is not sent).
team_inbox *Boolean* | Whether the project is `TeamInbox` (`true` or otherwise this property is not sent).


## Add a project

```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "project_add", "temp_id": "4ff1e388-5ca6-453a-b0e8-662ebf373b6b", "uuid": "32774db9-a1da-4550-8d9d-910372124fa4", "args": {"name": "Project4"}}]'

{
  ...
  "sync_status": {"32774db9-a1da-4550-8d9d-910372124fa4": "ok"},
  "temp_id_mapping": {"4ff1e388-5ca6-453a-b0e8-662ebf373b6b": 128501815},
  ...
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> project = api.projects.add('Project4')
>>> api.commit()
```

### Command arguments

Parameter | Required | Description
--------- | -------- | -----------
name *String* | Yes | The name of the project (a string value).
color *Integer* | No | The color of the project (a number between `0` and `11`, or between `0` and `21` for premium users).
indent *Integer* | No | The indent of the item (a number between `1` and `4`, where `1` is top-level).
item_order *Integer* | No | Project's order in the project list (a number, where the smallest value should place the project at the top).

## Update a project


```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands=[{"type": "project_update", "uuid": "1ca42128-d12f-4a66-8413-4d6ff2838fde", "args": {"id": 128501815, "indent": 2}}]'

{
  ...
  "sync_status": {"1ca42128-d12f-4a66-8413-4d6ff2838fde": "ok"},
  ...
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> project = api.projects.get_by_id(128501815)
>>> project.update(indent=2)
>>> api.commit()
```

Update an existing project.

### Command arguments

Parameter | Required | Description
--------- | -------- | -----------
id  *Integer or String (temp_id)* | Yes | The id of the project (could be temp id).
name *String* | No | The name of the project (a string value).
color *Integer* | No | The color of the project (a number between `0` and `11`, or between `0` and `21` for premium users).
indent *Integer* | No | The indent of the item (a number between `1` and `4`, where `1` is top-level).
item_order *Integer* | No | Project's order in the project list (a number, where the smallest value should place the project at the top).
collapsed *Integer* | No | Whether the project's sub-projects are collapsed (where `1` is true and `0` is false).


## Delete projects

```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands=[{"type": "project_delete", "uuid": "367182ba-125f-4dbb-bff6-c1343fd751e4", "args": {"ids": [128501815]}}]'

{
  ...
  "sync_status": {"367182ba-125f-4dbb-bff6-c1343fd751e4": "ok"},
  ...
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> project = api.projects.get_by_id(128501815)
>>> project.delete()
>>> api.commit()
```

Delete an existing project.

### Command arguments

Parameter | Required | Description
--------- | -------- | -----------
ids *Array of Integer (id) or String (temp id)* | Yes | List of the ids of the projects to delete (could be temp ids).


## Archive a project

```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands=[{"type": "project_archive", "uuid": "bbec1a60-2bdd-48ac-a623-c8eb968e1697", "args": {"ids": [128501682]}}]'

{
  ...
  "sync_status": {"bbec1a60-2bdd-48ac-a623-c8eb968e1697": "ok"},
  ...
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> project = api.projects.get_by_id(128501682)
>>> project.archive()
>>> api.commit()
```

*Only available for Todoist Premium users.*

Archive project and its children.

### Command arguments

Parameter | Required | Description
--------- | -------- | -----------
ids *Array of Integer (id) or String (temp id)* | Yes | List of the ids of the projects to archive (could be temp ids).

## Unarchive a project

```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands=[{"type": "project_unarchive", "uuid": "7d86f042-e098-4fa6-9c1f-a61fe8c39d74", "args": {"ids": [128501682]}}]'

{
  ...
  "sync_status": {"7d86f042-e098-4fa6-9c1f-a61fe8c39d74": "ok"},
  ...
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> project = api.projects.get_by_id(128501815)
>>> project.unarchive()
>>> api.commit()
```

*Only available for Todoist Premium users.*

Unarchive project and its children.

### Command arguments

Parameter | Required | Description
--------- | -------- | -----------
ids  *Array of Integer (id) or String (temp id)* | Yes | List of the ids of the projects to unarchive (could be temp ids).

## Update multiple orders/indents

```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands=[{"type": "project_update_orders_indents", "uuid": "bf0855a3-0138-4b76-b895-88cad8db9edc", "args": {"ids_to_orders_indents": {"128501470": [42, 1], "128501607": [43, 1]}}}]'

{
  ...
  "sync_status": {"bf0855a3-0138-4b76-b895-88cad8db9edc": "ok"},
  ...
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.projects.update_orders_indents({128501470: [42, 1], 128501607: [43, 1]})
>>> api.commit()
```

Update the orders and indents of multiple projects at once.

### Command arguments

Parameter | Required | Description
--------- | -------- | -----------
ids_to_orders_indents *Object* | Yes | A dictionary object, with a project id as key and a two elements list as value: `project_id: [item_order, indent]`
