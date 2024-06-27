import 'package:story_stack/features/auth/presentation/view/signin_view.dart';
import 'package:story_stack/features/auth/presentation/view/signup_view.dart';
import 'package:story_stack/features/primary/presentation/view/primary_view.dart';
import 'package:story_stack/view/about_us_view.dart';
import 'package:story_stack/view/avatar_selection_view.dart';
import 'package:story_stack/view/contact_us_view.dart';
import 'package:story_stack/view/edit_password_view.dart';
import 'package:story_stack/view/edit_profile_view.dart';
import 'package:story_stack/view/faq_view.dart';
import 'package:story_stack/view/forum_view.dart';
import 'package:story_stack/view/new_post_view.dart';
import 'package:story_stack/view/privacy_policy_view.dart';
import 'package:story_stack/view/profile_view.dart';
import 'package:story_stack/view/select_view.dart';
import 'package:story_stack/view/settings_view.dart';
import 'package:story_stack/view/splash_view.dart';
import 'package:story_stack/view/terms_of_use_view.dart';

class AppRoute {
  AppRoute._();
  static const String splashRoute = '/';
  static const String selectRoute = '/select';
  static const String signinRoute = '/signin';
  static const String signupRoute = '/signup';
  static const String homeRoute = '/home';
  static const String avatarSelectionRoute = '/avatar-selection';
  static const String profileRoute = '/profile';
  static const String editProfileRoute = '/edit-profile';
  static const String editPasswordRoute = '/edit-password';
  static const String settingsRoute = '/settings';
  static const String forumRoute = '/forum';
  static const String addPostRoute = '/addPost';
  static const String termsRoute = '/terms';
  static const String privacyRoute = '/privacy';
  static const String faqRoute = '/faq';
  static const String aboutRoute = '/about';
  static const String contactRoute = '/contact';
  static getApplicationRoute() {
    return {
      signinRoute: (context) => const SigninView(),
      signupRoute: (context) => const SignupView(),
      avatarSelectionRoute: (context) => const AvatarSelectionView(),
      splashRoute: (context) => const SplashView(),
      selectRoute: (context) => const SelectView(),
      homeRoute: (context) => const PrimaryView(),
      forumRoute: (context) => const ForumView(),
      addPostRoute: (context) => const NewPostView(),
      profileRoute: (context) => const ProfileView(),
      editProfileRoute: (context) => const EditProfileView(),
      editPasswordRoute: (context) => const EditPasswordView(),
      settingsRoute: (context) => const SettingsView(),
      termsRoute: (context) => const TermsOfUseView(),
      privacyRoute: (context) => const PrivacyPolicyView(),
      faqRoute: (context) => const FaqView(),
      aboutRoute: (context) => const AboutUsView(),
      contactRoute: (context) => const ContactUsView(),
    };
  }
}
