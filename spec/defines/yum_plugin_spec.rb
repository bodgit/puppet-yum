require 'spec_helper'

describe 'yum::plugin' do

  let(:pre_condition) do
    'include ::yum'
  end

  let(:title) do
    'test'
  end

  let(:params) do
    {
      content: "[main]\nenabled = 1\n"
    }
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_file('/etc/yum/pluginconf.d/test.conf') }
      it { is_expected.to contain_yum__plugin('test') }
    end
  end
end
