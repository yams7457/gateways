function init()
    pick_a_gateway()
    lock_chevrons()
    find_the_next_root()
    redraw()
end

diatonic_template = {2,4,5,7,9,11}
diatonic_template[0] = 0

note_names = {"Db", "D", "Eb", "E", "F", "Gb", "G", "Ab", "A", "Bb", "B"} 
note_names[0] = "C"

diatonic_scales = {}
current_pitch_collection = {}
next_pitch_collection = {}
chevron_one = {}
chevron_two = {}
chevrons_locked = {}

for i = 0,11 do
  diatonic_scales[i] = {}
  chevron_one[i] = 0
  chevron_two[i] = 0
  for j = 0,6 do
    diatonic_scales[i][j] = (i + diatonic_template[j]) % 12
  end
end

current_root = math.random(0,11)

for i = 0,6 do
  current_pitch_collection[i] = diatonic_scales[current_root][i]
end

function key(n,z)
  if n == 3 and z == 1 then
    replace_the_root()
    pick_a_gateway()
    lock_chevrons()
    find_the_next_root()
    redraw()
    print(current_root, half_of_gateway, other_half_of_gateway, next_root)
  end
end

function replace_the_root()
  for i = 0,6 do
    current_pitch_collection[i] = diatonic_scales[next_root][i]
  end
  
  current_root = next_root
  
end

function pick_a_gateway()
  half_of_gateway = current_pitch_collection[math.random(0,6)]
  other_half_of_gateway = current_pitch_collection[math.random(0,6)]
  
  if half_of_gateway == other_half_of_gateway then
    pick_a_gateway()
  end
  
  if half_of_gateway > other_half_of_gateway then
    distance = half_of_gateway - other_half_of_gateway
    if distance > 6 then
      distance = 12 - distance
    end
  end
  
  if other_half_of_gateway > half_of_gateway then
    distance = other_half_of_gateway - half_of_gateway
    if distance > 6 then
      distance = 12 - distance
    end
  end
  
end

function lock_chevrons()
  
  for i = 0,11 do
    chevron_one[i] = 0
    chevron_two[i] = 0
    chevrons_locked[i] = 0
  end
  
  for i = 0,11 do
    for j = 0,6 do
      if half_of_gateway == diatonic_scales[i][j] then
        chevron_one[i] = 1
      end
      if other_half_of_gateway == diatonic_scales[i][j] then
        chevron_two[i] = 1
      end
    end
    
    if chevron_one[i] == 1 and chevron_two[i] == 1 then
      chevrons_locked[i] = 1
    end

  end
  

end

function find_the_next_root()
  next_root = math.random(0,11)
  if chevrons_locked[next_root] == 0 or next_root == current_root then
    find_the_next_root()
  elseif chevrons_locked[next_root] == 1 then
    
    for i = 0,6 do
      next_pitch_collection[i] = diatonic_scales[next_root][i]
    end
    
  end
  
  
  
end

total_keyboard_width = 92
total_keyboard_height = 28
black_key_length = total_keyboard_height / 1.61803398875

black_keys = {}
black_keys[1] = 1.5 * .083 * total_keyboard_width - 3
black_keys[3] = 3.5 * .083 * total_keyboard_width - 3
black_keys[6] = 6.5 * .083 * total_keyboard_width - 3
black_keys[8] = 8.5 * .083 * total_keyboard_width - 3
black_keys[10] = 10.5 * .083 * total_keyboard_width - 3


white_keys = {}
white_keys[0] = 1 * .083 * total_keyboard_width - 5
white_keys[2] = 2.5 * .083 * total_keyboard_width - 3
white_keys[4] = 4.5 * .083 * total_keyboard_width - 4
white_keys[5] = 5.5 * .083 * total_keyboard_width - 2
white_keys[7] = 7.5 * .083 * total_keyboard_width - 3
white_keys[9] = 9.5 * .083 * total_keyboard_width - 3
white_keys[11] = 11.5 * .083 * total_keyboard_width - 3

