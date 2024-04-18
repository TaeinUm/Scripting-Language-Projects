# CSE 337 Assignment 2
# Taein Um
# SBU_email: taein.um@stonybrook.edu
# ID: 112348159

# Calculate the total number of walls needed to contain the virus in a grid
def contain_virus(grid)
  total_walls = 0
  
  # Iterate through each cell in the grid
  grid.each_with_index do |row, row_index|
    row.each_with_index do |cell, col_index|
      next unless cell == 1  # Skip if cells are not infected
      
      # Calculate and accumulate walls needed for each infected cell
      walls = calculate_walls_for_cell(grid, row_index, col_index)
      total_walls += walls
    end
  end
  
  total_walls
end

# Helper method to calculate the number of walls needed for a specific infected cell
def calculate_walls_for_cell(grid, row, col)
  walls = 0
  # Directions to check around the cell: up, down, left, right
  [[-1, 0], [1, 0], [0, -1], [0, 1]].each do |dx, dy|
    new_row, new_col = row + dx, col + dy
    
    # If adjacent cell is out of grid bounds or uninfected, increment walls count
    if new_row < 0 || new_row >= grid.length || new_col < 0 || new_col >= grid[0].length || grid[new_row][new_col] == 0
      walls += 1
    end
  end
  
  walls
end
