class jeffprefs {
    $module = "jeffprefs"
    File {
        owner => "root",
        group => "root",
        mode  => "0644",
    }
    file {
        "/root/.screenrc":
            source => "puppet:///modules/${module}/screenrc",
    }
}

