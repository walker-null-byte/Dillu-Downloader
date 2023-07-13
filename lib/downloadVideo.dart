import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import 'HomeController.dart';

Future<void> getVideoData({required String url, required HomeController controller}) async {
  await getPermission();
  if(controller.isDownloadClicked.value) {
    return;
  }
  controller.isDownloadClicked.value = true;
  controller.isDownloaded.value = false;
  controller.isLoading.value = true;
  controller.isError.value = false;
  controller.errorMsg.value = "";
  controller.videoQualities.value = [];

  YoutubeExplode yt = YoutubeExplode();
  try {
    var video = await yt.videos.get(url);
    var manifest = await yt.videos.streamsClient.getManifest(url);

    for(var i in manifest.muxed) {
      controller.videoQualities.value.add({
        'name': video.title.toString(),
        'data': i,
      });
      controller.videoQualities.refresh();

    }

  } catch (e) {
    controller.isLoading.value = false;
    controller.isDownloadClicked.value = false;
    controller.isError.value = true;
    controller.errorMsg.value = e.toString();
    return;
  }
  yt.close();
  controller.isLoading.value = false;
  controller.isDownloadClicked.value = false;
}

// Permission Function
Future<void> getPermission() async {
  // Check if storage permission is there or not. If not, ask for permission
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
  else{
    return;
  }
}