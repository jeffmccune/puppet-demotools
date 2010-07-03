# Class: puppettesting::params
#
#   This class provides parameters for the puppettesting class.
#
class puppettesting::params {
    # The full URL to the puppet-demotools.tar.gz file
    $demotools_tarball_real = $demotools_tarball ? {
        "" => "http://dl.dropbox.com/u/469429/puppetlabs/puppet-demotools.tar.gz",
        default => $demotools_tarball,
    }
    $puppet_tarball_real = $puppet_tarball ? {
        "" => "http://dl.dropbox.com/u/469429/puppetlabs/puppet.tar.gz",
        default => $puppet_tarball,
    }
}
# EOF
