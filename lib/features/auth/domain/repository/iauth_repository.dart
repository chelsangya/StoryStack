// import 'dart:io';

// import 'package:dartz/dartz.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:story_stack/core/failure/failure.dart';
// import 'package:story_stack/features/auth/data/repository/auth_remote_repository.dart';
// import 'package:story_stack/features/auth/domain/entity/auth_entity.dart';


// final iAuthRepositoryProvider =
//     Provider.autoDispose<IAuthRepository>((ref) => ref.read(
//           authRemoteRepositoryProvider,
//         ));

// abstract class IAuthRepository {
//   Future<Either<Failure, String>> registerUser(AuthEntity user);
//   Future<Either<Failure, String>> loginUser(String email, String password);

//   Future<Either<Failure, String>> changePassword(String password, String newPassword);
//   Future<Either<Failure, String>> updateProfile( String email,  String phone);
//   Future<Either<Failure, String>> uploadProfilePicture(File file);
//   Future<Either<Failure, String>> requestOTP(String email);
//   Future<Either<Failure, String>> resetPassword(String email, String otp, String password);
// }
