// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:story_stack/config/routes/app_routes.dart';
// import 'package:story_stack/core/common/snackbar/snackbar.dart';
// import 'package:story_stack/core/shared_pref/user_shared_prefs';
// import 'package:story_stack/features/auth/domain/usecase/login_usecase.dart';
// import 'package:story_stack/features/auth/domain/usecase/register_usecase.dart';
// import 'package:story_stack/features/auth/domain/usecase/reset_password_usecase.dart';
// import 'package:story_stack/features/auth/presentation/state/auth_state.dart';

// import '../../domain/entity/auth_entity.dart';

// final authViewModelProvider =
//     StateNotifierProvider.autoDispose<AuthViewModel, AuthState>(
//   (ref) => AuthViewModel(
//     authUseCase: ref.read(loginUseCaseProvider),
//     registerUseCase: ref.read(registerUseCaseProvider),
//     resetPasswordUsecase: ref.read(resetPasswordUsecaseProvider),
//     userSharedPrefs: ref.read(userSharedPrefsProvider),
//   ),
// );

// class AuthViewModel extends StateNotifier<AuthState> {
//   final LoginUseCase authUseCase;
//   final RegisterUseCase registerUseCase;
//   final ResetPasswordUsecase resetPasswordUsecase;
//   final UserSharedPrefs userSharedPrefs;

//   AuthViewModel({
//     required this.authUseCase,
//     required this.registerUseCase,
//     required this.resetPasswordUsecase,
//     required this.userSharedPrefs,
//   }) : super(AuthState.initialState());

//   Future<void> registerUser(AuthEntity auth, BuildContext context) async {
//     try {
//       state = state.copyWith(isLoading: true);
//       final result = await registerUseCase.registerUser(auth);
//       state = state.copyWith(isLoading: false);
//       result.fold(
//         (failure) {
//           state = state.copyWith(
//             error: failure.error,
//             isLoading: false,
//           );
//           mySnackBar(
//             message: state.error!,
//             context: context,
//             color: Colors.red[900],
//           );
//         },
//         (success) {
//           state = state.copyWith(
//             isLoading: false,
//             message: success,
//             showMessage: true,
//             error: null,
//           );
//           mySnackBar(
//             message: success,
//             context: context,
//             // color: Colors.red[900],
//           );
//         },
//       );
//     } catch (e) {
//       state = state.copyWith(
//         error: 'Error registering',
//         isLoading: false,
//         showMessage: true,
//       );
//     }
//   }

//   Future<void> loginUser(
//       BuildContext context, String email, String password) async {
//     try {
//       state = state.copyWith(isLoading: true);
//       final result = await authUseCase.loginUser(email, password);
//       state = state.copyWith(isLoading: false);
//       result.fold(
//         (failure) {
//           state = state.copyWith(
//             error: failure.error,
//             isLoading: false,
//             showMessage: true,
//           );
//           mySnackBar(
//             message: state.error!,
//             context: context,
//             color: Colors.red[900],
//           );
//         },
//         (success) {
//           state = state.copyWith(
//             isLoading: false,
//             message: success,
//             showMessage: true,
//             error: null,
//           );
//           mySnackBar(
//             message: success,
//             context: context,
//           );
//           Navigator.pushNamed(context, AppRoute.homeRoute);
//         },
//       );
//     } catch (e) {
//       state = state.copyWith(
//         error: 'Error logging in user',
//         isLoading: false,
//         showMessage: true,
//       );
//     }
//   }
  
//   void logout(BuildContext context) async {
//     state = state.copyWith(isLoading: true);
//       mySnackBar(
//       message: 'Logged Out',
//       context: context,
//     );
//     await userSharedPrefs.deleteUserToken();

  

//     Future.delayed(const Duration(milliseconds: 1000), () {
//       Navigator.pushNamed(context, AppRoute.signinRoute);
//     });
//   }

//   Future<void> requestOTP(BuildContext context, String email) async {
//     try {
//       state = state.copyWith(isLoading: true);
//       final result = await resetPasswordUsecase.requestOTP(email);
//       state = state.copyWith(isLoading: false);

//       result.fold(
//         (failure) {
//           state = state.copyWith(
//             error: failure.error,
//             isLoading: false,
//             showMessage: true,
//           );
//           mySnackBar(
//             message: state.error!,
//             context: context,
//             color: Colors.red[900],
//           );
//         },
//         (success) {
//           state = state.copyWith(
//             isLoading: false,
//             message: success,
//             showMessage: true,
//             error: null,
//           );
//           // Navigator.popAndPushNamed(context, AppRoute.resetPasswordRoute,
//           //     arguments: email);
//         },
//       );
//     } catch (e) {
//       state = state.copyWith(
//         error: 'Error logging in user',
//         isLoading: false,
//         showMessage: true,
//       );
//     }
//   }

//   Future<void> resetPassword(
//       BuildContext context, String email, String otp, String password) async {
//     try {
//       state = state.copyWith(isLoading: true);
//       final result =
//           await resetPasswordUsecase.resetPassword(email, otp, password);
//       state = state.copyWith(isLoading: false);

//       result.fold(
//         (failure) {
//           state = state.copyWith(
//             error: failure.error,
//             isLoading: false,
//             showMessage: true,
//           );
//           mySnackBar(
//             message: state.error!,
//             context: context,
//             color: Colors.red[900],
//           );
//         },
//         (success) {
//           state = state.copyWith(
//             isLoading: false,
//             message: success,
//             showMessage: true,
//             error: null,
//           );
//           Navigator.popAndPushNamed(context, AppRoute.signinRoute);
//         },
//       );
//     } catch (e) {
//       state = state.copyWith(
//         error: 'Error logging in user',
//         isLoading: false,
//         showMessage: true,
//       );
//     }
//   }


//    void logoutUser(BuildContext context) async {
//     state = state.copyWith(isLoading: true);
//     await userSharedPrefs.deleteUserToken();
//     Future.delayed(const Duration(milliseconds: 1000), () {
//       state=state.copyWith(isLoading: false, message: 'Logged Out', showMessage: true);
//       Navigator.pushNamed(context, AppRoute.signinRoute);
//     });
//   }
//   void resetMessage(bool value) {
//     state = state.copyWith(showMessage: false, error: null, isLoading: false);
//   }
// }