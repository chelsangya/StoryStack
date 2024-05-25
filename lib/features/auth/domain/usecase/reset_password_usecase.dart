import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_stack/core/failure/failure.dart';
import 'package:story_stack/features/auth/domain/repository/iauth_repository.dart';

final resetPasswordUsecaseProvider = Provider.autoDispose<ResetPasswordUsecase>(
    (ref) => ResetPasswordUsecase(repository: ref.read(iAuthRepositoryProvider)));


class ResetPasswordUsecase{
    final IAuthRepository repository;

  ResetPasswordUsecase({required this.repository});

    Future<Either<Failure, String>> requestOTP(
    String email,
  ) async {
    return await repository.requestOTP(email);
  }

  Future<Either<Failure, String>> resetPassword(
    String email,
    String otp,
    String password
  ) async {
    return await repository.resetPassword(email, otp, password);
  }
}