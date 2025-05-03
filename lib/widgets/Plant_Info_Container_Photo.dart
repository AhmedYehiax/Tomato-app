import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tomatooo_app/Constants.dart';
import 'package:tomatooo_app/widgets/Custom_Button_icon.dart';

class PlantInfoContainerPhoto extends StatelessWidget {
  const PlantInfoContainerPhoto({super.key});

  Future<void> _takePhoto(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      // You can do something with the photo here
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Photo captured: ${photo.name}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160,
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
            GestureDetector(
              onTap: () => _takePhoto(context), // <-- trigger camera
              child: CustomButtonIcon(
                title: 'Take Plant Photo',
                color: kPraimaryColor,
                IconData: Icons.camera_alt_outlined,
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
