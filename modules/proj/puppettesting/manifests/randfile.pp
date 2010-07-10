# Define: puppettesting::randfile
#
#   This defined type creates files with random contents.
#   Files are named f${kilobytes}k in the directory specified
#   by the location parameter.
#
# Parameters:
#
#   kilobytes => 8192
#   location - The directory to create the file in.
#
# Actions:
#
#   Creates a file with random contents of a specified size.
#
# Requires:
#
#   File["${location}"]
#
# Sample Usage:
#
#   puppettesting::randfile { "testfile":
#     kilobytes => 8192,
#     location => "/etc/puppet/modules/test/files",
#   }
#
class puppettesting::randfile($kilobytes, $location) {
  $module = "puppettesting"
  $dir = "${location}"
  exec {
    "puppetmodule-file-${name}-${kilobytes}k":
      command => "dd if=/dev/urandom of=${dir}/f${kilobytes}k bs=1k count=${kilobytes}",
      before  => File["${dir}/f${kilobytes}k"],
      require => File["${dir}"],
      creates => "${dir}/f${kilobytes}k";
  }
  file {
    "${dir}/f${kilobytes}k": ensure => present;
  }
}
