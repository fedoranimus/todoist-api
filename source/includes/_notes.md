# Notes

> An example task note object

```json
{
  "id": 17299568,
  "posted_uid": 1855589,
  "project_id": 128501470,
  "item_id": 33548400,
  "content": "Note",
  "file_attachment": {
    "file_type": "text/plain",
    "file_name": "File1.txt",
    "file_size": 1234,
    "file_url": "https://example.com/File1.txt",
    "upload_state": "completed"
  },
  "uids_to_notify": null,
  "is_deleted": 0,
  "is_archived": 0,
  "posted": "Wed 01 Oct 2014 14:54:55 +0000"
}
```

Notes are only available for Todoist Premium users.

### Properties

Property | Description
-------- | -----------
id | The id of the note (a unique number).
posted_uid | The id of the user that posted the note (a unique number).
item_id | The item which the note is part of (a unique number).
project_id | The project which the note is part of (a unique number).
content | The content of the note (a string value).
file_attachment | A file attached to the note (see more details about attachments later on).
uids_to_notify | A list of user ids to notify (unique numbers).
is_deleted | Whether the note is marked as deleted (where `1` is true and `0` is false).
is_archived | Whether the note is marked as archived (where `1` is true and `0` is false).
posted | The date when the notes was posted.

### File attachments

A file attachment is represented as a JSON object. The file attachment may point to a document, previously uploaded by the `upload_file` API call, or by any external resource.

### Base file properties

Attribute | Description
--------- | -----------
file_name | The name of the file (a string value).
file_size | The size of the file in bytes (a number).
file_type | MIME type (a string value such as `text/plain` or `image/png`).
file_url | The URL where the file is located (a string value representing an HTTP URL). Note that we don't cache the remote content on our servers and stream or expose files directly from third party resources. In particular this means that you should avoid providing links to non-encrypted (plain HTTP) respources, as exposing this files in Todoist may issue a browser warning.
upload_state | Upload completion state (a string value such as `pending` or `completed`).

### Image file properties

If you upload an image, you may provide thumbnail paths to ensure Todoist handles them appropriately. Valid thumbnail information is a JSON array with URL, width in pixels, height in pixels. Ex.: ["http://example.com/img.jpg",400,300]. "Canonical" thumbnails (ones we create by `upload_file` API call) have following sizes: 96x96, 288x288, 528x528.

Attribute | Description
--------- | -----------
tn_l | Large thumbnail (a list that contains the URL, the width and the height of the thumbnail).
tn_m | Medium thumbnail (a list that contains the URL, the width and the height of the thumbnail).
tn_s | Small thumbnail (a list that contains the URL, the width and the height of the thumbnail).

### Audio file properties

If you upload an audio file, you may provide an extra attribute `file_duration` (duration of the audio file in seconds, which takes an integer value). In the web interface the file is rendered back with a `<audio>` tag, so you should make sure it's supported in current web browsers. See [supported media formats](https://developer.mozilla.org/en-US/docs/HTML/Supported_media_formats) for the reference.


## Add a note

> An example of adding a note:

```shell
$ curl https://todoist.com/API/v6/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "note_add", "temp_id": "59fe4461-287b-4b00-bacc-ee771137a732", "uuid": "e1005f08-acd6-4172-bab1-4338f8616e49", "args": {"item_id": 33548400, "content": "Note1"}}]'
{ ...
  "SyncStatus": {"e1005f08-acd6-4172-bab1-4338f8616e49": "ok"},
  "TempIdMapping": {"59fe4461-287b-4b00-bacc-ee771137a732": 17299568},
  ... }
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> note = api.notes.add(33548400, 'Note1')
>>> api.commit()
```

Add a note.

### Required arguments

Argument | Description
-------- | -----------
item_id | The item which the note is part of (a unique number or temp id).
content | The content of the note (a string value).

### Optional arguments

Argument | Description
-------- | -----------
file_attachment | A file attached to the note (see more details about attachments above).


## Add a project note

> An example of adding a project note:

```shell
$ curl https://todoist.com/API/v6/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "note_add", "temp_id": "95653826-fc43-47b3-86c8-c11f90fe7aba", "uuid": "f5d12bd9-d14d-4529-b223-9cd7d593119e", "args": {"project_id": 128501682, "content": "Note1"}}]'
{ ...
  "SyncStatus": {"f5d12bd9-d14d-4529-b223-9cd7d593119e": "ok"},
  "TempIdMapping": {"95653826-fc43-47b3-86c8-c11f90fe7aba": 17299568},
  ... }
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> note = api.notes.add(128501682, 'Note1')
>>> api.commit()
```

Add a project note.

### Required arguments

Argument | Description
-------- | -----------
project_id | The project which the note is part of (a unique number).
content | The content of the note (a string value).

### Optional arguments

Argument | Description
-------- | -----------
file_attachment | A file attached to the note (see more details about attachments above).

## Update a note

> An example of updating a note:

```shell
$ curl https://todoist.com/API/v6/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "note_update", "uuid": "8a38f9c5-2cd0-4da5-87c1-26d617b354e0", "args": {"id": 17299568, "content": "UpdatedNote1"}}]'
{ ...
  "SyncStatus": {"8a38f9c5-2cd0-4da5-87c1-26d617b354e0": "ok"},
  ... }
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> note api.notes.get_by_id(17299568)
>>> note.update(content='UpdatedNote1')
>>> api.commit()
```

Update a note.

### Required arguments

Argument | Description
-------- | -----------
id | The id of the note (a unique number or temp id).

### Optional arguments

Argument | Description
-------- | -----------
content | The content of the note (a string value).
file_attachment | A file attached to the note (see more details about attachments above).

## Delete a note

> An example of deleting a note:

```shell
$ curl https://todoist.com/API/v6/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "note_delete", "uuid": "8d666fda-73c3-4677-8b04-5d223632c24f", "args": {"id": 17299568, "item_id": 33548400}}]'
{ ...
  "SyncStatus": {"8d666fda-73c3-4677-8b04-5d223632c24f": "ok"},
  ... }
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> note = api.notes.get_by_id(17299568)
>>> note.delete()
>>> api.commit()
```

Delete a note.

### Required arguments

Argument | Description
-------- | -----------
id | The id of the note (a unique number or temp id).
