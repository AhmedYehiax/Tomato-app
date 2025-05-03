import 'package:flutter/material.dart';
import 'package:tomatooo_app/Constants.dart';
import 'package:tomatooo_app/Screens/farmdetails.dart';

class ContainerOntabTomatoMarketplace extends StatelessWidget {
  const ContainerOntabTomatoMarketplace({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        width: double.infinity,
        height: 220,
        decoration: BoxDecoration(
          color: Color(0xffFFFFFF),
          border: Border.all(width: 0.4, color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 6,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Image.asset(
                'assets/Images/download.jpg',
                width: 90,
                height: 100,
                color: Colors.red,
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, FarmDetails.id);
                          },
                          child: Text(
                            'Sunshine Farms',
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: kFontFamily,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.favorite_border_outlined,
                          color: kSecondaryColor,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 15,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 3),
                        Text(
                          'California',
                          style: TextStyle(
                            fontFamily: kFontFamily,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          '.',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: Colors.blueGrey,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          '15 miles',
                          style: TextStyle(
                            fontFamily: kFontFamily,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Family-owned farm practicing organic methods since 1985. Specializes in heirloom tomato varieties.',
                      style: TextStyle(
                        fontFamily: kFontFamily,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.star, size: 22, color: Color(0xffFACC15)),
                        Icon(Icons.star, size: 22, color: Color(0xffFACC15)),
                        Icon(Icons.star, size: 22, color: Color(0xffFACC15)),
                        Icon(Icons.star, size: 22, color: Color(0xffFACC15)),
                        Icon(Icons.star, size: 22, color: Color(0xffFACC15)),
                        Text('(4.8)', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
