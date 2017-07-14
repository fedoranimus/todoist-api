# Emails

## Get or create

> An example creating an email to an object:

```shell
$ curl https://todoist.com/api/v7/emails/get_or_create \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d obj_type=project \
    -d obj_id=128501411
{
  "email": "Inbox <add.task.1855589.128501411.9a3ae36588cf36df@todoist.net>"
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.emails.get_or_create('project', 128501411)
{
  'email': 'Inbox <add.task.1855589.128501411.9a3ae36588cf36df@todoist.net>'
}
```

Creates a new email address for an object, or gets an existing email.

### Required parameters

Parameter | Description
--------- | -----------
token *String* | The user's token received on login.
obj_type *String* | The object's type, one of `project`, `project_comments` or `item`.
obj_id *Integer* | The object's id.


## Disable

> An example disabling an email to an object:

```shell
$ curl https://todoist.com/api/v7/emails/disable \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d obj_type=project \
    -d obj_id=128501411

{
  "status": "ok"
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.emails.disable('project', 128501411)
{
  'status': 'ok'
}
```

Disables an email address for an object.

### Required parameters

Parameter | Description
--------- | -----------
token *String* | The user's token received on login.
obj_type *String* | The object's type, one of `project`, `project_comments` or `item`.
obj_id *Integer* | The object's id.
