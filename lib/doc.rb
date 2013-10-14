DOC_ROOT = Pathname.new(File.expand_path('../', __FILE__))
DOC_GEM_ROOT = Pathname.new(File.expand_path('../../gems', __FILE__))
$:.unshift((DOC_ROOT).to_s)

require 'doc/code_objects'
require 'doc/generators'

