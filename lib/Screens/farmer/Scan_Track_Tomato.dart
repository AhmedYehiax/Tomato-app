import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:tomatooo_app/Constants.dart';
import 'package:tomatooo_app/widgets/Custom_Button_icon.dart';
import 'package:tomatooo_app/widgets/Custom_Container_widget.dart';
import 'package:http_parser/http_parser.dart';
import '../Profile_Page.dart';
import '../homepage.dart';
import 'ScanResultsLeaf.dart';
import 'Tomato_Fruit_Tracking.dart';

class ScanTrackTomato extends StatefulWidget {
  const ScanTrackTomato({super.key});
  static String id = 'Scan';

  State<ScanTrackTomato> createState() => _ScanTrackTomatoState();
}

class _ScanTrackTomatoState extends State<ScanTrackTomato>
    with TickerProviderStateMixin {
  late TabController tabController;

  int _currentIndex = 0;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  final _items = [
    SalomonBottomBarItem(
      icon: Icon(Icons.home_outlined),
      title: Text('Home'),
      selectedColor: Colors.white,
      unselectedColor: Colors.grey,
    ),
    SalomonBottomBarItem(
      icon: Icon(Icons.shopping_cart_outlined),
      title: Text('Shopping'),
      selectedColor: Colors.white,
      unselectedColor: Colors.grey,
    ),
    SalomonBottomBarItem(
      icon: Icon(Icons.person_outlined),
      title: Text('Person'),
      selectedColor: Colors.white,
      unselectedColor: Colors.grey,
    ),
  ];

  // -------------------------- Leaf Tomato---------------------------------------------------------
  Future<void> _takePhoto(BuildContext context) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? photo = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 1200,
      );

      if (photo == null) return;

      final bytes = await photo.readAsBytes();
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://${AppUri.uriFarmer}/predict_leaf'),
      );

      request.files.add(http.MultipartFile.fromBytes(
        'file',
        bytes,
        contentType: MediaType("image", "jpg"),
        filename: 'tomato_${DateTime.now().millisecondsSinceEpoch}.jpg',
      ));

      var response = await request.send();

      if (response.statusCode == 200) {
        final jsonResponse = await response.stream.bytesToString();
        final body = json.decode(jsonResponse) as Map<String, dynamic>;
        final base64Image = body["image"] as String? ?? '';

        if (base64Image.isEmpty) {
          throw Exception('No image data received from server');
        }

        final decodedImage = base64.decode(base64Image);
        final detections = (body["detections"] as List<dynamic>?) ?? [];

        if (detections.isNotEmpty) {
          final detection = detections.first;
          final className = detection["class_name"]?.toString() ?? "Unknown";
          final confidence = (detection["confidence"] as double?) ?? 0.0;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScanResultsLeaf(
                className: className,
                confidence: confidence,
                imageBytes: decodedImage,
              ),
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("No Detection"),
              content: const Text("No diseases were detected in the image."),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"),
                ),
              ],
            ),
          );
        }
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      print('Error: $e\n$stackTrace');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }
// -------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: const Color(0xffDCFCE7),
        backgroundColor: const Color(0xffDCFCE7),
        automaticallyImplyLeading: false,
        title: const Text(
          'Welcome, Farmer!',
          style: TextStyle(
            fontFamily: kFontFamily,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: kPraimryTextColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ListView(
          children: [
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: Text(
                    'What would you like to do today?',
                    style: TextStyle(
                      fontFamily: kFontFamily,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  width: double.infinity,
                  height: 400,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.4, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffFFFFFF),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomContainerWidget(
                        title: 'Detect Tomato Disease',
                        subtitle:
                        'Take a photo of your tomato plant leaves to identify potential diseases and get treatment recommendations',
                        IconData: FontAwesomeIcons.leaf,
                        color: Colors.black,
                        backgroundColor: const Color(0xffDCFCE7),
                        iconColor: kPraimaryColor,
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () => _takePhoto(context),
                        child: CustomButtonIcon(
                          fontcolor: Colors.white,
                          border: Border.all(width: 0, color: Colors.grey),
                          fontsize: 16,
                          iconsize: 20,
                          width: 340,
                          height: 60,
                          title: 'Scan Plant Leaves',
                          color: kPraimaryColor,
                          IconData: Icons.camera_alt_outlined,
                          iconColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 26),
                Container(
                  width: double.infinity,
                  height: 400,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.4, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffFFFFFF),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomContainerWidget(
                        title: 'Tomato Fruit Follow-up',
                        subtitle:
                        'Monitor your tomato fruit growth, track quality metrics, and record harvest data',
                        IconData: Icons.show_chart,
                        color: Colors.black,
                        backgroundColor: const Color(0xffDCFCE7),
                        iconColor: kPraimaryColor,
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, TomatoFruitTracking.id);
                        },
                        child: CustomButtonIcon(
                          fontcolor: Colors.white,
                          border: Border.all(width: 0, color: Colors.grey),
                          fontsize: 16,
                          iconsize: 18,
                          width: 340,
                          height: 60,
                          title: 'Track Fruit Development',
                          color: kPraimaryColor,
                          IconData: Icons.show_chart,
                          iconColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
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
              Navigator.pushReplacementNamed(context, ScanTrackTomato.id);
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