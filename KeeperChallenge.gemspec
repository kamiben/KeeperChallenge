# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "keeperchallenge/version"

Gem::Specification.new do |s|
  s.name            = "KeeperChallenge"
  s.version         = '0.0.3'
  s.authors         = ["Benjamin Combe"]
  s.email           = ["benjamin.combe@gmail.com"]
  s.homepage        = "https://github.com/kamiben/KeeperChallenge"
  s.summary         = %q{KeeperChallenge is a prototype scoreboard for running sports contests between friends}
  s.description     = %q{KeeperChallenge is a console based application that will allow the user to add participants, add activities and then determine the winner of the contest.}
  
  s.rubyforge_project = "KeeperChallenge"
  
  s.files           = `git ls-files`.split("\n")
  s.test_files      = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables     = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f)}
  s.require_paths   = ["lib"]
end