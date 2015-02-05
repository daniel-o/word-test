class ListHash < Hash
	def intialize
		super.default = Array.new
	end

	def add(key, value)
		unless self.has_key? key
			self[key] = Array.new
		end
		self[key] << value
	end
end
