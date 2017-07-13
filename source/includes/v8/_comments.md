<!--
This file is generated automatically from .yml data file and _template.mako.

Please don't modify it, and modify source files instead. To compile the
file, ensure you have Python and Mako installed, and build all .md files
with Makefile (as simple as "make -C source/includes")
-->
# Comments

## Comment object

> Comment object sample

```shell
{
  "attachment": {
    "file_name": "File.pdf", 
    "file_type": "application/pdf", 
    "file_url": "https://cdn-domain.tld/path/to/file.pdf", 
    "resource_type": "file"
  }, 
  "content": "Hello world", 
  "id": 1234, 
  "posted": "2016-09-22T07:00:00Z", 
  "project_id": 2345, 
  "task_id": 2345
}
```

```python
{
  "attachment": {
    "file_name": "File.pdf", 
    "file_type": "application/pdf", 
    "file_url": "https://cdn-domain.tld/path/to/file.pdf", 
    "resource_type": "file"
  }, 
  "content": "Hello world", 
  "id": 1234, 
  "posted": "2016-09-22T07:00:00Z", 
  "project_id": 2345, 
  "task_id": 2345
}
```


Attribute | Description
----------|------------
id | Comment id
task_id | Comment's task id (for task comments).
project_id | Comment's project id (for project comments)
posted | Comment's posted timestamp in UTC
content | Comment content
attachment | optional object with comment attachment info, see below for details




## Get all comments for given task or project

> Get all comments for given task or project

```shell
# command
curl -X GET "$root/comments?task_id=2345&token=$my_token"

# output
[
  {
    "id": 123,
    "task_id": 2345,
    "content": "Hello world",
    "posted": "2016-09-22T07:00:00Z",
    "attachment": {
      "resource_type": "file",
      "file_url": "https://cdn-domain.tld/path/to/file.pdf",
      "file_type": "application/pdf",
      "file_name": "File.pdf"
    }
  }
]

```

```python
# command
>>> print requests.get(root + "/comments", args={"token": my_token, "task_id": 2345}).json()

# output
[
  {
    "id": 123,
    "task_id": 2345,
    "content": "Hello world",
    "posted": "2016-09-22T07:00:00Z",
    "attachment": {
      "resource_type": "file",
      "file_url": "https://cdn-domain.tld/path/to/file.pdf",
      "file_type": "application/pdf",
      "file_name": "File.pdf"
    }
  }
]

```

One of `task_id` or `project_id` arguments is required.

### HTTP Request
`GET https://beta.todoist.com/API/v8/comments` returns JSON-encoded array of all comments

### Request GET arguments

Attribute | Description
----------|------------
project_id | Project id to filter
task_id | Task id to filter


## Create new comment

> Create new comment

```shell
# command
$ cat /tmp/note.json {
    "task_id": 2345,
    "content": "Hello world"
    "attachment": {
        "resource_type": "file",
        "file_url": "https://cdn-domain.tld/path/to/file.pdf",
        "file_type": "application/pdf",
        "file_name": "File.pdf"
    }
}
$ curl -X POST "$root/comments?token=$my_token"
    --data @/tmp/note.json
    -H "Content-Type: application/json"
    -H "X-Request-Id: 29290B91-F437-42EB-8AA9-C6814CAF16B5"

# output
{
  "id": 123,
  "content": "Hello world",
  "task_id": 2345,
  "posted": "2016-09-22T07:00:00Z",
  "attachment": {
    "resource_type": "file",
    "file_url": "https://cdn-domain.tld/path/to/file.pdf",
    "file_type": "application/pdf",
    "file_name": "File.pdf"
  }
}

```

```python
# command
requests.post(root + "/comments",
    args={"token": my_token},
    data=json.dumps({
        "task_id": 2345,
        "content": "Hello world"
        "attachment": {
            "resource_type": "file",
            "file_url": "https://cdn-domain.tld/path/to/file.pdf",
            "file_type": "application/pdf",
            "file_name": "File.pdf"
        }
    }),
    headers={
        "Content-Type": "application/json",
        "X-Request-Id": "29290B91-F437-42EB-8AA9-C6814CAF16B5",
    }
).json()

# output
{
  "id": 123,
  "content": "Hello world",
  "task_id": 2345,
  "posted": "2016-09-22T07:00:00Z",
  "attachment": {
    "resource_type": "file",
    "file_url": "https://cdn-domain.tld/path/to/file.pdf",
    "file_type": "application/pdf",
    "file_name": "File.pdf"
  }
}

```



### HTTP Request
`POST https://beta.todoist.com/API/v8/comments` returns newly created comment


### Request body attributes

Attribute | Description
----------|------------
task_id | Comment's task id (for task comments).
project_id | Comment's project id (for project comments)
content | Comment content
attachment | optional object for attachment object

## Get specific comment

> Get specific comment

```shell
# command
curl -X GET "$root/comments/1234?token=$my_token"

# output
{
  "id": 123,
  "content": "Hello world",
  "task_id": 2345,
  "posted": "2016-09-22T07:00:00Z",
  "attachment": {
    "resource_type": "file",
    "file_url": "https://cdn-domain.tld/path/to/file.pdf",
    "file_type": "application/pdf",
    "file_name": "File.pdf"
  }
}

```

```python
# command
requests.get(root + "/comments/1234", args={"token": my_token}).json()

# output
{
  "id": 123,
  "content": "Hello world",
  "task_id": 2345,
  "posted": "2016-09-22T07:00:00Z",
  "attachment": {
    "resource_type": "file",
    "file_url": "https://cdn-domain.tld/path/to/file.pdf",
    "file_type": "application/pdf",
    "file_name": "File.pdf"
  }
}

```



### HTTP Request
`GET https://beta.todoist.com/API/v8/comments/<comment_id>` returns comment by id



## Update specific comment

> Update specific comment

```shell
# command
curl -X POST "$root/comments/1234?token=$my_token"
    --data '{"content": "Goodbye world"}'
    -H "Content-Type: application/json"
    -H "X-Request-Id: 29290B91-F437-42EB-8AA9-C6814CAF16B5"

```

```python
# command
requests.post(root + "/comments/1234",
    args={"token": my_token},
    data=json.dumps({"content": "Goodbye world"}),
    headers={
        "Content-Type": "application/json",
        "X-Request-Id": "29290B91-F437-42EB-8AA9-C6814CAF16B5",
    }
)

```



### HTTP Request
`POST https://beta.todoist.com/API/v8/comments/<comment_id>` returns HTTP status code 204 and empty body


### Request body attributes

Attribute | Description
----------|------------
content | New content of the comment

## Delete specific comment

> Delete specific comment

```shell
# command
curl -X DELETE "$root/comments/1234?token=$my_token"

```

```python
# command
requests.delete(root + "/comments/1234", args={"token": my_token})

```



### HTTP Request
`DELETE https://beta.todoist.com/API/v8/comments/<comment_id>` returns empty response




