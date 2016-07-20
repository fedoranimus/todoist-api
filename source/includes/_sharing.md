# Sharing

Commands that are related to sharing projects will be described in this section.

## Share a project

> An example of sharing a project:

```shell
$ curl https://todoist.com/API/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "share_project", "temp_id": "854be9cd-965f-4ddd-a07e-6a1d4a6e6f7a", "uuid": "fe6637e3-03ce-4236-a202-8b28de2c8372", "args": {"project_id": "128501470", "email": "you@example.com"}}]'
{ ...
  "sync_status": {"fe6637e3-03ce-4236-a202-8b28de2c8372": "ok"},
  ... }
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.projects.share(128501470, 'you@example.com')
>>> api.commit()
```

Share a project.

### Required arguments

Argument | Description
-------- | -----------
project_id *Integer or String (temp_id)* | The project to be shared.
email *String* | The user email with whom to share the project.

## Delete a collaborator

> An example of deleting a person from a shared project:

```shell
$ curl https://todoist.com/API/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "delete_collaborator", "uuid": "0ae55ac0-3b8d-4835-b7c3-59ba30e73ae4", "args": {"project_id": 128501470, "email": "you@example.com"}}]'
{ ...
  "sync_status": {"0ae55ac0-3b8d-4835-b7c3-59ba30e73ae4": "ok"},
  ... }
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.collaborators.delete(128501470, 'you@example.com')
>>> api.commit()
```

Delete a person from a shared project.

### Required arguments

Argument | Description
-------- | -----------
project_id *Integer or String (temp_id)* | The project to be affected.
email *String* | The user email with whom the project was shared with.

## Accept an invitation

> An example of accepting an invitation:

```shell
$ curl https://todoist.com/API/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "accept_invitation", "uuid": "4b254da4-fa2b-4a88-9439-b27903a90f7f", "args": {"invitation_id": 1234,  "invitation_secret": "abcdefghijklmno"}}]'
{ ...
  "sync_status": {"4b254da4-fa2b-4a88-9439-b27903a90f7f": "ok"},
  ... }
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.invitations.accept(1234, 'abcdefghijklmno')
>>> api.commit()
```

Accept an invitation.

### Required arguments

Argument | Description
-------- | -----------
invitation_id *Integer* | The invitation id.
invitation_secret *String* | The secret fetched from the live notification.

## Reject an invitation

> An example of rejecting an invitation:

```shell
$ curl https://todoist.com/API/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "reject_invitation", "uuid": "284fd900-c36f-44e5-ab92-ee93455e50e0", "args": {"invitation_id": 1234,  "invitation_secret": "abcdefghijklmno"}}]'
{ ...
  "sync_status": {"284fd900-c36f-44e5-ab92-ee93455e50e0": "ok"},
  ... }
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.invitations.reject(1234, 'abcdefghijklmno')
>>> api.commit()
```

Reject an invitation.

### Required arguments

Argument | Description
-------- | -----------
invitation_id *Integer* | The invitation id.
invitation_secret *String* | The secret fetched from the live notification.

## Delete an invitation

> An example of deleting an invitation:

```shell
$ curl https://todoist.com/API/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "delete_invitation", "uuid": "399f6a8d-ddea-4146-ae8e-b41fb8ff6945", "args": {"invitation_id": 128501470}}]'
{ ...
  "sync_status": {"399f6a8d-ddea-4146-ae8e-b41fb8ff6945": "ok"},
  ... }
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.invitations.delete(128501470)
>>> api.commit()
```

Delete an invitation.

### Required arguments

Argument | Description
-------- | -----------
invitation_id *Integer* | The invitation to be deleted.