function redraw()
  screen.clear()
  screen.aa(1)
  screen.line_width(1)
  screen.move(0,0)
  
  --black keys as a percentage of the whole keyboard: 0.083

  screen.move(.083 * total_keyboard_width, 0)
  screen.line(.083 * total_keyboard_width, black_key_length)
  screen.line(2 * .083 * total_keyboard_width, black_key_length)
  screen.line(2 * .083 * total_keyboard_width, 0)
  
  screen.move(3 * .083 * total_keyboard_width, 0)
  screen.line(3 * .083 * total_keyboard_width, black_key_length)
  screen.line(4 * .083 * total_keyboard_width, black_key_length)
  screen.line(4 * .083 * total_keyboard_width, 0)
  
  screen.move(6 * .083 * total_keyboard_width, 0)
  screen.line(6 * .083 * total_keyboard_width, black_key_length)
  screen.line(7 * .083 * total_keyboard_width, black_key_length)
  screen.line(7 * .083 * total_keyboard_width, 0)
  
  screen.move(8 * .083 * total_keyboard_width, 0)
  screen.line(8 * .083 * total_keyboard_width, black_key_length)
  screen.line(9 * .083 * total_keyboard_width, black_key_length)
  screen.line(9 * .083 * total_keyboard_width, 0)
  
  screen.move(10 * .083 * total_keyboard_width, 0)
  screen.line(10 * .083 * total_keyboard_width, black_key_length)
  screen.line(11 * .083 * total_keyboard_width, black_key_length)
  screen.line(11 * .083 * total_keyboard_width, 0)
  
  --white keys as a percentage of the whole keyboard: 0.1424

  screen.move(1.5 * .083 * total_keyboard_width, black_key_length)
  screen.line(1.5 * .083 * total_keyboard_width, total_keyboard_height)
  screen.move(3.5 * .083 * total_keyboard_width, black_key_length)
  screen.line(3.5 * .083 * total_keyboard_width, total_keyboard_height)
  screen.move(6.5 * .083 * total_keyboard_width, black_key_length)
  screen.line(6.5 * .083 * total_keyboard_width, total_keyboard_height)
  screen.move(8.5 * .083 * total_keyboard_width, black_key_length)
  screen.line(8.5 * .083 * total_keyboard_width, total_keyboard_height)    
  screen.move(10.5 * .083 * total_keyboard_width, black_key_length)
  screen.line(10.5 * .083 * total_keyboard_width, total_keyboard_height)
  
  screen.move(5 * .083 * total_keyboard_width, 0)
  screen.line(5 * .083 * total_keyboard_width, total_keyboard_height)
  
  --draw the second piano
  --black keys
  
  screen.move(.083 * total_keyboard_width, 63 - total_keyboard_height)

  screen.line(.083 * total_keyboard_width, 63 - total_keyboard_height + black_key_length)
  screen.line(2 * .083 * total_keyboard_width, 63 - total_keyboard_height + black_key_length)
  screen.line(2 * .083 * total_keyboard_width, 63 - total_keyboard_height)


  screen.move(3 * .083 * total_keyboard_width, 63 - total_keyboard_height)

  screen.line(3 * .083 * total_keyboard_width, 63 - total_keyboard_height + black_key_length)
  screen.line(4 * .083 * total_keyboard_width, 63 - total_keyboard_height + black_key_length)
  screen.line(4 * .083 * total_keyboard_width, 63 - total_keyboard_height)


  screen.move(6 * .083 * total_keyboard_width, 63 - total_keyboard_height)

  screen.line(6 * .083 * total_keyboard_width, 63 - total_keyboard_height + black_key_length)
  screen.line(7 * .083 * total_keyboard_width, 63 - total_keyboard_height + black_key_length)
  screen.line(7 * .083 * total_keyboard_width, 63 - total_keyboard_height)


  screen.move(8 * .083 * total_keyboard_width, 63 - total_keyboard_height)

  screen.line(8 * .083 * total_keyboard_width, 63 - total_keyboard_height + black_key_length)
  screen.line(9 * .083 * total_keyboard_width, 63 - total_keyboard_height + black_key_length)
  screen.line(9 * .083 * total_keyboard_width, 63 - total_keyboard_height)


  screen.move(10 * .083 * total_keyboard_width, 63 - total_keyboard_height)

  screen.line(10 * .083 * total_keyboard_width, 63 - total_keyboard_height + black_key_length)
  screen.line(11 * .083 * total_keyboard_width, 63 - total_keyboard_height + black_key_length)
  screen.line(11 * .083 * total_keyboard_width, 63 - total_keyboard_height)

