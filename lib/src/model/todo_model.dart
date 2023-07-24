import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'todo_model.g.dart';

/// The type defenition for a JSON-serializable [Map]
typedef JsonMap = Map<String, dynamic>;

/// {@template todo_model}
/// A single `todo` item.
///
/// Contains a [title], [description] and [id], in addition [isCompleted] flag.
///
/// if [id] is provided it can not be empty, if not provided it will be
/// generated.
///
/// [Todo]s are immutable and can be  copied using [copyWith], in addition to
/// being serialized and deserialized using [toJson] and [fromJson] methods.
/// {@endtemplate}
/// {@macro todo_model}
@immutable
@JsonSerializable()
class Todo extends Equatable {
  /// {@macro todo_model}
  Todo({
    required this.title,
    this.description = '',
    String? id,
    this.isCompleted = false,
  })  : assert(
          id == null || id.isNotEmpty,
          'id must be either null or not empty',
        ),
        id = id ?? const Uuid().v4();

  /// {@macro todo_model}
  Todo copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return Todo(
      title: title ?? this.title,
      id: id ?? this.id,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  /// Deserializes the given [JsonMap] into a [Todo].
  static Todo fromJson(JsonMap json) => _$TodoFromJson(json);

  /// Serialize [Todo] into a [JsonMap]
  JsonMap toJson() => _$TodoToJson(this);

  /// Uniqe identifier  of the `todo`.
  ///
  /// Can not be empty
  final String id;

  /// Title of the `todo`.
  ///
  /// Can be empty
  final String title;

  /// Description of the `todo`.
  ///
  /// Empty by default.
  final String description;

  /// Whether `todo` is complete
  ///
  /// Default is `false`.
  final bool isCompleted;

  @override
  List<Object?> get props => [id, title, description, isCompleted];
}
