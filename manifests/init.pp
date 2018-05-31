# Manages the configuration of Yum.
#
# @example Declaring the class
#   include ::yum
#
# @example Don't purge unmanaged repositories
#   class { '::yum':
#     purge_repos => false,
#   }
#
# @param bugtracker_url
# @param cachedir
# @param conf_dir The top-level configuration directory, usually `/etc/yum`.
# @param conf_file The path to the main configuration file, usually
#   `/etc/yum.conf`.
# @param debuglevel
# @param default_plugins The default set of plugins to manage.
# @param distroverpkg
# @param exactarch
# @param fssnap_dir
# @param gpgcheck
# @param groups
# @param installonly_limit
# @param keepcache
# @param logfile
# @param obsoletes
# @param package_name The name of the package.
# @param pluginconf_dir
# @param plugins
# @param protected
# @param protected_dir
# @param purge_repos Whether to purge unmanaged repositories or not.
# @param repo_dir
# @param repos The default set of repositories.
# @param variables
# @param variable_dir
#
# @see puppet_classes::yum::plugin::etckeeper ::yum::plugin::etckeeper
# @see puppet_classes::yum::plugin::fastestmirror ::yum::plugin::fastestmirror
# @see puppet_classes::yum::plugin::kabi ::yum::plugin::kabi
# @see puppet_classes::yum::plugin::priorities ::yum::plugin::priorities
# @see puppet_classes::yum::plugin::protectbase ::yum::plugin::protectbase
# @see puppet_classes::yum::plugin::rhnplugin ::yum::plugin::rhnplugin
# @see puppet_classes::yum::plugin::security ::yum::plugin::security
# @see puppet_classes::yum::plugin::versionlock ::yum::plugin::versionlock
# @see puppet_defined_types::yum::group ::yum::group
# @see puppet_defined_types::yum::plugin ::yum::plugin
# @see puppet_defined_types::yum::protect ::yum::protect
# @see puppet_defined_types::yum::variable ::yum::variable
#
# @since 1.0.0
class yum (
  Stdlib::Absolutepath            $conf_dir          = $::yum::params::conf_dir,
  Stdlib::Absolutepath            $conf_file         = $::yum::params::conf_file,
  Hash[String, Hash[String, Any]] $default_plugins   = $::yum::params::default_plugins,
  Optional[Stdlib::Absolutepath]  $fssnap_dir        = $::yum::params::fssnap_dir,
  Hash[String, Hash[String, Any]] $groups            = $::yum::params::groups,
  String                          $package_name      = $::yum::params::package_name,
  Stdlib::Absolutepath            $pluginconf_dir    = $::yum::params::pluginconf_dir,
  Hash[String, Hash[String, Any]] $protected         = $::yum::params::protected,
  Stdlib::Absolutepath            $protected_dir     = $::yum::params::protected_dir,
  Boolean                         $purge_repos       = $::yum::params::purge_repos,
  Stdlib::Absolutepath            $repo_dir          = $::yum::params::repo_dir,
  Hash[String, Hash[String, Any]] $repos             = $::yum::params::repos,
  Stdlib::Absolutepath            $variable_dir      = $::yum::params::variable_dir,
  Hash[String, Hash[String, Any]] $variables         = $::yum::params::variables,
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