--white keys
  
  screen.move(1.5 * .083 * total_keyboard_width,  63 - total_keyboard_height + black_key_length)
  screen.line(1.5 * .083 * total_keyboard_width, 63)
  screen.move(3.5 * .083 * total_keyboard_width,  63 - total_keyboard_height + black_key_length)
  screen.line(3.5 * .083 * total_keyboard_width, 63)
  screen.move(6.5 * .083 * total_keyboard_width,  63 - total_keyboard_height + black_key_length)
  screen.line(6.5 * .083 * total_keyboard_width, 63)
  screen.move(8.5 * .083 * total_keyboard_width,  63 - total_keyboard_height + black_key_length)
  screen.line(8.5 * .083 * total_keyboard_width, 63)    
  screen.move(10.5 * .083 * total_keyboard_width,  63 - total_keyboard_height + black_key_length)
  screen.line(10.5 * .083 * total_keyboard_width, 63)  

  screen.move(5 * .083 * total_keyboard_width, 63 - total_keyboard_height)
  screen.line(5 * .083 * total_keyboard_width, 63)  
  
  --draw the outlines of the pianos!
  
  screen.move(0,1)
  screen.line(0,total_keyboard_height)
  screen.move(total_keyboard_width,1)
  screen.line(total_keyboard_width,total_keyboard_height)
  screen.move(total_keyboard_width, 63 - total_keyboard_height)
  screen.line(total_keyboard_width, 63)
  screen.move(0, 63 - total_keyboard_height)
  screen.line(0, 63)
  screen.move (0, total_keyboard_height)
  screen.line(total_keyboard_width, total_keyboard_height)
  screen.move(0, 63 - total_keyboard_height)
  screen.line(total_keyboard_width, 63 - total_keyboard_height)
  screen.move(0,1)
  screen.line(total_keyboard_width,1)
  screen.move(0,63)
  screen.line(total_keyboard_width,63)

    screen.font_size(12)
  
  for i = 0,6 do
     if black_keys[current_pitch_collection[i]] then
     screen.move(black_keys[current_pitch_collection[i]], total_keyboard_height / 1.6)
     screen.text("+")
  end 
    if white_keys[current_pitch_collection[i]] then
    screen.move(white_keys[current_pitch_collection[i]], total_keyboard_height / 1.1 )
    screen.text("+")
    end
  end
    
  for i = 0,6 do
    if black_keys[next_pitch_collection[i]] then
    screen.move(black_keys[next_pitch_collection[i]], total_keyboard_height / 1.6 + 63 - total_keyboard_height)
    screen.text("+")
    end 
    if white_keys[next_pitch_collection[i]] then
    screen.move(white_keys[next_pitch_collection[i]], total_keyboard_height / 1.1 + 63 - total_keyboard_height)
    screen.text("+")
    end
    
  end
  
  screen.move(total_keyboard_width + 3, 9)
  screen.text(note_names[current_root])
  screen.move(total_keyboard_width + 3, 63)
  screen.text(note_names[next_root])
  screen.move(total_keyboard_width + 3, 36)
  screen.text(note_names[half_of_gateway])
  screen.move(total_keyboard_width + 19, 36)
  screen.text(note_names[other_half_of_gateway])  
  screen.stroke()
  screen.update()

end
