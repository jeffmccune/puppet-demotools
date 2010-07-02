# Class: gcc::params
#
# This class manages parameters for the gcc module
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class gcc::params{
  case $operatingsystem {
    'fedora', 'centos', 'redhat': {
       $gcc_package = [ 'gcc', 'gcc-c++', ]
    }
    'ubuntu', 'debian': {
       $gcc_package = [ 'gcc', 'build-essential' ]
    }
  }
}
