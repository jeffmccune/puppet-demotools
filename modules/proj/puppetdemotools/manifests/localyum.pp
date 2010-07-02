# Manage a local yum repository.

class puppetdemotools::localyum {
  ##########
  $module = "puppetdemotools"
  File { owner => "0", group => "0", mode => "0644" }
  Exec { path => "/usr/kerberos/sbin:/usr/kerberos/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin" }
  ##########
  file {
    "/etc/yum.repos.d/localyum.repo":
      ensure   => "file",
      require  => [ Exec["localyumrepo"] ],
      source   => "puppet:///modules/${module}/etc/yum.repos.d/localyum.repo",
  }
  file {
    "/var/lib/localyumrepo":
      ensure => "directory",
  }
  package {
    "createrepo":
      ensure   => "installed",
  }
  exec {
    "createrepo /var/lib/localyumrepo":
      alias   => "localyumrepo",
      returns => [ 0 ],
      require => [ File["/var/lib/localyumrepo"],
                   Package["createrepo"] ],
  }
}
