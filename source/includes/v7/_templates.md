# Templates

Templates allow exporting of a projects tasks into a file or URL, and then importing of the complete task list to a new or existing project.  Note that, templates are only available for Todoist Premium users.

## Import into project

> On success, an HTTP 200 OK with JSON data of file data is returned:

```shell
$ curl https://todoist.com/api/v7/templates/import_into_project \
    -F token=0123456789abcdef0123456789abcdef01234567 \
    -F project_id=128501470 \
    -F file=@example.csv
{
  "status": "ok"
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.templates.import_into_project(128501470, 'example.csv')
{
  'status': 'ok'
}

```

Upload a file suitable to be passed as a template to be imported into a project.


## Export as file

> On success, a CSV template is returned:

```shell
$ curl https://todoist.com/api/v7/templates/export_as_file \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d project_id=128501470
TYPE,CONTENT,PRIORITY,INDENT,AUTHOR,RESPONSIBLE,DATE,DATE_LANG
task,Task1,4,1,Firstname (1),,,en
,,,,,,,
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.templates.export_as_file(128501470)
TYPE,CONTENT,PRIORITY,INDENT,AUTHOR,RESPONSIBLE,DATE,DATE_LANG
task,Task1,4,1,Firstname (1),,,en
,,,,,,,
```

Get a template for a project as a file.

## Export as shareable URL

> On success, a URL is returned:

```shell
$ curl https://todoist.com/api/v7/templates/export_as_url \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d project_id=128501470
{
  "file_name": "*_Project1.csv",
  "file_url": "https://*.cloudfront.net/*_Project1.csv"
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.templates.export_as_url(128501470)
{
  'file_name': '*_Project1.csv',
  'file_url': 'https://*.cloudfront.net/*_Project1.csv'
}

```

Get a template for a project as a shareable URL.

The URL can then be passed to `https://todoist.com/importFromTemplate?t_url=<url>` to make a sharable template.
