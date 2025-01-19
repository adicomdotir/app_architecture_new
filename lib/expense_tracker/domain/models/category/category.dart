import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';
part 'category.g.dart';

@freezed
class CategoryExp with _$CategoryExp {
  const factory CategoryExp({
    required int id,
    required String title,
    required int color,
  }) = _CategoryExp;

  factory CategoryExp.fromJson(Map<String, dynamic> json) =>
      _$CategoryExpFromJson(json);
}
