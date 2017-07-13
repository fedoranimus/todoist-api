# User

A user in Todoist is a JSON object. The dates will be in the UTC timezone. Typically a user object will have the following properties:

> An example user object

```json
{
  "id": 1855589,
  "token": "0123456789abcdef0123456789abcdef01234567",
  "email": "me@xample.com",
  "full_name": "Example User",
  "inbox_project": 128501411,
  "tz_info" : {
     "timezone" : "Europe/Athens",
     "minutes" : 0,
     "hours" : 3,
     "is_dst" : 1,
     "gmt_string" : "+03:00"
  },
  "start_page": "overdue, 7 days",
  "start_day": 1,
  "next_week": 1,
  "date_format": 0,
  "time_format": 0,
  "sort_order": 0,
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
  "features" : {
    "beta": 0,
    "restriction" : 3,
    "has_push_reminders": false,
  },
  "join_date": "Wed 30 Apr 2014 13:24:38 +0000"
}
```

### Properties

Property | Description
-------- | -----------
id *Integer* | The user's id.
token *String* | The user's token that should be used to call the other API methods.
email *String* | The user's email.
full_name *String* | The user's real name formatted as `Firstname Lastname`.
inbox_project *Integer* | The id of the user's `Inbox` project.
tz_info *Object* | The user's timezone (a dictionary structure), which includes the following elements: the `timezone` as a string value, the `hours` and `minutes` difference from GMT, whether daylight saving time applies denoted by `is_dst`, and a string value of the time difference from GMT that is `gmt_string`.
start_page *String* | The user's default view on Todoist. The start page can be one of the following: `_info_page` for the info page, `_blank` for a blank page, `_project_<PROJECT_ID>` for project with id `<PROJECT_ID>`, and `<ANY_QUERY>` to query after anything.
start_day *Integer* | The first day of the week (between `1` and `7`, where `1` is `Monday` and `7` is `Sunday`).
next_week *Integer* | The day of the next week, that tasks will be postponed to (between `1` and `7`, where `1` is `Monday` and `7` is `Sunday`).
time_format *Integer* | Whether to use a `24h` format such as `13:00` (if set to `0`) when displaying time, or a `12h` format such as `1:00pm` (if set to `1`).
date_format *Integer* | Whether to use the `DD-MM-YYYY` date format (if set to `0`), or the `MM-DD-YYYY` format (if set to `1`).
sort_order *Integer* | Whether to show projects in an `oldest dates first` order (if set to `0`, or a `oldest dates last` order (if set to `1`).
default_reminder *String* | The default reminder for the user. Reminders are only possible for Premium users. The default reminder can be one of the following: `email` to send reminders by email, `mobile` to send reminders to mobile devices via SMS, `push` to send reminders to smart devices using push notifications (one of the Android or iOS official clients must be installed on the client side to receive these notifications), `no_default` to turn off sending default reminders.
auto_reminder *Integer* | The default time in minutes for the automatic reminders set, whenever a due date has been specified for a task.
mobile_number *String* | The user's mobile number (`null` if not set).
mobile_host *String* | The user's mobile host (`null` if not set).
completed_count *Integer* | The total number of completed tasks.
completed_today *Integer* | The number of completed tasks for today.
karma *Number* | The user's karma score.
karma_trend *String* | The user's karma trend (for example `up`).
is_premium *String* | Whether the user has a Premium subscription (a `true` or `false` value).
premium_until *String* | The date when the user's Premium subscription ends (`null` if not a Premium user).
is_biz_admin *String* | Whether the user is a business account administrator (a `true` or `false` value).
business_account_id *Integer* | The id of the user's business account.
image_id *String* | The id of the user's avatar.
avatar_small *String* | The link to a 35x35 pixels image of the user's avatar.
avatar_medium *String* | The link to a 60x60 pixels image of the user's avatar.
avatar_big *String* | The link to a 195x195 pixels image of the user's avatar.
avatar_s640 *String* | The link to a 640x640 pixels image of the user's avatar.
theme *Integer* | The currently selected Todoist theme (a number between `0` and `10`).
features *Object* | Used internally for any special features that apply to the user.  Current special features include whether any special `restriction` applies to the user, whether the user is in `beta` status, whether the user `has_push_reminders` enabled, and whether `dateist_inline_disabled` that is inline date parsing support is disabled.
join_date *String* | The date when the user joined Todoist.


## Register a new user

> An example of registering a new user:


```shell
$ curl https://todoist.com/api/v7/user/register \
    -d email=me@example.com \
    -d full_name=Example\ User \
    -d password=secret
{
  "id": 1855589,
  "token": "0123456789abcdef0123456789abcdef01234567",
  "email": "me@xample.com",
  "full_name": "Example User",
  "inbox_project": 128501411,
  "tz_info": {
    "timezone": "GMT +1:00",
    "gmt_string": "+01:00",
    "hours": 1,
    "minutes": 0,
    "is_dst": 0
  },
  "start_page": "overdue, 7 days",
  "start_day": 1,
  "next_week": 1,
  "date_format": 0,
  "time_format": 0,
  "sort_order": 0,
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
  "features" : {
    "beta": 0,
    "restriction" : 3,
    "has_push_reminders": false,
  },
  "join_date": "Wed 30 Apr 2014 13:24:38 +0000"
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI()
>>> api.user.register('me@example.com', 'Example User', 'secret')
{
  'id': 1855589,
  'token': '0123456789abcdef0123456789abcdef01234567',
  'email': 'me@exampe.com',
  'full_name': 'Example User',
  'inbox_project': 128501411,
  'tz_info': {
    'timezone': 'GMT +1:00',
    'gmt_string': '+01:00',
    'hours': 1,
    'minutes': 0,
    'is_dst': 0
  },
  'start_page': 'overdue, 7 days',
  'start_day': 1,
  'next_week': 1,
  'date_format': 0,
  'time_format': 0,
  'sort_order': 0,
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
  'features' : {
    'beta': 0,
    'restriction' : 3,
    'has_push_reminders': false,
  },
  'join_date': 'Wed 30 Apr 2014 13:24:38 +0000',
}

```

Register a new user.

### Required parameters

Parameter | Description
--------- | -----------
email *String* | The user's email.
full_name *String* | The user's real name formatted as `Firstname Lastname`.
password *String* | The user's password.

### Optional parameters

Parameter | Description
--------- | -----------
lang *String* | The user's language, which can take one of the following values: `de`, `fr`, `ja`, `pl`, `pt_BR`, `zh_CN`, `es`, `hi`, `ko`, `pt`, `ru`, `zh_TW`.
timezone *String* | The user's timezone (a string value such as `UTC`, `Europe/Lisbon`, `US/Eastern`, `Asian/Taipei`). By default we use the user's IP address to determine the timezone.

## Delete an existing user

> An example of deleting an existing user:

```shell
$ curl https://todoist.com/api/v7/user/delete \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d current_password=secret
"ok"
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.user.delete('secret')
ok
```

Delete an existing user.

### Required parameters

Parameter | Description
--------- | -----------
token *String* | The user's token.
current_password *String* | The user's current password.

### Optional parameters

Parameter | Description
--------- | -----------
reason_for_delete *String* | A reason for deletion, that is used for sending feedback back to Todoist.


## Update user's properties


> An example of updating the user's properties:

```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "user_update", "uuid": "52f83009-7e27-4b9f-9943-1c5e3d1e6889", "args": {"time_format": 0}}]'
{ ...
  "sync_status": {"52f83009-7e27-4b9f-9943-1c5e3d1e6889": "ok"},
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
email *String* | The user's email.
full_name *String* | The user's real name formatted as `Firstname Lastname`.
password *String* | The user's password.
timezone *String* | The user's timezone (a string value such as `UTC`, `Europe/Lisbon`, `US/Eastern`, `Asian/Taipei`).
start_page *String* | The user's default view on Todoist. The start page can be one of the following: `_info_page` for the info page, `_blank` for a blank page, `_project_<PROJECT_ID>` for project with id `<PROJECT_ID>`, and `<ANY_QUERY>` to query after anything.
start_day *Integer* | The first day of the week (between `1` and `7`, where `1` is `Monday` and `7` is `Sunday`).
next_week *Integer* | The day of the next week, that tasks will be postponed to (between `1` and `7`, where `1` is `Monday` and `7` is `Sunday`).
time_format *Integer* | Whether to use a `24h` format such as `13:00` (if set to `0`) when displaying time, or a `12h` format such as `1:00pm` (if set to `1`).
date_format *Integer* | Whether to use the `DD-MM-YYYY` date format (if set to `0`), or the `MM-DD-YYYY` format (if set to `1`).
sort_order *Integer* | Whether to show projects in an `oldest dates first` order (if set to `0`, or a `oldest dates last` order (if set to `1`).
default_reminder *String* | The default reminder for the user. Reminders are only possible for Premium users. The default reminder can be one of the following: `email` to send reminders by email, `mobile` to send reminders to mobile devices via SMS, `push` to send reminders to smart devices using push notifications (one of the Android or iOS official clients must be installed on the client side to receive these notifications), `no_default` to turn off sending default reminders.
auto_reminder *Integer* | The default time in minutes for the automatic reminders set, whenever a due date has been specified for a task.
mobile_number *String* | The user's mobile number (`null` if not set).
mobile_host *String* | The user's mobile host (or `null` if not set).
theme *Integer* | The currently selected Todoist theme (between `0` and `10`).


## Update karma goals

```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "update_goals", "uuid": "b9bbeaf8-9db6-452a-a843-a192f1542892", "args": {"vacation_mode": 1}}]'
{ ...
  "sync_status": {"b9bbeaf8-9db6-452a-a843-a192f1542892": "ok"},
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
daily_goal *Integer* | The target number of tasks to complete per day.
weekly_goal *Integer* | The target number of tasks to complete per week.
ignore_days *Integer* | A list with the days of the week to ignore (`1` for `Monday` and `7` for `Sunday`).
vacation_mode *Integer* | Marks the user as being on vacation (where `1` is true and `0` is false).
karma_disabled *Integer* | Whether to disable the karma and goals measuring altogether (where `1` is true and `0` is false).


## Update notification settings

> An example of updating the user's notification settings

```shell
$ curl https://todoist.com/api/v7/notification_settings/update \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d notification_type=item_completed \
    -d service=email \
    -d dont_notify=1
{
  "user_left_project": {
    "notify_push": true,
    "notify_email": true
  },
  "biz_trial_will_end": {
    "notify_push": true,
    "notify_email": true
  },
  "biz_trial_enter_cc": {
    "notify_push": true,
    "notify_email": true
  },
  "item_completed": {
    "notify_push": true,
    "notify_email": false
  },
  "share_invitation_rejected": {
    "notify_push": true,
    "notify_email": true
  },
  "note_added": {
    "notify_push": true,
    "notify_email": true
  },
  "biz_account_disabled": {
    "notify_push": true,
    "notify_email": true
  },
  "biz_invitation_rejected": {
    "notify_push": true,
    "notify_email": true
  },
  "item_uncompleted": {
    "notify_push": true,
    "notify_email": true
  },
  "item_assigned": {
    "notify_push": true,
    "notify_email": true
  },
  "share_invitation_accepted": {
    "notify_push": true,
    "notify_email": true
  },
  "user_removed_from_project": {
    "notify_push": true,
    "notify_email": true
  },
  "biz_invitation_accepted": {
    "notify_push": true,
    "notify_email": true
  },
  "biz_payment_failed": {
    "notify_push": true,
    "notify_email": true
  }
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.user.update_notification_setting('item_completed', 'email', 1)
{
  'biz_invitation_rejected': {
    'notify_push': True,
    'notify_email': True
  },
  'user_left_project': {
    'notify_push': True,
    'notify_email': True
  },
  'note_added': {
    'notify_push': True,
    'notify_email': True
  },
  'biz_trial_enter_cc': {
    'notify_push': True,
    'notify_email': True
  },
  'item_completed': {
    'notify_push': True,
    'notify_email': False
  },
  'biz_trial_will_end': {
    'notify_push': True,
    'notify_email': True
  },
  'biz_account_disabled': {
    'notify_push': True,
    'notify_email': True
  },
  'share_invitation_rejected': {
    'notify_push': True,
    'notify_email': True
  },
  'item_uncompleted': {
    'notify_push': True,
    'notify_email': True
  },
  'item_assigned': {
    'notify_push': True,
    'notify_email': True
  },
  'share_invitation_accepted': {
    'notify_push': True,
    'notify_email': True
  },
  'user_removed_from_project': {
    'notify_push': True,
    'notify_email': True
  },
  'biz_invitation_accepted': {
    'notify_push': True,
    'notify_email': True
  },
  'biz_payment_failed': {
    'notify_push': True,
    'notify_email': True
  }
}
```

Update the user's notification settings.

### Required parameters

Parameter | Description
--------- | -----------
token *String* | The user's token received on login.
notification_type *String* | The notification type.  For a list of notifications have a look at the `Live Notifications` section.
service *String* | The service type, which can take the values: `email` or `push`.
dont_notify *Integer* | Whether notifications of this service should be notified (`1` to not notify, and `0` to nofify).


