# Profile Feature

This feature implements a complete user profile management system for the AI Finance Manager app.

## Files Created

### 1. `profile_models.dart`

- **UserProfile** model with all required fields:
  - `displayName` (String)
  - `email` (String)
  - `avatarAsset` (String?, optional)
  - `currency` (String, default: "CHF")
  - `monthlyBudget` (double?, optional)
  - `theme` (String, default: "system")
  - `blurAmounts` (bool, default: true)
  - `personaTag` (String?, optional)
- Includes `copyWith`, `toJson`, `fromJson` methods
- Provides `demoProfile` static getter for initial setup

### 2. `profile_repository.dart`

- Local repository using `shared_preferences`
- Methods:
  - `load()` - Load profile from storage or return demo profile
  - `save(UserProfile)` - Save profile to storage
  - `resetToDemo()` - Reset to demo profile
  - `clear()` - Clear all profile data

### 3. `profile_controller.dart`

- Riverpod `StateNotifier<UserProfile>` for state management
- Actions:
  - `setDisplayName(String)`
  - `setCurrency(String)`
  - `setMonthlyBudget(double?)`
  - `setTheme(String)`
  - `toggleBlur()`
  - `setPersonaTag(String?)`
  - `resetDemo()`

### 4. `profile_screen.dart`

- Complete UI implementation with:
  - **Header**: Circular avatar, display name, email, persona chip
  - **Preferences Section**:
    - Privacy toggle for blur amounts
    - Theme control (System/Light/Dark)
    - Currency dropdown (CHF/EUR/USD)
    - Monthly budget input field
  - **Actions Section**:
    - Export CSV button
    - Reload Demo Data button
    - Reset demo profile button
- Small reusable widgets: `SectionHeader`, `SettingTile`, `PersonaChip`

## Dependencies Added

- `shared_preferences: ^2.2.2` - Local storage
- `flutter_riverpod: ^2.4.9` - State management
- `go_router: ^12.1.3` - Navigation

## Routing

- Route `/profile` added to the app router
- Integrated with bottom navigation bar
- Uses `ShellRoute` for consistent navigation structure

## Assets

- Fallback avatar asset at `assets/logos/user_fallback.png`
- Assets directory configured in `pubspec.yaml`

## Usage

The profile screen is accessible via the bottom navigation bar. All user preferences are automatically saved to local storage and persist between app sessions. The demo profile provides a good starting point for new users.
