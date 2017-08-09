# Comments

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

### Properties

Property | Description
----------|------------
id *Integer* | Comment id
task_id *Integer* | Comment's task id (for task comments).
project_id *Integer* | Comment's project id (for project comments)
posted *String* | Date and time when comment was added, [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) format in UTC
content *String* | Comment content
attachment *Object* | Object with comment attachment info, see below for details (optional)

Optional attachment attribute describes object with attachment
metadata. Format of this object depends on kind of attachment it
describes, see [sync API documentation for format details](https://developer.todoist.com/sync/v7#uploads).


## Get all comments for a given task or project

> Get all comments for a given task or project

```shell
curl "https://beta.todoist.com/API/v8/comments?task_id=2345&token=$token"

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
import requests
requests.get("https://beta.todoist.com/API/v8/comments", params={"token": token, "task_id": 2345}).json()

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


Returns JSON-encoded array of all comments for a given `task_id` or
`project_id`. Note that one of `task_id` or `project_id` arguments is
required.

### Parameters

Parameter | Required | Description
--------- | -------- | -----------
project_id *Integer* | No | Id of the project used to filter comments
task_id *Integer* | No | Id of the task used to filter comments

**Note**: You **must** use at least one of them

## Create a new comment

> Create a new comment

```shell
$ cat > /tmp/note.json 
{
    "task_id": 2345,
    "content": "Hello world",
    "attachment": {
        "resource_type": "file",
        "file_url": "https://s3.amazonaws.com/domorebetter/Todoist+Setup+Guide.pdf",
        "file_type": "application/pdf",
        "file_name": "File.pdf"
    }
}
^C

$ curl "https://beta.todoist.com/API/v8/comments?token=$token" \
    -X POST \
    --data @/tmp/note.json \
    -H "Content-Type: application/json" \
    -H "X-Request-Id: $(uuidgen)"

{
  "id": 123,
  "content": "Hello world",
  "task_id": 2345,
  "posted": "2016-09-22T07:00:00Z",
  "attachment": {
    "resource_type": "file",
    "file_url": "https://s3.amazonaws.com/domorebetter/Todoist+Setup+Guide.pdf",
    "file_type": "application/pdf",
    "file_name": "File.pdf"
  }
}
```

```python
import requests
requests.post("https://beta.todoist.com/API/v8/comments",
    params={"token": token},
    data=json.dumps({
        "task_id": 2248549994,
        "content": "Hello world",
        "attachment": {
            "resource_type": "file",
            "file_url": "https://s3.amazonaws.com/domorebetter/Todoist+Setup+Guide.pdf",
            "file_type": "application/pdf",
            "file_name": "File.pdf"
        }
    }),
    headers={
        "Content-Type": "application/json",
        "X-Request-Id": str(uuid.uuid4()),
    }
).json()

{
  "id": 123,
  "content": "Hello world",
  "task_id": 2345,
  "posted": "2016-09-22T07:00:00Z",
  "attachment": {
    "resource_type": "file",
    "file_url": "https://s3.amazonaws.com/domorebetter/Todoist+Setup+Guide.pdf",
    "file_type": "application/pdf",
    "file_name": "File.pdf"
  }
}
```

Create a new comment on a project or task and return its object

### JSON body parameters

Parameter | Required | Description
--------- | -------- | -----------
task_id *Integer* | Yes (or `project_id`) | Comment's task id (for task comments).
project_id *Integer* | Yes (or `task_id`) | Comment's project id (for project comments)
content *String* | Yes | Comment content
attachment *Object* | No | Object for attachment object


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




