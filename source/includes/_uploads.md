# Uploads

Files can be uploaded to our servers and used as file attachments in Notes.

## Upload a file

> On success, an HTTP 200 OK with JSON data of file data is returned:

```shell
$ curl https://todoist.com/api/v7/uploads/add \
    -F token=0123456789abcdef0123456789abcdef01234567 \
    -F file_name=example.jpg \
    -F file=@/path/to/example.jpg
{
  "file_name": "example.jpg",
  "file_size": 85665,
  "file_type": "image/jpeg",
  "file_url": "https://*.cloudfront.net/*/example.jpg",
  "tn_l": [
    "https://*.cloudfront.net/tn_l_*.jpg",
    400, 309
  ],
  "tn_m": [
    "https://*.cloudfront.net/tn_m_*.jpg",
    288, 222
  ],
  "tn_s": [
    "https://*.cloudfront.net/tn_s_*.jpg",
    96, 74
  ]
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.uploads.add('example.jpg')
{
  'file_name': 'example.jpg',
  'file_size': 85665,
  'file_type': 'image/jpeg',
  'file_url': 'https://*.cloudfront.net/*/example.jpg',
  'tn_l': [
    'https://*.cloudfront.net/tn_l_*.jpg',
    400, 309
  ],
  'tn_m': [
    'https://*.cloudfront.net/tn_m_*.jpg',
    288, 222
  ],
  'tn_s': [
    'https://*.cloudfront.net/tn_s_*.jpg',
    96, 74
  ]
}

```
Upload a file suitable to be passed as a `file_attachment` attribute to the `note_add` or `note_update` calls.

### Required parameters

Parameter | Description
--------- | -----------
token *String* | The user's token received on login.
file_name *String* | The file name to be uploaded.

### Base file properties

Attribute | Description
--------- | -----------
file_name *String* | The name of the file.
file_size *Integer* | The size of the file in bytes.
file_type *String* | MIME type (i.e. `text/plain`, `image/png`).
file_url *String* | The URL where the file is located (a string value representing an HTTP URL). Note that we don't cache the remote content on our servers and stream or expose files directly from third party resources. In particular this means that you should avoid providing links to non-encrypted (plain HTTP) resources, as exposing this files in Todoist may issue a browser warning.
upload_state *String* | Upload completion state (either `pending` or `completed`).

### Image file properties

If you upload an image, you may provide thumbnail paths to ensure Todoist handles them appropriately. Valid thumbnail information is a JSON array with URL, width in pixels, height in pixels. Ex.: `["http://example.com/img.jpg",400,300]`. "Canonical" thumbnails (ones we create by `upload_file` API call) have following sizes: `96x96`, `288x288`, `528x528`.

Attribute | Description
--------- | -----------
tn_l *Array* | Large thumbnail (a list that contains the URL, the width and the height of the thumbnail).
tn_m *Array* | Medium thumbnail (a list that contains the URL, the width and the height of the thumbnail).
tn_s *Array* | Small thumbnail (a list that contains the URL, the width and the height of the thumbnail).

### Audio file properties

If you upload an audio file, you may provide an extra attribute `file_duration` (duration of the audio file in seconds, which takes an integer value). In the web interface the file is rendered back with a `<audio>` tag, so you should make sure it's supported in current web browsers. See [supported media formats](https://developer.mozilla.org/en-US/docs/HTML/Supported_media_formats) for the reference.

## Get uploads

> An example of getting the user's uploads

```shell
$ curl https://todoist.com/api/v7/uploads/get \
    -d token=0123456789abcdef0123456789abcdef01234567
[
    {
        "file_size": 86406,
        "file_type": "image/jpeg",
        "file_url": "https://*.cloudfront.net/*/example.jpg",
        "filename": "example.jpg",
        "id": 34xx,
        "ip": "8.8.8.x",
        "item_id": 26166xxxxxx,
        "note_id": 6157xxxxxx,
        "project_id": 156996xxxxxx,
        "uploaded": "Wed 16 Dec 2015 13:18:17 +0000",
        "user_id": 5713xxxxxx
    },
    {
        "file_size": 312,
        "file_type": "text/plain",
        "file_url": "https://*.cloudfront.net/*/todo.txt",
        "filename": "todo.txt",
        "id": 34xx,
        "ip": "2.86.104.243",
        "item_id": 26166xxxxxx,
        "note_id": 6157xxxxxx,
        "project_id": 156996xxxxxx,
        "uploaded": "Wed 16 Dec 2015 12:08:14 +0000",
        "user_id": 5713xxxxxx
    }
]
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.uploads.get()
[
    {
        "file_size": 86406,
        "file_type": "image/jpeg",
        "file_url": "https://*.cloudfront.net/*/example.jpg",
        "filename": "example.jpg",
        "id": 34xx,
        "ip": "8.8.8.x",
        "item_id": 26166xxxxxx,
        "note_id": 6157xxxxxx,
        "project_id": 156996xxxxxx,
        "uploaded": "Wed 16 Dec 2015 13:18:17 +0000",
        "user_id": 5713xxxxxx
    },
    {
        "file_size": 312,
        "file_type": "text/plain",
        "file_url": "https://*.cloudfront.net/*/todo.txt",
        "filename": "todo.txt",
        "id": 34xx,
        "ip": "2.86.104.243",
        "item_id": 26166xxxxxx,
        "note_id": 6157xxxxxx,
        "project_id": 156996xxxxxx,
        "uploaded": "Wed 16 Dec 2015 12:08:14 +0000",
        "user_id": 5713xxxxxx
    }
]
```

Get all user's uploads.

### Required parameters

Parameter | Description
--------- | -----------
token *String* | The user's token received on login (a string hash value).

### Optional parameters

Parameter | Description
--------- | -----------
limit *Integer* | The number of items to return (a number, where the default is `30`, and the maximum is `50`).
last_id *Integer* | Can be used for pagination. This should be the minimum upload id you've fetched so far. All results will be listed before that id.

## Delete upload

> An example of deleting an upload

```shell
$ curl https://todoist.com/api/v7/uploads/delete \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d file_url='https://*.cloudfront.net/*/example.jpg'
"ok"
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.uploads.delete('https://*.cloudfront.net/*/example.jpg')
ok
```

Delete an upload.

### Required parameters

Parameter | Description
--------- | -----------
token *String* | The user's token received on login (a string hash value).
file_url *String* | The file URL to delete.

