require 'spec_helper'

describe 'yum::plugin::security' do

  let(:pre_condition) do
    'include ::yum'
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      case facts[:os]['release']['major']
      when '6'
        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_file('/etc/yum/pluginconf.d/security.conf') }
        it { is_expected.to contain_package('yum-plugin-security') }
        it { is_expected.to contain_yum__plugin('security') }
      else
        it { is_expected.to compile.and_raise_error(%r{Evaluation Error}) }
      end
    end
  end
end
