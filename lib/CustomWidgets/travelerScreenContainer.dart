import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TravelerScreenContainer extends StatefulWidget {
  final String name;
  final ImageProvider image;
  final ImageProvider image2;
  const TravelerScreenContainer({
    required this.image,
    required this.image2,
    required this.name,
    super.key,
  });

  @override
  State<TravelerScreenContainer> createState() =>
      _TravelerScreenContainerState();
}

class _TravelerScreenContainerState extends State<TravelerScreenContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Image(image: widget.image),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: AutoSizeText(widget.name),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              child: Image(
                image: widget.image2,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Icon(Icons.thumb_up_alt_outlined),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(Icons.share),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
