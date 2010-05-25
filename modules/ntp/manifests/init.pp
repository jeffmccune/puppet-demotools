# NTP Module
# Jeff McCune <jeff@puppetlabs.com>
#

class ntp {
  File { owner => "0", group => "0", mode => "0644" }
  $module = "ntp"
  ######################################################
  package {
    "ntp":
      name       => "ntp",
      ensure     => "installed",
  }
  file {
    "/etc/ntp.conf":
      source     => "puppet:///${module}/etc/ntp.conf",
      require    => [ Package["ntp"] ],
      notify     => [ Service["ntp"] ],
  file {
    "/etc/ntp":
      ensure     => "directory",
  }
  service {
    "ntp":
      name       => "ntpd",
      enable     => "true",
      ensure     => "running",
      hasrestart => "true",
      hasstatus  => "true",
      require => [ File["/etc/ntp.conf"], File["/etc/ntp"] ],
  }
}
