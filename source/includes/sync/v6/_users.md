# Users

A user in Todoist is a JSON object. The dates will be in the UTC timezone. Typically a user object will have the following properties:

> An example user object

```json
{
  "id": 1855589,
  "token": "0123456789abcdef0123456789abcdef01234567",
  "email": "me@xample.com",
  "full_name": "Example User",
  "inbox_project": 128501411,
  "timezone": "Europe\/Athens",
  "tz_offset": ["+03:00", 3, 0, 1],
  "start_page": "overdue, 7 days",
  "start_day": 1,
  "next_week": 1,
  "date_format": 0,
  "time_format": 0,
  "sort_order": 0,
  "has_push_reminders": false,
  "default_reminder": null,
  "auto_reminder" : 30,
  "mobile_host": null,
  "mobile_number": null,
  "completed_count": 20,
  "completed_today" : 2,
  "karma": 684.0,
  "karma_trend": "-",
  "is_premium": false,
  "premium_until": null,
  "is_biz_admin": false,
  "business_account_id": null,
  "image_id": null,
  "avatar_small" : "https://*.cloudfront.net/*_small.jpg",
  "avatar_medium" : "https://*.cloudfront.net/*_medium.jpg",
  "avatar_big" : "https://*.cloudfront.net/*_big.jpg",
  "avatar_s640" : "https://*.cloudfront.net/*_s640.jpg",
  "theme" : 0,
  "guide_mode" : false,
  "restriction" : 3,
  "features" : {},
  "beta": 0,
  "is_dummy": 0,
  "join_date": "Wed 30 Apr 2014 13:24:38 +0000"
}
```

### Properties

