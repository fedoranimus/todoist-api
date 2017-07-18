<!--
This file is generated automatically from .yml data file and _template.mako.

Please don't modify it, and modify source files instead. To compile the
file, ensure you have Python and Mako installed, and build all .md files
with Makefile (as simple as "make -C source/includes")
-->
# Labels

## Label object

> Label object sample

```shell
{
  "id": 1234, 
  "name": "Project X", 
  "order": 10
}
```

```python
{
  "id": 1234, 
  "name": "Project X", 
  "order": 10
}
```


Attribute | Description
----------|------------
id | Label id
name | Label name
order | Order of label (position in the UI)




## Get all labels

> Get all labels

```shell
# command
curl -X GET "$root/labels?token=$my_token"

# output
[
  {"id": 123, "name": "Project X", "order": 10}
]

```

```python
# command
>>> print requests.get(root + "/labels", args={"token": my_token}).json()

# output
[
  {"id": 123, "name": "Project X", "order": 10}
]

```



### HTTP Request
`GET https://beta.todoist.com/API/v8/labels` returns JSON-encoded array of all user labels



## Create new label

> Create new label

```shell
# command
curl -X POST "$root/labels?token=$my_token"
    --data '{"name": "Movies to watch"}'
    -H "Content-Type: application/json"
    -H "X-Request-Id: 29290B91-F437-42EB-8AA9-C6814CAF16B5"

# output
{"id": 123, "name": "Project X", "order": 10}

```

```python
# command
requests.post(root + "/labels",
    args={"token": my_token},
    data=json.dumps({"name": "Project X"}),
    headers={
        "Content-Type": "application/json",
        "X-Request-Id": "29290B91-F437-42EB-8AA9-C6814CAF16B5",
    }
).json()

# output
{"id": 123, "name": "Project X", "order": 10}

```



### HTTP Request
`POST https://beta.todoist.com/API/v8/labels` returns newly created label


### Request body attributes

Attribute | Description
----------|------------
name | Name of the label
order | Label order

## Get specific label

> Get specific label

```shell
# command
curl -X GET "$root/labels/1234?token=$my_token"

# output
{"id": 123, "name": "Project X", "order": 10}

```

```python
# command
requests.get(root + "/labels/1234", args={"token": my_token}).json()

# output
{"id": 123, "name": "Project X", "order": 10}

```



### HTTP Request
`GET https://beta.todoist.com/API/v8/labels/<label_id>` returns label by id



## Update specific label

> Update specific label

```shell
# command
curl -X POST "$root/labels/1234?token=$my_token"
    --data '{"name": "Project Y"}'
    -H "Content-Type: application/json"
    -H "X-Request-Id: 29290B91-F437-42EB-8AA9-C6814CAF16B5"

```

```python
# command
requests.post(root + "/labels/1234",
    args={"token": my_token},
    data=json.dumps({"name": "Project Y"}),
    headers={
        "Content-Type": "application/json",
        "X-Request-Id": "29290B91-F437-42EB-8AA9-C6814CAF16B5",
    }
)

```



### HTTP Request
`POST https://beta.todoist.com/API/v8/labels/<label_id>` returns HTTP status code 204 and empty body


### Request body attributes

Attribute | Description
----------|------------
name | New name of the label (optional)
order | Label order (optional)

## Delete specific label

> Delete specific label

```shell
# command
curl -X DELETE "$root/labels/1234?token=$my_token"

```

```python
# command
requests.delete(root + "/labels/1234", args={"token": my_token})

```



### HTTP Request
`DELETE https://beta.todoist.com/API/v8/labels/<label_id>` returns empty response




