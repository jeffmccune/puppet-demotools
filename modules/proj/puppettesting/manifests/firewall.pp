# Class: puppettesting::firewall
#
#   This class disables the local firewall and selinux
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class puppettesting::firewall inherits puppettesting {
    $module = "puppettesting"
    service {
        "iptables":
            hasstatus => true,
            ensure => stopped,
            enable => false;
    }
    # Turn off selinux on boot
    file {
        "/etc/selinux/config":
            source => "puppet:///modules/${module}/etc/selinux/config";
        "/etc/sysconfig/selinux":
            ensure => "../selinux/config";
    }
    # Set selinux to permissive at runtime.
    exec {
        "":
        command => "/usr/sbin/setenforce 0",
        unless => "/usr/sbin/getenforce | /bin/grep -qx Permissive",
        onlyif => "/usr/sbin/selinuxenabled";

}
# EOF
