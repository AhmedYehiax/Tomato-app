import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:tomatooo_app/Constants.dart';

class PlanetInformationContainer extends StatefulWidget {
  const PlanetInformationContainer({super.key});

  @override
  State<PlanetInformationContainer> createState() =>
      _PlanetInformationContainerState();
}

class _PlanetInformationContainerState
    extends State<PlanetInformationContainer> {
  DateTime _selectedDate = DateTime.now();
  String? _selectedCountry;

  // final TextEditingController _plantIdController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _pickCountry() {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      onSelect: (Country country) {
        setState(() {
          _selectedCountry = country.name;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Plant Information',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: kFontFamily,
            ),
          ),
          const SizedBox(height: 20),

          // Tomato Variety
          const Text('Tomato Variety'),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            items: const [
              DropdownMenuItem(value: 'cherry', child: Text('Cherry Tomato')),
              DropdownMenuItem(value: 'roma', child: Text('Roma Tomato')),
              DropdownMenuItem(
                value: 'beefsteak',
                child: Text('Beefsteak Tomato'),
              ),
            ],
            onChanged: (value) {},
            decoration: InputDecoration(
              hintText: 'Select variety',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Planting Date
          const Text('Planting Date'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: _pickDate,
            child: AbsorbPointer(
              child: TextField(
                readOnly: true,
                controller: TextEditingController(
                  text:
                      '${_selectedDate.month}/${_selectedDate.day}/${_selectedDate.year}',
                ),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.calendar_today),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Field Location (Country Picker)
          const Text('Field Location'),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: _pickCountry,
            child: AbsorbPointer(
              child: TextField(
                controller: TextEditingController(text: _selectedCountry ?? ''),
                decoration: InputDecoration(
                  hintText: 'Select country',
                  suffixIcon: const Icon(Icons.arrow_drop_down),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Notes
          const Text('Notes'),
          const SizedBox(height: 8),
          TextField(
            maxLines: 4,
            controller: _notesController,
            decoration: InputDecoration(
              hintText: 'Add any additional notes about this plant...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 30),
          
        ],
      ),
    );
  }
}
