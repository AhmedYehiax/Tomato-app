import 'package:flutter/material.dart';
import 'package:tomatooo_app/Constants.dart';
import 'package:tomatooo_app/Models/Farms_Models.dart';
import 'package:tomatooo_app/widgets/Farm_Details_Widgets.dart';

class FarmDetails extends StatefulWidget {
  const FarmDetails({super.key});
  static String id = 'FarmDetails';

  @override
  State<FarmDetails> createState() => _FarmDetailsState();
}

class _FarmDetailsState extends State<FarmDetails> {
  bool isFavorite = false;
  Farms? farm;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Farms) {
      farm = args;
      isFavorite = farm!.isFavorite;
    }
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      if (farm != null) {
        farm!.isFavorite = isFavorite;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColorTwo,
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: const Color(0xffFEE2E2),
        backgroundColor: const Color(0xffFEE2E2),
        foregroundColor: kPraimryTextTwoColor,
        title: Center(
          child: Text(
            farm?.name ?? 'Farm Details',
            style: TextStyle(
              fontFamily: kFontFamily,
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: kPraimryTextTwoColor,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: _toggleFavorite,
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                color: isFavorite ? Colors.red : null,
              ),
            ),
          ),
        ],
      ),
      body: FarmDetailsWidgets(farm: farm),
    );
  }
}
