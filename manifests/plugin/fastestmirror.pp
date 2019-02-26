# Manage the Yum fastestmirror plugin.
#
# @example Declaring the class
#   include ::yum
#   include ::yum::plugin::fastestmirror
#
# @param ensure
# @param enable
# @param package_name
# @param verbose
# @param always_print_best_host
# @param socket_timeout
# @param hostfilepath
# @param maxhostfileage
# @param maxthreads
# @param exclude
# @param include_only
# @param prefer
# @param downgrade_ftp
#
# @see puppet_classes::yum ::yum
# @see puppet_defined_types::yum::plugin ::yum::plugin
#
# @since 1.0.0
class yum::plugin::fastestmirror (
  Enum['present', 'absent']  $ensure                 = 'present',
  Boolean                    $enable                 = true,
  String                     $package_name           = $::yum::params::fastestmirror_package_name,
  Optional[Boolean]          $verbose                = false,
  Optional[Boolean]          $always_print_best_host = true,
  Optional[Integer[0]]       $socket_timeout         = 3,
  Optional[String]           $hostfilepath           = 'timedhosts.txt',
  Optional[Integer[0]]       $maxhostfileage         = 10,
  Optional[Integer[0]]       $maxthreads             = 15,
  Optional[Array[String, 1]] $exclude                = undef,
  Optional[Array[String, 1]] $include_only           = undef,
  Optional[String]           $prefer                 = undef,
  Optional[Boolean]          $downgrade_ftp          = undef,
) inherits ::yum::params {

  if ! defined(Class['::yum']) {
    fail('You must include the yum base class before using the yum::plugin::fastestmirror class')
  }

  package { $package_name:
    ensure => $ensure,
    tag    => [
      "bodgit::${module_name}",
    ],
  }

  if $ensure == 'present' {
    ::yum::plugin { 'fastestmirror':
      content => template("${module_name}/fastestmirror.conf.erb"),
      require => Package[$package_name],
    }
  }
}
