<!--
This file is generated automatically from .yml data file and _template.mako.

Please don't modify it, and modify source files instead. To compile the
file, ensure you have Python and Mako installed, and build all .md files
with Makefile (as simple as "make -C source/includes")
-->
# Projects

## Project object

> Project object sample

```shell
{
  "comment_count": 10, 
  "id": 1234, 
  "indent": 1, 
  "name": "My project", 
  "order": 123
}
```

```python
{
  "comment_count": 10, 
  "id": 1234, 
  "indent": 1, 
  "name": "My project", 
  "order": 123
}
```


Attribute | Description
----------|------------
id | Project id
name | Project name
order | Project order (read-only, position in the list of projects)
indent | Project indentation level (read-only, value from 1 to 4)
comment_count | Number of project comments




## Get all projects

> Get all projects

```shell
# command
curl -X GET "$root/projects?token=$my_token"

# output
[
  {"id": 123, "name": "Inbox", "comment_count": 10, "order": 1, "indent": 1}
]

```

```python
# command
>>> print requests.get(root + "/projects", args={"token": my_token}).json()

# output
[
  {"id": 123, "name": "Inbox", "comment_count": 10, "order": 1, "indent": 1}
]

```



### HTTP Request
`GET https://beta.todoist.com/API/v8/projects` returns JSON-encoded array of all user projects



## Create new project

> Create new project

```shell
# command
curl -X POST "$root/projects?token=$my_token"
    --data '{"name": "Movies to watch"}'
    -H "Content-Type: application/json"
    -H "X-Request-Id: 29290B91-F437-42EB-8AA9-C6814CAF16B5"

# output
{"id": 123, "name": "Movies to watch", "comment_count": 0, "order": 1, "indent": 1}

```

```python
# command
requests.post(root + "/projects",
    args={"token": my_token},
    data=json.dumps({"name": "Movies to watch"}),
    headers={
        "Content-Type": "application/json",
        "X-Request-Id": "29290B91-F437-42EB-8AA9-C6814CAF16B5",
    }
).json()

# output
{"id": 123, "name": "Movies to watch", "comment_count": 0, "order": 1, "indent": 1}

```



### HTTP Request
`POST https://beta.todoist.com/API/v8/projects` returns newly created project


### Request body attributes

Attribute | Description
----------|------------
name | Name of the project

## Get specific project

> Get specific project

```shell
# command
curl -X GET "$root/projects/1234?token=$my_token"

# output
{"id": 123, "name": "Movies to watch", "comment_count": 0, "order": 1, "indent": 1}

```

```python
# command
requests.get(root + "/projects/1234", args={"token": my_token}).json()

# output
{"id": 123, "name": "Movies to watch", "comment_count": 0, "order": 1, "indent": 1}

```



### HTTP Request
`GET https://beta.todoist.com/API/v8/projects/<project_id>` returns project by id



## Update specific project

> Update specific project

```shell
# command
curl -X POST "$root/projects/1234?token=$my_token"
    --data '{"name": "Movies to watch"}'
    -H "Content-Type: application/json"
    -H "X-Request-Id: 29290B91-F437-42EB-8AA9-C6814CAF16B5"

```

```python
# command
requests.post(root + "/projects/1234",
    args={"token": my_token},
    data=json.dumps({"name": "Movies to watch"}),
    headers={
        "Content-Type": "application/json",
        "X-Request-Id": "29290B91-F437-42EB-8AA9-C6814CAF16B5",
    }
)

```



### HTTP Request
`POST https://beta.todoist.com/API/v8/projects/<project_id>` returns HTTP status code 204 and empty body


### Request body attributes

Attribute | Description
----------|------------
name | New name of the project

## Delete specific project

> Delete specific project

```shell
# command
curl -X DELETE "$root/projects/1234?token=$my_token"

```

```python
# command
requests.delete(root + "/projects/1234", args={"token": my_token})

```



### HTTP Request
`DELETE https://beta.todoist.com/API/v8/projects/<project_id>` returns empty response




