require 'optparse'

# Initialize options hash with default values
options = {
  count: false,    # Count the number of matching lines
  match: false,    # Print the matched part of each matching line
  mode: nil,       # Search mode: 'w' for whole word, 'p' for pattern, 'v' for invert match
  c_m_used: false  # Track if -c or -m is used
}

# Define the options parser
option_parser = OptionParser.new do |opts|
  opts.banner = "Usage: rgrep.rb filename [option] pattern"

  # Option for whole word search
  opts.on("-w", "Search for the whole word") do
    if options[:c_m_used]
      puts "Invalid combination of options"
      exit
    end
    options[:mode] = 'w'
  end
  
  # Option for regular expression pattern search (default mode)
  opts.on("-p", "Treat pattern as a regular expression (default)") do
    if options[:c_m_used]
      puts "Invalid combination of options"
      exit
    end
    options[:mode] = 'p'
  end
  
  # Option for inverted match search
  opts.on("-v", "Invert match: select non-matching lines") do
    if options[:c_m_used]
      puts "Invalid combination of options"
      exit
    end
    options[:mode] = 'v'
    options[:v_used] = true  # Mark that -v has been used to prevent -m from being used after it
  end
  
  # Option to count the number of matching lines instead of printing them
  opts.on("-c", "Count the number of matching lines") do
    # Make sure there is a valid option before -c
    if options[:mode].nil?
      puts "Invalid combination of options"
      exit
    end
    options[:count] = true
    options[:c_m_used] = true  # No more options should be allowed after -c
  end
  
  # Option to print only the matched parts of the line
  opts.on("-m", "Print the matched part of the line") do
    # Make sure -m is not used after -v
    if options[:mode].nil? || options[:v_used]
      puts "Invalid combination of options"
      exit
    end
    options[:match] = true
    options[:c_m_used] = true  # No more options should be allowed after -m
  end
end

# Parse the options; catch and handle invalid options
begin
  option_parser.parse!
rescue OptionParser::InvalidOption
  puts "Invalid option"
  exit
end

# Extract the filename and pattern from the command line arguments
filename = ARGV.shift
pattern = ARGV.shift

# Check for required arguments: filename and pattern
if filename.nil? || pattern.nil?
  puts "Missing required arguments"
  exit
end

# Set default mode to 'p' if no mode is specified
options[:mode] ||= 'p'

# Adjust the pattern for whole word search if -w option is used
pattern = "\\b#{pattern}\\b" if options[:mode] == 'w'
compiled_pattern = Regexp.new(pattern)

count = 0

# Process the file line by line
begin
  File.foreach(filename) do |line|
    match_data = line.match(compiled_pattern)
    # Handle inverted match mode separately
    if options[:mode] == 'v'
      next if match_data || line.match(/^\s*$/)  # Skip matching lines or empty lines
    else
      next unless match_data  # Skip non-matching lines in other modes
    end

    # Increment count and print matches based on options
    count += 1
    if options[:match] && match_data && !options[:count]
      puts match_data[0]  # Print matched parts
    elsif !options[:count]
      puts line.chomp  # Print whole line
    end
  end
rescue Errno::ENOENT
  puts "File not found: #{filename}"  # Handle file not found error
  exit
end

# Output the count if -c option is used
puts count if options[:count]
