import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'HomeController.dart';
import 'package:get/get.dart';

import 'VideoQuality.dart';
import 'downloadVideo.dart';

class Home extends StatelessWidget {
  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            getVideoData(url: controller.text, controller: homeController),
        label: const Text("Download"),
        icon: const Icon(Icons.download),
        backgroundColor: Colors.blueGrey[600],
      ),
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        title: const Text("Dillu YouTube Downloader"),
        backgroundColor: Colors.blueGrey[600],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Image(
              height: 200,
              width: 200,
              image: AssetImage("lib/assets/youtube.png"),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: formKey,
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Enter YouTube Video URL",
                  labelText: "YouTube URL",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a valid URL";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() {
              return homeController.isLoading.value
                  ? SpinKitWave(
                      color: Colors.blueGrey[600],
                      size: 50,
                    )
                  : const SizedBox(height: 0);
            }),
            Obx(() {
              return homeController.isError.value
                  ? Text(
                      "Error Downloading Video\n${homeController.errorMsg.value}")
                  : const SizedBox(height: 0);
            }),
            Obx(() {
              return homeController.isDownloaded.value
                  ? const Text(
                      "Video Downloaded Successfully",
                      style: TextStyle(color: Colors.green),
                    )
                  : const SizedBox(height: 0);
            }),
            Obx(() {
              return homeController.isDownloading.value
                  ? const SpinKitSpinningLines(color: Colors.black)
                  : const SizedBox(height: 0);
            }),
            Obx(() {
              return homeController.videoQualities.value.isNotEmpty
                  ? const Text(
                      "Choose Quality",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  : const SizedBox(height: 20);
            }),
            Obx(() => Column(
                  children: homeController.videoQualities.value
                      .map((e) => VideoQuality(
                            name: e["name"],
                            data: e["data"],
                            controller: homeController,
                          ))
                      .toList(),
                )),
          ],
        ),
      ),
    );
  }
}
