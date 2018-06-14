require 'spec_helper_acceptance'

describe 'yum::utils' do

  it 'should work with no errors' do

    pp = <<-EOS
      include ::yum
      include ::yum::utils
    EOS

    apply_manifest(pp, catch_failures: true)
    apply_manifest(pp, catch_changes:  true)
  end

  describe package('yum-utils') do
    it { is_expected.to be_installed }
  end
end
