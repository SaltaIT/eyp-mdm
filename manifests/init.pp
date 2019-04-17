class mdm (
            $password_minlen                      = '14',
            $password_complexity_digits_credit    = '-1',
            $password_complexity_uppercase_credit = '-1',
            $password_complexity_other_credit     = '-1',
            $password_complexity_lowercase_credit = '-1',
            $remember_old_passwords               = '12',
            $mandatory_services                   = [],
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

  if($mandatory_services.any)
  {
    service { $mandatory_services:
      ensure => 'running',
      enable => true,
    }
  }
}
