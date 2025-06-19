import 'dart:io';
import 'package:flutter/material.dart';
import '../../Constants.dart';

class TomatoFruitTrackingDetails extends StatefulWidget {
  final String plantId;
  final String plantName;
  final String lastUpdate;
  final String image;
  final int daysToHarvest;
  final String growthStageName;
  final List<GrowthHistory> growthHistory;

  const TomatoFruitTrackingDetails({
    Key? key,
    required this.plantId,
    required this.plantName,
    required this.lastUpdate,
    required this.image,
    required this.daysToHarvest,
    required this.growthStageName,
    required this.growthHistory,
  }) : super(key: key);

  @override
  _TomatoFruitTrackingDetailsState createState() => _TomatoFruitTrackingDetailsState();
}

class GrowthHistory {
  final ImageProvider image;
  final String date;
  final String growthStage;

  GrowthHistory({
    required this.image,
    required this.date,
    required this.growthStage,
  });
}

class _TomatoFruitTrackingDetailsState extends State<TomatoFruitTrackingDetails> {
  File? _capturedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPlantImage(),
            _buildPlantInfoSection(),
            const SizedBox(height: 16),
            _buildGrowthHistorySection(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'Plant Details',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w500,
          fontFamily: kFontFamily,
        ),
      ),
    );
  }

  Widget _buildPlantImage() {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        image: _getPlantImageDecoration(),
      ),
      child: _showPlaceholderIcon()
          ? Center(
        child: Icon(
          Icons.photo_camera,
          size: 50,
          color: Colors.grey[400],
        ),
      )
          : null,
    );
  }

  Widget _buildPlantTitleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.plantName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: kFontFamily,
          ),
        ),
        Text(
          'ID: ${widget.plantId.length > 5 ? '${widget.plantId.substring(0, 5)}' : widget.plantId}',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontFamily: kFontFamily,
          ),
        ),
      ],
    );
  }

  Widget _buildGrowthStageText() {
    return Text(
      'Current Stage: ${widget.growthStageName}',
      style: const TextStyle(
        fontSize: 16,
        fontFamily: kFontFamily,
      ),
    );
  }

  Widget _buildLastUpdatedText() {
    return Text(
      'Last updated: ${widget.lastUpdate.length > 10 ? '${widget.lastUpdate.substring(0, 10)}' : widget.lastUpdate}',
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey[600],
        fontFamily: kFontFamily,
      ),
    );
  }

  Widget _buildHarvestInfoRow() {
    return Row(
      children: [
        const Icon(Icons.calendar_month_outlined, color: kPraimaryColor),
        const SizedBox(width: 6),
        Text(
          widget.daysToHarvest == 0 ? 'Ready to harvest' : '${widget.daysToHarvest} days to harvest',
          style: const TextStyle(
            fontSize: 15,
            color: kPraimaryColor,
            fontFamily: kFontFamily,
          ),
        ),
      ],
    );
  }

  DecorationImage? _getPlantImageDecoration() {
    if (_capturedImage != null) {
      return DecorationImage(
        image: FileImage(_capturedImage!),
        fit: BoxFit.cover,
      );
    } else if (widget.image.isNotEmpty) {
      return DecorationImage(
        image: NetworkImage(widget.image),
        fit: BoxFit.cover,
      );
    }
    return null;
  }

  bool _showPlaceholderIcon() {
    return _capturedImage == null && widget.image.isEmpty;
  }

  Widget _buildPlantInfoSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPlantTitleRow(),
          const SizedBox(height: 8),
          _buildGrowthStageText(),
          const SizedBox(height: 12),
          _buildLastUpdatedText(),
          const SizedBox(height: 8),
          _buildHarvestInfoRow(),
        ],
      ),
    );
  }

  Widget _buildGrowthHistorySection() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Fruit Development History',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: kFontFamily,
              ),
            ),
          ),
          const SizedBox(height: 8),
          _buildHistoryList(),
        ],
      ),
    );
  }

  Widget _buildHistoryList() {
    if (widget.growthHistory.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'No history available',
          style: TextStyle(
            color: Colors.grey[600],
            fontFamily: kFontFamily,
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.growthHistory.length,
      separatorBuilder: (context, index) => Divider(
        height: 1,
        thickness: 1,
        color: Colors.grey[200],
        indent: 16,
        endIndent: 16,
      ),
      itemBuilder: (context, index) {
        final history = widget.growthHistory[index];
        return _buildHistoryItem(history);
      },
    );
  }

  Widget _buildHistoryItem(GrowthHistory history) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // History image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[200],
              image: DecorationImage(
                image: history.image,
                fit: BoxFit.cover,
              ),
            ),
            child: history.image == null
                ? Center(
              child: Icon(
                Icons.photo_camera,
                size: 30,
                color: Colors.grey[400],
              ),
            )
                : null,
          ),
          const SizedBox(width: 12),
          // History details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  history.growthStage,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: kFontFamily,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  history.date,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontFamily: kFontFamily,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}