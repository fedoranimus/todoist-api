# Backups

## Get backups

Todoist creates a backup archive of users' data on a daily basis. Backup archives can also be accessed from the web app
(`Todoist Settings` -> `Backups`).

> The list of recent backup archives can be accessed via the following API endpoint, and upon successful request, a HTTP 200 response will be returned with a list of backup archives in JSON format:


```shell
$ curl https://todoist.com/api/v7/backups/get \
    -d token=0123456789abcdef0123456789abcdef01234567
[
  {
    "version": "2016-01-13 02:03",
    "url": "https://s3.amazonaws.com/user_backups.todoist.com/..."
  },
    ...
]
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.backups.get()
[
  {
    'version': '2016-01-13 02:03',
    'url': 'https://s3.amazonaws.com/user_backups.todoist.com/...'
  },
  ...
]
```

### Required parameters

Parameter | Description
--------- | -----------
token *String* | The user's token received on login (a string hash value).
