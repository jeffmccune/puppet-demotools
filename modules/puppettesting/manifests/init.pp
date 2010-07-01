#

class puppettesting {
    $basedir = "/opt/puppetlabs"
    $puppeturl = "http://github.com/reductivelabs/puppet.git"
    File {
        ensure => directory,
        mode   => "0644",
        owner  => "0",
        group  => "0",
    }
    Vcsrepo {
        ensure => present,
        provider => "git",
    }
####
    file {
        [ "/opt", "${basedir}" ]:;
    }
    vcsrepo {
        "${basedir}/puppet":
            require => [ File["${basedir}"] ],
            source  => "${puppeturl}";
    }
}

