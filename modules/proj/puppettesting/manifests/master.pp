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
##
    file {
        "/etc/puppet/puppet.conf":
            owner => puppet,
            group => puppet,
            mode => 0644,
            source => "puppet:///modules/${module}/etc/puppet/puppet.conf";
    }
}

# EOF
