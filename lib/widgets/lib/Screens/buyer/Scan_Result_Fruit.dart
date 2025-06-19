import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:tomatooo_app/Constants.dart';

class ScanResultFruit extends StatelessWidget {
  final String className;
  final Uint8List? imageBytes;

  const ScanResultFruit({
    Key? key,
    required this.className,
    this.imageBytes,
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
        Uri.parse('http://${AppUri.uriFruit}:8000/detect'),
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
        final result = json.decode(jsonResponse);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ScanResultFruit(
              className: result['class_number']?.toString() ?? 'N/A',
              imageBytes: bytes,
            ),
          ),
        );
      } else {
        throw Exception('Failed to analyze image');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  // Helper function to get quality data based on class name
  Map<String, dynamic> getQualityData(String className) {
    switch (className) {
      case 'Class A':
        return {
          'class': 'Class A',
          'name': 'Very Fresh',
          'description': 'Bright red, firm texture, no blemishes',
          'daysPostHarvest': '0-3 days',
          'daysLeft': '13-16 days',
          'color': 'green',
        };
      case 'Class B':
        return {
          'class': 'Class B',
          'name': 'Fresh',
          'description': 'Red color, slightly softer but still firm',
          'daysPostHarvest': '4-6 days',
          'daysLeft': '10-12 days',
          'color': 'emerald',
        };
      case 'Class C':
        return {
          'class': 'Class C',
          'name': 'Moderately Fresh',
          'description': 'Slightly dull red, softening texture',
          'daysPostHarvest': '8-9 days',
          'daysLeft': '7-9 days',
          'color': 'yellow',
        };
      case 'Class D':
        return {
          'class': 'Class D',
          'name': 'Starting to Degrade',
          'description': 'Dull red/orange, soft texture, possible wrinkles',
          'daysPostHarvest': '10-12 days',
          'daysLeft': '4-6 days',
          'color': 'orange',
        };
      case 'Class E':
        return {
          'class': 'Class E',
          'name': 'Rotten (Unusable)',
          'description': 'Very soft, mold spots, strong odor',
          'daysPostHarvest': '14+ days',
          'daysLeft': '0 days',
          'color': 'red',
        };
      default:
        return {
          'class': 'NO Tomato',
          'name': 'Unknown Quality',
          'description': 'Unable to determine quality',
          'daysPostHarvest': 'N/A',
          'daysLeft': 'N/A',
          'color': 'grey',
        };
    }
  }

  // Helper function to get color based on quality class
  Color getColorForQuality(String colorName) {
    switch (colorName) {
      case 'green':
        return Colors.green;
      case 'emerald':
        return Colors.green.shade700;
      case 'yellow':
        return Colors.amber;
      case 'orange':
        return Colors.orange;
      case 'red':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuality = getQualityData(className);

    return Scaffold(
      backgroundColor: const Color(0xffFEF3F3),
      appBar: AppBar(
          backgroundColor: const Color(0xffFEE2E2),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Center(
            child: Text(
              "Quality Scan",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        var _fromkey;
                        var _nameController;
                        var _emailController;
                        var _problemController;
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          title: Row(
                            children: [
                              const Text("Report an Issue"),
                              SizedBox(width: 40),
                              IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: Icon(Icons.cancel_outlined, size: 35)
                              )
                            ],
                          ),
                          content: Form(
                              key: _fromkey,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    SizedBox(height: 10),
                                    TextFormField(
                                      controller: _nameController,
                                      decoration: InputDecoration(
                                        labelText: "Your Name",
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please Enter Your Name";
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 20),
                                    TextFormField(
                                      controller: _emailController,
                                      decoration: InputDecoration(
                                        labelText: "Email Address",
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please Enter Your Email";
                                        }
                                        if (!value.contains('@')) {
                                          return "Please Enter a valid email";
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 20),
                                    TextFormField(
                                      controller: _problemController,
                                      decoration: InputDecoration(
                                        hintText: "Describe the Problem",
                                        border: OutlineInputBorder(),
                                      ),
                                      maxLines: 7,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please Describe the Problem";
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 50),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (_fromkey.currentState!.validate()) {
                                          final reportData = {
                                            "name": _nameController.text,
                                            "email": _emailController.text,
                                            "problem": _problemController.text,
                                            "timestamp": DateTime.now().toString(),
                                          };
                                          print("Report submitted: $reportData");
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 80),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          side: BorderSide(color: Colors.red),
                                        ),
                                      ),
                                      child: const Text(
                                        'Send',
                                        style: TextStyle(fontSize: 16),
                                      ),
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
        padding: const EdgeInsets.symmetric(horizontal: 20 ),
        child: ListView(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: getColorForQuality(currentQuality['color'] as String).withOpacity(0.5),
                  width: 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 250,
                          width: 300,
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
                          child: imageBytes != null
                              ? ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.memory(
                              imageBytes!,
                              fit: BoxFit.cover,
                            ),
                          )
                              : const Center(child: Text('No image available')),
                        ),
                        SizedBox(height: 24,),
                        Row(
                          children: [
                            Text(
                              currentQuality['name'] as String,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: getColorForQuality(currentQuality['color'] as String),
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: getColorForQuality(currentQuality['color'] as String),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                '${currentQuality['class']}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentQuality['description'] as String,
                              style: const TextStyle(fontFamily: kFontFamily),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoBox(
                            label: 'Post-Harvest Age',
                            value: currentQuality['daysPostHarvest'] as String,
                            icon: Icons.access_time,
                            color: getColorForQuality(currentQuality['color'] as String),
                          )
                        ),
                        const SizedBox(width: 7),
                        Expanded(
                          child: _buildInfoBox(
                            label: 'Shelf Life Left',
                            value: currentQuality['daysLeft'] as String,
                            icon: Icons.access_time,
                            color: getColorForQuality(currentQuality['color'] as String),
                          )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Room Temperature Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.orange.shade200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.thermostat, color: Colors.orange,size: 30,),
                        SizedBox(width: 8),
                        Text(
                          'Room Temperature (28-31°C)',
                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'At room temperature, tomatoes will ripen faster and have a shorter shelf life. For your tomato quality (Class '
                          '${currentQuality['class']}), the expected remaining shelf life is approximately ${currentQuality['daysLeft']} at room temperature.',
                      style: TextStyle(fontFamily: kFontFamily,fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Cool Temperature Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.blue.shade200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.thermostat, color: Colors.blue,size: 30,),
                        SizedBox(width: 8),
                        Text(
                          'Cool Temperature (10-15°C)',
                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Storing tomatoes in a refrigerator (10-15°C) can extend their shelf life by approximately 5-7 days beyond the estimates for room temperature. This means your tomato could last up to '
                          '${currentQuality['daysLeft'].toString().contains('-')
                          ? (int.parse((currentQuality['daysLeft'] as String).split('-')[1].replaceAll(' days', '')) + 7).toString() + ' days'
                          : '0 days'} if refrigerated.',style: TextStyle(fontFamily: kFontFamily),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.green.shade100),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Recommendation',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'For maximum shelf life, store your tomatoes in a cool place. However, refrigeration may slightly affect flavor, so consider your priorities between longevity and taste. If you plan to consume the tomatoes within '
                                '${(currentQuality['daysLeft'] as String).split('-')[0]} days, room temperature storage will provide the best flavor.',
                          style: TextStyle(fontFamily: kFontFamily,fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(14),
                              backgroundColor: Colors.black87,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Back To Home',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          // Spacer(),
                          ElevatedButton(
                            onPressed: () => _retakePhoto(context),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 30),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Scan Again',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
  }
}

class ResultItem extends StatelessWidget {
  final String label;
  final int percentage;
  final Color color;

  const ResultItem({
    Key? key,
    required this.label,
    required this.percentage,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            Text(
              '$percentage%',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: Colors.grey[200],
            color: color,
            minHeight: 8,
          ),
        ),
      ],
    );
  }
}


Widget _buildInfoBox({
  required String label,
  required String value,
  required IconData icon,
  required Color color, // Add color parameter
}) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon, size: 18),
            const SizedBox(width: 2),
            Text(
              label,
              style: const TextStyle(
                fontFamily: kFontFamily,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color, // Use passed color
          ),
        ),
      ],
    ),
  );
}