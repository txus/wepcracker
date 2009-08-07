#include <iostream>
#include <boost/regex.hpp>
#include "lib/wep_cracker.cpp"

using namespace std;

int main(int argc, char *argv[]) {

  string essid, bssid, file;

  // Get the options from the given arguments

  for (int n = 1; n < argc; n++) {

    string str(argv[n]);

    if (str == "-b")
    {
      bssid = argv[n+1];
    }
    else if (str == "-e")
    {
      essid = argv[n+1];
    }
    else if (str == "-f")
    {
      file = argv[n+1];
    }

  }

  // Try to initialize the WepCracker class with given parameters

  WepCracker wep_cracker;

  try {
    wep_cracker.WepCracker(bssid, essid, file);
  }
  catch(int error){
    switch(error)
    {
      case 1:
        cerr << "The BSSID looks invalid." << endl;
        break;
      case 2:
        cerr << "The ESSID looks invalid." << endl;
        break;
      case 3:
        cerr << "The captures file looks invalid." << endl;
        break;
      default:
        break;
    }
    return NULL;
  }

  // If it's all ok, crack!

  wep_cracker.crack();

  return 0;
}

