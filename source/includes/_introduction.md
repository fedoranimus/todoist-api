# Introduction

Welcome to the official Todoist API documentation!  The Todoist API can be used to hook [Todoist](https://todoist.com) with other applications, as it makes it easy for your client to retrieve and sync your data.

The Todoist API is based on [REST](http://en.wikipedia.org/wiki/Representational_State_Transfer), so you can use it with a tool like [cURL](http://curl.haxx.se), but language bindings also exist for [Python](https://www.python.org), so it is easier and faster to write your own scripts or applications interacting with Todoist.

The [source code](https://github.com/Doist/todoist-api) of this API documentation is also available.

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
query | Query after date, priority or labels.
register | Registers a new account.
delete_user | Deletes an existing account.
get_redirect_link | Gets the redirect link.
get_productivity_stats | Gets the productivity stats.
update_notification_settings | Updates the notification settings.
get_all_completed_items | Gets the user's completed tasks.
add_item | Adds a new item.

## Upgrading

The *Todoist API* is currently in version 6, and it replaces the older *Standard API* and *Sync API*, both of which were considered as version 5.

In this section we document all the changes between the two different versions of our API, in order to make it easier to upgrade your client code.

### The old APIs

Both the *Standard API* and the *Sync API* are considered deprecated since the release of the current *Todoist API*, which means that we are recommending everyone to migrate their clients to use our new API.  For the time being, the old APIs will still be available, and while there is no plan to put an end to them anytime soon, it must be noted that we will not be extending them either.

The [Standard and Sync API reference documentation](https://todoist.com/API/deprecated) will still be available, but from a different location than before, as the old URLs are now redirecting to the present documentation.

### The new API

The new *Todoist API* is actually based on the old *Sync API*, but it was further simplified, while at the same time a lot of effort went into improving different aspects of it.

Some very few calls from the old *Standard API* are now part of the new *Todoist API*, and they are basically those that provide some needed functionality that is unrelated to the user's data and objects.

Another addition is the OAuth support, which means that applications can now use the OAuth2 protocol to obtain a user authorized API access token.

Here follows a list of the most major changes from the old *Sync API*:

* The `get`, `sync` and `syncAndGetUpdated` API calls, were combined into one call, that is called `sync`, and which can be used to fetch and send data.
* All the `sync` call commands are sending back to client return values, including the bulk commands that operate on multiple items at once.
* A new error reporting subsystem was added, and now each error in one of the API calls or any of the commands of the `sync` call, is reported back as a JSON object, and it includes details on what went wrong and why.
* A new input validation mechanism was implemented, and missing arguments or invalid input values are reported back as JSON errors.
* Special care has been taken to improve the consistency of each the `sync` call commands with each other, for a more unified experience.
* UUIDs are now the default way for specifying temporary IDs and timestamps for each `sync` call and its commands, which makes it easier for clients to overcome the problem of uniqueness between requests and objects.
* And while it is not visible, the new API had also had its internals reworked in many places, something important in order to make it faster and less error-prone to introduce new functionality.

A more detailed list of minor changes are included here, because they might be useful to those migrating from the old *Sync API*:

* The `sync` call `items_to_sync` argument has been renamed to `commands`.
* The `sync` call `resource_types` argument is now required, and also by default no data are returned, unless some resources have been specified with this argument.
* The `sync` call has a new required argument, the `seq_no_global`, which should be defined in the same way as the `seq_no` argument.
* The `sync` call `include_notification_settings` argument has been removed, and instead the `notification_settings` resource should be included in the `resource_types` argument. 
* The `sync` call `resource_types` argument has a new resource called `user` that includes the accounts's details in the returned data.
* The `sync` call `resource_types` argument has a new resource called `all` that makes it possible to fetch all types of objects, ie. all the user data.
* The `timestamp` parameter of the `sync` call `commands` argument has been replaced by the `uuid` parameter which accepts UUIDs.
* The `temp_id` parameter of the `sync` call `commands` argument is now accepting UUIDs.
* The `SyncStatus` list is included in the extra data returned by the `sync` call, in addition to the `TempIdMapping` list.
* The server now returns different HTTP status codes to indicate whether a request was successful or not and why.
* The `project_add` command of the `sync` call now accepts `project_id` as a parameter for adding project notes, in addition to `item_id` for adding item notes.
* The `item_uncomplete_update_meta` command of the `sync` call was removed, and it was replaced by the `restore_state` parameter that can be defined in the `sync` call `item_uncomplete` command. 
* The `label_register` command of the `sync` call was renamed to `label_add`.
* The `label_update_orders` command was added in the `sync` call, and it can be used to update multiple label orders at once.
* The `note_id` parameter of the `note_update` and `note_delete` commands of the `sync` call was renamed to `id`.
* The `update_goals` command was added in the `sync` call, and it can be used to update the user's karma goals.

For those calls that were kept from the old *Standard API*, here follows a list of the changes that took place:

* The `loginWithGoogle`, `uploadFile`, `deleteUser`, `getRedirectLink`, `getProductivityStats`, `updateNotificationSettings`, `getAllCompletedTasks` and `addItem` calls were renamed to `login_with_google`, `upload_file`, `delete_user`, `get_redirect_link`, `get_productivity_stats`, `update_notification_settings`, `get_all_completed_items` and `add_item` respectively.
* The renamed `get_all_completed_items` call, now takes two additional parameters, `to_date` and `offset`, in order to better select which completed tasks to access.

Finally, and although this affects both the new API and the older APIs, we would nonetheless like to mention here, that due to security reasons, support for callbacks (JSONP) was removed.  This was used for overcoming the same-origin policy of modern browsers, and we can only suggest that a utility like [cURL](http://curl.haxx.se) is used to access our APIs instead.
