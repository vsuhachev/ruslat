require 'ruslat/version'
require 'ruslat/core'

module Ruslat
  def self.included(base)
    puts "blah #{base.inspect}"
    base.extend(Core)
  end
end
