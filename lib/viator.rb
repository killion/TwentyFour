require 'faraday'
require 'multi_json'
require 'rash'
require 'viator/client'

# based on Jerry Cheung's Wego code: http://github.com/killion/wego
module Viator
  # @see Viator::Configuration
  def configure(options = {})
    options = Hashie::Mash.new(options)

    unless options[:logger]
      logger = Logger.new(STDERR)
      logger.level = Logger::WARN
      options[:logger] = logger
    end

    yield options if block_given?
    config(options)
  end

  def config(options = {})
    if @configuration
      options = Hashie::Mash.new(options).to_hash
      Configuration.new(@configuration.to_hash.merge(options))
    else
      @configuration = Configuration.new(options)
    end
    @configuration = @configuration && @configuration.merge(options) || Configuration.new(options)
  end

  # @return [Logger]
  def log
    config.logger
  end
  module_function :configure, :config, :log
  
  class Configuration < Hashie::Dash
    property :api_key, :required => true
    property :logger
  end
  
  class Error < StandardError
  end
end