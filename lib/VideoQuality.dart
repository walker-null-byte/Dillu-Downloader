import 'dart:io';

import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import 'HomeController.dart';
import 'downloadVideo.dart';

class VideoQuality extends StatelessWidget {
  late int thumbnailQuality;
  late Icon icon;

  late String name;
  late String quality;
  late String resolution;
  late String size;
  late String url;

  late MuxedStreamInfo data;
  late HomeController controller;
  late String destination;

  VideoQuality(
      {required this.name, required this.data, required this.controller}) {
    quality = data.videoQuality.toString();
    thumbnailQuality =
        int.parse(quality.substring(quality.length - 3, quality.length));
    destination = "storage/emulated/0/Download/DilluDownloader/";

    url = data.url.toString();
    resolution = data.videoResolution.toString();
    size = '${data.size.totalMegaBytes.toStringAsFixed(3)} MB';

    if (size == "0.0 MB") {
      icon = const Icon(Icons.music_note);
    } else if (thumbnailQuality == 144 ||
        thumbnailQuality == 360 ||
        thumbnailQuality == 480) {
      icon = const Icon(Icons.sd);
    } else if (thumbnailQuality == 720) {
      icon = const Icon(Icons.hd);
    } else {
      icon = const Icon(Icons.music_note);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey[600]!),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            icon,
            Text(
              "${thumbnailQuality}p",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(resolution),
            Text(size),
            IconButton(
              onPressed: () async {
                getPermission();
                controller.isDownloaded.value = false;
                controller.isDownloading.value = true;
                var file = File("$destination$name.mp4");
                if (!file.existsSync()) {
                  file.createSync(recursive: true);
                }

                var yt = YoutubeExplode();
                await yt.videos.streamsClient
                    .get(data)
                    .pipe(file.openWrite())
                    .then((_) {
                  controller.isDownloaded.value = true;
                  controller.isDownloading.value = false;
                });
                yt.close();
              },
              icon: const Icon(Icons.download),
              color: Colors.blueGrey[600],
              hoverColor: Colors.green,
            )
          ],
        ),
      ),
    );
  }
}
