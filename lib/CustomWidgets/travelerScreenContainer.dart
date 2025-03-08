import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:travel_to_mate/StateMangment/likeProvoder.dart';

class TravelerScreenContainer extends StatelessWidget {
  final String name;
  final ImageProvider image;
  final ImageProvider image2;
  final String description;
  final String postId;

  const TravelerScreenContainer({
    required this.postId,
    required this.image,
    required this.description,
    required this.image2,
    required this.name,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final likeProvider = Provider.of<LikeProvider>(context);
    print("TravelerScreenContainer - postId: $postId");
    print("Is Liked? ${likeProvider.isLiked(postId)}");

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: image,
                  backgroundColor: Colors.grey[300], // Placeholder color
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: AutoSizeText(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Post Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image(
                  image: image2,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Description Text
            AutoSizeText(
              description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
              minFontSize: 12,
            ),
            const SizedBox(height: 10),

            // Action Buttons (Like & Share)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.thumb_up,
                      color: likeProvider.isLiked(postId)
                          ? Colors.red
                          : Colors.grey),
                  onPressed: () {
                    print(
                        "Toggling like for postId: $postId"); // Debugging button press
                    likeProvider.toggleLike(postId);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.share, color: Colors.blue),
                  onPressed: () async {
                    // await Clipboard.setData(ClipboardData(text: postUrl)); // Copy link
                    // Share.share(postUrl); // Share the link
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
