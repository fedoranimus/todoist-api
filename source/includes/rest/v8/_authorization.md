# Authorization

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
