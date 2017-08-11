# Labels

> Label object sample

```shell
{
    "id": 1234,
    "name": "Project X",
    "order": 10
}
```

```python
{
    "id": 1234,
    "name": "Project X",
    "order": 10
}
```

### Properties

Property | Description
----------|------------
id *Integer* | Label id
name *String* | Label name
order *Integer* | Number used by clients to sort list of labels


## Get all labels

> Get all labels

```shell
curl "https://beta.todoist.com/API/v8/labels?token=$token"

[
    {
        "id": 1234,
        "name": "Project X",
        "order": 10
    }
]
```

```python
import requests
requests.get("https://beta.todoist.com/API/v8/labels", params={"token": token}).json()

[
    {
        "id": 1234,
        "name": "Project X",
        "order": 10
    }
]
```

Return a JSON-encoded array containing all user labels


## Create a new label

> Create a new label

```shell
curl "https://beta.todoist.com/API/v8/labels?token=$token" \
    -X POST \
    --data '{"name": "Movies to watch"}' \
    -H "Content-Type: application/json" \
    -H "X-Request-Id: $(uuidgen)"

{
    "id": 1234,
    "name": "Project X",
    "order": 10
}
```

```python
import requests
requests.post("https://beta.todoist.com/API/v8/labels",
    params={"token": token},
    data=json.dumps({"name": "Movies to watch"}),
    headers={
        "Content-Type": "application/json",
        "X-Request-Id": str(uuid.uuid4()),
    }
).json()

{
  "id": 1234,
  "name": "Project X",
  "order": 10
}
```

Create a new label and return its object as JSON.

### JSON body parameters

Parameter | Required | Description
--------- | -------- | -----------
name *String* | Yes | Name of the label
order *Integer* | No | Label order


## Get a label

> Get a label

```shell
curl "https://beta.todoist.com/API/v8/labels/1234?token=$token"

{
    "id": 1234,
    "name": "Project X",
    "order": 10
}
```

```python
import requests
requests.get("https://beta.todoist.com/API/v8/labels/1234", params={"token": token}).json()

{
    "id": 1234,
    "name": "Project X",
    "order": 10
}
```

Return a label by id


## Update a label

> Update a label

```shell
curl "https://beta.todoist.com/API/v8/labels/1234?token=$token" \
    -X POST \
    --data '{"name": "Project Y"}' \
    -H "Content-Type: application/json" \
    -H "X-Request-Id: $(uuidgen)"
```

```python
import requests
requests.post("https://beta.todoist.com/API/v8/labels/2148300211",
    params={"token": token},
    data=json.dumps({"name": "Project Z"}),
    headers={
        "Content-Type": "application/json",
        "X-Request-Id": str(uuid.uuid4()),
    }
)
```

Update a label and return an empty body with a HTTP status code 204.

### JSON body parameters

Parameter | Required | Description
--------- | -------- | -----------
name *String* | No | New name of the label
order *Integer* | No | Number that is used by clients to sort list of labels


## Delete a label

> Delete a label

```shell
curl -X DELETE "https://beta.todoist.com/API/v8/labels/1234?token=$token"
```

```python
import requests
requests.delete("https://beta.todoist.com/API/v8/labels/1234", params={"token": token})
```

Delete a label and return an empty body with a HTTP status code 204.
