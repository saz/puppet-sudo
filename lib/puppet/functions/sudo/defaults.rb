# frozen_string_literal: false

# Formats sudoers defaults config see https://linux.die.net/man/5/sudoers
#
#     Default_Type ::= 'Defaults' |
#                      'Defaults' '@' Host_List |
#                      'Defaults' ':' User_List |
#                      'Defaults' '!' Cmnd_List |
#                      'Defaults' '>' Runas_List
#
#     Default_Entry ::= Default_Type Parameter_List
#
#     Parameter_List ::= Parameter |
#                        Parameter ',' Parameter_List
#
#     Parameter ::= Parameter '=' Value |
#                   Parameter '+=' Value |
#                   Parameter '-=' Value |
#                   '!'* Parameter
#
# The function is passed an Array of Tuples
# e.g. [["env_reset", nil]]
#      [["mailto", {"value" => root}]]
Puppet::Functions.create_function(:'sudo::defaults') do
  def defaults(*args)
    res = ''
    raise "Unsupported number of arguments #{args.size}: #{args.inspect}" if args.nil?

    args.each do |tuple|
      raise "Unsupported number of arguments #{args.size}: #{args.inspect}" unless tuple.size == 2

      res.concat(defaults_entry(tuple[0], tuple[1]))
    end

    res
  end

  def defaults_entry(key, config)
    entry = "Defaults\t#{key}"

    unless config.nil?
      entry.concat((config['list']).to_s) if config.key? 'list'

      operator = '='
      operator = config['operator'] if config.key? 'operator'

      if config.key? 'value'
        val = config['value'].is_a?(String) ? "\"#{config['value']}\"" : config['value']

        entry.concat("#{operator}#{val}")
      end
    end

    entry.concat("\n")
  end
end
