# Live notifications

> Examples of live notifications:

```json
{
    "created": 1377639720,
    "from_uid": 123,
    "id": 1,
    "invitation_id": 456,
    "invitation_secret": "abcdefghijklmno",
    "notification_key": "notification_123",
    "notification_type": "share_invitation_sent",
    "seq_no": 12345567890,
    "state": "accepted"
}

{
    "created": 1377639720,
    "from_uid": 123,
    "id": 2,
    "invitation_id": 456,
    "notification_key": "notification_123",
    "notification_type": "share_invitation_accepted",
    "project_id": 789,
    "seq_no": 1234567890
}

{
    "created": 1377639720,
    "from_uid": 123,
    "id": 3,
    "invitation_id": 456,
    "notification_key": "notification_123",
    "notification_type": "share_invitation_rejected",
    "project_id": 789,
    "reject_email": "me@example.com",
    "seq_no": 1234567890
}

{
    "created": 1377639720,
    "from_uid": 123,
    "id": 4,
    "notification_key": "notification_123",
    "notification_type": "user_left_project",
    "project_id": 456,
    "seq_no": 1234567890
}

{
    "created": 1377639720,
    "from_uid": 123,
    "id": 5,
    "notification_key": "notification_123",
    "notification_type": "user_removed_from_project",
    "project_id": 456,
    "removed_name": "Example User",
    "removed_uid": 789,
    "seq_no": 1234567890
}

{
    "assigned_by_uid": 789,
    "created": 1377639720,
    "from_uid": 123,
    "id": 6,
    "item_content": "NewTask",
    "item_id": 456,
    "notification_key": "notification_123",
    "notification_type": "item_assigned",
    "project_id": 789,
    "responsible_uid": 321,
    "seq_no": 1234567890
}

{
    "assigned_by_uid": 789,
    "created": 1377639720,
    "from_uid": 123,
    "id": 7,
    "item_content": "NewTask",
    "item_id": 456,
    "notification_key": "notification_123",
    "notification_type": "item_completed",
    "project_id": 789,
    "responsible_uid": 321,
    "seq_no": 1234567890
}

{
    "assigned_by_uid": 789,
    "created": 1377639720,
    "from_uid": 123,
    "id": 8,
    "item": 456,
    "item_content": "NewTask",
    "notification_key": "notification_123",
    "notification_type": "item_uncompleted",
    "project": 789,
    "responsible_uid": 321,
    "seq_no": 1234567890
}

{
    "created": 1377639720,
    "from_uid": 123,
    "id": 9,
    "item_id": 456,
    "note_content": "NewTask",
    "note_id": 789,
    "notification_key": "notification_123",
    "notification_type": "note_added",
    "project_id": 321,
    "seq_no": 1234567890
}

{
    "created": 1377639720,
    "email": "me@example.com",
    "from_uid": 123,
    "id": 10,
    "notification_key": "notification_123",
    "notification_type": "biz_policy_disallowed_invitation",
    "project_id": 456,
    "seq_no": 1234567890,
    "from_user": {
        "email": "you@example.com",
        "full_name": "Example User",
        "id": "789",
        "image_id": "321"
    }
}

{
    "created": 1377639720,
    "from_uid": 123,
    "id": 11,
    "inviter_id": 456,
    "notification_key": "notification_123",
    "notification_type": "biz_policy_rejected_invitation",
    "seq_no": 1234567890,
    "from_user": {
        "email": "you@example.com",
        "full_name": "Example User",
        "id": "789",
        "image_id": "321"
    }
}

{
    "active_until": 1399299727,
    "created": 1377639720,
    "from_uid": 123,
    "id": 12,
    "notification_key": "notification_123",
    "notification_type": "biz_trial_will_end",
    "plan": "business_monthly",
    "quantity": 10,
    "seq_no": 1234567890
}

{
    "active_until": 1399299727,
    "amount_due": 600,
    "attempt_count": 1,
    "created": 1377639720,
    "currency": "usd",
    "description": "2 x Subscription to Monthly ($3.00/month)",
    "from_uid": 123,
    "id": 13,
    "next_payment_attempt": 1399299735,
    "notification_key": "notification_123",
    "notification_type": "biz_payment_failed",
    "plan": "business_monthly",
    "quantity": 10,
    "seq_no": 1234567890
}

{
    "active_until": 1399299727,
    "created": 1377639720,
    "from_uid": 123,
    "id": 14,
    "notification_key": "notification_123",
    "notification_type": "biz_account_disabled",
    "plan": "business_monthly",
    "quantity": 10,
    "seq_no": 1234567890
}

{
    "account_name": "Example Inc.",
    "created": 1377639720,
    "from_uid": 123,
    "from_user": {
        "email": "you@example.com",
        "full_name": "Example User",
        "id": "456",
        "image_id": "789"
    },
    "id": 15,
    "invitation_id": 321,
    "invitation_message": "Welcome to our team!",
    "invitation_secret": "abcdefghijklmno",
    "notification_key": "notification_123",
    "notification_type": "biz_invitation_created",
    "seq_no": 1234567890,
    "state": "accepted"
}

{
    "created": 1377639720,
    "from_uid": 123,
    "from_user": {
        "account_name": "Example Inc.",
        "email": "you@example.com",
        "full_name": "Example User",
        "id": "456",
        "image_id": "789"
    },
    "id": 16,
    "invitation_id": 321,
    "notification_key": "notification_123",
    "notification_type": "biz_invitation_accepted",
    "seq_no": 1234567890
}

{
    "created": 1377639720,
    "from_uid": 123,
    "from_user": {
        "account_name": "Example Inc.",
        "email": "you@example.com",
        "full_name": "Example User",
        "id": "456",
        "image_id": "789"
    },
    "id": 17,
    "invitation_id": 321,
    "notification_key": "notification_123",
    "notification_type": "biz_invitation_rejected",
    "seq_no": 1234567890
}
```

