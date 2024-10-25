import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../utils/app_constants.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> videoUrls = [];

  @override
  void onInit() {
    getHomeVideos();
    super.onInit();
  }

  getHomeVideos() async {
    DocumentSnapshot<Map<String, dynamic>> videosListDoc = await _firestore
        .collection(AppConstants.videosCollection)
        .doc(AppConstants.videosList)
        .get();
    if (videosListDoc.exists) {
      videoUrls = List<String>.from(videosListDoc.data()!['urls']);
    }
  }
}
