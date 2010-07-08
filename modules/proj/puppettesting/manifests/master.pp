# Class: puppettesting::master
#
#   Base class for the puppet master server setup.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class puppettesting::master {
    $module = "puppettesting"
    # The Run Command sets up the environment for us.
    $runcmd = $params::wrappercmd
    # Use the default ssldir unless specified.
    $ssldir = $params::ssldir ? {
        false   => "/etc/puppet/ssl",
        default => $params::ssldir,
    }
    ##
    file {
        "/etc/puppet/puppet.conf":
            owner => puppet,
            group => puppet,
            mode => 0644,
            source => "puppet:///modules/${module}/etc/puppet/puppet.conf";
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
    puppettesting::master:
}

# EOF
