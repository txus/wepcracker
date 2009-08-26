using namespace std;

class WepCracker {
  string bssid;
  string essid;
  string file;
  vector<string> options;

  public:
    WepCracker();
    void set_attributes(string, string, string);
    int crack();
  private:
    void validate_attributes();
    int generate_options();
    char get_letter_from();
    int sec2hms();
    char* humanize_time();
};

