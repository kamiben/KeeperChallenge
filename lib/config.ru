require "sinatra"
require File.dirname(__FILE__) +'/KeeperChallenge'
set :port, 4567
set :environment, :production

run Sinatra::Application

