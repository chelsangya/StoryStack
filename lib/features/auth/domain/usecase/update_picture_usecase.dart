import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_stack/core/failure/failure.dart';
import 'package:story_stack/features/auth/domain/repository/iauth_repository.dart';

final uploadPictureUseCaseProvider = Provider.autoDispose<UploadPictureUseCase>(
    (ref) =>
        UploadPictureUseCase(repository: ref.read(iAuthRepositoryProvider)));

class UploadPictureUseCase {
  final IAuthRepository repository;

  UploadPictureUseCase({required this.repository});

  Future<Either<Failure, String>> uploadProfilePicture(File? file) async {
    if (file == null) {
      return Left(Failure(error: "File is null"));
    }

    return await repository.uploadProfilePicture(file);
  }
}
