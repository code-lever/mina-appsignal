# Mina::AppSignal [![Build Status](https://travis-ci.org/code-lever/mina-appsignal.png)](https://travis-ci.org/code-lever/mina-appsignal) [![Code Climate](https://codeclimate.com/github/code-lever/mina-appsignal.png)](https://codeclimate.com/github/code-lever/mina-appsignal)

[Mina](https://github.com/mina-deploy/mina) tasks for interacting with [AppSignal](http://appsignal.com).

Adds the following tasks:

    appsignal:notify

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mina-appsignal', require: false
```

And then execute:

    $ bundle

## Usage

**Note:** Currently requires `curl` to be present on the server for notifications to be sent.  Patches happily accepted to improve this limitation!

If you are using a `config/appsignal.yml` file, you need only:

    require 'mina/appsignal'

    ...

    task deploy: :environment do
      deploy do
        ...

        to :launch do
          ...
          invoke :'appsignal:notify'
        end
      end
    end

If not, you'll need to set some options.

## Options

| Name                           | Description                                                |
| ------------------------------ | -----------------------------------------------------------|
| `appsignal_api_key`            | AppSignal push api key                                     |
|                                | Read from `config/appsignal.yml` or `ENV['APPSIGNAL_PUSH_API_KEY']` if available |
| `appsignal_app_name`           | AppSignal application name |
|                                | Read from `config/appsignal.yml` or `ENV['APPSIGNAL_APP_NAME']` if available |
| `appsignal_local_username`     | Local username of deploying user (optional)                |

## Contributing

1. Fork it ( https://github.com/code-lever/mina-appsignal/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
