import 'package:flutter/foundation.dart';

import '../../../business/model/todo.dart';
import '../../../data/repositories/todo_repository.dart';
import '../../../utils/command.dart';
import '../../../utils/result.dart';

class TodoListViewModel extends ChangeNotifier {
  TodoListViewModel({
    required TodoRepository todoRepository,
  }) : _todoRepository = todoRepository {
    load = Command0<void>(_load)..execute();
    add = Command1<void, String>(_add);
    delete = Command1<void, int>(_delete);
    edit = Command1<void, Todo>(_edit);
  }

  final TodoRepository _todoRepository;

  /// Load Todo items from repository.
  late Command0<void> load;

  /// Add a new Todo item.
  late Command1<void, String> add;

  /// Delete a Todo item by its id.
  late Command1<void, int> delete;

  /// Edit a Todo item by todo item.
  late Command1<void, Todo> edit;

// #docregion TodoListViewModel
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  Todo? _editableTodo;

  Todo? get editableTodo => _editableTodo;

  void toggleIsEdit(Todo? todo) {
    _editableTodo = todo;
    notifyListeners();
  }

  Future<Result<void>> _load() async {
    try {
      final result = await _todoRepository.fetchTodos();
      switch (result) {
        case Ok<List<Todo>>():
          _todos = result.value;
          return const Result.ok(null);
        case Error():
          return Result.error(result.error);
      }
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      notifyListeners();
    }
  }

// #enddocregion TodoListViewModel

// #docregion Add
  Future<Result<void>> _add(String task) async {
    try {
      final result = await _todoRepository.createTodo(task);
      switch (result) {
        case Ok<Todo>():
          _todos.add(result.value);
          return const Result.ok(null);
        case Error():
          return Result.error(result.error);
      }
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      notifyListeners();
    }
  }

// #enddocregion Add

  // #docregion Delete
  Future<Result<void>> _delete(int id) async {
    try {
      final result = await _todoRepository.deleteTodo(id);
      switch (result) {
        case Ok<void>():
          _todos.removeWhere((todo) => todo.id == id);
          return const Result.ok(null);
        case Error():
          return Result.error(result.error);
      }
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      notifyListeners();
    }
  }

  // #enddocregion Delete

  Future<Result<void>> _edit(Todo todo) async {
    try {
      final result = await _todoRepository.editTodo(todo);
      switch (result) {
        case Ok<Todo>():
          final idx = _todos.indexWhere(
            (todo) => todo.id == result.value.id,
          );
          if (idx != -1) {
            _todos[idx] = result.value;
          }
          return const Result.ok(null);
        case Error():
          return Result.error(result.error);
      }
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      notifyListeners();
    }
  }
}
