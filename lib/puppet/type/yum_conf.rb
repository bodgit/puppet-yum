Puppet::Type.newtype(:yum_conf) do
  desc <<-DESC
Manage a yum.conf setting.
@example Using the type
  yum_conf { 'main/distroverpkg':
    value => 'centos-release',
  }
DESC

  ensurable

  newparam(:name, :namevar => true) do
    desc 'Section/setting name to manage from yum.conf'
    # namevar should be of the form section/setting
    newvalues(/\S+\/\S+/)
  end

  newproperty(:value) do
    desc 'The value of the setting to define'
    munge do |v|
      v.to_s.strip
    end
  end
end
