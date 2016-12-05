# # Modules: AppSignal
# Adds settings and tasks for notifying AppSignal.
#
#     require 'mina/appsignal'
#
# ## Usage example
#     require 'mina/appsignal'
#
#     # this is your 'post_server_item' token for your project
#     set :appsignal_api_key, 'appsignal-api-key-goes-here'
#
#     task :deploy do
#       deploy do
#         ...
#
#         to :launch do
#           ...
#           invoke :'appsignal:notify'
#         end
#       end
#     end

require 'mina/rails'
require 'json'
require 'shellwords'

# ## Settings
# Any and all of these settings can be overriden in your `deploy.rb`.

# ### appsignal_api_key
# Sets the push api key for your AppSignal account.  Will be read from
# config/appsignal.yml, or the APPSIGNAL_PUSH_API_KEY if not set.  Required.
set :appsignal_api_key, nil

# ### appsignal_app_name
# Sets the name of the app being deployed.  Will be read from
# config/appsignal.yml, or the APPSIGNAL_APP_NAME if not set.  Required.
set :appsignal_app_name, nil

# ### appsignal_local_username
# Sets the name of the user who deployed.  Defaults to `whoami`.  Optional.
set :appsignal_local_username, %x[whoami].strip rescue nil

# ### appsignal_notification_debug
# If true, enables verbosity in the notification to help debug issues.  Defaults to false.
set :appsignal_notification_debug, false

namespace :appsignal do

  desc 'Notifies AppSignal of your deployment'
  task notify: :environment do
    api_key = fetch(:appsignal_api_key)
    api_key ||= Mina::AppSignal.from_config(fetch(:rails_env), 'push_api_key')
    api_key ||= ENV['APPSIGNAL_PUSH_API_KEY']
    unless api_key
      print_error '`:appsignal_api_key` must be defined to notify'
      exit
    end

    app_name = fetch(:appsignal_app_name)
    app_name ||= Mina::AppSignal.from_config(fetch(:rails_env), 'name')
    app_name ||= ENV['APPSIGNAL_APP_NAME']
    unless app_name
      print_error '`:appsignal_app_name` must be defined to notify'
      exit
    end

    unless set?(:branch) || set?(:commit)
      print_error 'Must define either `:branch` or `:commit`'
      exit
    end

    revision = set?(:commit) ? fetch(:commit) : %x[git rev-parse #{fetch(:branch)}].strip

    body = { revision: revision }
    body[:repository] = fetch(:branch) if set?(:branch)
    body[:user] = fetch(:appsignal_local_username).shellescape if set?(:appsignal_local_username)

    silent = fetch(:appsignal_notification_debug) ? '-v' : '-s -o /dev/null'
    script = [%Q(curl #{silent} -X POST)]
    script << %Q(-d '#{body.to_json}')
    script << %Q("https://push.appsignal.com/1/markers?api_key=#{api_key}&name=#{app_name}&environment=#{fetch(:rails_env)}")

    comment %{Notifying AppSignal of deployment}
    command %[#{script.join(' ')}]
  end

end
