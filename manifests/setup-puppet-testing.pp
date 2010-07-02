# Settings

$hostname_configured = $ipaddress ? {
    "192.168.100.148" => "hyel",
    "192.168.100.149" => "gunab",
    default => "unknown",
}

notice("Setting Hostname to: ${hostname_configured}")

puppet::hostname {
    "${hostname_configured}":
        domainname => "${domain}";
}

include jeffprefs
include puppettesting

# We need gcc
include gcc

