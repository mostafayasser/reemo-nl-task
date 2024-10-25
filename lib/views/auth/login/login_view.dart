import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../controllers/user_controller.dart';
import '../../../helpers/validators.dart';
import '../../../utils/custom_snackbar.dart';
import '../../../utils/loader.dart';
import '../../main/main_view.dart';
import '../../onboarding/onboarding_main_view.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController _authController = Get.find();
  final UserController _userController = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _focusNode = FocusNode();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Email',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _emailController,
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (val) => Validators.validateEmail(val),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Password',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _passwordController,
                  hintText: 'Enter your password',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  obSecure: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  validator: (val) => Validators.validatePassword(val),
                ),
                const SizedBox(height: 32.0),
                Center(
                  child: CustomButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        FocusScope.of(context).requestFocus(_focusNode);

                        String email =
                            _emailController.text.toLowerCase().trim();
                        String password = _passwordController.text.trim();
                        Loader.showLoader();
                        String message = await _authController.signInWithEmail(
                          email: email,
                          password: password,
                        );
                        if (message.isEmpty) {
                          await _userController.getUserFromFirestore(email);
                        }
                        Loader.hideLoader();
                        if (message.isEmpty) {
                          if (_userController
                              .currentUser.value.seniority.isEmpty) {
                            Get.offAll(() => OnboardingMainView());
                          } else {
                            Get.offAll(() => const MainView());
                          }
                        } else {
                          customSnackBar(isError: true, message: message);
                        }
                      }
                    },
                    title: 'Login',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
