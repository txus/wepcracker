require 'rubygems'
require 'lib/wep_cracker'
#require 'benchmark'

# First of all, check if airdecap-ng is present. Quit if not!

raise "Your system doesn't seem to have aircrack-ng suite installed.\nPlease install it before using WepCracker." unless `airdecap-ng` =~ /Airdecap-ng [0-9]/

# Get the mandatory arguments from args: BSSID, ESSID and captures file

bssid = ''
essid = ''
file = ''

ARGV.each_with_index do |arg, num|
  case arg
  when '-b'
    bssid = ARGV[num+1]
    raise "This BSSID looks invalid." unless bssid =~ /^([0-9a-fA-F]{2}\:){5}[0-9a-fA-F]{2}$/
  when '-e'
    essid = ARGV[num+1]
    raise "This ESSID doesn't look like a WLAN_XX kind." unless essid =~ /^WLAN_[0-9a-fA-F]{2}$/
  when '-f'
    file = ARGV[num+1]
    raise "File doesn't exist." unless File.exists?(file)
  end
end


wep_cracker = WepCracker.new(:bssid => bssid,
                             :essid => essid,
                             :file => file)

#Benchmark.bm(7) do |x| 
#  x.report("WepCracker::crack! :") {wep_cracker.crack!}
#end

wep_cracker.crack!
