import 'dart:convert';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'models/user_model.dart';
import 'services/bindings_service.dart';
import 'services/cache_service.dart';
import 'theme/theme_service.dart';
import 'utils/app_constants.dart';
import 'utils/translations.dart';
import 'views/main/main_view.dart';
import 'views/onboarding/onboarding_main_view.dart';
import 'views/welcome/welcome_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();
  await CacheService.init();
  BindingsService().dependencies();

  if (kReleaseMode) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
    // Pass all uncaught "fatal" errors from the framework to Crashlytics
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  UserModel getUserFromCache() {
    UserModel currentUser = UserModel.empty();
    String encodedUser = CacheService.getString(AppConstants.userData);
    if (encodedUser.isNotEmpty) {
      currentUser = UserModel.fromJson(jsonDecode(encodedUser));
    }
    return currentUser;
  }

  @override
  Widget build(BuildContext context) {
    UserModel currentUser = getUserFromCache();
    // Retrieve the saved locale from the cache service
    String savedLocale = CacheService.getString('lang');
    Locale locale;

    // Check if a locale is saved; if not, use the default locale (English)
    if (savedLocale.isNotEmpty) {
      if (savedLocale == 'nl') {
        locale = const Locale('nl', 'NL');
      } else {
        locale = const Locale('en', 'US');
      }
    } else {
      locale = const Locale('en', 'US');
    }
    return GetMaterialApp(
      title: 'Reemo Nl Task',
      theme: ThemeService.lightTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      locale: locale, // Default locale
      fallbackLocale: const Locale('en', 'US'), // Fallback locale
      home: currentUser.email.isEmpty
          ? const WelcomeView()
          : currentUser.industry.isEmpty
              ? OnboardingMainView()
              : const MainView(),
    );
  }
}
