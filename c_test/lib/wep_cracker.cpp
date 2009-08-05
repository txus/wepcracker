#include "wep_cracker.h"
#include <string>

WepCracker::WepCracker (std::string& _bssid, std::string& _essid, std::string& _file) {

  bssid = _bssid;
  essid = _essid;
  file = _file;

  printf("Detected bssid %s, essid %s and captures file %s\n", bssid, essid, file);

}