### Types

This is the list of notifications which can be issued by the system:

Type | Description
-----|------------
share_invitation_sent | Sent to the sharing invitation receiver.
share_invitation_accepted | Sent to the sharing invitation sender, when the receiver accepts the invitation.
share_invitation_rejected | Sent to the sharing invitation sender, when the receiver rejects the invitation.
user_left_project | Sent to everyone when somebody leaves the project.
user_removed_from_project | Sent to everyone, when a person removes somebody from the project.
item_assigned | Sent to user who is responsible for the task. Optionally it's also sent to the user who created the task initially, if the assigner and the task creator is not the same person.
item_completed | Sent to the user who assigned the task when the task is completed. Optionally it's also sent to the user who is responsible for this task, if the responsible user and the user who completed the task is not the same person.
item_uncompleted | Sent to the user who assigned the task when the task is uncompleted. Optionally it's also sent to the user who is responsible for this task, if the responsible user and the user who completed the task is not the same person.
note_added | Sent to all members of the shared project, whenever someone adds a note to the task.
biz_policy_disallowed_invitation | Sent to you when you try to share a project with someone outside of your business account, but the business account policy disallows this action.
biz_policy_rejected_invitation | Sent to you when you try to accept the invitation to a shared project from someone outside of your business account, but the business account policy disallows this action.
biz_trial_will_end | Sent to all business account administrators three days before the trial period of a subscription is scheduled to end.
biz_payment_failed | Sent to all business account administrators whenever an invoice attempt payment fails. This can occur either due to a declined payment, or because the customer has no active card. A particular case of note is that if a customer with no active card reaches the end of its free trial.
biz_account_disabled | Sent to all business account administrators when the account is disabled.
biz_invitation_created | Sent to an invitee, when one of business account administrators invites this user to the business account.
biz_invitation_accepted | Sent to an inviter, when the invitation is accepted.
biz_invitation_rejected | Sent to an inviter, when the invitation is rejected.

### Common properties

Some properties are common for all types of notifications, whereas some others
depend on the notification type.

Every live notification has the following properties:

Property | Description
-------- | -----------
id *Integer* | The id of the live notification.
created *Integer* | Live notification creation date. A number representing a timestamp since epoch.
from_uid *Integer* | The id of the user who initiated this live notification.
notification_key *String* | Unique notification key.
notification_type *String* | Type of notification. Different notification type define different extra fields which are described below.
seq_no *Integer* | Notification sequence number.
is_unread *Integer* | Whether the notification is marked as unread (`1`) or read (`0`).

### Specific properties

Here are the extra properties for the `*_invitation_*` types of live
notifications:

Property | Description
-------- | -----------
from_user *Object* | User data, useful on `share_invitation_sent`.
project_name *String*| The project name, useful for `share_invitation_*` where you may not have the project in the local model.
invitation_id *Integer* | The invitation id. Useful for accepting/rejecting invitations.
invitation_secret *String* | The invitation secret key. Useful for accepting/rejecting invitations.

Here are the extra properties for the `share_invitation_sent` type of live notifications:

Property | Description
-------- | -----------
state *String* | Invitation state. Initially `invited`, can change the state to `accepted` or `rejected`.

