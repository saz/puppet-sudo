# frozen_string_literal: true

require 'puppet'
Facter.add(:sudoversion) do
  confine :os do |os|
    os['family'] != 'windows'
  end
  setcode do
    if Facter::Core::Execution.which('sudo')
      sudoversion = Facter::Core::Execution.execute('sudo -V 2>&1')
      match = %r{^(?:Sudo version|sudo-rs)\s+([\w.]+)}i.match(sudoversion)
      match[1] if match
    elsif Facter::Core::Execution.which('rpm')
      Facter::Core::Execution.execute('rpm -q sudo --qf \'%{VERSION}\'')
    elsif Facter::Core::Execution.which('dpkg-query')
      Facter::Core::Execution.execute('dpkg-query -W -f=\'${Version}\n\' sudo')
    end
  end
end
