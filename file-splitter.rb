if ARGV.size != 2
  puts "Usage: ruby file-splitter.rb <filename.ext> <size_of_pieces_in_lines>"
  exit
end

file_name = ARGV[0]
num_lines = ARGV[1]

if File.exists?(file_name)
  file = File.open(file_name, "r")
  size = num_lines.to_i
  
  # call the wc -l command in bash, strip of whitespace, split on a space
  # get the first element (the actual number), then convert to int
  line_count = `wc -l "#{file_name}"`.strip.split(' ')[0].to_i


  puts "The file is #{line_count} lines long."

  

end
