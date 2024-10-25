import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../styles/app_gradients.dart';
import '../../utils/image_assets.dart';
import '../auth/login/login_view.dart';
import '../auth/registration/registration_view.dart';
import '../widgets/custom_button.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        centerTitle: true,
        elevation: 100,
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        decoration: const BoxDecoration(
          gradient: AppGradients.secondaryGradient,
        ),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "Swipe into your new job in just a few seconds",
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    ImageAssets.circlesImage,
                    opacity: const AlwaysStoppedAnimation(0.4),
                    fit: BoxFit.contain,
                    height: 120,
                  ),
                  Text("Swipe.",
                      style: Theme.of(context).textTheme.headlineMedium),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // create 3 dots like indicators
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "Swipe. Like. Works.",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 20,
                    ),
              ),
              const Spacer(),
              CustomButton(
                title: "I'm new to Swipework",
                onPressed: () {
                  Get.to(() => const RegistrationView());
                },
                iconBefore: false,
                icon: Icon(
                  Icons.arrow_forward,
                  color: Theme.of(context).iconTheme.color,
                  size: 15,
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                title: "Already have an account",
                onPressed: () {
                  Get.to(() => const LoginScreen());
                },
                iconBefore: false,
                icon: Icon(
                  Icons.arrow_forward,
                  color: Theme.of(context).iconTheme.color,
                  size: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
