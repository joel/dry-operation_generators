#!/usr/bin/env ruby
# frozen_string_literal: true

begin
  require "thor/group"
rescue LoadError
  puts "Thor is not available.\nIf you ran this command from a git checkout " \
       "of Rails, please make sure thor is installed,\nand run this command " \
       "as `ruby #{$PROGRAM_NAME} #{(ARGV | ["--dev"]).join(" ")}`"
  exit
end

require "active_support/inflector"

module Operations
  class CreateGenerator < Thor::Group
    include Thor::Actions

    class << self
      def exit_on_failure?
        true
      end
    end

    desc "Create a new Generator (Generator of generators)"

    source_root File.expand_path(".", __dir__)

    class_option :force, type: :boolean, default: false
    class_option :hook_for_test_framework, type: :boolean, default: true
    class_option :dry_run, type: :boolean, default: true

    argument :name, type: :string, required: true, desc: "Name of the generator"

    def plural_name
      name.pluralize
    end

    def singular_name
      name.singularize
    end

    def class_name
      singular_name.capitalize
    end

    def copy_generator_files
      return if options[:dry_run]

      template "templates/template_generator.rb.erb", "lib/operations/generators/#{name}_generator.rb"
      template "templates/template_generator_spec.rb.erb",
               "spec/operations/generators/#{name}_generator_spec.rb"

      create_file "lib/operations/generators/#{name}/templates/#{name}.rb.erb" do
        "This is #{name}.rb.erb"
      end
    end
  end
end

# ./bin/generator <generator name> --no-dry_run
Operations::CreateGenerator.start(ARGV)