Here are the extra properties for the `user_removed_from_project` type of live notifications:

Property | Description
-------- | -----------
removed_name *String* | The name of the user removed.
removed_uid *Integer* | The uid of the user removed.

Here are the extra properties for the `biz_trial_will_end` type of live notifications:

Property | Description
-------- | -----------
quantity *Integer*| The number of users under the control of the business account.
plan *String*| Tariff plan name. Valid values are `business_monthly` and `business_yearly`.
active_until *Integer*| The timestamp when the business account will be disabled. The value may not match the business account subscription end date, as we give some extra days (up to two weeks) to pay the invoice.

Here are the extra properties for the `biz_payment_failed` type of live notifications:

Property | Description
-------- | -----------
quantity *Integer* | The number of users under the control of the business account.
plan *String* | Tariff plan name. Valid values are `business_monthly` and `business_yearly`.
active_until *Integer* | The timestamp when the business account will be disabled. The value may not match the business account subscription end date, as we give some extra days (up to two weeks) to pay the invoice.
amount_due *Integer* | Invoice amount. Integer value in `0.01` of currency.
attempt_count *Integer* | Number of automatic payment attempts made for this invoice.
currency *String* | Currency value. Three-letter ISO currency code representing the currency in which the charge was made.
description *String* | Invoice description.
next_payment_attempt *String* | Timestamp value.

Here are the extra properties for the `biz_account_disabled` type of live notifications:

Property | Description
-------- | -----------
quantity *Integer* | The number of users under the control of the business account.
plan *String* | Tariff plan name. Valid values are `business_monthly` and `business_yearly`.
active_until *Integer* | The timestamp when the business account will be disabled. The value may not match the business account subscription end date, as we give some extra days (up to two weeks) to pay the invoice.

Here are the extra properties for the `biz_invitation_created` type of live
notifications:

Property | Description
-------- | -----------
state *String* | Invitation state. Initially `invited`, can change the state to `accepted` or `rejected`.
invitation_secret *String* | Invitation secret. Should be used to accept or reject invitation.
invitation_message *String* | Invitation message.
account_name *String* | Business account (company) name.

## Set last known

> An example of setting the last known notification:

```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "live_notifications_set_last_read", "uuid": "588b9ccf-29c0-4837-8bbc-fc858c0c6df8", "args": {"id": 1234}}]'

{
  ...
  "sync_status": {"588b9ccf-29c0-4837-8bbc-fc858c0c6df8": "ok"},
  ...
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.live_notifications.set_last_read(1234)
>>> api.commit()
```

Set the last known notification.

### Command arguments

Parameter | Required | Description
--------- | -------- | -----------
id *Integer* | Yes | The id of the last known notification (a number or `0` or `null` to mark all read).

## Mark as read

> An example of marking a notification as read:

```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "live_notifications_mark_read", "uuid": "588b9ccf-29c0-4837-8bbc-fc858c0c6df8", "args": {"id": 1234}}]'

{
  ...
  "sync_status": {"588b9ccf-29c0-4837-8bbc-fc858c0c6df8": "ok"},
  ...
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.live_notifications.mark_read(1234)
>>> api.commit()
```

Mark the notification as read.

### Command arguments

Parameter | Required | Description
--------- | -------- | -----------
id *Integer* | Yes |  The id of the notification.

## Mark all as read

> An example of marking all notifications as read:

```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "live_notifications_mark_read_all", "uuid": "588b9ccf-29c0-4837-8bbc-fc858c0c6df8"}]'

{
  ...
  "sync_status": {"588b9ccf-29c0-4837-8bbc-fc858c0c6df8": "ok"},
  ...
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.live_notifications.mark_read_all()
>>> api.commit()
```

Mark all notifications as read.


## Mark as unread

> An example of marking a notification as unread:

```shell
$ curl https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "live_notifications_mark_unread", "uuid": "588b9ccf-29c0-4837-8bbc-fc858c0c6df8", "args": {"id": 1234}}]'

{
  ...
  "sync_status": {"588b9ccf-29c0-4837-8bbc-fc858c0c6df8": "ok"},
  ...
}
```

```python
>>> import todoist
>>> api = todoist.TodoistAPI('0123456789abcdef0123456789abcdef01234567')
>>> api.live_notifications.mark_unread(1234)
>>> api.commit()
```

Mark the notification as unread.

### Command arguments

Parameter | Required | Description
--------- | -------- | -----------
id *Integer* | Yes | The id of the notification.
