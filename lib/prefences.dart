import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Preferences',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        primaryColor: const Color(0xFF4A148C),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const UserPreferencesScreen(),
    );
  }
}

class UserPreferencesScreen extends StatefulWidget {
  const UserPreferencesScreen({super.key});

  @override
  State<UserPreferencesScreen> createState() => _UserPreferencesScreenState();
}

class _UserPreferencesScreenState extends State<UserPreferencesScreen> {
  // State variables
  bool _notificationsEnabled = true;
  String _selectedTheme = 'Dark';
  String _selectedGender = 'Female';
  bool _termsAccepted = true;
  double _fontSize = 20.0;
  String _selectedInterest = 'Flutter';
  bool _showSuccessBanner = true;

  final Color _primaryPurple = const Color(0xFF4A148C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _primaryPurple,
        leading: const Icon(Icons.arrow_back, color: Colors.white),
        title: const Text('User Preferences', style: TextStyle(color: Colors.white)),
        actions: const [
          Icon(Icons.more_vert, color: Colors.white),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Enable Notifications
            _buildSectionHeader(Icons.notifications_none, Colors.deepPurple.shade50, Colors.deepPurple, 'Enable Notifications',
              trailing: Switch(
                value: _notificationsEnabled,
                activeColor: _primaryPurple,
                onChanged: (val) => setState(() => _notificationsEnabled = val),
              ),
            ),
            _buildStatusText('Notifications : ', _notificationsEnabled ? 'Enabled' : 'Disabled', _notificationsEnabled ? Colors.green : Colors.red),
            const Divider(height: 30),

            // 2. Choose Theme
            _buildSectionHeader(Icons.palette_outlined, Colors.orange.shade50, Colors.orange, 'Choose Theme'),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _buildThemeButton('Light', Icons.wb_sunny_outlined, _selectedTheme == 'Light')),
                const SizedBox(width: 10),
                Expanded(child: _buildThemeButton('Dark', Icons.nightlight_round, _selectedTheme == 'Dark')),
              ],
            ),
            const SizedBox(height: 10),
            _buildStatusText('Selected Mode : ', _selectedTheme, _primaryPurple),
            const Divider(height: 30),

            // 3. Select Gender
            _buildSectionHeader(Icons.person_outline, Colors.pink.shade50, Colors.pink, 'Select Gender'),
            Row(
              children: [
                _buildRadioButton('Male'),
                _buildRadioButton('Female'),
                _buildRadioButton('Other'),
              ],
            ),
            _buildStatusText('Selected Gender : ', _selectedGender, _primaryPurple),
            const Divider(height: 30),

            // 4. Terms & Conditions
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.check, size: 16, color: Colors.white),
                ),
                const SizedBox(width: 12),
                RichText(
                  text: TextSpan(
                    text: 'I accept the ',
                    style: const TextStyle(color: Colors.black87, fontSize: 14),
                    children: [
                      TextSpan(
                        text: 'Terms & Conditions',
                        style: TextStyle(color: _primaryPurple, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 36.0),
              child: _buildStatusText('Status : ', _termsAccepted ? 'Accepted' : 'Pending', Colors.green),
            ),
            const Divider(height: 30),

            // 5. Font Size
            _buildSectionHeader(Icons.font_download_outlined, Colors.blue.shade50, Colors.blue, 'Font Size ', subtitle: '(Sample Text)'),
            Row(
              children: [
                const Text('10'),
                Expanded(
                  child: Slider(
                    value: _fontSize,
                    min: 10,
                    max: 30,
                    activeColor: _primaryPurple,
                    onChanged: (val) => setState(() => _fontSize = val),
                  ),
                ),
                const Text('30'),
                const SizedBox(width: 10),
                Text('Current Size : ${_fontSize.toInt()}', style: TextStyle(color: _primaryPurple)),
              ],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text('Flutter is Awesome!', style: TextStyle(fontSize: _fontSize, fontWeight: FontWeight.w500)),
              ),
            ),
            const Divider(height: 30),

            // 6. Choose Your Interests
            _buildSectionHeader(Icons.favorite_border, Colors.purple.shade50, Colors.purple, 'Choose Your Interests ', subtitle: '(Select One)'),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: ['Flutter', 'AI', 'Web Development', 'Game Development'].map((interest) {
                bool isSelected = _selectedInterest == interest;
                return ChoiceChip(
                  label: Text(interest),
                  selected: isSelected,
                  selectedColor: _primaryPurple,
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(color: isSelected ? Colors.white : _primaryPurple),
                  side: BorderSide(color: _primaryPurple),
                  onSelected: (selected) {
                    if (selected) setState(() => _selectedInterest = interest);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            _buildStatusText('Selected Interest : ', _selectedInterest, _primaryPurple),
            const Divider(height: 30),

            // 7. Quick Actions
            _buildSectionHeader(Icons.bolt, Colors.orange.shade50, Colors.orange, 'Quick Actions',
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.refresh, color: _primaryPurple, size: 18),
                      label: Text('Reset', style: TextStyle(color: _primaryPurple)),
                      style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.grey.shade300), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.save, color: Colors.white, size: 18),
                      label: const Text('Save', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(backgroundColor: _primaryPurple, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                    ),
                  ],
                )
            ),
            const SizedBox(height: 16),

            // Success Banner
            if (_showSuccessBanner)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(color: Colors.green.shade700, borderRadius: BorderRadius.circular(4)),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.white),
                    const SizedBox(width: 10),
                    const Expanded(child: Text('Preferences Saved Successfully!', style: TextStyle(color: Colors.white))),
                    GestureDetector(
                      onTap: () => setState(() => _showSuccessBanner = false),
                      child: const Text('DISMISS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),
            const Divider(height: 30),

            // 8. Profile Completion
            _buildSectionHeader(Icons.format_list_bulleted, Colors.blue.shade50, Colors.blue, 'Profile Completion'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStepperStep('1', 'Personal Details', true, true),
                Expanded(child: Container(height: 2, color: _primaryPurple)),
                _buildStepperStep('2', 'Preferences', true, false),
                Expanded(child: Container(height: 2, color: Colors.grey.shade400)),
                _buildStepperStep('3', 'Finish', false, false),
              ],
            ),
            const SizedBox(height: 40), // Bottom padding for fixed bottom bar
          ],
        ),
      ),

      // Bottom Navigation Buttons
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, -2))],
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                ),
                child: Text('CANCEL', style: TextStyle(color: _primaryPurple, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: _primaryPurple,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                ),
                child: const Text('CONTINUE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildSectionHeader(IconData icon, Color bgColor, Color iconColor, String title, {String? subtitle, Widget? trailing}) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: bgColor,
          radius: 18,
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 12),
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        if (subtitle != null)
          Text(' $subtitle', style: const TextStyle(fontSize: 14, color: Colors.grey)),
        const Spacer(),
        if (trailing != null) trailing,
      ],
    );
  }

  Widget _buildStatusText(String label, String value, Color valueColor) {
    return Padding(
      padding: const EdgeInsets.only(left: 48.0, top: 4.0),
      child: RichText(
        text: TextSpan(
          text: label,
          style: const TextStyle(color: Colors.black87, fontSize: 13),
          children: [
            TextSpan(
              text: value,
              style: TextStyle(color: valueColor, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeButton(String title, IconData icon, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() => _selectedTheme = title),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
            color: isSelected ? _primaryPurple : Colors.purple.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: isSelected ? _primaryPurple : Colors.transparent)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isSelected ? Colors.orange : Colors.orange.shade300, size: 20),
            const SizedBox(width: 8),
            Text(title, style: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioButton(String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: value,
          groupValue: _selectedGender,
          activeColor: _primaryPurple,
          onChanged: (String? val) {
            setState(() {
              _selectedGender = val!;
            });
          },
        ),
        Text(value, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget _buildStepperStep(String stepNum, String label, bool isCompleted, bool isActive) {
    return Column(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: isCompleted ? _primaryPurple : Colors.grey.shade300,
          child: Text(
            stepNum,
            style: TextStyle(color: isCompleted ? Colors.white : Colors.grey.shade600, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
              fontSize: 12,
              color: isActive ? _primaryPurple : Colors.grey,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal
          ),
        ),
      ],
    );
  }
}