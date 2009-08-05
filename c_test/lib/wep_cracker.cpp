#include "wep_cracker.h"

using namespace std;

WepCracker::WepCracker (string _bssid, string _essid, string _file) {

  bssid = _bssid;
  essid = _essid;
  file = _file;
  //printf("Detected bssid %s, essid %s and captures file %s\n", bssid.c_str(), essid.c_str(), file.c_str());

  try{ validate_attributes(); }
  catch(int err) { throw err; }

}

int WepCracker::crack() {
  //TODO
}


// TODO: Implement validations with regular expressions (OMG)

int WepCracker::validate_attributes() {
  if (bssid.length() < 3) {
    throw 1;
  }
  if (essid.length() < 3) {
    throw 2;
  }
  if (essid.length() < 3) {
    throw 3;
  }
}
