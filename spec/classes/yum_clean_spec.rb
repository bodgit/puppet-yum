require 'spec_helper'

describe 'yum::clean' do

  let(:pre_condition) do
    'include ::yum'
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_class('yum::clean') }
      it { is_expected.to contain_exec('yum clean all') }
    end
  end
end
