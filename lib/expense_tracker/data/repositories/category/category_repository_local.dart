import '../../../domain/models/category/category.dart';
import '../../../utils/result.dart';
import '../../services/database_service.dart';
import 'category_repository.dart';

class CategoryRepositoryLocal extends CategoryRepository {
  CategoryRepositoryLocal({
    required DatabaseService database,
  }) : _database = database;

  final DatabaseService _database;

  @override
  Future<Result<List<CategoryExp>>> fetchCategories() async {
    if (!_database.isOpen()) {
      await _database.open();
    }
    return _database.getAll();
  }

  @override
  Future<Result<CategoryExp>> createCategory(CategoryExp category) async {
    if (!_database.isOpen()) {
      await _database.open();
    }
    return _database.insert(category);
  }

  @override
  Future<Result<void>> deleteCategory(int id) async {
    if (!_database.isOpen()) {
      await _database.open();
    }
    return _database.delete(id);
  }

  @override
  Future<Result<CategoryExp>> editCategory(CategoryExp todo) async {
    if (!_database.isOpen()) {
      await _database.open();
    }
    return _database.edit(todo);
  }
}
