
# Introduction

This is a documentation for simplified Todoist API. It's a set of API endpoints,
allowing you to work easily with basic Todoist objects: projects, task,
comments and labels.

API relies on standard http response codes to indicate operation result.
Response codes 5XX indicate server errors and are safe to retry later; response
codes 4XX indicate request errors and should not be retried unmodified as they
won't be processed any different by an API; codes 2XX indicate successful
operation. Responses with code `200 OK` are of type `application/json` and
contain JSON-encoded representation of one or more objects. Responses with
code `204 No Content` indicates successful operation without any data to return.

API root is `https://beta.todoist.com/API/v8`.

<aside class="notice">
This API is in beta status. We are actively working to extend and improve it.
</aside>

# Authentication

> Authenticated request and response examples

```shell
$ curl "https://beta.todoist.com/API/v8/projects?token=$token"
[
        {
                "id": 1234,
                "name": "Inbox",
                "comment_count": 0
        }
]
```

```python
>>> requests.get('https://beta.todoist.com/API/v8/projects',
...     query_string={'token': your_token)}
... ).json()
[{u'comment_count': 0, u'id': 1234, u'name': u'Inbox'}]
```

API endpoints accept GET arguments as url-encoded values.  Every endpoint
requires a mandatory `token` query string parameter that holds Todoist personal
API token or OAuth API token.


# Sending POST requests

> Note that for POST requests you have to encode arguments with JSON
> and use appropriate header to mark the payload format

```shell
$ curl -X POST "https://beta.todoist.com/API/v8/projects?token=$token"
       --data '{"name": "Foo"}'
       -H 'Content-Type: application/json'
       -H 'X-Request-Id: E95F7930-8CD1-424F-AA43-D4DF64B4F020'
```

```python
>>> requests.post('https://beta.todoist.com/API/v8/projects',
...     query_string={'token': your_token),
...     data=json.dumps({"name": "Foo"}),
...     headers={
...         'Content-Type': "application/json",
...         'X-Request-Id': "E95F7930-8CD1-424F-AA43-D4DF64B4F020",
...     }
... })
```

Payload of POST requests has to be JSON-encoded and accompanied with
`application/json` Content-Type header.

Every endpoint requires mandatory `token` query
string parameter that holds Todoist personal API token or OAuth API token.

Each modification request may provide additional `X-Request-Id` HTTP header that
could be used as an unique string to ensure modifications are applied only
once — request having the same id as previously seen would be discarded.  If you
need to implement any request re-trying logic it is strongly advised to make use
of this header. This header value should not exceed 36 bytes.
