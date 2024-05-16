import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:story_stack/config/constants/hive_table_constant.dart';

final hiveServiceProvider = Provider<HiveService>(
  (ref) => HiveService(),
);
class HiveService{
  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    // Hive.init(directory.path);
    // Hive.registerAdapter(BookHiveModelAdapter());
  }
 
  // Future<List<BookHiveModel>> getAllBook() async {
  //   var box = await Hive.openBox<BookHiveModel>(
  //       HiveTableConstant.bookBox);
  //   var book = box.values.toList();
  //   return Book;
  // }

  // Future<void> saveToLocal(BookHiveModel Book) async {
  //   var box = await Hive.openBox<BookHiveModel>(
  //       HiveTableConstant.BookBox);
  //   await box.put(Book.BookId, Book);
  //   print('Saved Book to local database: $Book');
  // }
}