Property | Description
-------- | -----------
id | The user's id (a unique number).
token | The user's token that should be used to call the other API methods (a unique string hash value).
email | The user's email (a string value representing a valid email address).
full_name | The user's real name (a string value in a `Firstname Surname` format).
inbox_project | The id of the user's `Inbox` project (a unique number).
timezone | The user's timezone (a string value such as `UTC`, `Europe/Lisbon`, `US/Eastern`, `Asian/Taipei`).
tz_offset | User's timezone offset `[GMT_STRING, HOURS, MINUTES, IS_DAYLIGHT_SAVINGS_TIME]`.
start_page | The user's default view on Todoist. The start page can be one of the following: `_info_page` for the info page, `_blank` for a blank page, `_project_<PROJECT_ID>` for project with id `<PROJECT_ID>`, and `<ANY_QUERY>` to query after anything.
start_day | The first day of the week (a number between `1` and `7`, where `1` is `Monday` and `7` is `Sunday`).
next_week | The day of the next week, that tasks will be postponed to (a number between `1` and `7`, where `1` is `Monday` and `7` is `Sunday`).
time_format | Whether to use a `24h` format such as `13:00` (if set to `0`) when displaying time, or a `12h` format such as `1:00pm` (if set to `1`).
date_format | Whether to use the `DD-MM-YYYY` date format (if set to `0`), or the `MM-DD-YYYY` format (if set to `1`).
sort_order | Whether to show projects in an `oldest dates first` order (if set to `0`, or a `oldest dates last` order (if set to `1`).
has_push_reminders | Whether the user has push reminders enabled (a `true` or `false` value).
default_reminder | The default reminder for the user. Reminders are only possible for Premium users. The default reminder can be one of the following: `email` to send reminders by email, `mobile` to send reminders to mobile devices via SMS, `push` to send reminders to smart devices using push notifications (one of the Android or iOS official clients must be installed on the client side to receive these notifications), `no_default` to turn off sending default reminders.
auto_reminder | The default time in minutes for the automatic reminders set, whenever a due date has been specified for a task (a number).
mobile_number | The user's mobile number (a string value or `null` if not set).
mobile_host | The user's mobile host (a string value or `null` if not set).
completed_count | The total number of completed tasks (a number).
completed_today | The number of completed tasks for today (a number).
karma | The user's karma score (a float number).
karma_trend | The user's karma trend (a string value like `up`).
is_premium | Whether the user has a Premium subscription (a `true` or `false` value).
premium_until | The date when the user's Premium subscription ends (`null` if not a Premium user).
is_biz_admin | Whether the user is a business account administrator (a `true` or `false` value).
business_account_id | The id of the user's business account (a unique number).
image_id | The id of the user's avatar (a unique string hash value).
avatar_small | The link to a 35x35 pixels image of the user's avatar (a string URL).
avatar_medium | The link to a 60x60 pixels image of the user's avatar (a string URL).
avatar_big | The link to a 195x195 pixels image of the user's avatar (a string URL).
avatar_s640 | The link to a 640x640 pixels image of the user's avatar (a string URL).
theme | The currently selected Todoist theme (a number between `0` and `10`).
guide_mode | Whether guide is enabled or not (a `true` or `false` value).
restriction | Used internally for any special restrictions that apply to the user.
features | Used internally for any special features that apply to the user.
beta | Whether the user is in beta status (where `1` is true and `0` is false).
is_dummy | Whether the user is a dummy user (where `1` is true and `0` is false).
join_date | The date when the user joined Todoist.


## Register a new user

> An example of registering a new user:


```shell
$ curl https://todoist.com/API/v6/register \
    -d email=me@example.com \
    -d full_name=Example\ User \
    -d password=secret
{
  "id": 1855589,
  "token": "0123456789abcdef0123456789abcdef01234567",
  "email": "me@xample.com",
  "full_name": "Example User",
  "inbox_project": 128501411,
  "timezone": "Europe\/Athens",
  "tz_offset": ["+03:00", 3, 0, 1],
  "start_page": "overdue, 7 days",
  "start_day": 1,
  "next_week": 1,
  "date_format": 0,
  "time_format": 0,
  "sort_order": 0,
  "has_push_reminders": false,
  "default_reminder": null,
  "auto_reminder" : 30,
  "mobile_host": null,
  "mobile_number": null,
  "completed_count": 20,
  "completed_today" : 2,
  "karma": 684.0,
  "karma_trend": "-",
  "is_premium": false,
  "premium_until": null,
  "is_biz_admin": false,
  "business_account_id": null,
  "image_id": null,
  "avatar_small" : "https://*.cloudfront.net/*_small.jpg",
  "avatar_medium" : "https://*.cloudfront.net/*_medium.jpg",
  "avatar_big" : "https://*.cloudfront.net/*_big.jpg",
  "avatar_s640" : "https://*.cloudfront.net/*_s640.jpg",
  "theme" : 0,
  "guide_mode" : false,
  "restriction" : 3,
  "features" : {},
  "beta": 0,
  "is_dummy": 0,
  "join_date": "Wed 30 Apr 2014 13:24:38 +0000"
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI()
>>> api.register('me@example.com', 'Example User', 'secret')
{
  'id': 1855589,
  'token': '0123456789abcdef0123456789abcdef01234567',
  'email': 'me@exampe.com',
  'full_name': 'Example User',
  'inbox_project': 128501411,
  'timezone': 'Europe/Athens',
  'tz_offset': ['+03:00', 3, 0, 1],
  'start_page': 'overdue, 7 days',
  'start_day': 1,
  'next_week': 1,
  'date_format': 0,
  'time_format': 0,
  'sort_order': 0,
  'has_push_reminders': False,
  'default_reminder': None,
  'auto_reminder' : 30,
  'mobile_host': None,
  'mobile_number': None,
  'completed_count': 20,
  'completed_today' : 2,
  'karma': 684.0,
  'karma_trend': '-',
  'is_premium': False,
  'premium_until': None,
  'is_biz_admin': False,
  'business_account_id': None,
  'image_id': None,
  'avatar_small' : 'https://*.cloudfront.net/*_small.jpg',
  'avatar_medium' : 'https://*.cloudfront.net/*_medium.jpg',
  'avatar_big' : 'https://*.cloudfront.net/*_big.jpg',
  'avatar_s640' : 'https://*.cloudfront.net/*_s640.jpg',
  'theme' : 0,
  'guide_mode' : False,
  'restriction' : 3,
  'features' : {},
  'beta': 0,
  'is_dummy': 0,
  'join_date': 'Wed 30 Apr 2014 13:24:38 +0000',
}

```

Register a new user.

### Required parameters

Parameter | Description
--------- | -----------
email | The user's email (a string value representing a valid email address).
full_name | The user's real name (a string value in a `Firstname Surname` format).
password | The user's password (a string value).

### Optional parameters

Parameter | Description
--------- | -----------
lang | The user's language, which can take one of the following values: `de`, `fr`, `ja`, `pl`, `pt_BR`, `zh_CN`, `es`, `hi`, `ko`, `pt`, `ru`, `zh_TW`.
timezone | The user's timezone (a string value such as `UTC`, `Europe/Lisbon`, `US/Eastern`, `Asian/Taipei`). By default we use the user's IP address to determine the timezone.

## Delete an existing user

> An example of deleting an existing user:

```shell
$ curl https://todoist.com/API/v6/delete_user \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d current_password=secret
"ok"
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.delete_user('secret')
ok
```

Delete an existing user.

### Required parameters

Parameter | Description
--------- | -----------
token | The user's token (a string hash value).
current_password | The user's current password (a string value).

### Optional parameters

Parameter | Description
--------- | -----------
reason_for_delete | A reason for deletion, that is used for sending feedback back to Todoist (a string value).


## Update user's properties


> An example of updating the user's properties:

```shell
$ curl https://todoist.com/API/v6/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "user_update", "uuid": "52f83009-7e27-4b9f-9943-1c5e3d1e6889", "args": {"time_format": 0}}]'
{ ...
  "SyncStatus": {"52f83009-7e27-4b9f-9943-1c5e3d1e6889": "ok"},
  ... }

```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.user.update(time_format=0)
```

Update the details of the user.

### Optional parameters

Parameter | Description
--------- | -----------
email | The user's email (a string value representing a valid email address).
full_name | The user's real name (a string value in a `Name Surname` format).
password | The user's password (a string value).
timezone | The user's timezone (a string value such as `UTC`, `Europe/Lisbon`, `US/Eastern`, `Asian/Taipei`).
start_page | The user's default view on Todoist. The start page can be one of the following: `_info_page` for the info page, `_blank` for a blank page, `_project_<PROJECT_ID>` for project with id `<PROJECT_ID>`, and `<ANY_QUERY>` to query after anything.
start_day | The first day of the week (a number between `1` and `7`, where `1` is `Monday` and `7` is `Sunday`).
next_week | The day of the next week, that tasks will be postponed to (a number between `1` and `7`, where `1` is `Monday` and `7` is `Sunday`).
time_format | Whether to use a `24h` format such as `13:00` (if set to `0`) when displaying time, or a `12h` format such as `1:00pm` (if set to `1`).
date_format | Whether to use the `DD-MM-YYYY` date format (if set to `0`), or the `MM-DD-YYYY` format (if set to `1`).
sort_order | Whether to show projects in an `oldest dates first` order (if set to `0`, or a `oldest dates last` order (if set to `1`).
default_reminder | The default reminder fo the user. Reminders are only possible for Premium users. The default reminder can be one of the following: `email` to send reminders by email, `mobile` to send reminders to mobile devices via SMS, `push` to send reminders to smart devices using push notifications (one of the Android or iOS official clients must be installed on the client side to receive these notifications), `no_default` to turn off sending default reminders.
auto_reminder | The default time in minutes for the automatic reminders set, whenever a due date has been specified for a task (a number).
mobile_number | The user's mobile number (a string value or `null` if not set).
mobile_host | The user's mobile host (a string value or `null` if not set).
theme | The currently selected Todoist theme (a number between `0` and `10`).


## Update karma goals

```shell
$ curl https://todoist.com/API/v6/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "update_goals", "uuid": "b9bbeaf8-9db6-452a-a843-a192f1542892", "args": {"vacation_mode": 1}}]'
{ ...
  "SyncStatus": {"b9bbeaf8-9db6-452a-a843-a192f1542892": "ok"},
  ... }

```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.user.update_goals(vacation_mode=1)
```

Update the karma goals of the user.

### Optional parameters

Parameter | Description
--------- | -----------
daily_goal | The target number of tasks to complete per day (a number).
weekly_goal | The target number of tasks to complete per week (a number).
ignore_days | A list with the days of the week to ignore (`1` for `Monday` and `7` for `Sunday`).
vacation_mode | Marks the user as being on vacation (where `1` is true and `0` is false).
karma_disabled | Whether to disable the karma and goals measuring altogether (where `1` is true and `0` is false).
