
DAY = 6
INPUT_FILE_PATH = "puzzle_inputs/day_#{DAY}/full_input_day_#{DAY}.txt"
INPUT_FILE_PATH_TEST = "puzzle_inputs/day_#{DAY}/full_input_day_#{DAY}_test.txt"

def is_the_boat_winning(race_duration, holding_time, record_distance)
  return true if (race_duration - holding_time) * holding_time > record_distance
  false
end

def main(input_file)

  times, distances = File.readlines(input_file, chomp: true)

  # times = times.split(':')[1].split(' ').map(&:to_i)
  # distances = distances.split(':')[1].split(' ').map(&:to_i)
  
  times = [times.split(':')[1].gsub(/\s+/, "").to_i]
  distances = [distances.split(':')[1].gsub(/\s+/, "").to_i]

  total = 1
  (0..times.length-1).to_a.each do |race_index|
    number_of_win_scenarios = 0
    possibilities = (0..times[race_index]).to_a
    possibilities.each do |holding_time|
      number_of_win_scenarios += 1 if is_the_boat_winning(times[race_index], holding_time, distances[race_index])
    end
    total = total * number_of_win_scenarios
  end
  p total
end

main(INPUT_FILE_PATH_TEST)
main(INPUT_FILE_PATH)
