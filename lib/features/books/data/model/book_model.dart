import 'package:json_annotation/json_annotation.dart';
import 'package:story_stack/features/books/domain/entity/book_entity.dart';

@JsonSerializable()
class BookAPIModel {
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

  BookAPIModel({
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

  factory BookAPIModel.fromJson(Map<String, dynamic> json) {
    return BookAPIModel(
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
  }

  Map<String, dynamic> toJson() {
    return{
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
  }

  // From entity to model
  factory BookAPIModel.fromEntity(BookEntity entity) {
    return BookAPIModel(
      bookId: entity.bookId,
      bookTitle: entity.bookTitle,
      bookAuthor: entity.bookAuthor,
      bookDescription: entity.bookDescription,
      bookImageUrl: entity.bookImageUrl,
      bookCategory: entity.bookCategory,
      bookPublisher: entity.bookPublisher,
      bookPublishedDate: entity.bookPublishedDate,
      bookLanguage: entity.bookLanguage,
      bookPageCount: entity.bookPageCount,
      bookIsbn10: entity.bookIsbn10,
      bookIsbn13: entity.bookIsbn13,
      bookRating: entity.bookRating,
      bookPrice: entity.bookPrice,
    );
  }

  // From model to entity
  static BookEntity toEntity(BookAPIModel model) {
    return BookEntity(
      bookId: model.bookId,
      bookTitle: model.bookTitle,
      bookAuthor: model.bookAuthor,
      bookDescription: model.bookDescription,
      bookImageUrl: model.bookImageUrl,
      bookCategory: model.bookCategory,
      bookPublisher: model.bookPublisher,
      bookPublishedDate: model.bookPublishedDate,
      bookLanguage: model.bookLanguage,
      bookPageCount: model.bookPageCount,
      bookIsbn10: model.bookIsbn10,
      bookIsbn13: model.bookIsbn13,
      bookRating: model.bookRating,
      bookPrice: model.bookPrice,
    );
  }
}
