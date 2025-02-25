import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:notification_listener_service/notification_listener_service.dart';
// import 'package:image/image.dart' as img; // Import the image package

class MusicBar extends StatefulWidget {
  const MusicBar({super.key});

  @override
  MusicBarState createState() => MusicBarState();
}

class MusicBarState extends State<MusicBar> {
  String songTitle = "Song Title";
  String artistName = "Artist Name";

  // Default album image placeholder
  Image albumImage = Image.network(
    'https://lh3.googleusercontent.com/eunTV0W9cfpSP1VNeB2eJyJ5fbXTRQs7dFH157m0on9yvDguXqEGKmIyjr0H-NKRBGVdMkyaSbMD97ut=w544-h544-l90-rj',
    width: 50,
    height: 50,
    fit: BoxFit.cover,
  );

  // Method to crop the image
  // Uint8List cropImage(Uint8List imageBytes) {
  //   img.Image? decodedImage = img.decodeImage(Uint8List.fromList(imageBytes));

  //   if (decodedImage != null) {
  //     // Crop the image (for example, remove 10 pixels from top and bottom)
  //     img.Image croppedImage = img.copyCrop(decodedImage,
  //         x: 0,
  //         y: 30,
  //         width: decodedImage.width,
  //         height: decodedImage.height - 60);

  //     // Convert the cropped image back to Uint8List for display
  //     return Uint8List.fromList(img.encodeJpg(croppedImage));
  //   }

  //   // Return the original image if it can't be decoded
  //   return imageBytes;
  // }

  Future<void> setupListener() async {
    /// Check if notification permission is enabled
    bool status = await NotificationListenerService.isPermissionGranted();

    /// Request notification permission
    if (!status) status = await NotificationListenerService.requestPermission();

    /// Stream the incoming notification events
    NotificationListenerService.notificationsStream.listen((event) {
      bool? removed = event.hasRemoved;
      if (removed != null) {
        if (removed) {
          setState(() {
            songTitle = "Song Title";
            artistName = "Artist Name";
            albumImage = Image.network(
              'https://lh3.googleusercontent.com/eunTV0W9cfpSP1VNeB2eJyJ5fbXTRQs7dFH157m0on9yvDguXqEGKmIyjr0H-NKRBGVdMkyaSbMD97ut=w544-h544-l90-rj',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            );
          });
          return;
        }
      }

      List<String> allowed = [
        "com.android.chrome",
        "com.google.android.youtube",
      ];

      if (allowed.contains(event.packageName)) {
        setState(() {
          songTitle = event.title ?? songTitle;
          artistName = event.content ?? artistName;

          Uint8List? buf = event.largeIcon;
          if (buf != null) {
            // Crop the image before displaying
            // Uint8List croppedImage = cropImage(buf);

            albumImage = Image.memory(
              // croppedImage,
              buf,
              width: 50, // Width for your image
              height: 50, // Height for your image
              fit: BoxFit.cover, // Cover the entire space
            );
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setupListener(); // Initialize listener when the widget is first created
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: [
          // Album Art
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            child: albumImage,
          ),
          const SizedBox(width: 16),

          // Song Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  songTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  artistName,
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Function to calculate the width of the text based on the available context size
  double getTextWidth(String text, BuildContext context) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: double.infinity);
    return textPainter.size.width;
  }
}
