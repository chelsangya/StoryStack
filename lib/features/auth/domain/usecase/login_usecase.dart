// import 'package:dartz/dartz.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:story_stack/core/failure/failure.dart';
// import 'package:story_stack/features/auth/domain/repository/iauth_repository.dart';

// final loginUseCaseProvider = Provider.autoDispose<LoginUseCase>(
//     (ref) => LoginUseCase(repository: ref.read(iAuthRepositoryProvider)));
    
// class LoginUseCase {
//   final IAuthRepository repository;

//   LoginUseCase({required this.repository});

//   Future<Either<Failure, String>> loginUser(
//       String email, String password) async {
//     return await repository.loginUser(email, password);
//   }
// }