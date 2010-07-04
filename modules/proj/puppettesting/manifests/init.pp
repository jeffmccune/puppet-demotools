# Class: puppettesting
#
#  Jeff McCune <jeff@puppetlabs.com>
#  2010-07-01
#  This module sets up a puppet testing environment.
#
class puppettesting {
    # We need our parameters
    include puppettesting::params
    # Resource Defaults
    File { ensure => directory, mode => "0644", owner => "0", group => "0" }
    Vcsrepo {
        ensure => present,
        provider => "git",
        require => [ File["${params::optdir}"] ],
    }
    Jeffutil::Tarball {
        path => "${params::optdir}",
        spooldir => $params::spooldir,
        require => [ File["${params::optdir}"] ],
    }
#### Resource Declarations
    file {
        "${params::spooldir}":;
        "/opt":;
        "${params::optdir}":;
    }
    jeffutil::tarball {
        "puppet-demotools.tar.gz":
            source => "${params::httpbase}/puppet-demotools.tar.gz";
        "puppet.tar.gz":
            source => "${params::httpbase}/puppet.tar.gz";
        "facter.tar.gz":
            source => "${params::httpbase}/facter.tar.gz";
        "puppet_spec.tar.gz":
            source => "${params::httpbase}/puppet_spec.tar.gz";
    }
    vcsrepo {
        "${params::optdir}/puppet":
            require => Jeffutil::Tarball["puppet.tar.gz"],
            source => "${params::puppeturl}";
        "${params::optdir}/facter":
            require => Jeffutil::Tarball["facter.tar.gz"],
            source => "${params::facterurl}";
        "${params::optdir}/puppet_spec":
            require => Jeffutil::Tarball["puppet_spec.tar.gz"],
            source => "${params::puppet_specurl}";
        "${params::optdir}/puppet-demotools":
            require => Jeffutil::Tarball["puppet-demotools.tar.gz"],
            source => "${params::puppet_demotoolsurl}";
    }
    file {
        "${params::optdir}/puppet_spec":
            require => Vcsrepo["${params::optdir}/puppet_spec"];
        "${params::optdir}/puppet_spec/local_setup.sh":
            ensure => file,
            content => "source ${params::demodir}/${params::demotools}/resources/environment-testing\n";
    }
}

