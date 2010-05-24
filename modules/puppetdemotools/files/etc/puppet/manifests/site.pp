$helloworld = "Hello World!
lsbdistdescription: ${lsbdistdescription}
uptime: ${uptime}
uptime_seconds: ${uptime_seconds}
memoryfree: ${memoryfree}\n"

node default {
  # include ntp

  file {
    "/tmp/foo.txt":
      path     => "/tmp/foo.txt",
      ensure   => "file",
      content  => $helloworld,
      owner    => "0",
      group    => "0",
      mode     => "0644";
  }
}
