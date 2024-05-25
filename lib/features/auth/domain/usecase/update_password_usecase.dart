import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_stack/core/failure/failure.dart';
import 'package:story_stack/features/auth/domain/repository/iauth_repository.dart';

final updatePasswordUseCaseProvider = Provider.autoDispose<UpdatePasswordUseCase>(
    (ref) => UpdatePasswordUseCase(repository: ref.read(iAuthRepositoryProvider)));

class UpdatePasswordUseCase{
   final IAuthRepository repository;

  UpdatePasswordUseCase({required this.repository});
    Future<Either<Failure, String>> updateUserPassword(
      String currentPassword, String newPassword) async {
    return await repository.changePassword(currentPassword, newPassword);
  }
}