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
  $dir = "${location}/${name}"
  File { owner => "0", group => "0", mode => "0644" }
  Exec {
    path    => "/bin:/usr/bin:/sbin:/usr/sbin",
    require => File["${dir}/files"],
  }
  Puppettesting::Randfile { location => "${dir}/files" }
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
  puppettesting::randfile {
    "${name}-1k": kilobytes => 1;
    "${name}-8k": kilobytes => 8;
    "${name}-64k": kilobytes => 64;
    "${name}-256k": kilobytes => 256;
    "${name}-512k": kilobytes => 512;
    "${name}-1024k": kilobytes => 1024;
    "${name}-4096k": kilobytes => 4096;
    "${name}-8192k": kilobytes => 8192;
  }
}
# EOF
