import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tomatooo_app/Constants.dart';
import 'package:tomatooo_app/widgets/Custom_Button.dart';
import 'package:tomatooo_app/widgets/Custom_Button_icon.dart';
import 'package:http/http.dart' as http;

class CustomContainerTomatoFruitTracking extends StatefulWidget {
  const CustomContainerTomatoFruitTracking({
    super.key,
    required this.Name,
    required this.id,
    required this.lastUpdate,
    required this.image,
    required this.days,
    required this.growthStage,
    required this.growthStageName,
    this.onGrowthStageUpdate,
  });

  final String Name;
  final String id;
  final String lastUpdate;
  final String image;
  final int days;
  final int growthStage;
  final String growthStageName;
  final Function(int stage, String stageName, int daysToHarvest)? onGrowthStageUpdate;


  @override
  State<CustomContainerTomatoFruitTracking> createState() => _CustomContainerTomatoFruitTrackingState();
}

class _CustomContainerTomatoFruitTrackingState extends State<CustomContainerTomatoFruitTracking> {
  late int currentStage;
  late String currentStageName;
  late int daysToHarvest;
  bool _isLoading = false;
  File? _capturedImage;
  ImageProvider? decodedImage;

  @override
  void initState() {
    super.initState();
    updateStageFromPercentage(widget.growthStage);
    daysToHarvest = widget.days;
  }

