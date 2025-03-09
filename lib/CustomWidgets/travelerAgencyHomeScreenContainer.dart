import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:travel_to_mate/CustomWidgets/fullscreenViewer.dart';

class TravelerAgencyHomeScreenContainer extends StatefulWidget {
  final ImageProvider imgLogo;
  final ImageProvider img;
  final String name;
  final String description;

  const TravelerAgencyHomeScreenContainer({
    required this.imgLogo,
    required this.img,
    required this.name,
    required this.description,
    super.key,
  });

  @override
  State<TravelerAgencyHomeScreenContainer> createState() =>
      _TravelerAgencyHomeScreenContainerState();
}

class _TravelerAgencyHomeScreenContainerState
    extends State<TravelerAgencyHomeScreenContainer> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipOval(
                  child: Image(
                    image: widget.imgLogo,
                    width: screenWidth * 0.12,
                    height: screenWidth * 0.12,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: screenWidth * 0.03),
                Expanded(
                  child: AutoSizeText(
                    widget.name,
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenWidth * 0.03),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        FullScreenImageViewer(imageUrl: widget.img),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image(
                    image: widget.img,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: screenWidth * 0.03),
            AutoSizeText(
              widget.description,
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
