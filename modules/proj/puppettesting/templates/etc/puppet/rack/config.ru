# a config.ru, for use with every rack-compatible webserver.
# SSL needs to be handled outside this, though.

# if puppet is not in your RUBYLIB:
# FIXME JJM This probably shouldn't be hard coded.
$:.unshift('/opt/puppetlabs/facter/lib')
$:.unshift('/opt/puppetlabs/puppet/lib')

$0 = "puppetmasterd"
require 'puppet'

# if you want debugging:
# ARGV << "--debug"

ARGV << "--rack"

require 'puppet/application/puppetmasterd'
# we're usually running inside a Rack::Builder.new {} block,
# therefore we need to call run *here*.
#
# JJM 0.25.X uses Puppet::Application[:puppetmasterd].run
# run Puppet::Application[:puppetmasterd].run
# JJM 2.6.X uses Puppet::Application[:master].run
run Puppet::Application[:master].run

