
DAY = 5
INPUT_FILE_PATH = "puzzle_inputs/day_#{DAY}/full_input_day_#{DAY}.txt"
INPUT_FILE_PATH_TEST = "puzzle_inputs/day_#{DAY}/full_input_day_#{DAY}_test.txt"

def clean_map(map)
  cleaned_map = []
  if map.include?('seeds:')
    # map.split(':')[1].split(' ').map(&:to_i) # part 1
    map.scan(/\d+ \d+/).each do |match|
      match = match.split(' ').map(&:to_i)
      cleaned_map += (match[0]..match[0]+match[1]-1).to_a
    end
  else 
    map.split("\n").each_with_index do |line, index|
      cleaned_map << line.split(' ').map(&:to_i) if index > 0
    end
  end
  cleaned_map
end

def convert_number(number, map)
  map.each do |range|
    start_range = range[1]
    end_range = range[1] + range[2] - 1
    return number - range[1] + range[0] if number.between?(start_range, end_range)
  end
  number
end

def main(input_file)
  seeds = []
  seeds, seed_to_soil_map, soil_to_fert_map, fert_to_water_map, water_to_light_map, light_to_temp_map, temp_to_hum_map, hum_to_loc_map = File.read(input_file).split("\n\n").map {|x| clean_map(x)}
  seeds = seeds.map{ |x| convert_number(x, seed_to_soil_map)}
  seeds = seeds.map{ |x| convert_number(x, soil_to_fert_map)}
  seeds = seeds.map{ |x| convert_number(x, fert_to_water_map)}
  seeds = seeds.map{ |x| convert_number(x, water_to_light_map)}
  seeds = seeds.map{ |x| convert_number(x, light_to_temp_map)}
  seeds = seeds.map{ |x| convert_number(x, temp_to_hum_map)}
  seeds = seeds.map{ |x| convert_number(x, hum_to_loc_map)}

  p seeds.min
end

# main(INPUT_FILE_PATH_TEST)
main(INPUT_FILE_PATH)
