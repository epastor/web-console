require 'active_support/lazy_load_hooks'
require 'web_console/repl'
require 'web_console/repl_session'
require 'binding_of_caller'
require 'web_console/exception_extension'
require 'action_dispatch/exception_wrapper'
require 'action_dispatch/debug_exceptions'

module WebConsole
  # Shortcut the +WebConsole::Engine.config.web_console+.
  def self.config
    Engine.config.web_console
  end

  ActiveSupport.run_load_hooks(:web_console, self)
end

