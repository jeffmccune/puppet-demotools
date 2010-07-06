# Class: puppettesting::master::passenger
#
#    Manage a puppetmaster for testing using passenger.
#
# Parameters:
#
# Actions:
#
# Requires:
#   Class["apache"]
#   Service["apache"]
#
# Sample Usage:
#
class puppettesting::master::passenger inherits puppettesting::master {
    $module = "puppettesting"
    include "apache"
    # Resource defaults
    File {
        owner => "root",
        group => "root",
        mode  => "0644",
    }
    # Resources
    file {
        [ "/etc/puppet/rack", "/etc/puppet/rack/public" ]:
            ensure => directory;
    }
    file {
        "/etc/puppet/rack/config.ru":
            content => template("${module}/etc/puppet/rack/config.ru"),
            owner => puppet,
            notify => [ Service["apache"] ],
    }
    file {
        "/etc/httpd/conf.d/passenger.conf":
            content => template("${module}/etc/httpd/conf.d/passenger.conf"),
            notify => [ Service["apache"] ];
    }
}
# EOF
