class { '::firewall':
  ensure => stopped,
}

package {'java-1.7.0-openjdk-devel':
  ensure => absent,
}

class { '::java' :
  package => 'java-1.8.0-openjdk-devel',
}

package { 'rubygems':
  ensure => present,
}


package { 'git': 
  ensure => present, 
}

# $gem_packages = ['puppet-lint', 'rubocop']

#package { $gem_packages:
#  provider => 'gem',
#}

# user {'jenkins':
#  shell => '/bin/bash',
# }

# file {'/home/jenkins':
#   ensure => directory,
#   owner  => 'jenkins',
# }

#file {'/home/jenkins/.bashrc':
#  ensure => file,
#  owner  => 'jenkins',
#}

# file {'/home/jenkins/.rvmrc':
#   ensure => file,
#   owner  => 'jenkins',
# }

# file_line {'Ruby Load':
#   path => '/etc/profile',
#   line => '[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"',
# }

# file_line {'Ruby install flag':
#   path => '/home/jenkins/.rvmrc',
#   line => 'rvm_install_on_use_flag=1',
# }

# file_line {'Ruby project flag':
#   path => '/home/jenkins/.rvmrc',
#   line => 'rvm_project_rvmrc=1',
# }

# file_line {'Ruby create flag':
#   path => '/home/jenkins/.rvmrc',
#   line => 'rvm_gemset_create_on_use_flag=1',
# }

include ::rvm

::rvm::system_user { 'jenkins': }

rvm_system_ruby {
  'ruby-2.1':
    ensure      => 'present',
    default_use => true,
}
