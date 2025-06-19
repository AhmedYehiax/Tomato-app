import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:tomatooo_app/Constants.dart';
import 'package:tomatooo_app/widgets/Custom_Button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static String id = 'ProfilePage';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = false;
  File? _profileImage;

  final nameController = TextEditingController(text: 'Anna Avetisyan');
  final birthdayController = TextEditingController(text: 'Birthday');
  final phoneController = TextEditingController(text: '818 123 4567');
  final instagramController = TextEditingController(text: 'Instagram account');
  final emailController = TextEditingController(text: 'info@aplusdesign.co');
  final passwordController = TextEditingController(text: 'Password');

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _profileImage = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 50, bottom: 30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [kPraimryTextColor, kPraimaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    backgroundImage:
                        _profileImage != null
                            ? FileImage(_profileImage!)
                            : null,
                    child:
                        _profileImage == null
                            ? Icon(
                              Icons.person,
                              size: 40,
                              color: kPraimaryColor,
                            )
                            : null,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  nameController.text,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),

          // Editable Content
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              children: [
                buildEditableRow(Icons.person_outline, nameController),
                buildEditableRow(Icons.cake_outlined, birthdayController),
                buildEditableRow(Icons.phone_android, phoneController),
                buildEditableRow(
                  Icons.camera_alt_outlined,
                  instagramController,
                ),
                buildEditableRow(Icons.email_outlined, emailController),
                buildEditableRow(Icons.visibility_outlined, passwordController),
              ],
            ),
          ),

          // Edit/Save Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isEditing = !isEditing;
                });
              },
              child: CustomButton(
                title: isEditing ? 'Save Profile' : 'Edit Profile',
                color: kPraimaryColor,
                width: double.infinity,
                height: 50,
                fontsize: 16,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEditableRow(IconData icon, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: kPraimaryColor),
          const SizedBox(width: 20),
          Expanded(
            child:
                isEditing
                    ? TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                      ),
                    )
                    : Text(
                      controller.text,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: kFontFamily,
                      ),
                    ),
          ),
        ],
      ),
    );
  }
}
