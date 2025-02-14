import 'package:flutter/material.dart';

class MusicBar extends StatelessWidget {
  const MusicBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: [
          // Album Art
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://lh3.googleusercontent.com/eunTV0W9cfpSP1VNeB2eJyJ5fbXTRQs7dFH157m0on9yvDguXqEGKmIyjr0H-NKRBGVdMkyaSbMD97ut=w544-h544-l90-rj', // Replace with your image URL
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),

          // Song Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Song Title',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  'Artist Name',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),

          // Play/Pause Button
          IconButton(
            icon: const Icon(Icons.play_arrow),
            onPressed: () {
              // Add play/pause logic here
            },
          ),
        ],
      ),
    );
  }
}
