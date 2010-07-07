# Class: ack
#
#   Install the ack executable in /usr/bin
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class ack {
    $module = "ack"
    file {
        "/usr/bin/ack":
            source => "puppet:///modules/${module}/ack",
            owner => 0,
            group => 0,
            mode => "0755";
    }
}
# EOF
