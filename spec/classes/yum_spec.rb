require 'spec_helper'

describe 'yum' do

  context 'on unsupported distributions' do
    let(:facts) do
      {
        os: {
          family: 'Unsupported',
        },
      }
    end

    it { is_expected.to compile.and_raise_error(%r{not supported on an Unsupported}) }
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_class('yum') }
      it { is_expected.to contain_class('yum::clean') }
      it { is_expected.to contain_class('yum::config') }
      it { is_expected.to contain_class('yum::install') }
      it { is_expected.to contain_class('yum::params') }
      it { is_expected.to contain_file('/etc/yum.conf') }
      it { is_expected.to contain_file('/etc/yum.repos.d') }
      it { is_expected.to contain_file('/etc/yum/pluginconf.d') }
      it { is_expected.to contain_package('yum') }
      it { is_expected.to contain_resources('yum_conf') }
      it { is_expected.to contain_resources('yumrepo') }
      it { is_expected.to contain_yum_conf('main/keepcache').with_value(0) }
      it { is_expected.to contain_yum_conf('main/cachedir').with_value('/var/cache/yum/$basearch/$releasever') }
      it { is_expected.to contain_yum_conf('main/debuglevel').with_value(2) }
      it { is_expected.to contain_yum_conf('main/exactarch').with_value(1) }
      it { is_expected.to contain_yum_conf('main/gpgcheck').with_value(1) }
      it { is_expected.to contain_yum_conf('main/logfile').with_value('/var/log/yum.log') }
      it { is_expected.to contain_yum_conf('main/obsoletes').with_value(1) }
      it { is_expected.to contain_yum_conf('main/plugins').with_value(1) }

      case facts[:os]['name']
      when 'CentOS'
        it { is_expected.to contain_class('yum::plugin::fastestmirror') }
        it { is_expected.to contain_yum_conf('main/bugtracker_url').with_value('http://bugs.centos.org/set_project.php?project_id=23&ref=http://bugs.centos.org/bug_report_page.php?category=yum') }
        it { is_expected.to contain_yum_conf('main/distroverpkg').with_value('centos-release') }
        it { is_expected.to contain_yum_conf('main/installonly_limit').with_value(5) }
        case facts[:os]['release']['major']
        when '6'
          it { is_expected.to contain_yumrepo('base') }
          it { is_expected.to contain_yumrepo('base-debuginfo') }
          it { is_expected.to contain_yumrepo('c6-media') }
          it { is_expected.to contain_yumrepo('centosplus') }
          it { is_expected.to contain_yumrepo('contrib') }
          it { is_expected.to contain_yumrepo('extras') }
          it { is_expected.to contain_yumrepo('fasttrack') }
          it { is_expected.to contain_yumrepo('updates') }

          if facts[:os]['release']['minor'].to_i > 4
            it { is_expected.to contain_yumrepo('C6.4-base') }
            it { is_expected.to contain_yumrepo('C6.4-centosplus') }
            it { is_expected.to contain_yumrepo('C6.4-contrib') }
            it { is_expected.to contain_yumrepo('C6.4-extras') }
            it { is_expected.to contain_yumrepo('C6.4-updates') }
          end

          if facts[:os]['release']['minor'].to_i > 3
            it { is_expected.to contain_yumrepo('C6.3-base') }
            it { is_expected.to contain_yumrepo('C6.3-centosplus') }
            it { is_expected.to contain_yumrepo('C6.3-contrib') }
            it { is_expected.to contain_yumrepo('C6.3-extras') }
            it { is_expected.to contain_yumrepo('C6.3-updates') }
          end

          if facts[:os]['release']['minor'].to_i > 2
            it { is_expected.to contain_yumrepo('C6.2-base') }
            it { is_expected.to contain_yumrepo('C6.2-centosplus') }
            it { is_expected.to contain_yumrepo('C6.2-contrib') }
            it { is_expected.to contain_yumrepo('C6.2-extras') }
            it { is_expected.to contain_yumrepo('C6.2-updates') }
          end

          if facts[:os]['release']['minor'].to_i > 1
            it { is_expected.to contain_yumrepo('C6.1-base') }
            it { is_expected.to contain_yumrepo('C6.1-centosplus') }
            it { is_expected.to contain_yumrepo('C6.1-contrib') }
            it { is_expected.to contain_yumrepo('C6.1-extras') }
            it { is_expected.to contain_yumrepo('C6.1-updates') }
          end

          if facts[:os]['release']['minor'].to_i > 0
            it { is_expected.to contain_yumrepo('C6.0-base') }
            it { is_expected.to contain_yumrepo('C6.0-centosplus') }
            it { is_expected.to contain_yumrepo('C6.0-contrib') }
            it { is_expected.to contain_yumrepo('C6.0-extras') }
            it { is_expected.to contain_yumrepo('C6.0-updates') }
          end
        when '7'
          it { is_expected.to contain_yumrepo('base') }
          it { is_expected.to contain_yumrepo('base-debuginfo') }
          it { is_expected.to contain_yumrepo('base-source') }
          it { is_expected.to contain_yumrepo('c7-media') }
          it { is_expected.to contain_yumrepo('centosplus') }
          it { is_expected.to contain_yumrepo('centosplus-source') }
          it { is_expected.to contain_yumrepo('cr') }
          it { is_expected.to contain_yumrepo('extras') }
          it { is_expected.to contain_yumrepo('extras-source') }
          it { is_expected.to contain_yumrepo('fasttrack') }
          it { is_expected.to contain_yumrepo('updates') }
          it { is_expected.to contain_yumrepo('updates-source') }

          if facts[:os]['release']['minor'].to_i > 1
            it { is_expected.to contain_yumrepo('C7.1.1503-base') }
            it { is_expected.to contain_yumrepo('C7.1.1503-centosplus') }
            it { is_expected.to contain_yumrepo('C7.1.1503-extras') }
            it { is_expected.to contain_yumrepo('C7.1.1503-fasttrack') }
            it { is_expected.to contain_yumrepo('C7.1.1503-updates') }
          end

          if facts[:os]['release']['minor'].to_i > 0
            it { is_expected.to contain_yumrepo('C7.0.1406-base') }
            it { is_expected.to contain_yumrepo('C7.0.1406-centosplus') }
            it { is_expected.to contain_yumrepo('C7.0.1406-extras') }
            it { is_expected.to contain_yumrepo('C7.0.1406-fasttrack') }
            it { is_expected.to contain_yumrepo('C7.0.1406-updates') }
          end
        end
      when 'RedHat'
        it { is_expected.to contain_class('yum::plugin::rhnplugin') }
        it { is_expected.not_to contain_yum_conf('main/bugtracker_url') }
        it { is_expected.not_to contain_yum_conf('main/distroverpkg') }
        it { is_expected.to contain_yum_conf('main/installonly_limit').with_value(3) }
      else
        it { is_expected.not_to contain_yum_conf('main/bugtracker_url') }
        it { is_expected.not_to contain_yum_conf('main/distroverpkg') }
        it { is_expected.to contain_yum_conf('main/installonly_limit').with_value(3) }
      end
    end
  end
end
