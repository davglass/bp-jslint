require 'uri'
require 'net/http'

bp_require 'json/json'

res = Net::HTTP.get_response(URI.parse('http://yui.yahooapis.com/2.5.2/build/editor/editor-beta.js'))


