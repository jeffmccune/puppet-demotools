# Class: jeffprefs
#
#   This module sets up things that make Jeff happy.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class jeffprefs {
    $module = "jeffprefs"
    include ack
    File {
        owner => "root",
        group => "root",
        mode  => "0644",
    }
    file {
        "/root/.screenrc":
            source => "puppet:///modules/${module}/screenrc",
    }
}

