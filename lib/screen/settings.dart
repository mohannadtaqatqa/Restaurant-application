import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

// Define color variables
const Color primaryColor = Colors.orange;
const Color secondaryColor = Colors.white;
const Color textColor = Colors.black;
const Color iconColor = Colors.orange;
const Color appBarColor = Colors.orange;

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الإعدادات',
          style: TextStyle(color: secondaryColor),
        ),
        backgroundColor: appBarColor,
      ),
      body: Column(
        children: [
          // Profile section at the top
          Container(
            padding: EdgeInsets.all(16),
            color: primaryColor.withOpacity(0.2),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/profile_picture.png'),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'اسم المستخدم',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'رقم الهاتف: +1234567890',
                      style: TextStyle(
                        fontSize: 16,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SettingsList(
              sections: [
                SettingsSection(
                  title: Text(
                    'الملف الشخصي',
                    style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
                  ),
                  tiles: <SettingsTile>[
                    SettingsTile.navigation(
                      leading: Icon(Icons.person, color: iconColor),
                      title: Text('عرض الملف الشخصي'),
                      onPressed: (BuildContext context) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProfileScreen()),
                        );
                      },
                    ),
                  ],
                ),
                SettingsSection(
                  title: Text(
                    'الإعدادات والخصوصية',
                    style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
                  ),
                  tiles: <SettingsTile>[
                    SettingsTile.navigation(
                      leading: Icon(Icons.settings, color: iconColor),
                      title: Text('إعدادات الحساب'),
                      onPressed: (BuildContext context) {
                        // Navigate to account settings screen
                      },
                    ),
                    SettingsTile.switchTile(
                      onToggle: (value) {
                        // Handle dark mode toggle
                      },
                      initialValue: false,
                      leading: Icon(Icons.dark_mode, color: iconColor),
                      title: Text('الوضع الليلي'),
                    ),
                    SettingsTile.navigation(
                      leading: Icon(Icons.language, color: iconColor),
                      title: Text('تغيير اللغة'),
                      onPressed: (BuildContext context) {
                        // Navigate to language selection screen
                      },
                    ),
                    SettingsTile.navigation(
                      leading: Icon(Icons.notifications, color: iconColor),
                      title: Text('إعدادات الإشعارات'),
                      onPressed: (BuildContext context) {
                        // Navigate to notification settings screen
                      },
                    ),
                  ],
                ),
                SettingsSection(
                  title: Text(
                    'الأمان',
                    style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
                  ),
                  tiles: <SettingsTile>[
                    SettingsTile.navigation(
                      leading: Icon(Icons.lock, color: iconColor),
                      title: Text('تغيير كلمة المرور'),
                      onPressed: (BuildContext context) {
                        // Navigate to change password screen
                      },
                    ),
                    SettingsTile.navigation(
                      leading: Icon(Icons.logout, color: iconColor),
                      title: Text('تسجيل الخروج'),
                      onPressed: (BuildContext context) {
                        // Handle logout
                      },
                    ),
                  ],
                ),
                SettingsSection(
                  title: Text(
                    'الدعم',
                    style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
                  ),
                  tiles: <SettingsTile>[
                    SettingsTile.navigation(
                      leading: Icon(Icons.help, color: iconColor),
                      title: Text('الأسئلة الشائعة'),
                      onPressed: (BuildContext context) {
                        // Navigate to FAQ screen
                      },
                    ),
                    SettingsTile.navigation(
                      leading: Icon(Icons.contact_support, color: iconColor),
                      title: Text('التواصل مع الدعم'),
                      onPressed: (BuildContext context) {
                        // Navigate to contact support screen
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Placeholder for ProfileScreen
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الملف الشخصي',
          style: TextStyle(color: secondaryColor),
        ),
        backgroundColor: appBarColor,
      ),
      body: Center(
        child: Text(
          'صفحة الملف الشخصي',
          style: TextStyle(fontSize: 24, color: textColor),
        ),
      ),
    );
  }
}
