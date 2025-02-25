import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TravelerAgencyHomeScreenContainer extends StatefulWidget {
  final ImageProvider imgLogo;
  final ImageProvider img;
  final String name;
  const TravelerAgencyHomeScreenContainer({
    required this.imgLogo,
    required this.img,
    required this.name,
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
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Image(image: widget.imgLogo),
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image(
                    image: widget.img,
                    fit: BoxFit.cover,
                  ),
                ),
              )),
          Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                ),
                AutoSizeText(
                  '4.5',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ]))
        ],
      ),
    );
  }
}
