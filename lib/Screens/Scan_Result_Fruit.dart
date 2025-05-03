import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ScanResultFruit extends StatelessWidget {
  final String className;
  final String confidence;
  final Uint8List? imageBytes;

  const ScanResultFruit({
    Key? key,
    required this.className,
    required this.confidence,
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
        Uri.parse('http://192.168.1.5:8000/detect'),
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

        // Replace current screen with new results
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ScanResultFruit(
              className: result['class_number']?.toString() ?? 'N/A',
              confidence: (result['confidence'] ?? 0).toStringAsFixed(2),
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

  @override
  Widget build(BuildContext context) {
    final parsedConfidence = double.tryParse(confidence) ?? 0.0;
    final percentage = (parsedConfidence).round();

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
              onPressed: (){
                showDialog(
                context: context,
                builder: (BuildContext context){
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
                                    hintText: "Describe the Problem ",
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
                                  side: BorderSide(color: Colors.red), // This adds the outline border
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(height: 30),
            Container(
              height: 350,
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
                  fit: BoxFit.fill,
                ),
              )
                  : const Center(child: Text('No image available')),
            ),
            const SizedBox(height: 24),
            Container(
              height: 370,
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    const Text(
                      'Scan Results',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text("Class: $className", style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 16),
                    ResultItem(
                      label: "Confidence:",
                      percentage: percentage,
                      color: _getConfidenceColor(parsedConfidence),
                    ),
                    const SizedBox(height: 75),
                    ElevatedButton(
                      onPressed: () => _retakePhoto(context),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        padding: const EdgeInsets.all(16),
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
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
                    )
                  ],
                ),
              ),
            ),
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

Color _getConfidenceColor(double confidence) {
  return confidence > 0.9
      ? Colors.green
      : confidence > 0.7
      ? Colors.orange
      : Colors.red;
}