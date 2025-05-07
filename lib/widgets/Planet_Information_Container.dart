import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:tomatooo_app/Constants.dart';

class PlanetInformationContainer extends StatefulWidget {
  const PlanetInformationContainer({
    super.key,
    required this.nameController,
    required this.idController,
  });

  final TextEditingController nameController;
  final TextEditingController idController;

  @override
  State<PlanetInformationContainer> createState() =>
      _PlanetInformationContainerState();
}
class _PlanetInformationContainerState
    extends State<PlanetInformationContainer> {
  DateTime _selectedDate = DateTime.now();
  String? _selectedVariety;
  final TextEditingController _notesController = TextEditingController();

  final List<String> _tomatoVarieties = [
    'Beefsteak Tomato',
    'Cherry Tomato',
    'Roma Tomato',
    'Grape Tomato',
  ];

  @override
  void initState() {
    super.initState();
    // Initialize name controller if variety is already selected
    if (_selectedVariety != null) {
      widget.nameController.text = _selectedVariety!;
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

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

          // Tomato Variety Dropdown
          const Text('Tomato Variety'),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: _selectedVariety,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            items: _tomatoVarieties.map((String variety) {
              return DropdownMenuItem<String>(
                value: variety,
                child: Text(variety),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedVariety = newValue;
                // Update the name controller with the selected variety
                if (newValue != null) {
                  widget.nameController.text = newValue;
                }
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a variety';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          // Plant ID
          const Text('Plant ID'),
          const SizedBox(height: 8),
          TextField(
            controller: widget.idController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Enter plant ID',
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
        ],
      ),
    );
  }
}
