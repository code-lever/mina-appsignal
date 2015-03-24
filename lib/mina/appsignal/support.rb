require 'yaml'

module Mina
  module AppSignal

    def self.from_config(env, key)
      @@config ||= YAML.load(File.read('config/appsignal.yml'))
      @@config[env][key]
    rescue
      nil
    end

  end
end
