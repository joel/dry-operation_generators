# frozen_string_literal: true

module Operations
  module Generators
    class ScaffoldGenerator < Rails::Generators::NamedBase
      include Base::Generators::BaseGenerator

      def call_generators
        invoke "operations:action", [name, verb, fields], options if defined?(Dry::Validation)
        unless verb == "destroy" || !defined?(Dry::Transaction)
          invoke "operations:contract",   [name, verb, fields],
                 options
        end
        unless verb == "destroy" || !defined?(Dry::Schema)
          invoke "operations:schema",     [name, verb, fields],
                 options
        end
        unless verb == "destroy" || !defined?(Dry::Validation)
          invoke "operations:validation", [name, verb, fields],
                 options
        end
        invoke "operations:repository", [name, verb, fields], options if defined?(Dry::Transaction)
        invoke "operations:register",   [name, verb, fields], options if defined?(Dry::Container)
        invoke "operations:operation",  [name, verb, fields], options if defined?(Dry::Transaction)
      end

      class << self
        def start(args, config)
          ActionGenerator.start(args, config)     if defined?(Dry::Validation)
          ContractGenerator.start(args, config)   if defined?(Dry::Transaction)
          SchemaGenerator.start(args, config)     if defined?(Dry::Schema)
          ValidationGenerator.start(args, config) if defined?(Dry::Validation)
          RepositoryGenerator.start(args, config) if defined?(Dry::Transaction)
          RegisterGenerator.start(args, config)   if defined?(Dry::Container)
          OperationGenerator.start(args, config)  if defined?(Dry::Transaction)
        end
      end
    end
  end
end
