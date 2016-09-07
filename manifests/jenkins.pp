class { '::firewall':
  ensure => stopped,
}

$ruby_packages =
  [ 'curl',
    'bison',
    'git-core',
    'libyaml-devel',
    'autoconf',
    'gcc-c++',
    'readline-devel',
    'zlib-devel',
    'libffi-devel',
    'openssl-devel',
    'automake',
    'libtool',
    'sqlite-devel',
  ]

package {$ruby_packages:
  ensure => present,
}

# include ::jenkins

# :jenkins::plugin { 'ruby': }

class {'::java': }

user {'jenkins':
  home  => '/home/jenkins',
  shell => '/bin/bash',
}

file {'/home/jenkins':
  ensure => directory,
  owner  => 'jenkins',
}

file {'/home/jenkins/.bashrc':
  ensure => file,
  owner  => 'jenkins',
}

file {'/home/jenkins/.rvmrc':
  ensure => file,
  owner  => 'jenkins',
}

file_line {'Ruby Load':
  path => '/home/jenkins/.bashrc',
  line => '[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"',
}

file_line {'Ruby install flag':
  path => '/home/jenkins/.rvmrc',
  line => 'rvm_install_on_use_flag=1',
}

file_line {'Ruby project flag':
  path => '/home/jenkins/.rvmrc',
  line => 'rvm_project_rvmrc=1',
}

file_line {'Ruby create flag':
  path => '/home/jenkins/.rvmrc',
  line => 'rvm_gemset_create_on_use_flag=1',
}

package {'jenkins': }

#include ::rvm

#rvm::system_user { 'jenkins': }

#rvm_system_ruby {
#  'ruby-2.1':
#    ensure      => 'present',
#    default_use => true,
#}
