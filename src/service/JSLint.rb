#require 'uri'
#require 'net/http'

#bp_require 'JSONRequestInstance'


#
# 
class JSLint

    def jslint(bp, args)
        #
        bp.complete(args)
    end

end

rubyCoreletDefinition = {
  'class' => "JSLint",
  'name'  => "JSLint",
  'major_version' => 0,
  'minor_version' => 0,
  'micro_version' => 1,
  'documentation' => 
    'TODO',

  'functions' =>
  [
    {
      'name' => 'jslint',
      'documentation' => "TODO",
      'arguments' =>
      [
         {
            'name' => 'scripts',
            'type' => 'array',
            'required' => true,
            'documentation' => 'todo'
          },
          {
            'name' => 'callback',
            'type' => 'callback',
            'required' => false,
            'documentation' => 'the callback to send a hello message to'
          }
      ]
    }
  ] 
}
