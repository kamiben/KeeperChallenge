require 'test/unit'

class MyUnitTest < Test::Unit::TestCase

  def setup
    puts "setup"
  end
  
  def teardown
    puts "teardown"
  end

  def test_basic
    puts "I ran"
  end 
  
end