import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_stack/core/failure/failure.dart';
import 'package:story_stack/features/auth/domain/repository/iauth_repository.dart';

final registerUseCaseProvider = Provider.autoDispose<RegisterUseCase>(
    (ref) => RegisterUseCase(repository: ref.read(iAuthRepositoryProvider)));
class RegisterUseCase {
  final IAuthRepository repository;

  RegisterUseCase({required this.repository});

  Future<Either<Failure, String>> registerUser( student) async {
    return await repository.registerUser(student);
  }
}