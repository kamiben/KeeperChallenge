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
    user_input.input = StringIO.new("Ben\n")
    display = Display.new(user_input)
    player1 = Player.new("Ben")
    player2 = Player.new("Claire")
    players = {"Ben" =>player1,"Claire" =>player2}
    
    assert_equal(display.select_player(players),"Ben")
    
    # test add player 
    user_input.input = StringIO.new("Cyril")
    assert_equal(display.add_player(),"Cyril")
    
    
  end

  def test_main
    game = Main.new()
    game.setup_test_users
    # quite hard to test a console based program that loops through the main. 
    # this test is on hold as not vital to the aim to the app
  end 
  
  def test_activity
    #Only accessors here ! Nothing to test
  end
  
  def test_player
    player = Player.new("Ben")
    
    # test new activity
    player.add_activity("Velo", 1, 1, 1)
 
    assert_equal(player.activities[0].type,"Velo")
    assert_equal(player.activities[0].km,1)
    assert_equal(player.activities[0].cal,1)
    assert_equal(player.activities[0].time,1)
    
    # test list_by_type
    assert_equal(player.activities_taken("Velo"),[player.activities[0]])
    
    # count_activities_type
    assert_equal(player.count_activity_type,1)
    
  end


  
end