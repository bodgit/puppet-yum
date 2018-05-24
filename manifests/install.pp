# @!visibility private
class yum::install {

  package { $::yum::package_name:
    ensure => present,
  }
}
