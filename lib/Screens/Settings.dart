import 'package:flutter/material.dart';
import 'dart:io';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:tomatooo_app/Constants.dart';
import 'package:tomatooo_app/Screens/Edit_Profile.dart';
import 'package:tomatooo_app/Screens/Profile_Page.dart';
import 'package:tomatooo_app/Screens/buyer/Tomato_MarketPlace.dart';
import 'package:tomatooo_app/Screens/homepage.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});
  static String id = 'Settings';

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  File? _profileImage;
  final _items = [
    SalomonBottomBarItem(
      icon: Icon(Icons.house_outlined),
      title: Text('Home'),
      selectedColor: Colors.white,
      unselectedColor: Colors.white,
    ),
    SalomonBottomBarItem(
      icon: Icon(Icons.shopping_cart_outlined),
      title: Text('Shopping'),
      selectedColor: Colors.white,
      unselectedColor: Colors.white,
    ),
    SalomonBottomBarItem(
      icon: Icon(Icons.person_outlined),
      title: Text('Person'),
      selectedColor: Colors.white,
      unselectedColor: Colors.white,
    ),
  ];
  int _currentIndex = 2;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is File) {
      setState(() {
        _profileImage = args;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColorTwo,
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: const Color(0xffFEE2E2),
        backgroundColor: const Color(0xffFEE2E2),
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Settings',
            style: TextStyle(
              fontFamily: kFontFamily,
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: kPraimryTextTwoColor,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            // Profile Header
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 15,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: _profileImage != null 
                              ? FileImage(_profileImage!) 
                              : const AssetImage('assets/images/profile.jpg') as ImageProvider,
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Sarah Johnson',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'sarah.j@email.com',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Edit Profile
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                      title: const Text('Edit Profile'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                       Navigator.pushNamed(context, EditProfileScreen.id);
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'Preferences',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Language
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      leading: const Icon(Icons.language),
                      title: const Text('Language'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text('English'),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                      onTap: () {
                        // Handle language selection
                      },
                    ),
                    const Divider(color: kbackgroundColorTwo, thickness: 2),

                    // Dark Mode
                    SwitchListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      title: const Text('Dark Mode'),
                      secondary: const Icon(Icons.dark_mode),
                      value: false,
                      onChanged: (bool value) {
                        // Handle dark mode toggle
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: const Color(0xff282F3C),
        ),
        margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: SalomonBottomBar(
          curve: Curves.ease,
          margin: const EdgeInsets.all(10),
          duration: const Duration(milliseconds: 300),
          items: _items,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });

            // Navigation logic
            if (index == 0) {
              Navigator.pushReplacementNamed(context, TomatoMarketplace.id);
            } else if (index == 1) {
              Navigator.maybePop(context, HomePage.id);
            } else if (index == 2) {
              Navigator.pushReplacementNamed(context, ProfilePage.id);
            }
          },
        ),
      ),
    );
  }
}
