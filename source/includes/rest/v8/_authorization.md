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
import requests
requests.get('https://beta.todoist.com/API/v8/projects',
    query_string={'token': your_token)}
).json()

[{u'comment_count': 0, u'id': 1234, u'name': u'Inbox'}]
```

API endpoints accept GET arguments as `url-encoded` values. Every endpoint
requires a `token` query string parameter that holds the
[Todoist personal API token](https://todoist.com/Users/viewPrefs?page=authorizations) or
[OAuth API token](https://developer.todoist.com/sync/v7/#oauth).
