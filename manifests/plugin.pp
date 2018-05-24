# Description
#
# @example
#
# @param content
# @param plugin
#
# @see puppet_classes::yum ::yum
#
# @since 1.0.0
define yum::plugin (
  String $content,
  String $plugin  = $title,
) {

  if ! defined(Class['::yum']) {
    fail('You must include the yum base class before using any yum defined resources')
  }

  file { "/etc/yum/pluginconf.d/${plugin}.conf":
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => $content,
  }
}
