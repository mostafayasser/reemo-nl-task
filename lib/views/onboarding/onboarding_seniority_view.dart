import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/onboarding_controller.dart';
import 'widgets/custom_choice_chip.dart';

class OnboardingSeniorityView extends StatelessWidget {
  final OnboardingController controller = Get.find<OnboardingController>();

  final List<String> seniorityLevels = [
    "Junior",
    "Mid-Level",
    "Senior",
    "Lead",
    "Manager"
  ];

  OnboardingSeniorityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            "What is your seniority level?",
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 40),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: seniorityLevels.map((level) {
            return Obx(() {
              bool isSelected = controller.selectedSeniority.value == level;
              return CustomChoiceChip(
                label: level,
                isSelected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    controller.selectedSeniority.value = level;
                  } else {
                    controller.selectedSeniority.value = "";
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
