# Define: jeffutil::tarball
#
# This defined type populates a filesystem branch from a tarball
# hosted on an HTTP server.  It uses curl for the transfer.
#
# Jeff McCune <jeff@puppetlabs.com>
# 2010-07-03
#
# Parameters:
#   $source:
#     The URL to the tarball
#     e.g. http://bit.ly/puppetdemotools.tar.gz
#   $archive:
#     The file name of the archive
#     e.g. puppet-demotools.tar.gz
#     Defaults to the name of the resource.
#   $path:
#     The local filesystem path to unpack the tarball into.
#     e.g. /opt/pupeptlabs
#   $spooldir:
#     The local filesystem path to spool the tarball.
#     defaults to /tmp
#
# Actions:
#   Download tarball into $spooldir
#   Unpack tarball into $path
#
# Requires:
#   File["${path}"] (The directory to unpack into)
#
# Sample Usage:
#   $urlbase = "http://dl.dropbox.com/u/469429/puppetlabs"
#
#   jeffutil::tarball { "puppet-demotools.tar.gz":
#     source => "${urlbase}/puppet-demotools.tar.gz",
#     path => "/opt/puppetlabs",
#   }
define jeffutil::tarball($source, $archive=false, $path, $spooldir="/tmp") {
    # Variables
    $archive_real = $archive? { false => $name, default => $archive, }
    # Resources
    exec { "curl ${archive_real}":
        command => "curl -o '${spooldir}/${archive_real}' '${source}'",
        path => ["/bin", "/usr/bin", "/usr/local/bin", "/opt/csw/bin", "/opt/sfw/bin", ],
        creates => "${spooldir}/${archive_real}",
        notify => Exec["unpack ${archive_real}"],
    }
    exec { "unpack ${archive_real}":
        command => "tar -C '${path}' -x -z -f '${spooldir}/${archive_real}'",
        path => ["/bin", "/usr/bin", "/usr/local/bin", "/opt/csw/bin", "/opt/sfw/bin", ],
        refreshonly => true,
    }
}
# EOF
