# Define: puppettesting::puppetmodule
#
#   This defined type creates a puppet module
#   in a module directory.
#
#   TODO: Functions, Templates
#
# Parameters:
#
#   location => "/etc/puppet/modules"
#
# Actions:
#
#   Scaffolds "typical" modules using templates
#
# Requires:
#
# Sample Usage:
#
#   puppettesting::puppetmodule { "test1": location => "/tmp/modules" }
#
define puppettesting::puppetmodule($location="/etc/puppet/modules") {
  $module = "puppettesting"
  File { owner => "0", group => "0", mode => "0644" }
  Exec { path => "/bin:/usr/bin:/sbin:/usr/sbin" }
  $dir = "${modulepath}/${name}"
  ####
  file {
    "${dir}":
      ensure => directory;
    "${dir}/manifests":
      ensure => directory;
    "${dir}/manifests/init.pp":
      content => template("${module}/manifests/class.pp.erb");
    "${dir}/manifests/child1":
      content => template("${module}/manifests/subclass.pp.erb");
    "${dir}/manifests/define1":
      content => template("${module}/manifests/define.pp.erb");
    "${dir}/files":
      ensure => directory;
  }
  ####
  exec {
    "puppetmodule-file-${name}-1k":
      command => "dd if=/dev/urandom of=${dir}/files/f1k bs=1k count=1",
      creates => "${dir}/files/f1k";
    "puppetmodule-file-${name}-8k":
      command => "dd if=/dev/urandom of=${dir}/files/f1k bs=1k count=8",
      creates => "${dir}/files/f8k";
    "puppetmodule-file-${name}-16k":
      command => "dd if=/dev/urandom of=${dir}/files/f1k bs=1k count=16",
      creates => "${dir}/files/f16k";
    "puppetmodule-file-${name}-64k":
      command => "dd if=/dev/urandom of=${dir}/files/f1k bs=1k count=64",
      creates => "${dir}/files/f64k";
    "puppetmodule-file-${name}-512k":
      command => "dd if=/dev/urandom of=${dir}/files/f1k bs=1k count=512",
      creates => "${dir}/files/f512k";
    "puppetmodule-file-${name}-1024k":
      command => "dd if=/dev/urandom of=${dir}/files/f1k bs=1k count=1024",
      creates => "${dir}/files/f1024k";
    "puppetmodule-file-${name}-8192k":
      command => "dd if=/dev/urandom of=${dir}/files/f1k bs=1k count=8192",
      creates => "${dir}/files/f8192k";
  }
}
# EOF
