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
attachment *Object* | Attachment file (optional)

The optional attachment attribute describes object with attachment
metadata. Format of this object depends on kind of attachment it describes,
see [sync API documentation for format details](https://developer.todoist.com/sync/v7#uploads).


## Get all comments

> Get all comments

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


## Get a comment

> Get a comment

```shell
curl "https://beta.todoist.com/API/v8/comments/1234?token=$token"

{
    "id": 1234,
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
import requests
requests.get("https://beta.todoist.com/API/v8/comments/1234", params={"token": token}).json()

{
    "id": 1234,
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

Returns a comment by id


## Update a comment

> Update a comment

```shell
curl "https://beta.todoist.com/API/v8/comments/1234?token=$token" \
    -X POST \
    --data '{"content": "Goodbye world"}' \
    -H "Content-Type: application/json" \
    -H "X-Request-Id: $(uuidgen)"
```

```python
import requests
requests.post("https://beta.todoist.com/API/v8/comments/1234",
    params={"token": token},
    data=json.dumps({"content": "Goodbye world"}),
    headers={
        "Content-Type": "application/json",
        "X-Request-Id": str(uuid.uuid4()),
    }
)
```

Update a comment and return an empty body with a HTTP status code 204

### JSON body parameters

Parameter | Required | Description
--------- | -------- | -----------
content *String* | Yes | New content for the comment


## Delete a comment

> Delete a comment

```shell
curl -X DELETE "https://beta.todoist.com/API/v8/comments/1234?token=$token"
```

```python
import requests
requests.delete("https://beta.todoist.com/API/v8/comments/1234", params={"token": token})
```

Delete a comment and return an empty body with a HTTP status code 204
