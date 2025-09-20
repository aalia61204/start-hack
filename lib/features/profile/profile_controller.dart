import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'profile_models.dart';
import 'profile_repository.dart';

// Repository provider
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository();
});

// Profile state notifier
class ProfileController extends StateNotifier<UserProfile> {
  final ProfileRepository _repository;

  ProfileController(this._repository) : super(UserProfile.demoProfile) {
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final profile = await _repository.load();
    state = profile;
  }

  Future<void> _saveProfile(UserProfile profile) async {
    await _repository.save(profile);
    state = profile;
  }

  /// Set display name
  Future<void> setDisplayName(String displayName) async {
    final updatedProfile = state.copyWith(displayName: displayName);
    await _saveProfile(updatedProfile);
  }

  /// Set currency
  Future<void> setCurrency(String currency) async {
    final updatedProfile = state.copyWith(currency: currency);
    await _saveProfile(updatedProfile);
  }

  /// Set monthly budget
  Future<void> setMonthlyBudget(double? monthlyBudget) async {
    final updatedProfile = state.copyWith(monthlyBudget: monthlyBudget);
    await _saveProfile(updatedProfile);
  }

  /// Set theme
  Future<void> setTheme(String theme) async {
    final updatedProfile = state.copyWith(theme: theme);
    await _saveProfile(updatedProfile);
  }

  /// Toggle blur amounts
  Future<void> toggleBlur() async {
    final updatedProfile = state.copyWith(blurAmounts: !state.blurAmounts);
    await _saveProfile(updatedProfile);
  }

  /// Set persona tag
  Future<void> setPersonaTag(String? personaTag) async {
    final updatedProfile = state.copyWith(personaTag: personaTag);
    await _saveProfile(updatedProfile);
  }

  /// Reset to demo profile
  Future<void> resetDemo() async {
    final demoProfile = await _repository.resetToDemo();
    state = demoProfile;
  }
}

// Profile controller provider
final profileControllerProvider = StateNotifierProvider<ProfileController, UserProfile>((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return ProfileController(repository);
});
