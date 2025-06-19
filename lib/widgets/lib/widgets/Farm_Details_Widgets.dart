import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tomatooo_app/Constants.dart';
import 'package:tomatooo_app/Screens/buyer/History_Scan_Tomato.dart';
import 'package:tomatooo_app/widgets/Custom_Button_icon.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../Screens/buyer/Scan_Result_Fruit.dart';

class FarmDetailsWidgets extends StatelessWidget {
  const FarmDetailsWidgets({super.key});
  final String img = 'assets/Images/Farms/farm1.png';


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
        Uri.parse('http://${AppUri.uriFruit}:8000/detect'),
      );

      // Add file to request
      request.files.add(http.MultipartFile.fromBytes(
        'file',
         bytes,
        contentType: MediaType("image", "jpg"),
        filename: 'tomato_${DateTime.now().millisecondsSinceEpoch}.jpg',
      ));

      // Send request
      var response = await request.send();

      if (response.statusCode == 200) {
        final jsonResponse = await response.stream.bytesToString();
        final result = json.decode(jsonResponse);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScanResultFruit(
                className: result['class_number']?.toString() ?? 'N/A',
              imageBytes: bytes,
            ),
          ),
        );
      } else {
        throw Exception('Server error: ${response.reasonPhrase}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
              color: Colors.red,
              image: DecorationImage(
                image: AssetImage(img),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 15),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sunshine Farms',
                style: TextStyle(
                  fontFamily: kFontFamily,
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 18,
                    color: kSecondaryColor,
                  ),
                  SizedBox(width: 3),
                  Text(
                    'California',
                    style: TextStyle(
                      fontFamily: kFontFamily,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    '.',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.blueGrey,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    '15 miles',
                    style: TextStyle(
                      fontFamily: kFontFamily,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Icon(Icons.star, size: 30, color: Color(0xffFACC15)),
                  Icon(Icons.star, size: 30, color: Color(0xffFACC15)),
                  Icon(Icons.star, size: 30, color: Color(0xffFACC15)),
                  Icon(Icons.star, size: 30, color: Color(0xffFACC15)),
                  Icon(Icons.star, size: 30, color: Color(0xffFACC15)),
                  Text(
                    '(4.8)',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                height: 340,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Contact Information',
                        style: TextStyle(
                          fontFamily: kFontFamily,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 10,),
                      _buildContactItem(
                        Icons.local_phone_outlined,
                        'Phone',
                        '(555) 123-4567',
                              () => {},
                      ),
                      const Divider(
                        color: Colors.white,
                      ),
                      _buildContactItem(
                        Icons.email_outlined,
                        'Email',
                          'contact@sunshinefarms.com',
                            () => {/* Launch email */},
                      ),
                      const Divider(
                        color: Colors.white,
                      ),
                      _buildContactItem(
                        Icons.language,
                        'Website',
                        'www.sunshinefarms.com',
                            () => {/* Launch website */},
                      ),
                      const Divider(
                        color: Colors.white,
                      ),
                      _buildContactItem(
                        Icons.location_on_outlined,
                        'Address',
                        '1234 Tomato Lane, Fresno, CA 93706',
                            () => {/* Open maps */},
                      ),
                    ]
                  )
                ),
              ),
            SizedBox(height: 25),
            Container(
              width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.clock,
                        color: kSecondaryColor,
                        weight: 20,
                      ),
                      SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hours',
                            style: TextStyle(
                              fontFamily: kFontFamily,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Mon-Sat: 8AM-5PM, Sun: 9AM-3PM',
                            style: TextStyle(
                              fontFamily: kFontFamily,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        color: kSecondaryColor,
                        weight: 20,
                      ),
                      SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Established',
                            style: TextStyle(
                              fontFamily: kFontFamily,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '1985',
                            style: TextStyle(
                              fontFamily: kFontFamily,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 25),
          Container(
            width: double.infinity,
            height: 350,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Sunshine Farms:',
                    style: TextStyle(
                      fontFamily: kFontFamily,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Sunshine Farms has been a cornerstone of sustainable agriculture in California for over three decades. Our family has been growing premium heirloom tomatoes using traditional organic methods passed down through generations. We take pride in our commitment to biodiversity, soil health, and environmentally friendly farming practices. Our tomatoes are known for their exceptional flavor, vibrant colors, and nutritional value.',
                    style: TextStyle(
                      fontFamily: kFontFamily,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 25),
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Available Products',
                    style: TextStyle(
                      fontFamily: kFontFamily,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 15,
                                color: kSecondaryColor,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Beefsteak Tomatoes',
                                style: TextStyle(
                                  fontFamily: kFontFamily,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 15,
                                color: kSecondaryColor,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Heirloom Varieties',
                                style: TextStyle(
                                  fontFamily: kFontFamily,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 15,
                                color: kSecondaryColor,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Cherry Tomatoes',
                                style: TextStyle(
                                  fontFamily: kFontFamily,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 15,
                                color: kSecondaryColor,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Roma Tomatoes',
                                style: TextStyle(
                                  fontFamily: kFontFamily,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 25),
          Container(
            width: double.infinity,
            height: 220,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Farm Gallery',
                    style: TextStyle(
                      fontFamily: kFontFamily,
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/Images/Farms/gallery1.jpg',
                          width: 110,
                          height: 130,
                          fit: BoxFit.cover,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/Images/Farms/gallery2.jpg',
                          width: 110,
                          height: 130,
                          fit: BoxFit.cover,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/Images/Farms/gallery3.jpg',
                          width: 110,
                          height: 130,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 25),
          CustomButtonIcon(
            title: 'Call Farm',
            color: kSecondaryColor,
            IconData: Icons.phone_outlined,
            iconColor: Colors.white,
            width: double.infinity,
            height: 60,
            fontsize: 20,
            iconsize: 20,
            border: Border.all(width: 0,color: Colors.white),
            fontcolor: Colors.white,
          ),
          SizedBox(height: 30),
          Container(
            width: double.infinity,
            height: 380,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: kbackgroundColorTwo,
                    child: Icon(
                      Icons.camera_alt_outlined,
                      size: 35,
                      color: kSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Take a Photo of Your Tomato',
                    style: TextStyle(
                      fontFamily: kFontFamily,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Capture an image of your tomato to analyze its quality and freshness',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: kFontFamily,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: kThirdColor,
                    ),
                  ),
                  const SizedBox(height: 26),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () => _takePhoto(context),
                          child: CustomButtonIcon(
                            title: 'Take Photo',
                            color: kSecondaryColor,
                            IconData: Icons.camera_alt_outlined,
                            iconColor: Colors.white,
                            width: 160,
                            height: 55,
                            fontsize: 17,
                            iconsize: 17,
                            border: Border.all(width: 0,color: Colors.white),
                            fontcolor: Colors.white,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HistoryScanTomato()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30), // Reduced horizontal padding since we're adding an icon
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                color: Color(0xffFEE2E2), // Border color
                                width: 1.0, // Border width
                              ),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min, // This makes the row take only necessary space
                            children: [
                              Icon(Icons.history, color: Colors.black,size: 17,), // Added icon
                              SizedBox(width: 14), // Space between icon and text
                              Text(
                                'History',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
      ]
      )
    );
  }
}

Widget _buildContactItem(IconData icon, String label, String value, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Color(0xFFDC2626),
            size: 25,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontFamily: kFontFamily,
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: kFontFamily,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 15,
            color: Colors.grey,
          ),
        ],
      ),
    ),
  );
}