require 'sinatra'
require 'dm-core'
require 'dm-migrations'

require File.dirname(__FILE__) +'/keeperchallenge/score'
require File.dirname(__FILE__) +'/keeperchallenge/database'


# Main program
class Main
  def setup_test_users
    @players.update({"Ben" => Player.new("Ben")})
    @players.update({"Claire" => Player.new("Claire")})
    
    @players["Ben"].add_activity("velo", 15, 15, 15)
    @players["Ben"].add_activity("course", 10, 10, 10)
    @players["Claire"].add_activity("course", 20, 20, 20)
    @players["Claire"].add_activity("velo", 12, 12, 12)
    @players["Claire"].add_activity("natation", 30, 20, 10)
  end  
end



  get '/' do
    erb :index,:locals => {:message => ''}
  end

  get '/add-activity' do 
    erb :addactivity_form
  end

  post '/add-activity' do 

    # we need to add an activity
    player = Player.get!(params[:name])
    new_activity = player.activities.new
    new_activity.activitytype = params[:activitytype]
    new_activity.time = params[:time]
    new_activity.cal = params[:cal]
    new_activity.km = params[:km]
    new_activity.created_at = Time.now
    new_activity.updated_at = Time.now
    
    new_activity.save
    message = "Activity successfully added, ID #{new_activity.id} Player #{new_activity.player.name} Type #{new_activity.activitytype} Time : #{new_activity.time}"
    erb :index,:locals => {:message => message}
  end

  get '/add-player' do 
    erb :addplayer_form
  end
  
  post '/add-player' do

    new_user = Player.new
    new_user.name = params[:name]
    new_user.created_at = Time.now
    new_user.save
    message = "Player successfully added, Name : #{new_user.name} Creation date : #{new_user.created_at}."
    #puts User.get(:id => 1).name
    erb :index,:locals => {:message => message}
  end

  get '/player/:id' do
    @player = Player.get(params[:id])
    @player.score += 100
    @player.save
    erb :edit_player

  end

  get '/scoreboard' do
    @activities_type = ["velo", "course" , "marche",  "natation"]
    @players = Player.all
    score = Score.new(@players)
    score.compute(@activities_type)
    erb :display_scores, :locals => {:players => @players}
  end

  get '/cleardb' do 

  end

