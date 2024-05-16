import 'package:story_stack/features/books/domain/entity/book_entity.dart';

class BookState {
  final bool isLoading;
  final String? error;
  final bool showMessage;
  final String? message;
  final BookEntity? bookEntity;

  BookState({
    required this.isLoading,
    this.error,
    this.message,
    this.showMessage = false,
    this.bookEntity,
  });

  factory BookState.initialState() {
    return BookState(
      isLoading: false,
      error: null,
      showMessage: false,
      message: null,
      bookEntity: null,
    );
  }

  BookState copyWith({
    bool? isLoading,
    String? error,
    bool? showMessage,
    String? message,
    String? imageName,
    BookEntity? bookEntity,
  }) {
    return BookState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      showMessage: showMessage ?? this.showMessage,
      message: message ?? this.message,
      bookEntity: bookEntity ?? this.bookEntity,
    );
  }

  @override
  String toString() => 'BookState(isLoading: $isLoading, error: $error, )';
}
