require 'spec_helper'

describe 'yum::protect' do

  let(:pre_condition) do
    'include ::yum'
  end

  let(:title) do
    'test'
  end

  let(:params) do
    {
      packages: [
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

      it { is_expected.to contain_file('/etc/yum/protected.d/test.conf').with_content("foo\nbar\n") }
      it { is_expected.to contain_yum__protect('test') }
    end
  end
end
