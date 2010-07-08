# Class: puppettesting::master::certificates
#
#   2010-07-07 Jeff McCune <jeff@puppetlabs.com>
#
#   This class generates certificates for puppet server configurations
#   which don't use the built in HTTP server.
#   These certificates are necessary for SSL configuration.
#
# Parameters:
#
#   $params::cmdwrapper - The puppet RUBYLIB and PATH wrapper script
#   $params::ssldir - The puppet ssldir configuration option
#
# Actions:
#
#   Executes puppetca --list to generate the CA certificates
#   Executes puppetca --generate ${fqdn} to generate the SSL certificates
#
# Requires:
#
#   Puppet Runtime (Puppet is being used to configure Puppet)
#
#   Service["apache"] - The executes must run before Apache starts up.
#
# Sample Usage:
#
#   include puppettesting::cacert
#
class puppettesting::master::certificates {
    # The Run Command sets up the environment for us.
    $runcmd = $params::runcmd
    # Use the default ssldir unless specified.
    $ssldir = $params::ssldir ? {
        false   => "/etc/puppet/ssl",
        default => $params::ssldir,
    }
    ####
    exec {
        "generate-cacerts":
            command => "${runcmd} puppetca --list",
            creates => "${ssldir}/ca/ca_key.pem",
    }
    exec {
        "generate-sslcerts":
            command => "${runcmd} puppetca --generate ${fqdn}",
            creates => "${ssldir}/certs/${fqdn}.pem",
    }
}
