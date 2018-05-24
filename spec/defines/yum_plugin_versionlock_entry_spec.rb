require 'spec_helper'

describe 'yum::plugin::versionlock::entry' do

  let(:pre_condition) do
    'include ::yum include ::yum::plugin::versionlock'
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

      it { is_expected.to contain_concat__fragment('/etc/yum/pluginconf.d/versionlock.list test').with_content("foo\nbar\n") }
      it { is_expected.to contain_yum__plugin__versionlock__entry('test') }
    end
  end
end
