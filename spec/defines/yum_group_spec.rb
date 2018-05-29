require 'spec_helper'

describe 'yum::group' do

  let(:pre_condition) do
    'include ::yum'
  end

  let(:title) do
    'test'
  end

  let(:params) do
    {
      pkglist: [
        'foo',
        'bar',
      ],
    }
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_concat('/etc/yum/version-groups.conf') }
      it { is_expected.to contain_concat__fragment('/etc/yum/version-groups.conf test') }
      it { is_expected.to contain_yum__group('test') }
    end
  end
end
