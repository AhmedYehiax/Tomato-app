import 'package:flutter/material.dart';
import 'package:tomatooo_app/Screens/ScanResultsLeaf.dart';
import 'package:tomatooo_app/Screens/addnewplant.dart';
import 'package:tomatooo_app/Screens/farmdetails.dart';
import 'package:tomatooo_app/Screens/homepage.dart';
import 'package:tomatooo_app/Screens/leafrecognition.dart';
import 'package:tomatooo_app/Screens/Profile_Page.dart';
import 'package:tomatooo_app/Screens/Sign_in_RegisterPage.dart';
import 'package:tomatooo_app/Screens/Scan_Results.dart';
import 'package:tomatooo_app/Screens/Scan_Track_Tomato.dart';
import 'package:tomatooo_app/Screens/Sign_up_Register_Page.dart';
import 'package:tomatooo_app/Screens/Tomato_Fruit_Tracking.dart';
import 'package:tomatooo_app/Screens/Tomato_MarketPlace.dart';

import 'Screens/Scan_Result_Fruit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   home:  ScanResultsLeaf(className: 'null', confidence: 60, imageBytes: null,),
    // );
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      routes: {
        Registerpage.id: (context) => const Registerpage(),
        SignUpRegisterPage.id: (context) => const SignUpRegisterPage(),
        HomePage.id: (context) => const HomePage(),
        ScanTrackTomato.id: (context) => const ScanTrackTomato(),
        LeafRecognition.id: (context) => const LeafRecognition(),
        ScanResults.id: (context) => const ScanResults(),
        TomatoFruitTracking.id: (context) => TomatoFruitTracking(),
        AddNewPlant.id: (context) => const AddNewPlant(),
        ProfilePage.id: (context) => const ProfilePage(),
        TomatoMarketplace.id: (context) => TomatoMarketplace(),
        FarmDetails.id: (context) => FarmDetails(),
      },
      initialRoute: Registerpage.id,
    );
  }
}
