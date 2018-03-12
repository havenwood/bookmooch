# frozen_string_literal: true

require_relative 'db'

Sequel::Model.plugin :auto_validations
Sequel::Model.plugin :prepared_statements

if ENV['RACK_ENV'] == 'development'
  Sequel::Model.cache_associations = false

  unless defined?(Unreloader)
    require 'rack/unreloader'
    Unreloader = Rack::Unreloader.new(:reload=>false)
  end

  Unreloader.require('models'){|f| Sequel::Model.send(:camelize, File.basename(f).sub(/\.rb\z/, ''))}

  require 'logger'
  DB.loggers << Logger.new($stdout)
else
  Sequel::Model.plugin :subclasses
  Sequel::Model.freeze_descendents
  DB.freeze
end
