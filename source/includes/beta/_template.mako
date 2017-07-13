<!--
This file is generated automatically from .yml data file and _template.mako.

Please don't modify it, and modify source files instead. To compile the
file, ensure you have Python and Mako installed, and build all .md files
with Makefile (as simple as "make -C source/includes")
-->
${h1(title)}

${h2(object.name)}

> ${object.name} sample

```shell
${json.dumps({attr.name: attr.value for attr in object.attrs}, indent=2, sort_keys=True)}
```

```python
${json.dumps({attr.name: attr.value for attr in object.attrs}, indent=2, sort_keys=True)}
```


Attribute | Description
----------|------------
%for attr in object.attrs:
${ make_table_row(attr.name, attr.description) }
%endfor



##############################
## Endpoints documentation
##############################

%for endpoint in endpoints:
${h2(endpoint.name)}

> ${endpoint.name}

```shell
# command
${endpoint.shell_sample}
%if endpoint.get("output_sample"):
# output
${endpoint.output_sample}
%endif
```

```python
# command
${endpoint.python_sample}
%if endpoint.get("output_sample"):
# output
${endpoint.output_sample}
%endif
```

${ endpoint.get("description", "") }

${h3("HTTP Request")}
`${endpoint.verb} https://beta.todoist.com/API/v8/${ endpoint.url }` returns ${endpoint.returns}

%if endpoint.get("get_args"):
${h3("Request GET arguments")}

Attribute | Description
----------|------------
%for attr in endpoint.get_args:
${ make_table_row(attr.name, attr.description) }
%endfor
%endif

%if endpoint.get("post_attrs"):
${h3("Request body attributes")}

Attribute | Description
----------|------------
%for attr in endpoint.post_attrs:
${ make_table_row(attr.name, attr.description) }
%endfor
%endif

%endfor
