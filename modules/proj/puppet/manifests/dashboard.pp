class puppet::dashboard {
  yumrepo { 'puppetlabs':
    baseurl => 'http://yum.puppetlabs.com/$releasever/base/$basearch/',
    enabled => '1',
    keepalive => '1',
    gpgcheck => '0',
    descr => 'Local Base repo arch'
  }
  package {'dashboard':
    ensure => present,
    require => Yumrepo['puppetlabs'],
  }
}
