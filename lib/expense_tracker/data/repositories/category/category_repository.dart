import '../../../domain/models/category/category.dart';
import '../../../utils/result.dart';

abstract class CategoryRepository {
  Future<Result<List<CategoryExp>>> fetchCategories();

  Future<Result<CategoryExp>> createCategory(String task);

  Future<Result<void>> deleteCategory(int id);

  Future<Result<CategoryExp>> editCategory(CategoryExp todo);
}
