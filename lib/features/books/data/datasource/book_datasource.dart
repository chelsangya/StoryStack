
// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:story_stack/core/networking/http_service.dart';
// import 'package:story_stack/core/shared_pref/user_shared_prefs';

// final bookRemoteDataSourceProvider =
//     Provider.autoDispose<BookRemoteDatasource>(
//   (ref) => BookRemoteDatasource(
//     dio: ref.read(httpServiceProvider),
//     userSharedPrefs: ref.read(userSharedPrefsProvider),
//   ),
// );

// class BookRemoteDatasource{
//   final Dio dio;
//   final UserSharedPrefs userSharedPrefs;
//   BookRemoteDatasource({
//     required this.dio,
//     required this.userSharedPrefs,
//   });
  
//   // Future<void> viewbooks() async {

//   // }
// }