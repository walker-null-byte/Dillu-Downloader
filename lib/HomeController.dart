import 'package:get/get.dart';

class HomeController extends GetxController {
  Rx<bool> isDownloadClicked = Rx<bool>(false);
  Rx<bool> isLoading = Rx<bool>(false);
  Rx<bool> isError = Rx<bool>(false);
  Rx<String> errorMsg = Rx<String>("");
  Rx<bool> isDownloaded = Rx<bool>(false);

  Rx<bool> isDownloading = Rx<bool>(false);

  Rx<List<dynamic>> videoQualities = Rx<List<dynamic>>([]);


}