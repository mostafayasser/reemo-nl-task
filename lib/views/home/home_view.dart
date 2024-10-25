import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import 'widgets/video_player_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: controller.videoUrls.length,
        itemBuilder: (context, index) {
          return VideoPlayerWidget(url: controller.videoUrls[index]);
        },
      ),
    );
  }
}
