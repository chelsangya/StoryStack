
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_stack/config/constants/api_endpoints.dart';
import 'package:story_stack/core/failure/failure.dart';
import 'package:story_stack/core/networking/http_service.dart';
import 'package:story_stack/core/shared_pref/user_shared_prefs';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:story_stack/features/auth/data/model/auth_api_model.dart';
import 'package:story_stack/features/auth/domain/entity/auth_entity.dart';



final authRemoteDataSourceProvider = Provider.autoDispose<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class AuthRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  AuthRemoteDataSource({
    required this.dio,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, String>> registerUser(AuthEntity auth) async {
    try {
      AuthAPIModel authAPIModel = AuthAPIModel.fromEntity(auth);
      var response =
          await dio.post(ApiEndpoints.register, data: authAPIModel.toJson());

      if (response.statusCode == 200) {
        String message = response.data['message'];
        return Right(message);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, String>> loginUser(
    String email,
    String password,
  ) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.login,
        data: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        String token = response.data['token'];
        String message = response.data['message'];
        userSharedPrefs.setUserToken(token);
        userSharedPrefs.setUser(response.data['userData']);
        return Right(message);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, String>> updateUser(
    String email,
    String phone,
  ) async {
    try {
      String? token;
      final data = await userSharedPrefs.getUserToken();
      data.fold((l) => token = null, (r) => token = r!);
      var response = await dio.put(
        ApiEndpoints.updateUser,
        data: {
          "email": email,
          "phone": phone,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        String message = response.data['message'];
        // userSharedPrefs.setUser(response.data['user']);
        return Right(message);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, String>> uploadProfilePicture(File? image) async {
    try {
      if (image == null) {
        return Left(Failure(error: "Image file is null"));
      }
      String? token;
      final data = await userSharedPrefs.getUserToken();
      data.fold((l) => token = null, (r) => token = r!);
      FormData formData = FormData.fromMap({
        'userImage': await MultipartFile.fromFile(image.path),
      });
      Response response = await dio.put(
        ApiEndpoints.uploadProfilePicture,
        data: formData,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        String message = response.data['message'];
        // userSharedPrefs.setProfilePicture(response.data['userImageUrl']);
        return Right(message);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, String>> updateUserPassword(
      String currentPassword, String newPassword) async {
    try {
      String? token;
      final data = await userSharedPrefs.getUserToken();
      final userData = await userSharedPrefs.getUser();
      data.fold((l) => token = null, (r) => token = r!);
      String? id = userData?['_id']?.toString() ?? '';
      var response = await dio.put(
        '${ApiEndpoints.changePassword}/$id',
        data: {
          "currentPassword": currentPassword,
          "newPassword": newPassword,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        String message = response.data['message'];
        return Right(message);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, String>> requestOTP(
    String email,
  ) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.requestOTP,
        data: {
          "email": email,
        },
      );
      if (response.statusCode == 200) {
        String message = response.data['message'];

        return Right(message);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, String>> resetPassword(
      String email, String otp, String password) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.resetPassword,
        data: {"email": email, "otp": otp, "newPassword": password},
      );
      if (response.statusCode == 200) {
        String message = response.data['message'];
        return Right(message);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }
}