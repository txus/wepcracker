#include "wep_cracker.h"

using namespace std;

WepCracker::WepCracker() {}

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
  int rate = 0;
  int eta = 0;
  int counter = 0;

  /*for (int i = 0; i < options.size(); i++)
  #{
    printf("Opcio %i: %s", i, options[i]);
  }
  //  starting_at = Time.now
  //  len = @options.length
*/

}


// TODO: Implement validations with regular expressions using Boost.Regex library (OMG)

void WepCracker::validate_attributes() {
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

int WepCracker::generate_options() {
  options.push_back("X000138DC960E");
  options.push_back("X111843752983");
}

