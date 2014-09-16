require_relative './jukebox.rb'
require_relative './song_library'
require 'pry'

def run
  puts "Welcome to Ruby Console Jukebox!" 
  loop do
  puts "Enter a command to continue. Type 'help' for a list of commands."
    input = command.downcase
    if input != "exit" 
      run_command(input) # unless command.downcase == "exit"
    else 
      break
    end  
  end
end

def command
  gets.strip
end

def run_command(command)
  case command
    when "help"
      show_help
    else
      jukebox(command)
  end
end

def show_help
  help = "Never worked a jukebox, eh? Pretty standard. Available commands are:\n"
  help += "'help' - shows this menu\n"
  help += "'list' - lists the whole song library\n"
  help += "or you can enter an artist's name to show that artist's songs\n"
  puts help
end

run