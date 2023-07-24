import 'package:todos_api/todos_api.dart';

/// {@template todos_api}
/// The interface for an API providing access to list of todos.
/// {@endtemplate}
abstract class TodosApi {
  /// {@macro todos_api}
  const TodosApi();

  /// Provides a [Stream] of all todos
  Stream<List<Todo>> getTodos();

  /// Save a [todo].
  ///
  /// If a [todo] with the same id already exist, it will be replaced
  Future<void> saveTodo(Todo todo);

  /// Delete `todo` with the given [id]
  ///
  /// If no `todo` with the given [id] exist, a [TodoNotFoundException] error
  /// is thown
  Future<void> deleteTodo(String id);

  /// Delete all completed todos.
  ///
  /// Returns the number of completed todos
  Future<int> clearCompleted();

  /// Sets the 'isComplete' state of all todos to the given value
  ///
  /// Returns the number of updated todos
  Future<int> completeAll({required bool isCompleted});
}

/// Error thrown when a [Todo] with a given id is not found.
class TodoNotFoundException implements Exception {}
