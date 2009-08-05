using namespace std;

class WepCracker {
  string bssid;
  string essid;
  string file;
  string options;

  public:
    WepCracker(string, string, string);
    int crack();
  private:
    int validate_attributes();
    int generate_options();
    char get_letter_from();
    int sec2hms();
    char* humanize_time();
};


