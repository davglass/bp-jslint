require 'uri'
require 'net/http'
require 'tempfile'

bp_require 'json/json'


#
# 
class JSLint
    @callback = nil
    # an initialize function is _required_
    def initialize(args)
    end

    def _lint(txt, url)
        #@callback.invoke('_lint')
        res2 = Net::HTTP.post_form(URI.parse('http://jslint.davglass.com/'), { 'source' => txt })
        puts res2.body
        
        #@callback.invoke(res2.body)
        obj = JSON.parse(res2.body)
        if url
            obj['url'] = url
        end
        @callback.invoke(obj)
    end

    def _getText(file)
        #Here I should be able to run jslint locally if they have java installed
        # if they don't I can fall back to the web service
        #@callback.invoke('_getText')
        #tmpFil = Tempfile.new('jslint')
        #tFile = File.new(tmpFil.path, "w+")

        res = Net::HTTP.get_response(URI.parse(file))
        #tFile.puts res.body
        _lint(res.body, file)
    end

    def jslint(bp, args)
        #
        @callback = args['callback']
        args['callback'].invoke(args['scripts'])
        #@callback.invoke('HERE #1')
        #args['scripts'].each do |script|
        for script in args['scripts']
            #@callback.invoke('HERE #2')
            args['callback'].invoke(script)
            args['callback'].invoke(script['src'])
            if script['src']
                _getText(script['src'])
            end
            if script['txt']
                _lint(script['txt'])
            end
        end
    end

end

rubyCoreletDefinition = {
  'class' => "JSLint",
  'name'  => "JSLint",
  'major_version' => 0,
  'minor_version' => 0,
  'micro_version' => 2,
  'documentation' => 
    'TODO',

  'functions' =>
  [
    {
      'name' => 'jslint',
      'documentation' => "Performs JSLint on all scripts on the page.",
      'arguments' =>
      [
         {
            'name' => 'scripts',
            # valid types will be documented on our site shortly,
            # we'll also improve log messages to clearly indicate when you
            # specify an invalid type.  !array, but list
            'type' => 'list',
            'required' => true,
            'documentation' => 'The list of scripts to check, either the text or a URL'
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
