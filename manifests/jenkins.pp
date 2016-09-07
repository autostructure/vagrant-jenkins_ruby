class { '::firewall':
  ensure => stopped,
}

$ruby_packages = ['curl', 'bison', 'build-essential', 'zlib1g-dev', 'libssl-dev', 'libreadline5-dev', 'libxml2-dev',  'git-core']

package {$ruby_packages:
  ensure => present,
}

# include ::jenkins

# :jenkins::plugin { 'ruby': }

class {'::java': } ->

file {'/home/jenkins':
  ensure => directory,
  owner  => 'jenkins',
}

user {'jenkins':
  home  => '/home/jenkins',
  shell => '/bin/bash',
} ->

file {'/home/jenkins/.bashrc':
  ensure => file,
  owner  => 'jenkins',
} ->

file {'/home/jenkins/.rvmrc':
  ensure => file,
  owner  => 'jenkins',
} ->

file_line {'Ruby Load':
  path => '/home/jenkins/.bashrc',
  line => '[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"',
} ->

file_line {'Ruby install flag':
  path => '/home/jenkins/.rvmrc',
  line => 'rvm_install_on_use_flag=1',
} ->

file_line {'Ruby project flag':
  path => '/home/jenkins/.rvmrc',
  line => 'rvm_project_rvmrc=1',
} ->

file_line {'Ruby create flag':
  path => '/home/jenkins/.rvmrc',
  line => 'rvm_gemset_create_on_use_flag=1',
} ->

exec {'/usr/bin/wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo':
  user => 'jenkins',
} ->

exec {'/usr/bin/rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key':
  user => 'jenkins',
} ->

package {'jenkins': } ->

exec {'/usr/bin/gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3':
  user => 'jenkins',
} ->

exec {'/usr/bin/curl -sSL https://get.rvm.io | bash -s stable --ruby':
  user => 'jenkins',
} ~>

service {'jenkins':
  ensure => running,
}

#include ::rvm

#rvm::system_user { 'jenkins': }

#rvm_system_ruby {
#  'ruby-2.1':
#    ensure      => 'present',
#    default_use => true,
#}
