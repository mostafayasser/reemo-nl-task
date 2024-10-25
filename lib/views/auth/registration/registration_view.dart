import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../controllers/user_controller.dart';
import '../../../helpers/validators.dart';
import '../../../models/user_model.dart';
import '../../../utils/custom_snackbar.dart';
import '../../../utils/loader.dart';
import '../../onboarding/onboarding_main_view.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  final AuthController _authController = Get.find();
  final UserController _userController = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _focusNode = FocusNode();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _registerUser() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).requestFocus(_focusNode);
      String password = _passwordController.text.trim();
      String email = _emailController.text.toLowerCase().trim();
      String name = _nameController.text.trim();
      Loader.showLoader();
      UserModel userModel = UserModel(
        email: email,
        name: name,
        industry: "",
        seniority: "",
        jobType: "",
      );
      String message = await _authController.signUp(
        userModel: userModel,
        password: password,
      );
      if (message.isEmpty) {
        await _userController.setUserData(userModel);
      }
      Loader.hideLoader();
      if (message.isEmpty) {
        Get.offAll(() => OnboardingMainView());
      } else {
        customSnackBar(isError: true, message: message);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Name',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: _nameController,
                      hintText: 'Enter your name',
                      textInputAction: TextInputAction.next,
                      isCapital: true,
                      validator: (val) => Validators.validateName(val),
                    ),
                    const SizedBox(height: 16),
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
                    const SizedBox(height: 16),
                    Text(
                      'Password',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: 'Enter your password',
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
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
                    const SizedBox(height: 16),
                    Text(
                      'Confirm Password',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: _confirmPasswordController,
                      hintText: 'Confirm your password',
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      obSecure: _obscureConfirmPassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                      validator: (val) => Validators.validateConfirmPassword(
                          val, _passwordController.text.trim()),
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: CustomButton(
                        onPressed: _registerUser,
                        title: 'Register',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
