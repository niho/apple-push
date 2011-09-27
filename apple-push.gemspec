$LOAD_PATH.unshift 'lib'
require 'apple-push/version'

Gem::Specification.new do |s|
  s.name        = 'apple-push'
  s.version     = ApplePush::Version
  s.summary     = 'ApplePush is a very simple implementation of the APNS (Apple Push Notification
  Service) protocol'
  s.description = 'ApplePush is a very simple implementation of the APNS (Apple Push Notification Service) protocol. It differs from the APNS gem by being able to push to different iOS apps from the same Ruby application.'

  s.author      = 'Niklas Holmgren'
  s.email       = 'niklas@sutajio.se'
  s.homepage    = 'http://github.com/sutajio/apple-push/'

  s.require_path  = 'lib'

  s.files             = %w( README.md Rakefile LICENSE CHANGELOG )
  s.files            += Dir.glob("lib/**/*")
  s.files            += Dir.glob("test/**/*")
  s.files            += Dir.glob("tasks/**/*")
  s.files            += Dir.glob("certs/**/*")

  s.extra_rdoc_files  = [ "LICENSE", "README.md" ]
  s.rdoc_options      = ["--charset=UTF-8"]

  s.add_dependency('json', '> 1.0.0')
end