// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoImpl _$$TodoImplFromJson(Map<String, dynamic> json) => _$TodoImpl(
      id: (json['id'] as num).toInt(),
      task: json['task'] as String,
    );

Map<String, dynamic> _$$TodoImplToJson(_$TodoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'task': instance.task,
    };