  Future<void> _takePhoto(BuildContext context) async {
    try {
      setState(() {
        _isLoading = true;
      });

      final ImagePicker picker = ImagePicker();
      final XFile? photo = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 1200,
      );

      if (photo == null) return;

      final tempImage = File(photo.path);
      final bytes = await photo.readAsBytes();
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://${AppUri.uriFarmer}/predict_fruit'),
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
        final detections = (body["detections"] as List<dynamic>?) ?? [];

        if (detections.isNotEmpty) {
          // Only update image and stage if we have detections
          if (base64Image.isNotEmpty) {
            final decodedBytes = base64.decode(base64Image);
            setState(() {
              decodedImage = MemoryImage(decodedBytes);
              _capturedImage = tempImage;
            });
          }

          final detection = detections.first;
          final className = detection["class_name"]?.toString() ?? "Unknown";
          _updateGrowthStageFromDetection(className);

        } else {
          // No detections - don't update the image
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("No Detection"),
              content: const Text("No tomatoes detected in the image."),
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
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _updateGrowthStageFromDetection(String className) {
    // Map detected classes to growth stages
    int newPercentage;
    String newStageName;

    switch (className.toLowerCase()) {
      case 'plant set':
        newPercentage = 20;
        newStageName = 'Plant Set';
        break;
      case 'flowering':
        newPercentage = 40;
        newStageName = 'Flowering';
        break;
      case 'l_green':
      case 'b_green':
        newPercentage = 60;
        newStageName = 'Fruit Set';
        break;
      case 'l_half_ripped':
      case 'b_half_ripped':
        newPercentage = 80;
        newStageName = 'Ripening';
        break;
      case 'l_fully_ripped':
      case 'b_fully_ripped':
        newPercentage = 100;
        newStageName = 'Harvesting';
        break;
      default:
        return; // Don't update if class not recognized
    }

    setState(() {
      currentStageName = newStageName;
      daysToHarvest = _calculateDaysToHarvest(newStageName);
    });

    if (widget.onGrowthStageUpdate != null) {
      widget.onGrowthStageUpdate!(newPercentage, newStageName, daysToHarvest);
    }
  }

  void updateStageFromPercentage(int percentage) {
    if (percentage < 20) {
      currentStage = 1;
      currentStageName = 'Plant Set';
    } else if (percentage < 40) {
      currentStage = 2;
      currentStageName = 'Flowering';
    } else if (percentage < 60) {
      currentStage = 3;
      currentStageName = 'Fruit Set';
    } else if (percentage < 80) {
      currentStage = 4;
      currentStageName = 'Ripening';
    } else {
      currentStage = 5;
      currentStageName = 'Harvesting';
    }
  }

  int _calculateDaysToHarvest(String stage) {
    switch (stage) {
      case 'Plant Set':
        return 160;
      case 'Flowering':
        return 65;
      case 'Fruit Set':
        return 30;
      case 'Ripening':
        return 15;
      case 'Harvesting':
        return 0;
      default:
        return 0;
    }
  }

  String getStageDescription(String stageName) {
    switch (stageName) {
      case 'Plant Set':
        return 'Young plant establishing roots and growing first leaves';
      case 'Flowering':
        return 'Healthy flowers, good pollination';
      case 'Fruit Set':
        return 'Small fruits developing from flowers';
      case 'Ripening':
        return 'Fruits growing and changing color';
      case 'Harvesting':
        return 'Fruits ready to be harvested';
      default:
        return '';
    }
  }

  void _showGrowthStageUpdateDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Update Growth Stage',
            style: TextStyle(
              fontFamily: kFontFamily,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildStageOption('Plant Set', 1, 20),
              _buildStageOption('Flowering', 2, 40),
              _buildStageOption('Fruit Set', 3, 60),
              _buildStageOption('Ripening', 4, 80),
              _buildStageOption('Harvesting', 5, 100),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStageOption(String stageName, int stage, int percentage) {
    return InkWell(
      onTap: () {
        int newDaysToHarvest = _calculateDaysToHarvest(stageName);
        setState(() {
          currentStage = stage;
          currentStageName = stageName;
          daysToHarvest = newDaysToHarvest;
        });
        // Call the callback to update the parent widget
        if (widget.onGrowthStageUpdate != null) {
          widget.onGrowthStageUpdate!(percentage, stageName, newDaysToHarvest);
        }
        Navigator.of(context).pop();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: widget.growthStageName == stageName
              ? kPraimaryColor.withOpacity(0.1)
              : Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: widget.growthStageName == stageName
                ? kPraimaryColor
                : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              widget.growthStageName == stageName
                  ? Icons.check_circle
                  : Icons.circle_outlined,
              color: widget.growthStageName == stageName ? kPraimaryColor : Colors.grey,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stageName,
                    style: TextStyle(
                      fontFamily: kFontFamily,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    '${percentage}% complete • ${_calculateDaysToHarvest(stageName)} days to harvest',
                    style: TextStyle(
                      fontFamily: kFontFamily,
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Container(
        width: double.infinity,
        height: 250, // Slightly increased for better spacing
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Changed to better distribute space
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _isLoading
                      ? Container(
                    width: 80,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                      : decodedImage != null
                      ? Container(
                    width: 80,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: decodedImage!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                      : widget.image.isNotEmpty
                      ? Image.asset(widget.image, width: 80, height: 150)
                      : Container(
                    width: 80,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.image_not_supported, color: Colors.grey[400]),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start, // Better text alignment
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.Name,
                                style: TextStyle(
                                  fontFamily: kFontFamily,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                                overflow: TextOverflow.ellipsis, // Prevent text overflow
                              ),
                            ),
                            Text(
                              'Id:${widget.id}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.calendar,
                              color: Colors.grey,
                              size: 15,
                            ),
                            Expanded(
                              child: Text(
                                ' Last updated: ${widget.lastUpdate}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: kFontFamily,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                ),
                                overflow: TextOverflow.ellipsis, // Prevent text overflow
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Growth Stage:',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: kFontFamily,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              widget.growthStageName,
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: kFontFamily,
                                fontWeight: FontWeight.w600,
                                color: kPraimaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        // Linear Progress
                        LinearProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(kPraimaryColor),
                          backgroundColor: Color(0xffE5E7EB),
                          minHeight: 10,
                          value: widget.growthStage / 100.0,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start, // Align to top for better layout
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                getStageDescription(currentStageName),
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: kFontFamily,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                ),
                                maxLines: 2, // Limit to 2 lines
                                overflow: TextOverflow.ellipsis, // Add ellipsis for overflow
                              ),
                            ),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end, // Right-align days info
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min, // Take minimum space
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.clock,
                                      size: 15,
                                      color: Color(0xffF08A54),
                                    ),
                                    SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.days == 0
                                              ? 'Ready to'
                                              : '${widget.days} days to',
                                          style: TextStyle(
                                            fontFamily: kFontFamily,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xffF08A54),
                                          ),
                                        ),
                                        Text(
                                          'harvest',
                                          style: TextStyle(
                                            fontFamily: kFontFamily,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xffF08A54),
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
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(), // Push buttons to the bottom
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _takePhoto(context),
                      child: CustomButtonIcon(
                        title: 'Update Photo',
                        color: Colors.white,
                        IconData: Icons.camera_alt_outlined,
                        iconColor: Colors.black,
                        width: MediaQuery.of(context).size.width * 0.4, // Proportional width
                        height: 45,
                        fontsize: 14.2,
                        iconsize: 17,
                        border: Border.all(width: 0.4, color: Colors.grey),
                        fontcolor: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: CustomButton(
                      borderRadius: BorderRadius.circular(10),
                      title: 'Update Status',
                      color: kPraimaryColor,
                      width: MediaQuery.of(context).size.width * 0.4, // Proportional width
                      height: 45,
                      fontsize: 14.2,
                      onPressed: _showGrowthStageUpdateDialog,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}