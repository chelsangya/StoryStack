import 'package:equatable/equatable.dart';

class BookEntity extends Equatable {
    final String? bookId;
  final String? bookTitle;
  final String? bookAuthor;
  final String? bookDescription;
  final String? bookImageUrl;
  final String? bookCategory;
  final String? bookPublisher;
  final String? bookPublishedDate;
  final String? bookLanguage;
  final String? bookPageCount;
  final String? bookIsbn10;
  final String? bookIsbn13;
  final String? bookRating;
  final String? bookPrice;
  @override
  List<Object?> get props =>
      [
        bookId,
        bookTitle,
        bookAuthor,
        bookDescription,
        bookImageUrl,
        bookCategory

        ];

  const BookEntity({
    this.bookId,
    this.bookTitle,
    this.bookAuthor,
    this.bookDescription,
    this.bookImageUrl,
    this.bookCategory,
    this.bookPublisher,
    this.bookPublishedDate,
    this.bookLanguage,
    this.bookPageCount,
    this.bookIsbn10,
    this.bookIsbn13,
    this.bookRating,
    this.bookPrice,
   
  });

  factory BookEntity.fromJson(Map<String, dynamic> json) => 
  BookEntity(
        bookId: json['_id'],
        bookTitle: json['bookTitle'],
        bookAuthor: json['bookAuthor'],
        bookDescription: json['bookDescription'],
        bookImageUrl: json['bookImageUrl'],
        bookCategory: json['bookCategory'],
        bookPublisher: json['bookPublisher'],
        bookPublishedDate: json['bookPublishedDate'],
        bookLanguage: json['bookLanguage'],
        bookPageCount: json['bookPageCount'],
        bookIsbn10: json['bookIsbn10'],
        bookIsbn13: json['bookIsbn13'],
        bookRating: json['bookRating'],
        bookPrice: json['bookPrice'],
      );

  Map<String, dynamic> toJson() => {
        '_id': bookId,
        'bookTitle': bookTitle,
        'bookAuthor': bookAuthor,
        'bookDescription': bookDescription,
        'bookImageUrl': bookImageUrl,
        'bookCategory': bookCategory,
        'bookPublisher': bookPublisher,
        'bookPublishedDate': bookPublishedDate,
        'bookLanguage': bookLanguage,
        'bookPageCount': bookPageCount,
        'bookIsbn10': bookIsbn10,
        'bookIsbn13': bookIsbn13,
        'bookRating': bookRating,
        'bookPrice': bookPrice,
      };

  @override
  String toString() {
    return 'BookEntity { bookId: $bookId, bookTitle: $bookTitle, bookAuthor: $bookAuthor, bookDescription: $bookDescription, bookImageUrl: $bookImageUrl, bookCategory: $bookCategory, bookPublisher: $bookPublisher, bookPublishedDate: $bookPublishedDate, bookLanguage: $bookLanguage, bookPageCount: $bookPageCount, bookIsbn10: $bookIsbn10, bookIsbn13: $bookIsbn13, bookRating: $bookRating, bookPrice: $bookPrice }';
  }
}
