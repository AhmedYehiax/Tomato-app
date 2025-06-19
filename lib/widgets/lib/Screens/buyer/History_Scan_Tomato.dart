import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tomatooo_app/Screens/buyer/Scan_Result_Fruit.dart';

import '../../Constants.dart';

class HistoryScanTomato extends StatefulWidget {
  const HistoryScanTomato({super.key});

  @override
  State<HistoryScanTomato> createState() => _HistoryScanTomatoState();
}

class _HistoryScanTomatoState extends State<HistoryScanTomato> {
  List<ScanItem> scanHistory = [
    ScanItem(
      date: '5/8/2024',
      time: '14:32',
      className: 'Class B',
    ),
    ScanItem(
      date: '5/5/2024',
      time: '10:15',
      className: 'Class A',
    ),
    ScanItem(
      date: '5/1/2024',
      time: '09:45',
      className: 'Class C',
    ),
    ScanItem(
      date: '4/28/2024',
      time: '16:20',
      className: 'Class D',
    ),
    ScanItem(
      date: '4/25/2024',
      time: '11:30',
      className: 'Class E',
    ),
  ];

  Map<String, dynamic> getQualityData(String className) {
    switch (className) {
      case 'Class A':
        return {
          'name': 'Very Fresh',
          'daysPostHarvest': '0-3 days',
          'daysLeft': '13-16 days',
          'color': 'green',
        };
      case 'Class B':
        return {
          'name': 'Fresh',
          'daysPostHarvest': '4-6 days',
          'daysLeft': '10-12 days',
          'color': 'emerald',
        };
      case 'Class C':
        return {
          'name': 'Moderately Fresh',
          'daysPostHarvest': '8-9 days',
          'daysLeft': '7-9 days',
          'color': 'yellow',
        };
      case 'Class D':
        return {
          'name': 'Starting to Degrade',
          'daysPostHarvest': '10-12 days',
          'daysLeft': '4-6 days',
          'color': 'orange',
        };
      case 'Class E':
        return {
          'name': 'Rotten (Unusable)',
          'daysPostHarvest': '13+ days',
          'daysLeft': '0 days',
          'color': 'red',
        };
      default:
        return {
          'name': 'Unknown Quality',
          'daysPostHarvest': 'N/A',
          'daysLeft': 'N/A',
          'color': 'grey',
        };
    }
  }

  Color getColorForQuality(String colorName) {
    switch (colorName) {
      case 'green':
        return Colors.green;
      case 'emerald':
        return Colors.green.shade700;
      case 'yellow':
        return Colors.amber;
      case 'orange':
        return Colors.orange;
      case 'red':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _deleteItem(int index) {
    setState(() {
      scanHistory.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Center(child: Text('Deleted')),
        backgroundColor: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9E0E0),
        elevation: 0,
        title: Text(
          'Scan History',
          style: TextStyle(
            color: Color(0xAA8B0000),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xAA8B0000),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: scanHistory.length,
        separatorBuilder: (context, index) => const Divider(height: 20, color: kbackgroundColor),
        itemBuilder: (context, index) {
          final item = scanHistory[index];
          final qualityData = getQualityData(item.className);
          return _buildDismissibleItem(item, qualityData, index);
        },
      ),
    );
  }

  Widget _buildDismissibleItem(ScanItem item, Map<String, dynamic> qualityData, int index) {
    return Dismissible(
      key: Key(item.date + item.time),
      direction: DismissDirection.startToEnd,
      background: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) => _deleteItem(index),
      child: _buildScanItem(item, qualityData),
    );
  }

  Widget _buildScanItem(ScanItem item, Map<String, dynamic> qualityData) {
    final color = getColorForQuality(qualityData['color']);
    return GestureDetector(
        onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScanResultFruit(className: item.className,),
        ),
      );
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 110,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: item.img != null
                    ? FileImage(File(item.img!.path))
                    : AssetImage('assets/Images/download.jpg') as ImageProvider,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _buildInfoWithIcon(
                      icon: Icons.calendar_today,
                      text: item.date,
                    ),
                    const SizedBox(width: 16),
                    _buildInfoWithIcon(
                      icon: Icons.access_time,
                      text: item.time,
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        item.className,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  qualityData['name'],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Harvested: ${qualityData['daysPostHarvest']}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Shelf life left: ${qualityData['daysLeft']}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
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

  Widget _buildInfoWithIcon({required IconData icon, required String text}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.grey.shade600,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class ScanItem {
  final XFile? img;
  final String date;
  final String time;
  final String className;

  ScanItem({
    this.img,
    required this.date,
    required this.time,
    required this.className,
  });
}