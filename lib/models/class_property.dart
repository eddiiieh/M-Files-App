import 'package:json_annotation/json_annotation.dart';

part 'class_property.g.dart';

@JsonSerializable()
class ClassProperty {
  final int id;
  final String name;
  final String displayName;
  final int dataType;
  final bool isRequired;
  final bool isAutomatic;
  final bool isHidden;
  final String? defaultValue;
  final List<PropertyValue>? valuelist;

  ClassProperty({
    required this.id,
    required this.name,
    required this.displayName,
    required this.dataType,
    required this.isRequired,
    required this.isAutomatic,
    required this.isHidden,
    this.defaultValue,
    this.valuelist,
  });

  factory ClassProperty.fromJson(Map<String, dynamic> json) =>
      _$ClassPropertyFromJson(json);

  Map<String, dynamic> toJson() => _$ClassPropertyToJson(this);
}

@JsonSerializable()
class PropertyValue {
  final String displayValue;
  final dynamic value;

  PropertyValue({
    required this.displayValue,
    required this.value,
  });

  factory PropertyValue.fromJson(Map<String, dynamic> json) =>
      _$PropertyValueFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyValueToJson(this);
}