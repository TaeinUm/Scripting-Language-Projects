class Array
  # Alias the original array indexing and map methods to preserve †he original functionality
  alias_method :original_brackets, :[]
  alias_method :original_map, :map

  
  # Override the [] method
  def [](index)
    if index.between?(-self.size, self.size-1)
      original_brackets(index) # Use the original method if index is within bounds
    else
      '\0' # Return '\0' if index is out of bounds
    end
  end

  # Override map method
  def map(sequence=nil, &block)
    if sequence
      # Adjust indices for negative values and ensure they are within array bounds
      adjusted_sequence = sequence.map do |i|
        i += self.length if i < 0 # Adjust negative indices
        i.between?(0, self.length-1) ? i : nil # Exclude out-of-bounds indices
      end.compact
      
      # Apply the block to elements specified by the adjusted sequence
      adjusted_sequence.map { |index| block.call(self[index]) }
    else
      # If no sequence is provided, apply the original map behavior
      original_map(&block)
    end
  end

end
