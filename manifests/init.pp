class mdm (
            $password_minlen                      = '14',
            $password_complexity_digits_credit    = '-1',
            $password_complexity_uppercase_credit = '-1',
            $password_complexity_other_credit     = '-1',
            $password_complexity_lowercase_credit = '-1',
            $password_default_max_days            = 30,
            $remember_old_passwords               = '12',
            $mandatory_services                   = undef,
          ) inherits mdm::params{

  class { 'pam::cracklib':
    minlen  => $password_minlen,
    dcredit => $password_complexity_digits_credit,
    ucredit => $password_complexity_uppercase_credit,
    ocredit => $password_complexity_other_credit,
    lcredit => $password_complexity_lowercase_credit,
  }

  class { 'pam::unix':
    remember => $remember_old_passwords,
  }

  if($mandatory_services!=undef)
  {
    service { $mandatory_services:
      ensure => 'running',
      enable => true,
    }  
  }

  include ::shadow
  include ::shadow::useradd
  include ::shadow::filemodes

  class { 'shadow::logindefs':
    pass_max_days => $password_default_max_days,
  }


}
