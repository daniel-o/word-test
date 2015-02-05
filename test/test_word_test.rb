require "minitest/autorun"
require "word_test"
require "stringio"

class TestWordTest < Minitest::Unit::TestCase
	def test_read_input
		word_test = WordTest.new

		mock_io = StringIO.new(<<-input)
			Azerbaijan
			azimuth
			azimuthal
			Aztec
			Aztecan
		input

		output = ""
		word_test.send :read_input, mock_io do |word|
			output += word
		end

		assert_equal mock_io.read.gsub(/\w+/, ''), output.gsub(/\w+/, '')
	end

	def test_sequences
		word_test = WordTest.new
		sequences = word_test.send :sequences, "azimuth"

		assert_equal ["azim", "zimu", "imut", "muth"], sequences
	end

	def test_build_list
		word_test = WordTest.new

		mock_io = StringIO.new <<-input
			azimuth
			aztec
			aztecan
		input

		test_list = {
			"azim" => ["azimuth"],
			"zimu" => ["azimuth"],
			"imut" => ["azimuth"],
			"muth" => ["azimuth"],
			"azte" => ["aztec", "aztecan"],
			"ztec" => ["aztec", "aztecan"],
			"teca" => ["aztecan"],
			"ecan" => ["aztecan"]
		}


		list = word_test.send :build_list, mock_io

		assert_equal test_list, list
	end
end
