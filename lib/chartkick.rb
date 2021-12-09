# modules
require "chartkick/enumerable"
require "chartkick/helper"
require "chartkick/version"

# integrations
require "chartkick/engine" if defined?(Rails)
require "chartkick/sinatra" if defined?(Sinatra)

if defined?(ActiveSupport.on_load)
  ActiveSupport.on_load(:action_view) do
    include Chartkick::Helper
  end
end

module Chartkick
  class << self
    attr_accessor :content_for
    attr_accessor :options
    
    def load!
      register_sprockets if sprockets?
    end
    
    private
    
    # Environment detection helpers
    def sprockets?
      defined?(::Sprockets)
    end

    def register_sprockets
      Sprockets.append_path(javascripts_path)
    end

    def javascripts_path
      File.join assets_path, 'javascripts'
    end

    def assets_path
      @assets_path ||= File.join gem_path, 'vendor', 'assets'
    end

    def gem_path
      @gem_path ||= File.expand_path '..', File.dirname(__FILE__)
    end    
  end
  self.options = {}
end

Chartkick.load!

