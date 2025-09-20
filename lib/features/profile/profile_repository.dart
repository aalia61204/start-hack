import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'profile_models.dart';

class ProfileRepository {
  static const String _profileKey = 'user_profile';

  /// Load user profile from local storage
  Future<UserProfile> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final profileJson = prefs.getString(_profileKey);
      
      if (profileJson != null) {
        final profileMap = json.decode(profileJson) as Map<String, dynamic>;
        return UserProfile.fromJson(profileMap);
      }
      
      // Return demo profile if no saved profile exists
      return UserProfile.demoProfile;
    } catch (e) {
      // Return demo profile on error
      return UserProfile.demoProfile;
    }
  }

  /// Save user profile to local storage
  Future<void> save(UserProfile profile) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final profileJson = json.encode(profile.toJson());
      await prefs.setString(_profileKey, profileJson);
    } catch (e) {
      // Handle error silently or log it
      print('Error saving profile: $e');
    }
  }

  /// Reset to demo profile
  Future<UserProfile> resetToDemo() async {
    final demoProfile = UserProfile.demoProfile;
    await save(demoProfile);
    return demoProfile;
  }

  /// Clear all profile data
  Future<void> clear() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_profileKey);
    } catch (e) {
      print('Error clearing profile: $e');
    }
  }
}
