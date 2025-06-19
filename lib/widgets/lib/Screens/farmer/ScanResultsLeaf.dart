import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tomatooo_app/Constants.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
class ScanResultsLeaf extends StatelessWidget {
  final String className;
  final double confidence;
  final Uint8List imageBytes;

  const ScanResultsLeaf({
    Key? key,
    required this.className,
    required this.confidence,
    required this.imageBytes,
  }) : super(key: key);

  Future<void> _retakePhoto(BuildContext context) async {
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

          Navigator.pushReplacement(
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
  String _getDiseaseDescription(String diseaseName) {
    switch (diseaseName.toLowerCase()) {
      case 'early blight':
        return "Early blight is a common fungal disease that affects tomato plants. It's characterized by brown spots with concentric rings on leaves, which can lead to leaf yellowing and drop.";
      case 'late blight':
        return "Late blight is a serious fungal disease that can quickly destroy tomato plants. It causes irregular grayish spots that turn into large brown lesions, often with white fungal growth on the underside.";
      case 'leaf mold':
        return "Leaf mold is a fungal disease that thrives in humid conditions. It causes pale green or yellowish spots on upper leaf surfaces with fuzzy grayish-purple mold on the undersides.";
      case 'septoria leaf spot':
        return "Septoria leaf spot causes numerous small brown spots with dark edges on leaves. The centers may fall out, giving leaves a shot-hole appearance.";
      case 'healthy':
        return "Your tomato plant appears healthy! Continue with good cultural practices like proper watering, fertilization, and pest management to maintain plant health.";
      default:
        return "This condition has been identified in your tomato plant. While we don't have specific information about it, general good cultural practices can help maintain plant health.";
    }
  }

  List<Widget> _getCareInstructions(String diseaseName) {
    final generalInstructions = [
      InstructionItem(
        icon: FontAwesomeIcons.leaf,
        text: 'Remove affected leaves to prevent spread',
      ),
      InstructionItem(
        icon: Icons.water_drop_outlined,
        text: 'Water at the base of the plant to keep leaves dry',
      ),
      InstructionItem(
        icon: Icons.wb_sunny_outlined,
        text: 'Ensure proper sunlight and air circulation',
      ),
    ];

    final specificInstructions = <InstructionItem>[];

    switch (diseaseName.toLowerCase()) {
      case 'early blight':
      case 'late blight':
        specificInstructions.addAll([
          InstructionItem(
            icon: Icons.clean_hands,
            text: 'Apply fungicide containing chlorothalonil or copper',
          ),
          InstructionItem(
            icon: Icons.grass,
            text: 'Rotate crops and avoid planting tomatoes in same spot',
          ),
        ]);
        break;
      case 'leaf mold':
        specificInstructions.addAll([
          InstructionItem(
            icon: Icons.deck,
            text: 'Reduce humidity and improve ventilation',
          ),
          InstructionItem(
            icon: Icons.water,
            text: 'Avoid overhead watering',
          ),
        ]);
        break;
      case 'septoria leaf spot':
        specificInstructions.addAll([
          InstructionItem(
            icon: Icons.clean_hands,
            text: 'Apply fungicide at first sign of disease',
          ),
          InstructionItem(
            icon: Icons.delete,
            text: 'Remove and destroy all plant debris at season end',
          ),
        ]);
        break;
    }

    return [
      ...generalInstructions,
      ...specificInstructions,
    ].map((item) => _buildInstructionRow(item.icon, item.text)).toList();
  }

  Widget _buildInstructionRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: kbackgroundColorTwo,
            child: Icon(
              icon,
              size: 18,
              color: kPraimryTextColor,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: kFontFamily,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffDCFCE7),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon:const Icon(Icons.arrow_back)
        ),

        title: Center(
          child: const Text(
            'Scan Results',
            style: TextStyle(
              fontFamily: kFontFamily,
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: kPraimryTextColor,
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: (){
                showDialog(
                    context: context,
                    builder: (BuildContext context){
                      var _fromkey;
                      var _nameController;
                      var _emailController;
                      var _problemController;
                      return AlertDialog(
                        title: Row(
                          children: [
                            const Text("Report an Issue"),
                            SizedBox(width: 40),
                            IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.cancel_outlined,size: 35,))
                          ],
                        ),
                        content: Form(key: _fromkey,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(height: 10,),
                                  TextFormField(
                                    controller: _nameController,
                                    decoration: InputDecoration(
                                      labelText: "Your Name",
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value){
                                      if(value==null|| value.isEmpty){
                                        return "Please Enter Your Name ";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 20,),
                                  TextFormField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      labelText: "Email Address",
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value){
                                      if(value==null|| value.isEmpty){
                                        return "Please Enter Your Email ";
                                      }
                                      if(!value.contains('@')){
                                        return "Please Enter a valid email ";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 20,),
                                  TextFormField(
                                    controller: _problemController,
                                    decoration: InputDecoration(
                                      labelText: "Describe the Problem ",
                                      border: OutlineInputBorder(),
                                    ),
                                    maxLines: 7,
                                    validator: (value){
                                      if(value==null|| value.isEmpty){
                                        return "Please Describe the Problem ";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 50,),
                                  ElevatedButton(
                                    onPressed: () {
                                      if(_fromkey.currentState!.validate()) {
                                        final reportData = {
                                          "name": _nameController.text,
                                          "email": _emailController.text,
                                          "problem": _problemController.text,
                                          "timestamp": DateTime.now().toString(),
                                        };
                                        print("Report submitted :$reportData");
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 80),
                                      elevation: 0, // This removes the shadow
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: BorderSide(color: Colors.green), // This adds the outline border
                                      ),
                                    ),
                                    child: const Text(
                                      'Send',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    // TextButton(onPressed: (){
                                    //   if(_fromkey.currentState!.validate()){
                                    //     final reportData={
                                    //       "name": _nameController.text,
                                    //       "email": _emailController.text,
                                    //       "problem": _problemController.text,
                                    //
                                    //       "timestamp": DateTime.now().toString(),
                                    //     };
                                    //     print("Report submitted :$reportData");
                                    //     Navigator.pop(context);
                                    //
                                    //   }
                                    // }, child: Text("Submit"),
                                    // )
                                  )
                                ],
                              ),
                            )
                        ),

                      );
                    }
                );
              },
              icon: const Icon(Icons.report_gmailerrorred_outlined, color: Colors.black)
          ),
        ]
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      child: Image.memory(
                        imageBytes,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          className,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: kPraimryTextTwoColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Confidence: ${(confidence * 100).toStringAsFixed(2)}%',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 17,
                            color: Colors.black,
                            height: 0,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _getDiseaseDescription(className),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[800],
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Care Instructions',
                      style: TextStyle(
                        fontFamily: kFontFamily,
                        fontSize: 19,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 15),
                    ..._getCareInstructions(className),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _retakePhoto(context),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 30),
                padding: const EdgeInsets.all(14),
                backgroundColor: kPraimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Scan Again',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class InstructionItem {
  final IconData icon;
  final String text;

  InstructionItem({required this.icon, required this.text});
}