import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:tomatooo_app/Constants.dart';

class EditProfileScreen extends StatefulWidget {
  static String id = 'EditProfile';
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _profileImage;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          
        ),
        title: Text('Edit Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('Save', style: TextStyle(color: Colors.blue)),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          SizedBox(height: 10),
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : AssetImage('assets/images/profile.jpg') as ImageProvider,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.camera_alt, color: Colors.white, size: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Center(
            child: TextButton(
              onPressed: _pickImage,
              child: Text('Change Photo', style: TextStyle(color: Colors.blue)),
            ),
          ),
          SizedBox(height: 20),
          _buildTextField('Full Name', _nameController),
          SizedBox(height: 12),
          _buildTextField('Email', _emailController),
          SizedBox(height: 12),
          _buildTextField('Phone Number', _phoneController),
          SizedBox(height: 12),
          _buildTextField('Location', _locationController),
          SizedBox(height: 24),
          Text('Account', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 8),
          ListTile(
            leading: Icon(Icons.lock_outline),
            title: Text('Change Password'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          SizedBox(height: 8),
          ListTile(
            leading: Icon(Icons.delete, color: Colors.red),
            title: Text('Delete Account', style: TextStyle(color: Colors.red)),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.red, size: 16),
            onTap: () {},
            tileColor: Colors.red.withOpacity(0.05),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ],
      ),
      
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller, {bool enabled = true}) {
    return TextField(
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
