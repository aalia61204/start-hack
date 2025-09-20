class UserProfile {
  final String displayName;
  final String email;
  final String? avatarAsset;
  final String currency;
  final double? monthlyBudget;
  final String theme;
  final bool blurAmounts;
  final String? personaTag;

  const UserProfile({
    required this.displayName,
    required this.email,
    this.avatarAsset,
    this.currency = 'CHF',
    this.monthlyBudget,
    this.theme = 'system',
    this.blurAmounts = true,
    this.personaTag,
  });

  UserProfile copyWith({
    String? displayName,
    String? email,
    String? avatarAsset,
    String? currency,
    double? monthlyBudget,
    String? theme,
    bool? blurAmounts,
    String? personaTag,
  }) {
    return UserProfile(
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      avatarAsset: avatarAsset ?? this.avatarAsset,
      currency: currency ?? this.currency,
      monthlyBudget: monthlyBudget ?? this.monthlyBudget,
      theme: theme ?? this.theme,
      blurAmounts: blurAmounts ?? this.blurAmounts,
      personaTag: personaTag ?? this.personaTag,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'email': email,
      'avatarAsset': avatarAsset,
      'currency': currency,
      'monthlyBudget': monthlyBudget,
      'theme': theme,
      'blurAmounts': blurAmounts,
      'personaTag': personaTag,
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      displayName: json['displayName'] as String,
      email: json['email'] as String,
      avatarAsset: json['avatarAsset'] as String?,
      currency: json['currency'] as String? ?? 'CHF',
      monthlyBudget: json['monthlyBudget'] as double?,
      theme: json['theme'] as String? ?? 'system',
      blurAmounts: json['blurAmounts'] as bool? ?? true,
      personaTag: json['personaTag'] as String?,
    );
  }

  // Demo profile for initial setup
  static UserProfile get demoProfile => const UserProfile(
        displayName: 'Demo User',
        email: 'demo@example.com',
        currency: 'CHF',
        monthlyBudget: 5000.0,
        theme: 'system',
        blurAmounts: true,
        personaTag: 'Finance Enthusiast',
      );
}
