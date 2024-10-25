import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/onboarding_controller.dart';
import '../widgets/custom_text_field.dart';
import 'widgets/custom_choice_chip.dart';

class OnboardingIndustryView extends StatelessWidget {
  final OnboardingController controller = Get.find<OnboardingController>();

  final List<String> industries = [
    "Education",
    "Healthcare",
    "Construction",
    "Retail",
    "Finance",
    "Marketing",
    "Hospitality",
    "Tech",
    "Manufacturing",
    "Transportation",
    "Other"
  ];

  OnboardingIndustryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "What industry are you looking for a job in?",
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: industries.map((industry) {
                  return Obx(() {
                    bool isSelected =
                        controller.selectedIndustry.value == industry;
                    return CustomChoiceChip(
                      label: industry,
                      isSelected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          controller.otherIndustryController.clear();
                          controller.selectedIndustry.value = industry;
                        } else {
                          controller.selectedIndustry.value = "";
                        }
                      },
                    );
                  });
                }).toList(),
              ),
              if (controller.selectedIndustry.value == "Other")
                const SizedBox(height: 20),
              if (controller.selectedIndustry.value == "Other")
                CustomTextField(
                  controller: controller.otherIndustryController,
                  hintText: "Enter your industry e.g. Agriculture",
                  radius: 10,
                ),
            ],
          ),
        );
      },
    );
  }
}
