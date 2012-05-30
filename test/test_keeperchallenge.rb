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
  
  def test_add_activity
    player = Player.new("Ben")
    
    # test new activity
    player.add_activity("Velo", 1, 1, 1)
 
    assert_equal(player.activities[0].type,"Velo")
    assert_equal(player.activities[0].km,1)
    assert_equal(player.activities[0].cal,1)
    assert_equal(player.activities[0].time,1)
    
  end 
  
  def test_list_by_type
    player = Player.new("Ben")
    player.add_activity("Velo", 1, 1, 1)

    assert_equal(player.activities_taken("Velo"),[player.activities[0]])
    
  end
  
  def test_count_activities_type
    player = Player.new("Ben")
    player.add_activity("Velo", 1, 1, 1)
    
    assert_equal(player.count_activity_type,1)
  end

  def test_score
    setup_test_users
    @activities_type = ["velo", "course" , "marche",  "natation"]
    score = Score.new(@players)
    
    score.compute(@activities_type)
    assert_equal(@players["Ben"].score,11)
    assert_equal(@players["Claire"].score,21)
    
    @players.clear
  end
  
  def test_find_best_score

    score = Score.new(@players)
    total_time = {}
    total_time['Ben'] = 10
    total_time['Claire'] = 5
    assert_equal(score.find_best_score(total_time),'Ben')

  end
  
  def reset_player_score
    player = Player.new("Ben")
    player.score = 10
    players=[player]
    assert_equal(player.score,10)
    score = Score.new(players)
    score.reset_player_score
    assert_equal(player.score,0)
    
  end
  
  
  def setup_test_users
    @players ={}
    @players.update({"Ben" => Player.new("Ben")})
    @players.update({"Claire" => Player.new("Claire")})
    
    @players["Ben"].add_activity("velo", 15, 15, 15)
    @players["Ben"].add_activity("course", 10, 10, 10)
    @players["Claire"].add_activity("course", 20, 20, 20)
    @players["Claire"].add_activity("velo", 12, 12, 12)
    @players["Claire"].add_activity("natation", 30, 20, 10)
  end
  
  
  def test_load
      players = {}
      @folder_path = "../lib/keeperchallenge/db/"
      puts @folder_path
      player_file = File.open("#{@folder_path}Ben",'w')
      activity_string = "Velo 1 1 1\n"
      player_file.write(activity_string)
      player_file.close
      
      db = FileDatabase.new
      
      db.load(players)
      
      assert_equal(players["Ben"].name,"Ben")
      assert_equal(players["Ben"].activities[0].type,"Velo")
      
      db.clear
      
  end
  
  
  def test_save
    setup_test_users
    db = FileDatabase.new     
    db.save(@players)    
    index = 0
    Dir.foreach(db.folder_path) do |file|
      if !(file =='.' || file == '..')
        if index == 0
          assert_equal(file,'Ben')
        elsif index ==1 
          assert_equal(file,'Claire')
        end
      end
      index += 1
    end
    
    db.clear
  end
  
end