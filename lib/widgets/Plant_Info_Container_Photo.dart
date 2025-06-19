import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tomatooo_app/Constants.dart';
import 'package:tomatooo_app/widgets/Custom_Button_icon.dart';
import 'dart:io';

class PlantInfoContainerPhoto extends StatefulWidget {
  const PlantInfoContainerPhoto({
    super.key,
    required this.onImageSelected,
  });

  final Function(String) onImageSelected;

  @override
  State<PlantInfoContainerPhoto> createState() => _PlantInfoContainerPhotoState();
}

class _PlantInfoContainerPhotoState extends State<PlantInfoContainerPhoto> {
  String? _selectedImagePath;
  File? _selectedImageFile;

  Future<void> _takePhoto(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80, // Reduce image quality to avoid large files
      maxWidth: 1024, // Limit image width
      maxHeight: 1024, // Limit image height
    );

    if (photo != null) {
      setState(() {
        _selectedImagePath = photo.path;
        _selectedImageFile = File(photo.path);
      });
      widget.onImageSelected(photo.path);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Photo captured: ${photo.name}')),
      );
    }
  }

  Future<void> _pickFromGallery(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80, // Reduce image quality to avoid large files
      maxWidth: 1024, // Limit image width
      maxHeight: 1024, // Limit image height
    );

    if (image != null) {
      setState(() {
        _selectedImagePath = image.path;
        _selectedImageFile = File(image.path);
      });
      widget.onImageSelected(image.path);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Photo selected: ${image.name}')),
      );
    }
  }

  void _showImageOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _takePhoto(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickFromGallery(context);
                },
              ),
              if (_selectedImagePath != null)
                ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: const Text('Remove Photo', style: TextStyle(color: Colors.red)),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _selectedImagePath = null;
                      _selectedImageFile = null;
                    });
                    widget.onImageSelected('');
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Plant Photo',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: kFontFamily,
              ),
            ),
            const SizedBox(height: 20),
            
            // Show selected image preview
            if (_selectedImagePath != null && _selectedImageFile != null)
              Container(
                width: double.infinity,
                height: 120,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    _selectedImageFile!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 120,
                  ),
                ),
              ),
            
            GestureDetector(
              onTap: () => _showImageOptions(context),
              child: CustomButtonIcon(
                title: _selectedImagePath != null ? 'Change Photo' : 'Add Plant Photo',
                color: kPraimaryColor,
                IconData: _selectedImagePath != null ? Icons.edit : Icons.camera_alt_outlined,
                iconColor: Colors.white,
                width: double.infinity,
                height: 50,
                fontsize: 17,
                iconsize: 17,
                border: Border.all(width: 0),
                fontcolor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
