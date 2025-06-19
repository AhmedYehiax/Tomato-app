import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:tomatooo_app/Constants.dart';
import 'package:tomatooo_app/widgets/OnTab_Tomato_Market_Two.dart';
import 'package:tomatooo_app/widgets/OnTab_Tomato_Market_one.dart';

import '../Profile_Page.dart';
import '../homepage.dart';

class TomatoMarketplace extends StatefulWidget {
  const TomatoMarketplace({super.key});
  static String id = 'TomatoMarketPlace';
  @override
  State<TomatoMarketplace> createState() => _TomatoMarketplaceState();
}

class _TomatoMarketplaceState extends State<TomatoMarketplace>
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
      icon: Icon(Icons.home_outlined),
      title: Text('Home'),
      selectedColor: Colors.white,
      unselectedColor: Colors.white,
    ),
    SalomonBottomBarItem(
      icon: Icon(FontAwesomeIcons.leaf),
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
  final List<Widget> widgitList = [];

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      backgroundColor: kbackgroundColorTwo,
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: const Color(0xffFEE2E2),
        backgroundColor: const Color(0xffFEE2E2),
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Tomato Marketplace',
            style: TextStyle(
              fontFamily: kFontFamily,
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: kPraimryTextTwoColor,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.favorite_border_outlined, color: kSecondaryColor),
                const SizedBox(width: 5),
                Text(
                  'Tomato Farms',
                  style: TextStyle(
                    fontFamily: kFontFamily,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
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
                        'All Farms',
                        style: TextStyle(
                          fontFamily: kFontFamily,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Favorite Farms',
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
                  OntabTomatoMarketOne(),
                  OntabTomatoMarketTwo(),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomSheet: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: const Color(0xff282F3C),
        ),
        margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: SalomonBottomBar(
          curve: Curves.ease,
          margin: const EdgeInsets.all(10),
          duration: const Duration(milliseconds: 100),
          items: _items,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });

            // Navigation logic
            if (index == 0) {
              Navigator.pushReplacementNamed(context, TomatoMarketplace.id);
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

// class SearchBar extends StatelessWidget {
//   const SearchBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 18),
//       child: Container(
//         child: TextField(
//           decoration: InputDecoration(
//             contentPadding: EdgeInsets.all(15),
//             border: OutlineInputBorder(
//               borderSide: BorderSide.none,
//               borderRadius: BorderRadius.circular(50),
//             ),
//             filled: true,
//             fillColor: Color(0xffFFFCFC),
//             hintText: 'Search farms by name...',
//             hintStyle: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w400,
//               color: Colors.grey,
//             ),
//             prefixIcon: Icon(
//               Icons.search_sharp,
//               size: 25,
//               color: const Color.fromARGB(255, 236, 85, 74),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
