import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TravelerScreenContainer extends StatefulWidget {
  final String name;
  final ImageProvider image;
  final ImageProvider image2;
  final String description;
  const TravelerScreenContainer({
    required this.image,
    required this.description,
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
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.05,
                    height: MediaQuery.of(context).size.height * 0.025,
                    child: Image(image: widget.image)),
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
              width: double.infinity,
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image(
                  image: widget.image2,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: AutoSizeText(
                widget.description,
                style: TextStyle(fontSize: 14, color: Colors.black54),
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
