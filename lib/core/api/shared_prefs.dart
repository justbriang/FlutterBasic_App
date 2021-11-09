import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{

  // Save user's info
 Future<bool> saveProfDetails(String userDetails) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(
            "user_details", userDetails);
  }

    // Retrieve user's info
 Future<String?> getProfDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(
            "user_details");
  }


}