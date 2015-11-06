# Introduction

Welcome to the Todoist API documentation. The Todoist API can be used to hook Todoist with other applications, as it makes it easy for your client to retrieve and sync your data.


In order to keep track of any changes we do to our API documentation, we recommend you to subscribe to the [Todoist API page on API Changelog](https://www.apichangelog.com/api/todoist).

<p><script type="text/javascript" src="//www.apichangelog.com/static/widget/follow.js" api="todoist"></script></p>

## Libraries

At the moment there are language bindings for Python, but we are planning on creating client libraries for other languages and platforms in the future.

### Python

> You can install the Todoist Python library from PyPI with:

```
$ pip install todoist-python
```

The language bindings for Python come in the form of the [Todoist Python API library](https://github.com/Doist/todoist-python).

A [PyPI package](https://pypi.python.org/pypi/todoist-python) has been also prepared in order to easily install the Todoist Python library in your system.

There is more detailed documentation speficically for the Todoist Python API library, and this [API reference](http://todoist-python.readthedocs.org/en/latest/) documentation can be also read online.

## Overview

The Todoist API is based on syncing data from and to the server, so almost all
interactions with the Todoist server can be done with a single call: `sync`.
This can be used to get the full model (projects, items, etc.), and then
update it, or perform changes to it.

Then there are a few more auxiliary calls that can perform some actions that
are not related to the full model, but are nonetheless useful.

### Available calls

Call | Description
---- | -----------
sync | Retrieves or sends data.
login | Logins to the server using the user's password.
login_with_google | Logins to the server using OAuth2.
upload_file | Uploads a file.
register | Registers a new account.
delete_user | Deletes an existing account.
get_redirect_link | Gets the redirect link.
get_productivity_stats | Gets the productivity stats.
update_notification_settings | Updates the notification settings.
get_all_completed_items | Gets the user's completed tasks.
add_item | Adds a new item.

