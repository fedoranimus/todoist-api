# Labels

> An example label object

```json
{
  "id": 790748,
  "name": "Label1",
  "color": 7,
  "item_order": 0,
  "is_deleted": 0
}
```

### Properties

Property | Description
-------- | -----------
id *Integer* | The id of the label.
name *String* | The name of the label.
color *Integer* | The color of the label (a number between `0` and `7`, or between `0` and `12` for premium users). The color codes corresponding to these numbers are: `#019412`, `#a39d01`, `#e73d02`, `#e702a4`, `#9902e7`, `#1d02e7`, `#0082c5`, `#555555`.  And for the additional colors of the premium users: `#008299`, `#03b3b2`, `#ac193d`, `#82ba00`, `#111111`.
item_order *Integer* | Label’s order in the label list (a number, where the smallest value should place the label at the top).
is_deleted *Integer* | Whether the label is marked as deleted (where `1` is true and `0` is false).

## Add a label

> An example of adding a label:

```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "label_add", "temp_id": "f2f182ed-89fa-4bbb-8a42-ec6f7aa47fd0", "uuid": "ba204343-03a4-41ff-b964-95a102d12b35", "args": {"name": "Label1"}}]'

{
  ...
  "sync_status": {"ba204343-03a4-41ff-b964-95a102d12b35": "ok"},
  "temp_id_mapping": {"f2f182ed-89fa-4bbb-8a42-ec6f7aa47fd0": 790748},
  ...
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> label = api.labels.add('Label1')
>>> api.commit()
```

### Required arguments

Argument | Description
-------- | -----------
name *String* | The name of the label

### Optional arguments

Argument | Description
-------- | -----------
color *Integer* | The color of the label (a number between `0` and `7`, or between `0` and `12` for premium users).
item_order *Integer* | Label’s order in the label list (a number, where the smallest value should place the label at the top).

## Update a label

> An example of updating a label:

```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "label_update", "uuid": "9c9a6e34-2382-4f43-a217-9ab017a83523", "args": {"id": 790748, "color": 3}}]'

{
  ...
  "sync_status": {"9c9a6e34-2382-4f43-a217-9ab017a83523": "ok"},
  ...
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> label = api.labels.get_by_id(790748)
>>> label.update(color=3)
>>> api.commit()
```

### Required arguments

Argument | Description
-------- | -----------
id *Integer or String (temp_id)* | The id of the label.

### Optional arguments

Argument | Description
-------- | -----------
name *String* | The name of the label.
color *Integer* | The color of the label (a number between `0` and `7`, or between `0` and `12` for premium users).
item_order *Integer* | Label’s order in the label list.

## Delete a label

> An example of deleting a label:

```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "label_delete", "uuid": "aabaa5e0-b91b-439c-aa83-d1b35a5e9fb3", "args": {"id": 790748}}]'

{
  ...
  "sync_status": {"aabaa5e0-b91b-439c-aa83-d1b35a5e9fb3": "ok"},
  ...
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> label = api.labels.get_by_id(790748)
>>> label.delete()
>>> api.commit()
```

### Required arguments

Argument | Description
-------- | -----------
id *Integer or String (temp_id)* | The id of the label.

## Update multiple orders

> An example of updating the orders of multiple labels at once:

```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands=[{"type": "label_update_orders", "uuid": "1402a911-5b7a-4beb-bb1f-fb9e1ed798fb", "args": {"id_order_mapping": {"790748":  1, "790749": 2}}}]'

{
  ...
  "sync_status": {
    "517560cc-f165-4ff6-947b-3adda8aef744": "ok"},
  ...
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.labels.update_orders({790748: 1, 790749: 2})
>>> api.commit()
```

### Required arguments

Argument | Description
-------- | -----------
id_order_mapping *Object* | A dictionary, where a label id is the key, and the order its value: `label_id: order`.
