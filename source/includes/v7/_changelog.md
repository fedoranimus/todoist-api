# Changes

In this section we document all the changes between the two different versions of our API, in order to make it easier to upgrade your client code.

## Migration guide

The new v7 Todoist API is still based on the original Todoist Sync API (as was the case for the v6 API), so the differences between the two APIs aren't as extended as those between the v5 and v6 APIs.

The main difference between the two APIs is that the `seq_no`, ie. the sequence number which was basically an always increasing number, is not used anymore to implement the incremental sync functionality, but instead the `sync_token` has been introduced, a string hash value.  So in order to do the initial full sync instead of `seq_no=0`, one needs to send `sync_token=*`.  Other than than, the last known value of `sync_token` should be used in order to an incremental sync, similar to what was done before with the `seq_no`.

Here follows a list of various minor changes from the previous API version:

* The `sync_token` value is not returned by the `sync` call anymore, but the `sync_token` and the `full_sync` variables are returned instead.
* The `sync` call now returns all objects in underscore naming convention, instead of CamelCase, so the `Collaborators`, `CollaboratorStates`, `DayOrders`, `Filters`, `Items`, `Labels`, `LiveNotifications`, `LiveNotificationsLastRead`, `Notes`, `Projects`, `Reminders`, `SettingsNotifications`, `SyncStatus`, `TempIdMapping`, and `User` objects, where renamed to `collaborators`, `collaborator_states`, `day_orders`, `filters`, `items`, `labels`, `live_notifications`, `live_notifications_last_read`, `notes`, `projects`, `reminders`, `settings_notifications`, `sync_status`, `temp_id_mapping`, and `user`, respectively
* The `DayOrdersTimestamp` has been deprecated, and instead the `sync_token` is used to keep track of updates.
* The `UserId` variable is not returned by the `sync` call anymore.
* The `timezone` and `tz_offset` properties of the user were replaced by the `tz_info` object.
* The `is_dummy` and `guide_mode` properties of the user were removed.
* The `has_push_reminders`, `beta`, `restrictions`, and `dateist_inline_disabled` properties of the user were moved to the `features` object.
* The `uid` property of labels was removed.
* The `user_id` property of filters was removed.
* The `due_date` property of reminders was removed.
* The `user_id`, `archived_date`, and `archived_timestamp` properties of projects were removed.
* The `due_date` property of items was removed.
* Only 10 notes per item are returned with the `sync` call and thus the `get_item` call should be used for more.
