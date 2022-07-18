# sudo defaults
type Sudo::Defaults = Hash[String, Variant[Struct[{
                                      Optional[list] => String,
                                      Optional[operator] => Sudo::Defaults_operator,
                                      Optional[value] => Variant[String,Numeric],
                                  }], Undef]
                          ]
