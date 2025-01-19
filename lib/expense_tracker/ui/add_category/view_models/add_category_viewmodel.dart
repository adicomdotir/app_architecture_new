import 'dart:async';

import 'package:app_architecture_new/expense_tracker/domain/models/category/category.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import '../../../data/repositories/category/category_repository.dart';
import '../../../utils/command.dart';
import '../../../utils/result.dart';

class AddCategoryViewModel extends ChangeNotifier {
  AddCategoryViewModel({
    required CategoryRepository categoryRepository,
  }) : _categoryRepository = categoryRepository {
    addCategory = Command1(_addCategory);
  }

  final CategoryRepository _categoryRepository;
  final _log = Logger('AddCategoryViewModel');

  late Command1<CategoryExp, CategoryExp> addCategory;

  Future<Result<CategoryExp>> _addCategory(CategoryExp category) async {
    try {
      final result = await _categoryRepository.createCategory(category);
      switch (result) {
        case Ok<CategoryExp>():
          _log.fine('Added category');
        case Error<CategoryExp>():
          _log.warning('Failed to add category', result.error);
          return result;
      }
      return result;
    } finally {
      notifyListeners();
    }
  }
}
