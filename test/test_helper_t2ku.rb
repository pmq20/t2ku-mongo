# This is the common test helper for the tests that
# does not entail loading the whole rails environment(which costs time!)

require 'minitest/autorun'
require 'active_support/all'
require 'pry'
require 't2ku'
$test_base_dir = File.expand_path('../sandbox/t2ku',__FILE__)
puts "Running tests inside #{$test_base_dir}"