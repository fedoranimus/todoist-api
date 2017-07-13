# Attachments

Attachment is an optional part of the comment, stored under "attachment"
attribute. Every comment may have no more than one attachment.
RESTful API allows to set attachments on comment creation, but
does not allow to update it yet.

## Attachment attributes

> Attachment object sample

```json
{
  "resource_type": "file",
  "file_url": "https://cdn-domain.tld/path/to/file.pdf",
  "file_type": "application/pdf",
  "file_name": "File.pdf"
}
```

<!-- Created with http://www.tablesgenerator.com/markdown_tables -->

| Attribute | Description | Allowed values | Example |
|---------------------|-------------------------------------------------------------------------------------|--------------------------------------------------|----------------------------------------------------------------------------------|
| resource_type | Attachment resource type (mail/outlook used internally by Todoist Outlook client) | file, image, video, audio, website, mail/outlook | `"file"` |
| image_width | Image width (in pixels, required for image resource type) |  | `800` |
| image_height | Image height (in pixels, required for image resource type) |  | `600` |
| file_url | File URL (required for resource types `image`, `video`, `audio`, `file`) |  | `"https://example.com/document.pdf"` |
| file_name | File name (required for resource types `image`, `video`, `audio`, `file`) |  | `"Document.pdf"` |
| file_type | File MIME type (required for resource types `image`, `video`, `audio`, `file`) |  | `"application/pdf"` |
| upload_state | Attachment upload state | pending, completed, canceled | `"pending"` |
| file_size | File size in bytes (required for resource types `image`, `video`, `audio`, `file`)  |  | `2048` |
| file_duration | File duration (optional, makes sense for resource types `video`, `audio`) |  | `120` |
| url | Attachment URL (required and makes sense only for resource `website`) |  | `"https://example.com"` |
| title | Attachment title (required and makes sense only for resource `website`) |  | `"Example domain"` |
| description | Attachment description (optional) |  | `"This domain is established to be used for illustrative examples in documents"` |
| outlook_resource_id | Attachment Outlook resource id (used by Todoist Outlook plugin) |  |  |
