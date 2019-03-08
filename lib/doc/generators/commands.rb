$LOAD_PATH.unshift File.expand_path('../../../../gems/CocoaPods/lib', __FILE__)

module Pod
  module Doc
    module Generators

      # Provides support for describing executable commands and options.
      #
      class Commands < Base

        def initialize(*args)
          super
          require 'cocoapods'
          load_plugins
        end

        def load_plugins
          claide_command.plugin_prefixes.each do |plugin_prefix|
            CLAide::Command::PluginManager.load_plugins(plugin_prefix)
          end
        end

        def name
          'Commands'
        end

        def claide_command
          Pod::Command
        end

        def generate_code_object
          namespace = CodeObjects::NameSpace.new
          namespace.name = name
          namespace.html_description = description(claide_command)
          namespace.groups = create_groups(claide_command)
          namespace
        end

        private

        def description(claide_command)
          message = claide_command.description || claide_command.summary
          # FIXME
          message = message.strip_heredoc.gsub("'", '`')
          args    = CLAide::Command::Banner.new(claide_command).send(:signature_arguments)
          full_command = claide_command.full_command
          "<pre>#{full_command} #{args}</pre><p>#{markdown_h(message)}</p>"
        end

        def command_groups
          {
            'Installation' => [
              'pod init',
              'pod install',
              'pod update',
              'pod outdated',
              'pod deintegrate',
            ],

            'Environment' => [
              'pod env'
            ],

            'Browse' => [
              "pod search",
              "pod list",
              "pod try",
            ],

            'Specifications' => [
              "pod spec create",
              "pod spec lint",
              "pod spec cat",
              "pod spec which",
              "pod spec edit",
            ],

            'Trunk' => [
              'pod trunk add-owner',
              'pod trunk info',
              'pod trunk me',
              'pod trunk push',
              'pod trunk register',
              'pod trunk remove-owner',
              'pod trunk deprecate',
              'pod trunk delete',
            ],

            'Repos' => [
              "pod repo add",
              "pod repo add-cdn",
              "pod repo update",
              "pod repo lint",
              "pod repo list",
              "pod repo remove",
              "pod repo push",
              "pod setup",
            ],

            'Libraries' => [
              "pod lib create",
              "pod lib lint",
            ],

            'IPC' => [
              "pod ipc repl",
              "pod ipc spec",
              "pod ipc podfile",
              "pod ipc podfile-json",
              "pod ipc list",
              "pod ipc update-search-index",
            ],

            'Plugins' => [
              'pod plugins list',
              'pod plugins search',
              'pod plugins installed',
              'pod plugins create',
              'pod plugins publish',
            ],

            'Cache' => [
              'pod cache list',
              'pod cache clean',
            ],
          }

        end

        def create_groups(claide_command)
          calide_commands = claide_command.subcommands.map do |claide_subcommand|
            [claide_subcommand, claide_subcommand.subcommands]
          end.flatten.compact
          calide_commands.reject! { |c| c.abstract_command? }

          groups = []
          command_groups.each do |name, full_commands|
            group = CodeObjects::Group.new
            group.name = name
            group.meths = full_commands.map do |full_command_name|
              claide_command = calide_commands.find { |c| c.full_command == full_command_name }
              raise "[Commands] Unable to find `#{full_command_name}`." unless claide_command
              calide_commands.delete(claide_command)
              subcommand = create_subcommand(claide_command)
              subcommand.group = group
              subcommand
            end
            groups << group
          end
          raise "[Commands] No group for commands `#{calide_commands.map(&:full_command)}`" unless calide_commands.empty?
          groups
        end

        def create_subcommand(claide_subcommand)
          subcommand = CodeObjects::SubCommand.new
          subcommand.name = claide_subcommand.full_command
          subcommand.html_description = description(claide_subcommand)
          registry = yard_registry.at(claide_subcommand.to_s)
          subcommand.tags = registry.tags if registry
          # FIXME
          # puts claide_subcommand.name
          # puts  claide_subcommand.options
          subcommand.options = (claide_subcommand.options - claide_subcommand.superclass.options).map { |(name, desc)| [name, markdown_h(desc + '.')] }
          subcommand.parent_options = claide_subcommand.superclass.options.map { |(name, desc)| [name, markdown_h(desc + '.')] }
          # subcommand.examples = []
          subcommand
        end
      end

    end
  end
end
