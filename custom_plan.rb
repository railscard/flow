require 'zeus/rails'

class CustomPlan < Zeus::Rails
  def server
    require 'rails/command'
    ::Rails::Command.invoke 'server', ARGV
  end

  def console
    require 'rails/command'
    require 'rails/commands/console/console_command'
    ::Rails::Command.invoke 'console', ARGV
  end
end

Zeus.plan = CustomPlan.new
