import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:tomatooo_app/Constants.dart';
import 'package:tomatooo_app/Screens/Settings.dart';
import 'package:tomatooo_app/Screens/buyer/Tomato_MarketPlace.dart';
import 'package:tomatooo_app/Screens/homepage.dart';
import 'package:tomatooo_app/widgets/Custom_Button.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static String id = 'Profilepage';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  // Controllers for password change dialog
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _verificationCodeController =
      TextEditingController();
  bool _isVerificationSent = false;

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
// Whatsapp Launcher
  Future<void> _launchWhatsApp() async {
    final Uri whatsappUrl = Uri.parse('https://wa.me/201151109167');
    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch WhatsApp')),
        );
      }
    }
  }

  void _showPasswordChangeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Change Password'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!_isVerificationSent) ...[
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: _newPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'New Password',
                          hintText: 'Enter new password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          hintText: 'Confirm new password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (_newPasswordController.text !=
                              _confirmPasswordController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Passwords do not match')),
                            );
                            return;
                          }
                          // Here you would typically send the verification code
                          setState(() {
                            _isVerificationSent = true;
                          });
                        },
                        child: Text('Send Verification Code'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kSecondaryColor,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ] else ...[
                      TextField(
                        controller: _verificationCodeController,
                        decoration: InputDecoration(
                          labelText: 'Verification Code',
                          hintText: 'Enter verification code',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Here you would verify the code and update the password
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Password updated successfully'),
                            ),
                          );
                        },
                        child: Text('Verify and Update Password'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kSecondaryColor,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _emailController.clear();
                    _newPasswordController.clear();
                    _confirmPasswordController.clear();
                    _verificationCodeController.clear();
                    setState(() {
                      _isVerificationSent = false;
                    });
                  },
                  child: Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  final _items = [
    SalomonBottomBarItem(
      icon: Icon(Icons.home_outlined),
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
            'Profile',
            style: TextStyle(
              fontFamily: kFontFamily,
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: kPraimryTextTwoColor,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(height: 60),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child:
                        _image == null
                            ? Icon(Icons.person, size: 50, color: Colors.white)
                            : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: MediaQuery.of(context).size.width * 0.35,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        decoration: BoxDecoration(
                          color: kSecondaryColor,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(6),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                textAlign: TextAlign.center,
                'Sarah Johnson',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                textAlign: TextAlign.center,
                'sarah.johnson@example.com',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),

              // Account Settings
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    buildSectionTitle('ACCOUNT SETTINGS'),
                    Divider(
                      height: 2,
                      color: const Color.fromARGB(255, 230, 208, 208),
                    ),
                    buildTile(
                      icon: Icons.lock,
                      title: 'Change Password',
                      onTap: _showPasswordChangeDialog,
                    ),
                    Divider(
                      height: 2,
                      color: const Color.fromARGB(255, 230, 208, 208),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Settings.id,
                          arguments: _image,
                        );
                      },
                      child: buildTile(icon: Icons.settings, title: 'Settings'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Support
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    buildSectionTitle('SUPPORT'),
                    Divider(
                      height: 2,
                      color: const Color.fromARGB(255, 230, 208, 208),
                    ),
                    GestureDetector(
                      onTap: _launchWhatsApp,
                      child: buildTile(
                        icon: Icons.headset_mic,
                        title: 'Contact Us',
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Log Out Button
              GestureDetector(
                onTap: () {},
                child: CustomButton(
                  title: 'Log out',
                  color: kSecondaryColor,
                  width: double.infinity,
                  height: 50,
                  fontsize: 18,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
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

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildTile({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
