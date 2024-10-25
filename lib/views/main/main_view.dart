import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/user_controller.dart';
import '../../services/cache_service.dart';
import '../../styles/app_gradients.dart';
import '../../utils/image_assets.dart';
import '../../utils/loader.dart';
import '../home/home_view.dart';
import '../profile/profile_view.dart';
import '../welcome/welcome_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 1;
  final UserController _userController = Get.find();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    Get.put(HomeController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String lang = CacheService.getString('lang');
    bool isDutch = lang == 'nl';
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(100.0), // Set the custom height here
        child: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.menu), // Change this to your desired icon
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: AppGradients.primaryGradient,
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(25),
                bottomEnd: Radius.circular(25),
              ),
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
                right: BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
                left: BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 40,
              ), // Adjust the bottom padding
              child: Align(
                alignment:
                    Alignment.bottomCenter, // Aligns the text near the bottom
                child: Text(
                  "${"welcome_back".tr}, ${_userController.currentUser.value.name}.",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
            ),
          ),
          elevation: 0,
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            style: IconButton.styleFrom(
              padding: const EdgeInsets.all(20),
              backgroundColor: Colors.blue.shade300.withOpacity(0.3),
              elevation: 1,
              shadowColor: Colors.black45,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            onPressed: () {
              setState(() {
                _currentIndex = 0;
              });
            },
            icon: const Icon(
              Icons.home_outlined,
              color: Colors.black,
            ),
          ),
          IconButton(
            style: IconButton.styleFrom(
              padding: const EdgeInsets.all(20),
              backgroundColor: Colors.blue.shade300.withOpacity(0.3),
              elevation: 1,
              shadowColor: Colors.black45,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            onPressed: () {
              setState(() {
                _currentIndex = 1;
              });
            },
            icon: const Icon(
              Icons.person_outline,
              color: Colors.black,
            ),
          ),
        ],
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
            _currentIndex == 0 ? const HomeView() : ProfileView(),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              // language button
              ListTile(
                leading: const Icon(Icons.language),
                title: Text(
                  isDutch ? 'English' : 'Nederlands',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () async {
                  Get.back();
                  if (isDutch) {
                    const locale = Locale('en', 'US');
                    await CacheService.setString('lang', 'en');
                    Get.updateLocale(locale);
                  } else {
                    const locale = Locale('nl', 'NL');
                    await CacheService.setString('lang', 'nl');
                    Get.updateLocale(locale);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: Text(
                  'sign_out'.tr,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () async {
                  Loader.showLoader();
                  final AuthController authController = Get.find();
                  await authController.signOut();
                  _userController.clearUserData();
                  Loader.hideLoader();
                  Get.offAll(() => const WelcomeView());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
