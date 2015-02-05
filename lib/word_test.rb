require './list_hash'

class WordTest
	def write_sequences(input_name, sequence_file, word_file)
		begin
			input_file = File.new input_name, "r"

			list_hash = build_list input_file
			
			sequence_output = File.open sequence_output, "w"
			word_output = File.open word_output, "w"
		rescue IOError
			sequence_output.close
			word_output.close
		end
	end

	def build_list(input_io)
		list_hash = ListHash.new
		read_input input_io do |word|
			sequences(word).each do |sequence|
				list_hash.add sequence, word
			end
		end
		list_hash
	end

	def read_input(input_io, &block)
		input_io.each_line do |line|
			# Skips the line if there isn't anything on it so extra work
			# isn't done unnecessarily.
			unless line.empty?
				# Checking to make sure multiple words didn't slip through
				# on a single line. If they are we can still grab them.
				line.strip.split(/\s/).each do |word|
					block.call word
				end
			end
		end
	end

	def sequences(word, seq_length=4)
		keys = Array.new
		if word.length >= seq_length
			range_max = word.length - seq_length
			slice_range = 0..range_max
			slice_range.each do |index|
				key = word.slice index, seq_length
				keys << key
			end
		end
		keys
	end
end
