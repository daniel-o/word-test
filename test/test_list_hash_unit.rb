require "minitest/autorun"
require "list_hash"

class TestListHash < Minitest::Unit::TestCase
	def test_initialize_default
		list = ListHash.new

		assert_equal Array.new, list["default"], "Expecting an empty array as default missing value"
	end

	def test_add
		list = ListHash.new

		list.add :one, :uno
		assert_equal [:uno], list[:one], "Contains first added object in an array"
		list.add :one, :une
		assert_equal [:uno, :une], list[:one], "Is array with both added values"
	end
end
