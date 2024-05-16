import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_stack/core/failure/failure.dart';
import 'package:story_stack/features/books/data/datasource/book_datasource.dart';
import 'package:story_stack/features/books/domain/entity/book_entity.dart';
import 'package:story_stack/features/books/domain/repository/ibook_repository.dart';

final bookRemoteRepositoryProvider = Provider.autoDispose<IBookRepository>(
  (ref) => BookRemoteRepository(
    bookRemoteDatasource: ref.read(bookRemoteDataSourceProvider),
  ),
);

class BookRemoteRepository implements IBookRepository {
  BookRemoteDatasource bookRemoteDatasource;
  BookRemoteRepository({
    required this.bookRemoteDatasource,
  });
  @override
  Future<Either<Failure, List<BookEntity>>> viewbooks() {
    // TODO: implement viewbooks
    throw UnimplementedError();
  }
}
