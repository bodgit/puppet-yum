# Manage per-plugin configuration files.
#
# @example Configure an example plugin
#   include ::yum
#   ::yum::plugin { 'example':
#     content => @(EOS/L),
#       [main]
#       enabled = 1
#       | EOS
#   }
#
# @param content The content of the plugin configuration file.
# @param plugin The name of the plugin.
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

  file { "${::yum::pluginconf_dir}/${plugin}.conf":
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => $content,
  }
}
