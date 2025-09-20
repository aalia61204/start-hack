import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_controller.dart';
import 'profile_models.dart';

class ProfileScreen extends ConsumerWidget {
  final VoidCallback? onExportCsv;
  final VoidCallback? onReloadDemo;

  const ProfileScreen({
    super.key,
    this.onExportCsv,
    this.onReloadDemo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileControllerProvider);
    final controller = ref.read(profileControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            _buildHeader(profile),
            const SizedBox(height: 32),
            
            // Preferences Section
            SectionHeader(title: 'Preferences'),
            const SizedBox(height: 16),
            
            // Privacy Toggle
            SettingTile(
              title: 'Privacy — Blur amounts',
              subtitle: 'Hide transaction amounts in the app',
              trailing: Switch(
                value: profile.blurAmounts,
                onChanged: (_) => controller.toggleBlur(),
              ),
            ),
            const SizedBox(height: 16),
            
            // Theme Control
            SettingTile(
              title: 'Theme',
              subtitle: 'Choose your preferred theme',
              trailing: DropdownButton<String>(
                value: profile.theme,
                onChanged: (value) {
                  if (value != null) {
                    controller.setTheme(value);
                  }
                },
                items: const [
                  DropdownMenuItem(value: 'system', child: Text('System')),
                  DropdownMenuItem(value: 'light', child: Text('Light')),
                  DropdownMenuItem(value: 'dark', child: Text('Dark')),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Currency Dropdown
            SettingTile(
              title: 'Currency',
              subtitle: 'Default currency for transactions',
              trailing: DropdownButton<String>(
                value: profile.currency,
                onChanged: (value) {
                  if (value != null) {
                    controller.setCurrency(value);
                  }
                },
                items: const [
                  DropdownMenuItem(value: 'CHF', child: Text('CHF')),
                  DropdownMenuItem(value: 'EUR', child: Text('EUR')),
                  DropdownMenuItem(value: 'USD', child: Text('USD')),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Monthly Budget
            SettingTile(
              title: 'Monthly Budget',
              subtitle: 'Set your monthly spending limit',
              trailing: SizedBox(
                width: 100,
                child: TextFormField(
                  initialValue: profile.monthlyBudget?.toString() ?? '',
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: '0.00',
                    suffixText: profile.currency,
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  ),
                  onChanged: (value) {
                    final budget = double.tryParse(value);
                    controller.setMonthlyBudget(budget);
                  },
                ),
              ),
            ),
            const SizedBox(height: 32),
            
            // Actions Section
            SectionHeader(title: 'Actions'),
            const SizedBox(height: 16),
            
            // Export CSV Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onExportCsv,
                icon: const Icon(Icons.download),
                label: const Text('Export CSV'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            
            // Reload Demo Data Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onReloadDemo,
                icon: const Icon(Icons.refresh),
                label: const Text('Reload Demo Data'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            
            // Reset Demo Profile Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => controller.resetDemo(),
                icon: const Icon(Icons.restore),
                label: const Text('Reset demo profile'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(UserProfile profile) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey[300],
            backgroundImage: profile.avatarAsset != null
                ? AssetImage(profile.avatarAsset!)
                : const AssetImage('assets/logos/user_fallback.png'),
            child: profile.avatarAsset == null
                ? const Icon(Icons.person, size: 40, color: Colors.grey)
                : null,
          ),
          const SizedBox(width: 16),
          
          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.displayName,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  profile.email,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                if (profile.personaTag != null)
                  PersonaChip(label: profile.personaTag!),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Small widget components
class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.grey[800],
      ),
    );
  }
}

class SettingTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget trailing;

  const SettingTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}

class PersonaChip extends StatelessWidget {
  final String label;

  const PersonaChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.blue[700],
        ),
      ),
    );
  }
}
