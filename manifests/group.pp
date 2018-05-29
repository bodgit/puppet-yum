# Manage version groups.
#
# @example Define an example group
#   include ::yum
#   ::yum::group { 'yum':
#     run_with_packages => true,
#     pkglist           => [
#       'glibc',
#       'sqlite',
#       'libcurl',
#       'nss',
#       'yum-metadata-parser',
#       'rpm',
#       'rpm-libs',
#       'rpm-python',
#       'python',
#       'python-iniparse',
#       'python-urlgrabber',
#       'python-pycurl',
#     ],
#   }
#
# @param group
# @param pkglist
# @param run_with_packages
#
# @see puppet_classes::yum ::yum
#
# @since 1.0.0
define yum::group (
  Array[String, 1]  $pkglist,
  String            $group             = $title,
  Optional[Boolean] $run_with_packages = undef,
) {

  ensure_resource('concat', "${::yum::conf_dir}/version-groups.conf", {
    owner => 0,
    group => 0,
    mode  => '0644',
    warn  => "# !!! Managed by Puppet !!!\n",
  })

  ::concat::fragment { "${::yum::conf_dir}/version-groups.conf ${group}":
    content => template("${module_name}/version-groups.conf.erb"),
    target  => "${::yum::conf_dir}/version-groups.conf",
  }
}
