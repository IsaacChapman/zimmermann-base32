require "rubygems"
require "minitest/autorun"

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require "simplecov"
SimpleCov.start

begin
  # Coveralls is marked as an _optional_ dependency, so don't
  # throw a fit if it's not there.
  require "coveralls"
  Coveralls.wear!
rescue LoadError
end

require "rantly"
require "rantly/minitest_extensions"
