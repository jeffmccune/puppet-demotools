# Class: puppettesting::params
#
#   2010-07-08 Jeff McCune <jeff@puppetlabs.com>
#
#   This class provides parameters for the puppettesting class.
#
class puppettesting::params {
    # FIXME JJM $optdir should be refactored to $prefix
    $optdir = $fact_optdir ? { "" => "/opt/puppetlabs", default => "${fact_optdir}", }
    notice("::puppettesting::params::optdir='${optdir}'")
    # The wrapper command to execute the internal puppet runtime
    # FIXME JJM This should be part of the puppetlabs-bootstrap project in /opt/puppetlabs
    $wrappercmdinternal = "${optdir}/puppet-demotools/bin/wrappercmdinternal"
    $wrappercmd = "${optdir}/puppet-demotools/bin/wrappercmdinternal"
    # The base HTTP directory to find seed tarballs.
    $httpbase = "http://dl.dropbox.com/u/469429/puppetlabs"
    notice("::puppettesting::params::httpbase='${httpbase}'")
    $spooldir = "/var/puppet/puppettesting"
    notice("::puppettesting::params::spooldir='${spooldir}'")
    # Comes from facter environment variable in puppet-runtime script
    $demodir = $fact_demodir ? { "" => "/opt/puppetlabs", default => "${demodir}", }
    notice("::puppettesting::params::demodir='${demodir}'")
    $demotools = $fact_demotools ? { "" => "puppet-demotools", default => "${demotools}", }
    notice("::puppettesting::params::demotools='${demotools}'")
    # STATIC Variables
    $puppeturl = "http://github.com/reductivelabs/puppet.git"
    notice("::puppettesting::params::puppeturl='${puppeturl}'")
    $facterurl = "http://github.com/reductivelabs/facter.git"
    notice("::puppettesting::params::facterurl='${facterurl}'")
    $puppet_specurl = "http://github.com/jes5199/puppet_spec.git"
    notice("::puppettesting::params::puppet_specurl='${puppet_specurl}'")
    $puppet_demotoolsurl = "http://github.com/jeffmccune/puppet-demotools.git"
    notice("::puppettesting::params::puppet_demotoolsurl='${puppet_demotoolsurl}'")
    # The passenger_version
    $passenger_version = "2.2.9"
    notice("::puppettesting::params::passenger_version='${passenger_version}'")
    # The location of the passenger module
    $passenger_module_path = "/usr/lib/ruby/gems/1.8/gems/passenger-${passenger_version}/ext/apache2/mod_passenger.so"
    notice("::puppettesting::params::passenger_module_path='${passenger_module_path}'")
    $passenger_ruby = "/usr/bin/ruby"
    notice("::puppettesting::params::passenger_ruby='${passenger_ruby}'")

}
# EOF
