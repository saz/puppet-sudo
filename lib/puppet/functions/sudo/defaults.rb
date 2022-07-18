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
    unless args.nil?
      args.each do |tuple|
        if tuple.size == 2
          res.concat(defaults_entry(tuple[0], tuple[1]))
        else
          raise "Unsupported number of arguments #{args.size}: #{args.inspect}"
        end
      end
    else
      raise "Unsupported number of arguments #{args.size}: #{args.inspect}"
    end

    res
  end

  def defaults_entry(key, config)
    entry = "Defaults\t#{key}"

    unless config.nil?
      if config.key? 'list'
        entry.concat("#{config['list']}")
      end

      operator = '='
      if config.key? 'operator'
        operator = config['operator']
      end

      if config.key? 'value'
        entry.concat("#{operator}#{config['value']}")
      end
    end


    entry.concat("\n")
  end
end