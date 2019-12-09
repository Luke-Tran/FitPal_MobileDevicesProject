// To hold info about the user
bool isLoggedIn = false;
String userEmail = "";
String profilePic = "";

// To make sure the workouts list is up to date
bool isWorkoutsLoaded = false;

bool isNumeric(String s) {
  RegExp validNumber = RegExp(r"\b\d+(\.\d+)?\b");
  RegExp invalidCharacters = RegExp(r"[^0-9\.]");
  if (!invalidCharacters.hasMatch(s)
  && validNumber.allMatches(s).length == 1
  && RegExp(r"\.").allMatches(s).length <= 1) {
    return true;
  }
  return false;
}