require 'test/unit'
require 'stringio'
require_relative '../lib/keeperchallenge'

class MyUnitTest < Test::Unit::TestCase

  def test_user_input
    # STDIN should be returned by get_input
    user_input = UserInput.new()
    text_input = StringIO.new("velo\n")
    user_input.input = text_input
    assert_equal(user_input.get_input,"velo")
 
  end
  
  def test_display
    # test select_player
    user_input = UserInput.new()
    user_input.input = StringIO.new("1\n")
    display = Display.new(user_input)
    player1 = Player.new("Ben")
    player2 = Player.new("Claire")
    players = [player1,player2]
    
    assert_equal(display.select_player(players),0)
    
    # test add player 
    user_input.input = StringIO.new("Cyril")
    assert_equal(display.add_player(),"Cyril")
    
    
  end

  def test_main
    game = Main.new()
    game.setup_test_users

    # game should quit

  end 
  
end