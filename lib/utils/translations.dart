import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'nl_NL': {
          'sign_out': 'Afmelden',
          'welcome_back': 'Welkom Terug',
          'industry': 'Industrie',
          'seniority': 'Senioriteit',
          'type': 'Type',
        },
        'en_US': {
          'sign_out': 'Sign Out',
          'welcome_back': 'Welcome Back',
          'industry': 'Industry',
          'seniority': 'Seniority',
          'type': 'Type',
        },
      };
}
