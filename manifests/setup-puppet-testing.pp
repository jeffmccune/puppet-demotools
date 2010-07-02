# Settings

$hostname_configured = $ipaddress ? {
    "192.168.100.148" => "hyel",
    "192.168.100.149" => "gunab",
    default => "unknown",
}

notice("Setting Hostname to: ${hostname_configured}")

# Set the hostname of the system
puppet::hostname {
    "${hostname_configured}":
        domainname => "${domain}";
}

include jeffprefs
include puppettesting

# We need gcc for Passenger
include gcc
# We need apache for Passenger
include apache

