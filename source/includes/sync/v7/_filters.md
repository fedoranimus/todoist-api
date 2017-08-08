# Filters

*Filters are only available for Todoist Premium users.*

> An example filter object

```json
{
  "id": 4638878,
  "name": "Priority 1",
  "query": "priority 1",
  "color": 6,
  "item_order": 3,
  "is_deleted": 0
}
```

### Properties

Property | Description
-------- | -----------
id *Integer* | The id of the filter.
name *String* | The name of the filter.
query *String* | The query to search for. [Examples of searches](https://todoist.com/Help/Filtering) can be found in the Todoist help page.
color *Integer* | The color of the filter (between `0` and `7`, or between `0` and `12` for premium users).  The color codes corresponding to these numbers are: `#019412`, `#a39d01`, `#e73d02`, `#e702a4`, `#9902e7`, `#1d02e7`, `#0082c5`, `#555555`.  And for the additional colors of the premium users: `#008299`, `#03b3b2`, `#ac193d`, `#82ba00`, `#111111`.
item_order *Integer* | Filter’s order in the filter list (where the smallest value should place the filter at the top).
is_deleted *Integer* | Whether the filter is marked as deleted (where `1` is true and `0` is false).

## Add a filter

> An example of adding a filter:

```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "filter_add", "temp_id": "9204ca9f-e91c-436b-b408-ea02b3972686", "uuid": "0b8690b8-59e6-4d5b-9c08-6b4f1e8e0eb8", "args": {"name": "Filter1", "query": "no due date"}}]'

{
  ...
  "sync_status": {"0b8690b8-59e6-4d5b-9c08-6b4f1e8e0eb8": "ok"},
  "temp_id_mapping": {"9204ca9f-e91c-436b-b408-ea02b3972686": 9},
  ...
}

```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> filter = api.filters.add('Filter1', 'no due date')
>>> api.commit()
```

### Command arguments

Parameter | Required | Description
--------- | -------- | -----------
name *String* | Yes | The name of the filter.
query *String* | Yes | The query to search for. [Examples of searches](https://todoist.com/Help/Filtering) can be found in the Todoist help page.
color *Integer* | No | The color of the filter (between `0` and `7`, or between `0` and `12` for premium users).
item_order *Integer* | No | Filter’s order in the filter list (the smallest value should place the filter at the top).

## Update a filter

> An example of updating a filter:

```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "filter_update", "uuid": "a68b588a-44f7-434c-b3c5-a699949f755c", "args": {"id": 9, "query": "tomorrow"}}]'

{
  ...
  "sync_status": {"a68b588a-44f7-434c-b3c5-a699949f755c": "ok"},
  ...
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> filter = api.filters.get_by_id(9)
>>> filter.update(query='tomorrow')
>>> api.commit()
```

### Command arguments

Parameter | Required | Description
--------- | -------- | -----------
id *Integer or String (temp_id)* | Yes | The id of the filter.
name *String* | No | The name of the filter
query *String* | No | The query to search for. [Examples of searches](https://todoist.com/Help/Filtering) can be found in the Todoist help page.
color *Integer* | No | The color of the filter (between `0` and `7`, or between `0` and `12` for premium users).
item_order *Integer* | No | Filter’s order in the filter list (where the smallest value should place the filter at the top).

## Delete a filter

> An example of deleting a filter:

```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "filter_delete", "uuid": "b8186025-66d5-4eae-b0dd-befa541abbed", "args": {"id": 9}}]'

{
  ...
  "sync_status": {"b8186025-66d5-4eae-b0dd-befa541abbed": "ok"},
  ...
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> filter = api.filters.get_by_id(9)
>>> filter.delete()
>>> api.commit()
```

### Command arguments

Parameter | Required | Description
--------- | -------- | -----------
id *Integer or String (temp_id)* | Yes | The id of the filter.

## Update multiple orders

> An example of updating the orders of multiple filters at once:

```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands=[{"type": "filter_update_orders", "uuid": "517560cc-f165-4ff6-947b-3adda8aef744", "args": {"id_order_mapping": {"9":  1, "10": 2}}}]'

{
  ...
  "sync_status": {"517560cc-f165-4ff6-947b-3adda8aef744": "ok"},
  ...
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.filters.update_orders({9: 1, 10: 2})
>>> api.commit()
```

Update the orders of multiple filters at once.

### Command arguments

Parameter | Required | Description
--------- | -------- | -----------
id_order_mapping *Object* | Yes | A dictionary, where a filter id is the key, and the order its value: `filter_id: order`.
