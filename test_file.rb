# Given the word list, count how many words are in the dictionary.
# Note: This isn't the most efficient way to do thise.  If I was going for
#   speed, I would have made each dicitonary word the key of a hash, and
#   had O(n) lookup times.
def process_words(words, dictionary)
  puts "Starting thread #{Thread.current.object_id}\n"

  found = 0
  words.each do |word|
    if dictionary.include? word
      found += 1
    end
  end

  puts "Done with thread #{Thread.current.object_id}\n"
  Thread.current[:found] = found
end

# Read the dictionary into an array.
dictionary = []
File.open('/usr/share/dict/words', 'r').each_line do |word|
  word = word.gsub("\n",'')
  dictionary << word
end

# Read the list of words into an array.
all_words = []
File.open('10000_word_lorem_ipsum.txt', 'r').each_line do |line|
  line_words = line.split
  line_words.each { |word| all_words << word }
end

# Get the chunk size, and then spawn enough threads to accomodate the
# number of chunks.
chunk_size = (ARGV[0].nil?) ? 2000 : ARGV[0].to_i
threads = []
started = Time.now
all_words.each_slice(chunk_size) do |slice|
  threads << Thread.new { process_words(slice, dictionary) }
end

# Use Thread.join to make sure that child threads aren't killed when the
# main thread exits.
found_words_count = 0
threads.each do |t|
  t.join
  found_words_count += t[:found]
end
ended = Time.now
total_time = (ended - started)

puts "Words: #{found_words_count} / #{all_words.count}"
puts "Time: #{total_time}"
puts "Threads: #{threads.count}"