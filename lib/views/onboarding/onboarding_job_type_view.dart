import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/onboarding_controller.dart';
import 'widgets/custom_choice_chip.dart';

class OnboardingJobTypeView extends StatelessWidget {
  final OnboardingController controller = Get.find<OnboardingController>();

  final List<String> jobTypes = ["Remote", "On Site", "Hybrid"];

  OnboardingJobTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "What type of job are you looking for?",
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: jobTypes.map((type) {
            return Obx(() {
              bool isSelected = controller.selectedJobType.value == type;
              return CustomChoiceChip(
                label: type,
                isSelected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    controller.selectedJobType.value = type;
                  } else {
                    controller.selectedJobType.value = "";
                  }
                },
              );
            });
          }).toList(),
        ),
      ],
    );
  }
}
