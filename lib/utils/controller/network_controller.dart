import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateNetworkConnection);
  }

  void _updateNetworkConnection(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      Get.rawSnackbar(
        messageText: const Text(
          "Lost Connection to Internet!",
          style: TextStyle(color: Colors.white),
        ),
        isDismissible: false,
        duration: const Duration(days: 1),
        margin: EdgeInsets.zero,
        snackStyle: SnackStyle.GROUNDED,
        icon: const Icon(
          Icons.cloud_off,
          color: Colors.red,
        ),
      );
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }
}
