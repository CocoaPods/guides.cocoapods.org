DOC_ROOT = Pathname.new(File.expand_path('../', __FILE__))
$:.unshift((DOC_ROOT).to_s)

require 'doc/code_objects'
require 'doc/generators'
