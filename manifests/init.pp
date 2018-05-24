# Description
#
# @example Declaring the class
#   include ::yum
#
# @param bugtracker_url
# @param cachedir
# @param conf_dir
# @param conf_file
# @param debuglevel
# @param default_plugins
# @param distroverpkg
# @param exactarch
# @param gpgcheck
# @param installonly_limit
# @param keepcache
# @param logfile
# @param obsoletes
# @param package_name
# @param plugins
# @param purge_repos
# @param repo_dir
# @param repos
#
# @see puppet_classes::yum::plugin::etckeeper ::yum::plugin::etckeeper
# @see puppet_classes::yum::plugin::fastestmirror ::yum::plugin::fastestmirror
# @see puppet_classes::yum::plugin::kabi ::yum::plugin::kabi
# @see puppet_classes::yum::plugin::priorities ::yum::plugin::priorities
# @see puppet_classes::yum::plugin::protectbase ::yum::plugin::protectbase
# @see puppet_classes::yum::plugin::rhnplugin ::yum::plugin::rhnplugin
# @see puppet_classes::yum::plugin::security ::yum::plugin::security
# @see puppet_classes::yum::plugin::versionlock ::yum::plugin::versionlock
# @see puppet_defined_types::yum::plugin ::yum::plugin
#
# @since 1.0.0
class yum (
  Stdlib::Absolutepath            $conf_dir          = $::yum::params::conf_dir,
  Stdlib::Absolutepath            $conf_file         = $::yum::params::conf_file,
  Hash[String, Hash[String, Any]] $default_plugins   = $::yum::params::default_plugins,
  String                          $package_name      = $::yum::params::package_name,
  Boolean                         $purge_repos       = $::yum::params::purge_repos,
  Stdlib::Absolutepath            $repo_dir          = $::yum::params::repo_dir,
  Hash[String, Hash[String, Any]] $repos             = $::yum::params::repos,
  Optional[String]                $bugtracker_url    = $::yum::params::bugtracker_url,
  Optional[Stdlib::Absolutepath]  $cachedir          = $::yum::params::cachedir,
  Optional[Integer[0, 10]]        $debuglevel        = $::yum::params::debuglevel,
  Optional[String]                $distroverpkg      = $::yum::params::distroverpkg,
  Optional[Boolean]               $exactarch         = $::yum::params::exactarch,
  Optional[Boolean]               $gpgcheck          = $::yum::params::gpgcheck,
  Optional[Integer[0]]            $installonly_limit = $::yum::params::installonly_limit,
  Optional[Boolean]               $keepcache         = $::yum::params::keepcache,
  Optional[Stdlib::Absolutepath]  $logfile           = $::yum::params::logfile,
  Optional[Boolean]               $obsoletes         = $::yum::params::obsoletes,
  Optional[Boolean]               $plugins           = $::yum::params::plugins,
) inherits ::yum::params {

  contain ::yum::install
  contain ::yum::config

  Class['::yum::install'] -> Class['::yum::config']
}
