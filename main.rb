require 'pry'

require 'active_record'
require_relative 'active-record-connect'
require_relative 'contact'
require_relative 'application'

application = Application.new
application.start
