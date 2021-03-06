require 'spec_helper'

describe 'yum::plugin::etckeeper' do

  let(:pre_condition) do
    'include ::yum'
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_class('etckeeper') }
      it { is_expected.to contain_file('/etc/yum/pluginconf.d/etckeeper.conf') }
      it { is_expected.to contain_yum__plugin('etckeeper') }
    end
  end
end
