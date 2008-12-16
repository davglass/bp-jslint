#require 'uri'
#require 'net/http'

#bp_require 'JSONRequestInstance'


#
# 
class JSLint
    # an initialize function is _required_
    def initialize(args)
    end

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
            # valid types will be documented on our site shortly,
            # we'll also improve log messages to clearly indicate when you
            # specify an invalid type.  !array, but list
            'type' => 'list',
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
