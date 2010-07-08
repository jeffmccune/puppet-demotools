# Class: puppettesting::params
#
#   This class provides parameters for the puppettesting class.
#
class puppettesting::params {
    # The base HTTP directory to find seed tarballs.
    $httpbase = "http://dl.dropbox.com/u/469429/puppetlabs"
    notice("::puppettesting::params::httpbase='${httpbase}'")
    $spooldir = "/var/puppet/puppettesting"
    notice("::puppettesting::params::spooldir='${spooldir}'")
    $optdir = $fact_optdir ? { "" => "/opt/puppetlabs", default => "${fact_optdir}", }
    notice("::puppettesting::params::optdir='${optdir}'")
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
    # The location of the passenger module
    $passenger_module_path = "/usr/lib/ruby/gems/1.8/gems/passenger-2.2.15/ext/apache2/mod_passenger.so"
    # The passenger_version
    $passenger_version = "passenger-2.2.15"
    # The wrapper command to execute the internal puppet runtime
    # FIXME JJM This should be part of the puppetlabs-bootstrap project in /opt/puppetlabs
    $wrappercmdinternal = "${optdir}/puppet-demotools/bin/wrappercmdinternal"
}
# EOF
