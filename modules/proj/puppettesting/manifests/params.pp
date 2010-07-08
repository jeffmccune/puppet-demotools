# Class: puppettesting::params
#
#   2010-07-08 Jeff McCune <jeff@puppetlabs.com>
#
#   This class provides parameters for the puppettesting class.
#
class puppettesting::params {
    # FIXME JJM $optdir should be refactored to $prefix
    $ns = "puppettesting::params"
    $optdir = $fact_optdir ? {
      "" => "/opt/puppetlabs",
      default => "${fact_optdir}",
    }
    notice("::${ns}::optdir='${optdir}'")

    # The wrapper command to execute the internal puppet runtime
    # FIXME JJM This should be in /opt/puppetlabs/puppetlabs-bootstrap
    # FIXME JJM This command is intended to run the internal puppet
    $wrappercmdinternal = "${optdir}/puppet-demotools/bin/wrappercmdinternal"
    notice("::${ns}::wrappercmdinternal='${wrappercmdinternal}'")

    # FIXME JJM This command is intended to run the "system" puppet
    $wrappercmd = "${optdir}/puppet-demotools/bin/wrappercmdinternal"
    notice("::${ns}::wrappercmd='${wrappercmd}'")

    # The base HTTP directory to find seed tarballs.
    $httpbase = "http://dl.dropbox.com/u/469429/puppetlabs"
    notice("::${ns}::httpbase='${httpbase}'")

    $spooldir = "/var/puppet/puppettesting"
    notice("::${ns}::spooldir='${spooldir}'")

    # Comes from facter environment variable in puppet-runtime script
    $demodir = $fact_demodir ? {
      "" => "/opt/puppetlabs",
      default => "${demodir}",
    }
    notice("::${ns}::demodir='${demodir}'")

    # FIXME JJM 2010-07-08 demotools needs to be ripped out
    $demotools = $fact_demotools ? {
      "" => "puppet-demotools",
      default => "${demotools}",
    }
    notice("::${ns}::demotools='${demotools}'")

    # STATIC Variables
    $puppeturl = "http://github.com/reductivelabs/puppet.git"
    notice("::${ns}::puppeturl='${puppeturl}'")

    $facterurl = "http://github.com/reductivelabs/facter.git"
    notice("::${ns}::facterurl='${facterurl}'")

    $puppet_specurl = "http://github.com/jes5199/puppet_spec.git"
    notice("::${ns}::puppet_specurl='${puppet_specurl}'")

    $puppet_demotoolsurl = "http://github.com/jeffmccune/puppet-demotools.git"
    notice("::${ns}::puppet_demotoolsurl='${puppet_demotoolsurl}'")

    # The passenger_version
    $passenger_version = "2.2.11"
    notice("::${ns}::passenger_version='${passenger_version}'")

    # The location of the passenger module
    $passenger_module_path = "/usr/lib/ruby/gems/1.8/gems/passenger-${passenger_version}/ext/apache2/mod_passenger.so"
    notice("::${ns}::passenger_module_path='${passenger_module_path}'")

    $passenger_ruby = "/usr/bin/ruby"
    notice("::${ns}::passenger_ruby='${passenger_ruby}'")

}
# EOF
