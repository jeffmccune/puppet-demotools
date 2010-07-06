# Settings
$hostname_configured = $ipaddress ? {
    "192.168.100.148" => "hyel",
    "192.168.100.149" => "gunab",
    default => "unknown",
}
$testing_role = $hostname_configured ? {
    "hyel"  => "master",
    default => "agent",
}
notice("Configured hostname: [${hostname_configured}]")
notice("Configured role: [${testing_role}]")
#################################################

# Set the hostname of the system
puppet::hostname {
    "${hostname_configured}":
        domainname => "${domain}";
}

# Stuff to make Jeff happy...
include jeffprefs
# The actual testing infrastructure module
include puppettesting
# We need gcc for Passenger
include gcc
# We need apache for Passenger
include apache
# Passenger (Base install)
include passenger

# Puppet Master setup as passenger
include puppettesting::master::passenger

