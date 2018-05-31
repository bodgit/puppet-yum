# @!visibility private
class yum::utils::install {

  package { $::yum::utils::package_name:
    ensure => present,
  }
}
