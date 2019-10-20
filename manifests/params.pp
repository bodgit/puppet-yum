# @!visibility private
class yum::params {

  case $::facts['os']['family'] {
    'RedHat': {
      $cachedir                   = '/var/cache/yum/$basearch/$releasever'
      $conf_dir                   = '/etc/yum'
      $conf_file                  = '/etc/yum.conf'
      $debuglevel                 = 2
      $exactarch                  = true
      $fastestmirror_package_name = 'yum-plugin-fastestmirror'
      $gpgcheck                   = true
      $groups                     = {
        'yum' => {
          'run_with_packages' => true,
          'pkglist'           => [
            'glibc',
            'sqlite',
            'libcurl',
            'nss',
            'yum-metadata-parser',
            'rpm',
            'rpm-libs',
            'rpm-python',
            'python',
            'python-iniparse',
            'python-urlgrabber',
            'python-pycurl',
          ],
        },
      }
      $kabi_package_name          = 'kabi-yum-plugins'
      $keepcache                  = false
      $logfile                    = '/var/log/yum.log'
      $obsoletes                  = true
      $package_name               = 'yum'
      $pluginconf_dir             = "${conf_dir}/pluginconf.d"
      $plugins                    = true
      $priorities_package_name    = 'yum-plugin-priorities'
      $protectbase_package_name   = 'yum-plugin-protectbase'
      $protected_dir              = "${conf_dir}/protected.d"
      $purge_repos                = true
      $repo_dir                   = '/etc/yum.repos.d'
      $rhnplugin_package_name     = 'yum-rhn-plugin'
      $utils_package_name         = 'yum-utils'
      $variable_dir               = "${conf_dir}/vars"
      $versionlock_package_name   = 'yum-plugin-versionlock'

      case $::facts['os']['release']['major'] {
        '6': {
          $fssnap_dir            = undef
          $protected             = {}
          $security_package_name = 'yum-plugin-security'
          $versionlock_show_hint = undef
        }
        default: {
          $fssnap_dir            = "${conf_dir}/fssnap.d"
          $protected             = {
            'systemd' => {},
          }
          $versionlock_show_hint = true
        }
      }

      case $::facts['os']['name'] {
        'CentOS': {
          $distroverpkg      = 'centos-release'
          $installonly_limit = 5
          $variables         = {
            'infra' => {
              'value' => 'genclo',
            },
          }

          case $::facts['os']['release']['major'] {
            '6': {
              $bugtracker_url  = 'http://bugs.centos.org/set_project.php?project_id=19&ref=http://bugs.centos.org/bug_report_page.php?category=yum'
              $default_plugins = {
                'fastestmirror' => {},
                'security'      => {},
              }
              $repos           = ['base', 'centosplus', 'contrib', 'extras', 'updates'].reduce({}) |Hash $memo, String $repo| {
                $descr = $repo ? {
                  'centosplus' => 'Plus',
                  default      => capitalize($repo),
                }
                $label = $repo ? {
                  'base'  => 'os',
                  default => $repo,
                }

                $current = {
                  $repo => {
                    'ensure'     => 'present',
                    'descr'      => "CentOS-\$releasever - ${descr}",
                    'enabled'    => $repo ? {
                      'centosplus' => 0,
                      'contrib'    => 0,
                      default      => undef,
                    },
                    'gpgcheck'   => 1,
                    'gpgkey'     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
                    'mirrorlist' => "http://mirrorlist.centos.org/?release=\$releasever&arch=\$basearch&repo=${label}&infra=\$infra",
                  },
                }

                $previous = $::facts['os']['release']['minor'] ? {
                  '0'     => {},
                  default => range(0, Integer($::facts['os']['release']['minor']) - 1).reduce({}) |Hash $memo, Integer $minor| {
                    $descr = $repo ? {
                      'centosplus' => 'CentOSPlus',
                      default      => capitalize($repo),
                    }

                    $memo + {
                      "C6.${minor}-${repo}" => {
                        'ensure'   => 'present',
                        'baseurl'  => "http://vault.centos.org/6.${minor}/${label}/\$basearch/",
                        'descr'    => "CentOS-6.${minor} - ${descr}",
                        'enabled'  => 0,
                        'gpgcheck' => 1,
                        'gpgkey'   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
                      }
                    }
                  },
                }

                $memo + $current + $previous
              } + {
                'base-debuginfo' => {
                  'ensure'   => 'present',
                  'baseurl'  => 'http://debuginfo.centos.org/6/$basearch/',
                  'descr'    => 'CentOS-6 - Debuginfo',
                  'enabled'  => 0,
                  'gpgcheck' => 1,
                  'gpgkey'   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-Debug-6',
                },
                'c6-media'       => {
                  'ensure'   => 'present',
                  'baseurl'  => "file:///media/CentOS/\n        file:///media/cdrom/\n        file:///media/cdrecorder/",
                  'descr'    => 'CentOS-$releasever - Media',
                  'enabled'  => 0,
                  'gpgcheck' => 1,
                  'gpgkey'   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
                },
                'fasttrack'      => {
                  'ensure'     => 'present',
                  'descr'      => 'CentOS-6 - fasttrack',
                  'enabled'    => 0,
                  'gpgcheck'   => 1,
                  'gpgkey'     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
                  'mirrorlist' => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=fasttrack&infra=$infra',
                },
              }
            }
            '7': {
              $bugtracker_url  = 'http://bugs.centos.org/set_project.php?project_id=23&ref=http://bugs.centos.org/bug_report_page.php?category=yum'
              $default_plugins = {
                'fastestmirror' => {},
              }
              $repos           = ['base', 'centosplus', 'extras', 'fasttrack', 'updates'].reduce({}) |Hash $memo, String $repo| {
                $descr = $repo ? {
                  'centosplus' => 'Plus',
                  'fasttrack'  => $repo,
                  default      => capitalize($repo),
                }
                $label = $repo ? {
                  'base'  => 'os',
                  default => $repo,
                }

                $current = {
                  $repo => {
                    'ensure'     => 'present',
                    'descr'      => $repo ? {
                      'fasttrack' => "CentOS-7 - ${descr}",
                      default     => "CentOS-\$releasever - ${descr}",
                    },
                    'enabled'    => $repo ? {
                      'centosplus' => 0,
                      'fasttrack'  => 0,
                      default      => undef,
                    },
                    'gpgcheck'   => 1,
                    'gpgkey'     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7',
                    'mirrorlist' => "http://mirrorlist.centos.org/?release=\$releasever&arch=\$basearch&repo=${label}&infra=\$infra",
                  },
                }

                $source = $repo ? {
                  'fasttrack' => {},
                  default     => {
                    "${repo}-source" => {
                      'ensure'   => 'present',
                      'baseurl'  => "http://vault.centos.org/centos/\$releasever/${label}/Source/",
                      'descr'    => "CentOS-\$releasever - ${descr} Sources",
                      'enabled'  => 0,
                      'gpgcheck' => 1,
                      'gpgkey'   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7',
                    },
                  },
                }

                $previous = $::facts['os']['release']['minor'] ? {
                  '0'     => {},
                  default => range(0, Integer($::facts['os']['release']['minor']) - 1).reduce({}) |Hash $memo, Integer $minor| {
                    $release = $minor ? {
                      0 => '1406',
                      1 => '1503',
                      2 => '1511',
                      3 => '1611',
                      4 => '1708',
                      5 => '1804',
                      6 => '1810',
                      7 => '1908',
                    }

                    $descr = $repo ? {
                      'centosplus' => 'CentOSPlus',
                      default      => capitalize($repo),
                    }

                    $memo + {
                      "C7.${minor}.${release}-${repo}" => {
                        'ensure'   => 'present',
                        'baseurl'  => "http://vault.centos.org/7.${minor}.${release}/${label}/\$basearch/",
                        'descr'    => "CentOS-7.${minor}.${release} - ${descr}",
                        'enabled'  => 0,
                        'gpgcheck' => 1,
                        'gpgkey'   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7',
                      }
                    }
                  },
                }

                $memo + $current + $source + $previous
              } + {
                'base-debuginfo' => {
                  'ensure'   => 'present',
                  'baseurl'  => 'http://debuginfo.centos.org/7/$basearch/',
                  'descr'    => 'CentOS-7 - Debuginfo',
                  'enabled'  => 0,
                  'gpgcheck' => 1,
                  'gpgkey'   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-Debug-7',
                },
                'c7-media'       => {
                  'ensure'   => 'present',
                  'baseurl'  => "file:///media/CentOS/\n        file:///media/cdrom/\n        file:///media/cdrecorder/",
                  'descr'    => 'CentOS-$releasever - Media',
                  'enabled'  => 0,
                  'gpgcheck' => 1,
                  'gpgkey'   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7',
                },
                'cr'             => {
                  'ensure'   => 'present',
                  'baseurl'  => 'http://mirror.centos.org/centos/$releasever/cr/$basearch/',
                  'descr'    => 'CentOS-$releasever - cr',
                  'enabled'  => 0,
                  'gpgcheck' => 1,
                  'gpgkey'   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7',
                },
              }
            }
            default: {
              fail("The ${module_name} module is not supported on ${::facts['os']['name']} ${::facts['os']['release']['major']}.")
            }
          }
        }
        'RedHat': {
          $bugtracker_url    = undef
          $default_plugins   = {
            'rhnplugin' => {},
          }
          $distroverpkg      = undef
          $installonly_limit = 3
          $repos             = {} # FIXME
          $variables         = {}
        }
        default: {
          $bugtracker_url    = undef
          $default_plugins   = {} # FIXME
          $distroverpkg      = undef
          $installonly_limit = 3
          $repos             = {} # FIXME
          $variables         = {}
        }
      }
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::facts['os']['family']} based system.")
    }
  }
}
