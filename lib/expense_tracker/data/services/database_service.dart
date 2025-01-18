import 'package:logging/logging.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/models/category/category.dart';
import '../../utils/result.dart';

class DatabaseService {
  DatabaseService({
    required this.databaseFactory,
  });

  final DatabaseFactory databaseFactory;

  static const _kTableCategory = 'category';
  static const _kColumnId = '_id';
  static const _kColumnTitle = 'title';

  Database? _database;

  bool isOpen() => _database != null;

  Future<void> open() async {
    Logger('name').info(
      join(await databaseFactory.getDatabasesPath(), 'app_database.db'),
    );
    _database = await databaseFactory.openDatabase(
      join(await databaseFactory.getDatabasesPath(), 'app_database.db'),
      options: OpenDatabaseOptions(
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE $_kTableCategory($_kColumnId INTEGER PRIMARY KEY AUTOINCREMENT, $_kColumnTitle TEXT)',
          );
        },
        version: 1,
      ),
    );
  }

  Future<Result<CategoryExp>> insert(String title) async {
    try {
      final id = await _database!.insert(_kTableCategory, {
        _kColumnTitle: title,
      });
      return Result.ok(CategoryExp(id: id, title: title));
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<List<CategoryExp>>> getAll() async {
    print('8888888888');
    try {
      final entries = await _database!.query(
        _kTableCategory,
        columns: [_kColumnId, _kColumnTitle],
      );
      print('entries');
      final list = entries
          .map(
            (element) => CategoryExp(
              id: element[_kColumnId] as int,
              title: element[_kColumnTitle] as String,
            ),
          )
          .toList();
      return Result.ok(list);
    } on Exception catch (e) {
      Logger(runtimeType.toString()).shout('1');
      return Result.error(e);
    }
  }

  Future<Result<void>> delete(int id) async {
    try {
      final rowsDeleted = await _database!
          .delete(_kTableCategory, where: '$_kColumnId = ?', whereArgs: [id]);
      if (rowsDeleted == 0) {
        return Result.error(Exception('No category found with id $id'));
      }
      return const Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<CategoryExp>> edit(CategoryExp category) async {
    try {
      final rowsEdited = await _database!.update(
        _kTableCategory,
        category.toJson(),
        where: '$_kColumnId = ?',
        whereArgs: [category.id],
      );
      if (rowsEdited == 0) {
        return Result.error(
          Exception('No category found with id ${category.id}'),
        );
      }
      return Result.ok(category);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future close() async {
    await _database?.close();
    _database = null;
  }
}
