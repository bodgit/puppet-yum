# Manage entries in the Yum versionlock plugin lock list.
#
# @example Exclude a particular package/version from being installed
#   include ::yum
#   include ::yum::plugin::versionlock
#   ::yum::plugin::versionlock::entry { 'kernel':
#     packages => [
#       '!0:kernel-2.6.32-696.3.2.el6.*',
#     ],
#   }
#
# @param packages
#
# @see puppet_classes::yum::plugin::versionlock
#
# @since 1.0.0
define yum::plugin::versionlock::entry (
  Array[String, 1] $packages,
) {

  if ! defined(Class['::yum::plugin::versionlock']) {
    fail('You must include the yum::plugin::versionlock base class before using any yum::plugin::versionlock defined resources')
  }

  ::concat::fragment { "${::yum::plugin::versionlock::locklist} ${title}":
    content => "${join($packages, "\n")}\n",
    target  => $::yum::plugin::versionlock::locklist,
  }
}
