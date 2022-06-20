function init()
  screen.font_face(38)
  distance = 0
  find_an_interval()
end

old_root = 0
new_root = 0
guess_where_we_are_going = 0

diatonic_scale = {}
diatonic_scale[0] = 0
diatonic_scale[1] = 2
diatonic_scale[2] = 4
diatonic_scale[3] = 5
diatonic_scale[4] = 7
diatonic_scale[5] = 9
diatonic_scale[6] = 11

scales_containing_both_values = {}
one_note_is_there = {}
the_other_note_is_there = {}

for i = 0,11 do
  one_note_is_there[i] = 0
  the_other_note_is_there[i] = 0
end


current_pitch_collection = {}

for i = 0,6 do 
  current_pitch_collection[i] = diatonic_scale[i]
end

rooted_scales = {}
for i = 0,11 do
  rooted_scales[i] = {}
  for j = 0,6 do
    rooted_scales[i][j] = (diatonic_scale[j] + i) % 12
  end
end

note_names = {}
note_names[0] = "C"
note_names[1] = "Db"
note_names[2] = "D"
note_names[3] = "Eb"
note_names[4] = "E"
note_names[5] = "F"
note_names[6] = "Gb"
note_names[7] = "G"
note_names[8] = "Ab"
note_names[9] = "A"
note_names[10] = "Bb"
note_names[11] = "B"


function key(n,z)
  if n == 3 and z == 1 then
    generate_a_pitch_collection()
  end
end

function find_an_interval()
  
for i = 0, 11 do
  one_note_is_there[i] = 0
  the_other_note_is_there[i] = 0
end

for k in pairs (scales_containing_both_values) do
    scales_containing_both_values[k] = nil
end
  
  one_note = current_pitch_collection[math.random(0,6)]
  a_different_note = current_pitch_collection[math.random(0,6)]
  
  while(one_note >= a_different_note) do
    
      one_note = current_pitch_collection[math.random(0,6)]
      a_different_note = current_pitch_collection[math.random(0,6)]
  
  end
  
  if one_note < a_different_note then
    
      distance = a_different_note - one_note
      redraw()
      
  end
  
end

function generate_a_pitch_collection()

for i = 0,11 do
  for j = 0,6 do
  if one_note == rooted_scales[i][j] then
    one_note_is_there[i] = 1
  end
  if a_different_note == rooted_scales[i][j] then
    the_other_note_is_there[i] = 1
  end
  end
  
  if one_note_is_there[i] == 1 then
    if the_other_note_is_there[i] == 1 then
      if i ~= new_root then
        table.insert(scales_containing_both_values, i)
      end
    end
  
  end
  end

  tab.print(one_note_is_there)

new_root = scales_containing_both_values[(math.random(tablelength(scales_containing_both_values)))]

      for i = 0,6 do
        current_pitch_collection[i] =

rooted_scales[new_root][i]

end

    find_an_interval()
    redraw()
end

    


function redraw()
  screen.clear()
    screen.aa(1)
    screen.line_width(1)
    screen.move(128,0)
    screen.line(128,45)
    screen.line(0,45)
    screen.line(0,0)
    for i = 1,7 do
      screen.move(i * 18.285, 45)
      screen.line(i * 18.285, 27)
    if i == 3 then
      screen.line(i * 18.285, 0)
    end
    end
    for i = 1,6 do
      if i ~= 3 then
        if i == 1 then
        screen.move (i * 12.19, 0)
        screen.line(i * 12.19, 27)
        screen.line(i * 12.19 + 12.19, 27)
        screen.line(i * 12.19 + 12.19, 0)
      elseif i == 2 then
        screen.move (i * 12.19 + 6.095, 0)
        screen.line(i * 12.19 + 6.095, 27)
        screen.line(i * 12.19 + 12.19 + 6.05, 27)
        screen.line(i * 12.19 + 12.19 + 6.095, 0)  
        
      elseif i == 4 then
        screen.move (i * 12.19 + 12.19 + 6.095, 0)
        screen.line(i * 12.19 + 12.19 + 6.095, 27)
        screen.line(i * 12.19 + 12.19 + 12.19 + 6.095, 27)
        screen.line(i * 12.19 + 12.19 + 12.19 + 6.095, 0)          
      
      elseif i == 5 then
        screen.move (i * 12.19 + 12.19 + 12.19, 0)
        screen.line(i * 12.19 + 12.19 + 12.19, 27)
        screen.line(i * 12.19 + 12.19 + 12.19 + 12.19, 27)
        screen.line(i * 12.19 + 12.19 + 12.19 + 12.19, 0)         

      elseif i == 6 then
        screen.move (i * 12.19 + 12.19 + 12.19 + 6.095, 0)
        screen.line(i * 12.19 + 12.19 + 12.19 + 6.095, 27)
        screen.line(i * 12.19 + 12.19 + 12.19 + 12.19 + 6.095, 27)
        screen.line(i * 12.19 + 12.19 + 12.19 + 12.19 + 6.095, 0)             
        
      end
      end
    end
      
  screen.font_size(12)
  
  for i = 0,6 do
    if black_keys[current_pitch_collection[i]] then
    screen.move(black_keys[current_pitch_collection[i]], 22)
    screen.text("+")
    end 
    if white_keys[current_pitch_collection[i]] then
    screen.move(white_keys[current_pitch_collection[i]], 40)
    screen.text("+")
    end
    
  end
  
  screen.font_size(22)
  screen.move(32, 62)
  screen.text(note_names[new_root])
  screen.move(72, 62)
  screen.text(note_names[one_note])
  screen.move(92, 62)
  screen.text(note_names[a_different_note])
  
    screen.stroke()
  screen.update()
end

black_keys = {}
black_keys[1] = 14.285
black_keys[3] = 32.57
black_keys[6] = 69.14
black_keys[8] = 87.425
black_keys[10] = 105.71


white_keys = {}
white_keys[0] = 6.1425
white_keys[2] = 24.4275
white_keys[4] = 42.7125
white_keys[5] = 60.9975
white_keys[7] = 79.2825
white_keys[9] = 97.5675
white_keys[11] = 115.8525

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
