$:.unshift(File.dirname(__FILE__) + '/../app')
$:.unshift(File.dirname(__FILE__) + '/../lib')
$:.unshift(File.dirname(__FILE__))

require 'bundler'
Bundler.require(:default, :development, :test)

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
end
