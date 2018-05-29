require 'spec_helper'

describe 'yum::variable' do

  let(:pre_condition) do
    'include ::yum'
  end

  let(:title) do
    'test'
  end

  let(:params) do
    {
      value: 'test',
    }
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_file('/etc/yum/vars/test') }
      it { is_expected.to contain_yum__variable('test') }
    end
  end
end
