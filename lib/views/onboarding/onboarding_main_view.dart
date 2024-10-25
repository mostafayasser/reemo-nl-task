import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/onboarding_controller.dart';
import '../../styles/app_gradients.dart';
import '../../utils/custom_snackbar.dart';
import '../../utils/image_assets.dart';
import '../../utils/loader.dart';
import '../main/main_view.dart';
import '../widgets/custom_button.dart';
import 'onboarding_industry_view.dart';
import 'onboarding_job_type_view.dart';
import 'onboarding_seniority_view.dart';

class OnboardingMainView extends StatelessWidget {
  final OnboardingController controller = Get.put(OnboardingController());

  OnboardingMainView({super.key});

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Let's get acquainted"),
            centerTitle: true,
            leading: controller.currentPage.value == 0
                ? null
                : IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      controller.previousPage();
                    },
                  ),
          ),
          extendBodyBehindAppBar: true,
          body: Container(
            decoration: const BoxDecoration(
              gradient: AppGradients.primaryGradient,
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  right: -(MediaQuery.of(context).size.width * 2.5),
                  bottom: 50,
                  child: Image.asset(
                    ImageAssets.circlesImage, // Your image path in assets
                    fit: BoxFit.contain,
                    opacity: const AlwaysStoppedAnimation(0.4),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      // put a sized box with height same as the safearea widget takes
                      SizedBox(height: topPadding + kToolbarHeight),
                      // Stepper-like progress bar
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: LinearProgressIndicator(
                          value: (controller.currentPage.value + 1) / 3,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Expanded(
                        child: Builder(
                          builder: (context) {
                            // Show different screens based on the current page
                            switch (controller.currentPage.value) {
                              case 0:
                                return OnboardingIndustryView();
                              case 1:
                                return OnboardingSeniorityView();
                              case 2:
                                return OnboardingJobTypeView();
                              default:
                                return OnboardingIndustryView();
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        title: controller.currentPage.value < 2
                            ? "Next"
                            : "Finish",
                        onPressed: () async {
                          String errorMessage = controller.validateStep();
                          if (errorMessage.isNotEmpty) {
                            customSnackBar(
                              isError: true,
                              message: errorMessage,
                            );
                            return;
                          } else {
                            if (controller.currentPage.value < 2) {
                              controller.nextPage();
                            } else {
                              Loader.showLoader();
                              await controller.submitAnswers();
                              Loader.hideLoader();
                              Get.offAll(() => const MainView());
                            }
                          }
                        },
                        iconBefore: false,
                        icon: controller.currentPage.value < 2
                            ? Icon(
                                Icons.arrow_forward,
                                size: 16,
                                color: Theme.of(context).iconTheme.color,
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
