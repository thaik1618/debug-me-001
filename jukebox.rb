def jukebox(command)
  if command == "list"
    list_library
  else
    parse_command(command)
  end
end

def list_library
  lib = full_library
  lib.each do |artist, album_hash|
    puts list_artist(artist, album_hash)
  end
end

def list_artist(artist, album_hash)
   artist_list = "\n---------------\n"
   artist_list += "#{artist}:\n"
   artist_list += "---------------"
   album_hash[:albums].each do |album_name, songs_hash|
     artist_list += "\n#{album_name}:\n\t"
     artist_list += songs_hash[:songs].join("\n\t")
   end
   artist_list
end

def parse_command(command)
  parse_artist(command, full_library) || play_song(command, full_library) || not_found(command)
end

def parse_artist(command, lib)
  cmd = title_case(command)
  if lib.has_key?(cmd)
    puts list_artist(command, lib[cmd])
    parsed = true
  else
    lib.each do |artist, hash|
      if command.downcase == artist.to_s.gsub("_"," ").downcase
        puts list_artist(artist, lib)
        parsed = false
        break
      end
    end
  end
  parsed
end

def title_case(string)
  string.split(" ").map do |word|  
    word.capitalize unless /\band|\bis|\bor|\bthe|\ba|\bof/.match(word) 
  end.join(" ").to_sym
end

def play_song(command, lib)
  played = false
  lib.each do |artist, hash|
    
    hash.each do |album_name, albums_hash|

      albums_hash.each do |album, songs_hash|

        songs_hash.each do |songs, song|

          song.each do |ind_song|
            if ind_song.downcase == command.downcase
              puts "Now Playing: #{artist}: #{album} - #{ind_song}\n\n"
              played = true
            end
          end
       end
      end
    end
  end
played  
end

def not_found(command)
  puts "I did not understand '#{command}'!\n\n"
  true
end