require 'puppet'
Facter.add(:sudoversion) do
  setcode do
    if Facter::Util::Resolution.which('sudo')
      sudoversion = Facter::Util::Resolution.exec('sudo -V 2>&1')
      %r{^Sudo version ([\w\.]+)}.match(sudoversion)[1]
    elsif Facter::Util::Resolution.which('rpm')
      Facter::Util::Resolution.exec('rpm -q sudo --qf \'%{VERSION}\'')
    elsif Facter::Util::Resolution.which('dpkg-query')
      Facter::Util::Resolution.exec('dpkg-query -W -f=\'${Version}\n\' sudo')
    end
  end
end
