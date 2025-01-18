import 'dart:async';

import 'package:app_architecture_new/expense_tracker/domain/models/category/category.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import '../../../data/repositories/category/category_repository.dart';
import '../../../utils/command.dart';
import '../../../utils/result.dart';

class CategoryViewModel extends ChangeNotifier {
  CategoryViewModel({
    required CategoryRepository categoryRepository,
  }) : _categoryRepository = categoryRepository {
    load = Command0(_load)..execute();
  }

  final CategoryRepository _categoryRepository;
  final _log = Logger('CategoryViewModel');
  List<CategoryExp> _categories = [];

  late Command0 load;

  List<CategoryExp> get categories => _categories;

  Future<Result> _load() async {
    Logger(runtimeType.toString()).info('3');
    try {
      final result = await _categoryRepository.fetchCategories();
      switch (result) {
        case Ok<List<CategoryExp>>():
          _categories = result.value;
          _log.fine('Loaded categories');
        case Error<List<CategoryExp>>():
          _log.warning('Failed to load categories', result.error);
          return result;
      }
      return result;
    } finally {
      notifyListeners();
    }
  }
}
