# Mark certain packages as protected.
#
# @example Protect a package
#   include ::yum
#   ::yum::protect { 'systemd': }
#
# @param packages
#
# @see puppet_classes::yum ::yum
#
# @since 1.0.0
define yum::protect (
  Array[String, 1] $packages = [$title],
) {

  if ! defined(Class['::yum']) {
    fail('You must include the yum base class before using any yum defined resources')
  }

  file { "${::yum::protected_dir}/${title}.conf":
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => "${join($packages, "\n")}\n",
  }
}
