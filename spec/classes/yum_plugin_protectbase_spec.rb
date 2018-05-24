require 'spec_helper'

describe 'yum::plugin::protectbase' do

  let(:pre_condition) do
    'include ::yum'
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_file('/etc/yum/pluginconf.d/protectbase.conf') }
      it { is_expected.to contain_package('yum-plugin-protectbase') }
      it { is_expected.to contain_yum__plugin('protectbase') }
    end
  end
end
