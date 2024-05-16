import 'package:story_stack/features/primary/presentation/view/primary_view.dart';
import 'package:story_stack/view/avatar_selection_view.dart';
import 'package:story_stack/view/select_view.dart';
import 'package:story_stack/view/signin_view.dart';
import 'package:story_stack/view/signup_view.dart';
import 'package:story_stack/view/splash_view.dart';

class AppRoute {
  AppRoute._();
  static const String splashRoute = '/';
  static const String selectRoute = '/select';
  static const String signinRoute = '/signin';
  static const String signupRoute = '/signup';
  static const String homeRoute = '/home';
  static const String avatarSelectionRoute = '/avatar-selection';
  static const String profileRoute = '/profile';
  static const String settingsRoute = '/settings';
  static getApplicationRoute() {
    return {
      signinRoute: (context) => const SigninView(),
      signupRoute: (context) => const SignupView(),
      avatarSelectionRoute: (context) => const AvatarSelectionView(),
      splashRoute: (context) => const SplashView(),
      selectRoute: (context) => const SelectView(),
      homeRoute: (context) => const PrimaryView(),
      // profileRoute: (context) => ProfileView(),
      // settingsRoute: (context) => SettingsView(),
    };
  }
}
