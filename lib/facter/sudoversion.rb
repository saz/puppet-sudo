require 'puppet'
Facter.add("sudoversion") do
  setcode do
    if Facter::Util::Resolution.which('rpm')
      sudoversion = Facter::Util::Resolution.exec('rpm -q sudo --nosignature --nodigest --qf \'%{VERSION}\'')
    end
  end
end
