# Define: puppettesting::master::certificates
#
# 2010-07-08 Jeff McCune <jeff@puppetlabs.com>
#
# This defined type generate SSL certificates for the host
# prior to executing puppet.  It is designed to run on the
# puppetmaster prior to starting the HTTP SSL server.
#
# Parameters:
#
#   ssldir - The location of the SSL directory Defaults to /etc/puppet/ssl
#   cn - The certificate name to generate.  Defaults to the resource title
# 
# Actions:
#
#   Executes puppetca --generate
#   Copies the files from the CA into place.
#
# Requires:
#
#   $params::runcmd - The wrapper script for the puppet runtime.
#
# Sample Usage:
#
#   puppettesting::master::certificates { "${fqdn}":
#     ssldir => "/etc/puppet/ssl",
#     notify => Service["apache"],
#   }
#
define puppettesting::master::certificates( $ssldir="/etc/puppet/ssl", $cn=false ) {
  $cn_real = $cn ? { false => $name, default => $cn }
  $runcmd = $params::wrappercmdinternal
  #
  exec {
    "generate-sslcert-${cn_real}":
      command => "${runcmd} puppetca --generate ${cn_real}",
      creates => "${ssldir}/certs/${cn_real}.pem",
  }
}