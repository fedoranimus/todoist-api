# Backups

Todoist creates a backup achieves of users' data on the daily basis. Backup achieves can be accessed from the web app 
(Todoist Setting / Backups). The list of recent backup achieves can also be accessed via the following API endpoints: 

`/API/v6/backups/get` (HTTP POST, application/x-www-form-urlencoded)



```shell
$ curl https://todoist.com/API/v6/backups/get \
    -d token=0123456789abcdef0123456789abcdef01234567
```


### Required parameters

Parameter | Description
--------- | -----------
token *String* | access token


>Upon successful request, a HTTP 200 response will be returned with a list of backup achieve in JSON format.

```shell
[
    {
        "version": "2016-01-13 02:03", 
        "url": "https://s3.amazonaws.com/user_backups.todoist.com/..."
    },
    ...
]
```


