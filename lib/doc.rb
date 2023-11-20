DOC_ROOT = Pathname.new(__dir__)
$:.unshift((DOC_ROOT).to_s)

require 'doc/code_objects'
require 'doc/generators'
