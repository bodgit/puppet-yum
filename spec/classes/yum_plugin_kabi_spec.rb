require 'spec_helper'

describe 'yum::plugin::kabi' do

  let(:pre_condition) do
    'include ::yum'
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_file('/etc/yum/pluginconf.d/kabi.conf') }
      it { is_expected.to contain_package('kabi-yum-plugins') }
      it { is_expected.to contain_yum__plugin('kabi') }
    end
  end
end
