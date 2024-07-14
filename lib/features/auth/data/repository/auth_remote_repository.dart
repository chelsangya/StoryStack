
// import 'dart:io';

// import 'package:dartz/dartz.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:story_stack/core/failure/failure.dart';

// import 'package:story_stack/features/auth/data/datasource/auth_datasource.dart';
// import 'package:story_stack/features/auth/domain/entity/auth_entity.dart';

// import 'package:story_stack/features/auth/domain/repository/iauth_repository.dart';

// final authRemoteRepositoryProvider = Provider.autoDispose<IAuthRepository>(
//   (ref) => AuthRemoteRepository(
//     authRemoteDataSource: ref.read(authRemoteDataSourceProvider),
//   ),
// );

// class AuthRemoteRepository implements IAuthRepository {
//   AuthRemoteDataSource authRemoteDataSource;
//   AuthRemoteRepository({
//     required this.authRemoteDataSource,
//   });
//  @override
//   Future<Either<Failure, String>> loginUser(
//       String email, String password) async {
//     final result = await authRemoteDataSource.loginUser(email, password);
//     return result.fold((failure) => Left(failure), (success) => Right(success));
//   }

//   @override
//   Future<Either<Failure, String>> registerUser(AuthEntity user) async {
//     final result = await authRemoteDataSource.registerUser(user);
//     return result.fold((failure) => Left(failure), (success) => Right(success));
//   }

//   @override
//   Future<Either<Failure, String>> changePassword(
//       String password, String newPassword) async {
//     final result =
//         await authRemoteDataSource.updateUserPassword(password, newPassword);
//     return result.fold((failure) => Left(failure), (success) => Right(success));
//   }

//   @override
//   Future<Either<Failure, String>> updateProfile(String email,
//    String phone) async {
//     final result = await authRemoteDataSource.updateUser(
//          email, phone);
//     return result.fold((failure) => Left(failure), (success) => Right(success));
//   }

//   @override
//   Future<Either<Failure, String>> uploadProfilePicture(File file) async {
//       final result = await authRemoteDataSource.uploadProfilePicture(file);
//     return result.fold((failure) => Left(failure), (success) => Right(success));
//   }
  
//    @override
//   Future<Either<Failure, String>> requestOTP(
//       String email) async {
//     final result = await authRemoteDataSource.requestOTP(email);
//     return result.fold((failure) => Left(failure), (success) => Right(success));
//   }

//   @override
//   Future<Either<Failure, String>> resetPassword(
//       String email, String otp, String password) async {
//     final result = await authRemoteDataSource.resetPassword(email, otp, password);
//     return result.fold((failure) => Left(failure), (success) => Right(success));
//   }
 
// }
