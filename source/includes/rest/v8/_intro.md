# Overview

This is the official documentation for Todoist Rest API. Our original API,
named [Sync API](/sync/), was created for our own applications and provide an
easy way to deal with full and partial syncs, but it's not so simple for
individual calls. REST API aims to provide a API developer friendly way to deal
with the most basic features of Todoist API.

### Request and response format

API endpoints accept arguments either as url-encoded values for non-POST
requests or as json-encoded objects encoded in POST request body with
application/json Content-Type.

Each modification request may provide additional `X-Request-Id` HTTP header that
could be used as an unique string to ensure modifications are applied only once
— request having the same id as previously seen would be discarded. 

It's is not required but can be handy if you need to implement any request
re-trying logic. This header value should not exceed 36 bytes. We will be
generating them with `uuidgen` for shell and `uuid.uuid4` for Python in the code
examples.

This API relies on standard HTTP response codes to indicate operation
result. The table below is a simple reference about the most used status codes:

Status code | Description
------------|------------
200 | The request was processed successfully
204 | The request was processed successfully without any data to return.
4xx | The request was processed with an error and should not be retried unmodified as they won't be processed any different by an API
5xx | The request failed due to a server error, it's safe to retry later

All `200 OK` responses have the `Content-type: application/json` and contain a
JSON-encoded representation of one or more objects.

Payload of POST requests has to be JSON-encoded and accompanied with
`application/json` Content-Type header.
