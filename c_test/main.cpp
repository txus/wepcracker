#include <iostream>
#include <string>
#include "lib/wep_cracker.cpp"

using namespace std;

int main(int argc, char *argv[]) {

  string essid, bssid, file;

  for (int n = 1; n < argc; n++) {
    // cout << "Arg num " << n << ": " << argv[n] << "\n";
    printf("%s", argv[n]);

    /*
    switch(argv[n])
    {
      case "-b":
        bssid = argv[n+1];
        break;
      case "-e":
        essid = argv[n+1];
        break;
      case "-f":
        file = argv[n+1];
        break;
      default:
        break;
    }

    */
  }

  // WepCracker wep_cracker(essid, bssid, file);
  return 0;
}

