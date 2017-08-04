# View Options

View Options is a JSON object containing view configuration user have
set for different views.

Each key of View Options object identifies a view to which the view configuration
apply, and the associated value is a "View Option" object containing
actual the view configuration info.


> An example View Options

```json
{
    "today": {
        "view_type": "due"
    },
    "seven_day": {
        "view_type": "priority"
    },
    "projects": {
        "18918319": {
            "view_type": "custom",
            "custom_view": {
                "group_by": "priority",
                "sort_by": "assignee",
                "include": {
                    "own": true
                }
            }
        }
    }
}
```

### Properties

Property | Description
-------- | -----------
today *Object (View Option)* | View option for "Today" view
seven_days *Object (View Option)* | View option for "Next 7 days" view
projects *Object* | Containing view options for projects. Each key/value identifies a project (by project id) and its configured view option.



### View Option Properties

Property | Description
-------- | -----------
view_type *string or null* | Could one of these value: `"due"`, `"priority"`, `"assigned"`, `"custom"` or `null`. A null value indicates the view to be set to its default view configuration.
custom_view *Object* | An object containing the detail configuration of custom view. The field will be undefined when no custom view is configured.


### Custom View Properties

Property | Description
-------- | -----------
group_by *string or null* | Specifies how the tasks to be grouped into different section lists. Could one of these value: `"due"`, `"priority"`, `"assignee"`, `"project"` or `null`. A null value indicates the tasks should not be grouped.
sort_by *string or null* | Specifies how the tasks to be sorted within a group. Could one of these value: `"alphabetical"`, `"due"`, `"priority"`, `"assignee"` or `null`. A null value indicates the view to be set to its default sorting configuration.
include *Object* | Required fields, specifying what tasks to be included in the view. It is an object with only a single key/value.


### Custom View "include" Properties

The "include" value in the custom view setting is an object with only a single key/value. The key specifies the tasks to be included
while its associated value should always be `True` (an exception is `user_ids` which contains an array of user id)


Property | Description
-------- | -----------
all *boolean* | Indicate the custom view should show all tasks
own *boolean* | Indicate the custom view should show non-assigned tasks and tasks assigned to the users.
assigned *boolean* | Indicate the custom view should show all assigned tasks
unassigned *boolean* | Indicate the custom view should show all unassigned tasks
user_ids *[]integer* | Indicate the custom view should show tasks assigned to the specified users





## Update View Options


The sync command `view_options_update` updates the user's View Options. The command arguments specified the views to
be updated.


> An example of updating Today and Next 7 Days's view options:

```shell
https://todoist.com/api/v7/sync \
    -d token=0123456789abcdef0123456789abcdef01234567 \
    -d commands='[{"type": "view_options_update", "uuid": "0b8690b8-59e6-4d5b-9c08-6b4f1e8e0eb8", "args": {"today": {"view_type": "due"}, "seven_days": "priority"}}]'

```

### Parameters

Parameter | Required | Description
--------- | -------- | -----------
today *Object (View Option)* | No | Updated view option for 'Today' view
seven_days *Object (View Option)* | No |  Updated view option for 'Today' view
projects *Object* | NO |  Updated view option for the specifiec projects


