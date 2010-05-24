define puppet::hostname ($address = $ipaddress, $domainname, $masterip='') {
  File { owner => 'root', group => 'root', mode => '644' }
  exec {"set-hostname-${name}": command => "/bin/hostname ${name}.${domainname}" }
  file {'/etc/sysconfig/network': content => template('puppet/sysconfig_network.erb') }
  if $masterip {
    host {
      'puppet': ensure => present, ip => $masterip, host_aliases => "puppet.${domainname}";
      $name: ensure => present, ip => $address, host_aliases => "${name}.${domainname}"; 
    }
  } else {
    host {$name:
      ensure => present,
      ip => $address,
      host_aliases => ["${name}.${domainname}", "puppet.${domainname}", "puppet"] 
    }
  }
}
