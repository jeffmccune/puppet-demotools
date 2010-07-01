#

class puppettesting {
    $basedir = "/opt/puppetlabs"
    $puppeturl = "http://github.com/reductivelabs/puppet.git"
    $facterurl = "http://github.com/reductivelabs/facter.git"
    File {
        ensure => directory,
        mode   => "0644",
        owner  => "0",
        group  => "0",
    }
    Vcsrepo {
        ensure => present,
        provider => "git",
        require => [ File["${basedir}"] ],
    }
####
    file {
        [ "/opt", "${basedir}" ]:;
    }
    vcsrepo {
        "${basedir}/puppet":
            source => "${puppeturl}";
        "${basedir}/facter":
            source => "${facterurl}";
        "${basedir}/puppet_spec":
            source => "http://github.com/jes5199/puppet_spec.git";
    }
}

