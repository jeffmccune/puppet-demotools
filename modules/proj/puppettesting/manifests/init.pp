# Class: puppettesting
#
#  Jeff McCune <jeff@puppetlabs.com>
#  2010-07-01
#  This module sets up a puppet testing environment.
#
class puppettesting {
    # We need our parameters
    include puppettesting::params
    # JJM /opt/puppetlabs is our default base directory
    $optdir = $fact_optdir ? { "" => "/opt/puppetlabs", default => "${fact_optdir}", }
    notice("optdir is: [${optdir}]")
    # Comes from facter environment variable in puppet-runtime script
    $demodir_real = $demodir ? { "" => "/opt/puppetlabs", default => "${demodir}", }
    $demotools_real = $demotools ? { "" => "puppet-demotools", default => "${demotools}", }
    # STATIC Variables
    $puppeturl = "http://github.com/reductivelabs/puppet.git"
    $facterurl = "http://github.com/reductivelabs/facter.git"
    # Resource Defaults
    File {
        ensure => directory,
        mode   => "0644",
        owner  => "0",
        group  => "0",
    }
    Vcsrepo {
        ensure => present,
        provider => "git",
        require => [ File["${optdir}"] ],
    }
    Jeffutil::Tarball {
        path => "${optdir}",
        require => [ File["${optdir}"] ],
    }
#### Resource Declarations
    file {
        "/opt":;
        "${optdir}":;
    }
    jeffutil::tarball {
        "puppet-demotools.tar.gz":
            source => "${params::httpbase}/puppet-demotools.tar.gz";
        "puppet.tar.gz":
            source => "${params::httpbase}/puppet.tar.gz";
    }
    vcsrepo {
        "${optdir}/puppet":
            require => Jeffutil::Tarball["puppet.tar.gz"],
            source => "${puppeturl}";
        "${optdir}/facter":
            source => "${facterurl}";
        "${optdir}/puppet_spec":
            source => "http://github.com/jes5199/puppet_spec.git";
    }
    file {
        "${optdir}/puppet_spec":
            require => Vcsrepo["${optdir}/puppet_spec"];
        "${optdir}/puppet_spec/local_setup.sh":
            ensure => file,
            content => "source ${demodir_real}/${demotools_real}/resources/environment-testing\n";
    }
}

