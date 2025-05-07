import 'package:flutter/material.dart';
import 'package:tomatooo_app/Screens/buyer/Scan_Result_Fruit.dart';
import 'package:tomatooo_app/Screens/homepage.dart';
import 'package:tomatooo_app/Screens/Profile_Page.dart';
import 'package:tomatooo_app/Screens/Sign_in_RegisterPage.dart';
import 'package:tomatooo_app/Screens/Scan_Results.dart';
import 'package:tomatooo_app/Screens/Sign_up_Register_Page.dart';
import 'package:tomatooo_app/Screens/splashscreen.dart';

import 'Screens/buyer/Tomato_MarketPlace.dart';
import 'Screens/farmer/Scan_Track_Tomato.dart';
import 'Screens/farmer/Tomato_Fruit_Tracking.dart';
import 'Screens/farmer/addnewplant.dart';
import 'Screens/buyer/farmdetails.dart';
import 'Screens/farmer/leafrecognition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   home: ScanResultFruit(className: 'E', confidence: '90'),
    // );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        Splashscreen.id: (context) => const Splashscreen(),
        Registerpage.id: (context) => const Registerpage(),
        SignUpRegisterPage.id: (context) => const SignUpRegisterPage(),
        HomePage.id: (context) => const HomePage(),
        ScanTrackTomato.id: (context) => const ScanTrackTomato(),
        LeafRecognition.id: (context) => const LeafRecognition(),
        ScanResults.id: (context) => const ScanResults(),
        TomatoFruitTracking.id: (context) => const TomatoFruitTracking(),
        AddNewPlant.id: (context) => const AddNewPlant(),
        ProfilePage.id: (context) => const ProfilePage(),
        TomatoMarketplace.id: (context) => const TomatoMarketplace(),
        FarmDetails.id: (context) => const FarmDetails(),
      },
      initialRoute: Splashscreen.id, // Changed to splash screen
      // initialRoute: ScanTrackTomato.id,
    );
  }
}
