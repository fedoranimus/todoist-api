# todoist-api -  The official Todoist API documentation source

[![Build Status](https://travis-ci.org/tripit/slate.svg?branch=master)](https://travis-ci.org/tripit/slate) [![Dependency Status](https://gemnasium.com/tripit/slate.png)](https://gemnasium.com/tripit/slate)

## Getting started

### Prerequisites

You're going to need:

 - **Ruby, version 1.9.3 or newer**
 - **Bundler** — If Ruby is already installed, but the `bundle` command doesn't work, just run `gem install bundler` in a terminal.

### Getting set up

 1. Fork this repository on Github.
 2. Clone *your forked repository* (not our original one) to your hard drive with `git clone https://github.com/YOURUSERNAME/todoist-api.git`
 3. `cd todoist-api`
 4. Install all dependencies: `bundle install` (a `bundle update` maybe needed before that)
 5. Start the test server: `bundle exec middleman server`

You can now see the docs at <http://localhost:4567>. And as you edit `source/index.md`, your server should automatically update.

Now that all is setup in your machine, you'll probably want to learn more about the [Slate template](https://github.com/tripit/slate), which is used for this API documentation.  There is a lot of articles on it at [the Slate wiki](https://github.com/tripit/slate/wiki).


### Build distribution

```
rake build
```


### Doc Writer Guide



##### Terminology

"Sync API request" - We will use capitalized "Sync" word to refer to all requests made to the
sync API endpoint (https://todoist.com/API/v6/sync)


##### JSON
When describing a JSON data, make sure you use the terms that is consistent to the spec. (i.e. Use "array", not "list". Use "object", not "dictionary").
