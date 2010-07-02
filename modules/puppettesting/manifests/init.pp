# JJM Puppet Testing Module
# This module sets up a host to run performance
# testing.

class puppettesting {
    # JJM Place stuff in /opt/puppetlabs
    $optdir = $fact_optdir ? { false => "/opt/puppetlabs", default => "${fact_optdir}", }
    # Comes from facter environment variable in puppet-runtime script
    $demodir_real = $demodir ? { false => "/demo", default => "${demodir}", }
    $demotools_real = $demotools ? { false => "puppet-demotools", default => "${demotools}", }
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
#### Resource Declarations
    file {
        [ "/opt", "${optdir}" ]:;
    }
    vcsrepo {
        "${optdir}/puppet":
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
            content => "source /demo/puppet-demotools/resources/environment\n";
    }
}

