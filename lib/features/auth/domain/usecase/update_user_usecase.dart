import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_stack/core/failure/failure.dart';
import 'package:story_stack/features/auth/domain/repository/iauth_repository.dart';
final updateUserUseCaseProvider = Provider.autoDispose<UpdateUserUseCase>(
    (ref) => UpdateUserUseCase(
      repository: ref.read(iAuthRepositoryProvider))
      );

class UpdateUserUseCase {
  final IAuthRepository repository;

  UpdateUserUseCase({required this.repository});

  Future<Either<Failure, String>> updateUserProfile(
     String email, String phone) async {
    return await repository.updateProfile(
       email, phone);
  }
}