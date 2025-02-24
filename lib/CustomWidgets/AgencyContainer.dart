import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AgencyContainer extends StatelessWidget {
  final ImageProvider agencyImg;
  final ImageProvider img;
  final String agencyName;
  final String? shortDesc;

  const AgencyContainer({
    required this.agencyImg,
    required this.img,
    required this.agencyName,
    this.shortDesc,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.1,
                height: MediaQuery.of(context).size.height * 0.05,
                child: Image(image: agencyImg),
              ),
              AutoSizeText(agencyName),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image(
                  width: double.infinity,
                  image: img,
                  fit: BoxFit.cover,
                )),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: AutoSizeText(
                shortDesc!,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 12,
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 12,
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 12,
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 12,
                ),
                Icon(
                  Icons.star_border,
                  color: Colors.amber,
                  size: 12,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: AutoSizeText('4.2'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.thumb_up_alt_outlined,
                            size: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.share,
                              size: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) {
                      //   return MainTravelerScreen();
                      // }));
                    },
                    child: AutoSizeText(
                      'Book Now',
                      style: TextStyle(color: Colors.white, fontSize: 7),
                    ),
                    style: ButtonStyle(
                        padding: MaterialStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                        ),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xFF088F8F))),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
