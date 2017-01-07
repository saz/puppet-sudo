require 'puppet'
Facter.add('sudoversion') do
  setcode do
    if Facter::Util::Resolution.which('rpm')
      Facter::Util::Resolution.exec('rpm -q sudo --qf \'%{VERSION}\'')
    elsif Facter::Util::Resolution.which('sudo') && Facter::Util::Resolution.which('awk')
      Facter::Util::Resolution.exec('sudo -V | awk \'/Sudo version/ {print $3}\'')
    end
  end
end
