// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CategoryExpImpl _$$CategoryExpImplFromJson(Map<String, dynamic> json) =>
    _$CategoryExpImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      color: (json['color'] as num).toInt(),
    );

Map<String, dynamic> _$$CategoryExpImplToJson(_$CategoryExpImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'color': instance.color,
    };
