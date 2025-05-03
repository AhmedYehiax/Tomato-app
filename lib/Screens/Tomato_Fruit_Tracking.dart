import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:tomatooo_app/Constants.dart';

import 'package:tomatooo_app/Screens/homepage.dart';
import 'package:tomatooo_app/Screens/Scan_Track_Tomato.dart';
import 'package:tomatooo_app/widgets/Tab_One_Tomato_Fruit_Tracking.dart';
import 'package:tomatooo_app/widgets/Tab_Two_Tomato_Fruit_Tracking.dart';

class TomatoFruitTracking extends StatefulWidget {
  const TomatoFruitTracking({super.key});
  static String id = 'TomatoFruitTracking';
  @override
  State<TomatoFruitTracking> createState() => _TomatoFruitTrackingState();
}

class _TomatoFruitTrackingState extends State<TomatoFruitTracking>
    with TickerProviderStateMixin {
  late TabController tabController;
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
      icon: Icon(Icons.house_outlined),
      title: Text('Home'),
      selectedColor: Colors.white,
      unselectedColor: Colors.white,
    ),
    SalomonBottomBarItem(
      icon: Icon(Icons.shopping_cart_outlined),
      title: Text('Shopping'),
      selectedColor: Colors.white,
      unselectedColor: Colors.white,
    ),
    SalomonBottomBarItem(
      icon: Icon(Icons.person_outlined),
      title: Text('Person'),
      selectedColor: Colors.white,
      unselectedColor: Colors.white,
    ),
  ];

  int _currentIndex = 0;
  // final _screens = [
  //   ScanTrackTomato(),
  //   HomePage(),
  //   Center(child: Text('Re page')),
  // ];
  final List<Widget> widgitList = [
    ScanTrackTomato(),
    HomePage(),
    Center(child: Text('Re page')),
  ];

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        surfaceTintColor: const Color(0xffDCFCE7),
        backgroundColor: const Color(0xffDCFCE7),
        foregroundColor: kPraimryTextColor,
        title: const Text(
          'Tomato Fruit Tracking',
          style: TextStyle(
            fontFamily: kFontFamily,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: kPraimryTextColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            SizedBox(height: 25),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color(0xffF4F4F5),
                  borderRadius: BorderRadius.circular(10),

                ),
                child: TabBar(
                  dividerColor: Color(0xffF4F4F5),
                  unselectedLabelColor: const Color(0xff9B9BA1),
                  labelColor: Colors.black,
                  indicatorWeight: 1,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelStyle: TextStyle(fontWeight: FontWeight.w700),
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  controller: tabController,
                  tabs: [
                    Tab(
                      child: Text(
                        'Active Tracking',
                        style: TextStyle(
                          fontFamily: kFontFamily,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Growth History',
                        style: TextStyle(
                          fontFamily: kFontFamily,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  TabOneTomatoFruitTracking(),
                  TabTwoTomatoFruitTracking(),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomSheet: widgitList[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: Color(0xff282F3C),
        ),
        margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: SalomonBottomBar(
          curve: Curves.ease,
          margin: EdgeInsets.all(10),
          duration: Duration(seconds: 1),
          items: _items,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
