# frozen_string_literal: true

require 'puppet'
Facter.add(:sudo) do
  confine :os do |os|
    os['family'] != 'windows'
  end
  setcode do
    if Facter::Core::Execution.which('sudo')
      sudo_version = Facter::Core::Execution.execute('sudo -V 2>&1')
      match = %r{^(Sudo version|sudo-rs)\s+([\w.]+)}i.match(sudo_version)
      match&.then do |sudo_match|
        {
          'kind' => sudo_match[1].casecmp?('sudo-rs') ? 'sudo-rs' : 'sudo',
          'version' => sudo_match[2],
        }
      end
    elsif Facter::Core::Execution.which('rpm')
      {
        'kind' => 'sudo',
        'version' => Facter::Core::Execution.execute('rpm -q sudo --qf \'%{VERSION}\''),
      }
    elsif Facter::Core::Execution.which('dpkg-query')
      {
        'kind' => 'sudo',
        'version' => Facter::Core::Execution.execute('dpkg-query -W -f=\'${Version}\\n\' sudo'),
      }
    end
  end
end
