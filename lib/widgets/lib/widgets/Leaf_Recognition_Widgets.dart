import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:camera/camera.dart';
import 'package:tomatooo_app/Constants.dart';
import 'package:tomatooo_app/Screens/Scan_Results.dart';
import 'package:tomatooo_app/widgets/Custom_Button_icon.dart';

// Store the available cameras globally
List<CameraDescription> _cameras = [];

class LeafRecognitionWidgets extends StatefulWidget {
  const LeafRecognitionWidgets({super.key});

  @override
  State<LeafRecognitionWidgets> createState() => _LeafRecognitionWidgetsState();
}

class _LeafRecognitionWidgetsState extends State<LeafRecognitionWidgets> {
  @override
  void initState() {
    super.initState();
    _initCameras();
  }

  Future<void> _initCameras() async {
    WidgetsFlutterBinding.ensureInitialized();
    _cameras = await availableCameras();
  }

  Future<void> _openCamera(BuildContext context) async {
    var status = await Permission.camera.request();

    if (status.isGranted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CameraScreen(camera: _cameras.first),
        ),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Camera permission denied')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: GestureDetector(
              onTap: () => _openCamera(context),
              child: CustomButtonIcon(
                title: 'Start Camera',
                color: kPraimaryColor,
                IconData: Icons.camera_alt_outlined,
                iconColor: Colors.white,
                width: 220,
                height: 55,
                fontsize: 17,
                iconsize: 18,
                border: Border.all(width: 0),
                fontcolor: Colors.white,
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 150,
          decoration: const BoxDecoration(color: Color(0xff111827)),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ScanResults.id);
            },
            child: Center(
              child: Container(
                width: 300,
                height: 55,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF3366FF),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.visibility_outlined, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'View Example Result',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  const CameraScreen({super.key, required this.camera});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _takePhoto() async {
    try {
      await _initializeControllerFuture;
      final XFile file = await _controller.takePicture();

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Photo captured: ${file.path}')));

      // Optional: Navigate or handle file here
    } catch (e) {
      debugPrint("Error taking photo: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to capture photo")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          FutureBuilder(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_controller);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: _takePhoto,
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    border: Border.all(color: Colors.white, width: 4),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
