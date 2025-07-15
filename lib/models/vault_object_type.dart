import 'package:json_annotation/json_annotation.dart';

part 'vault_object_type.g.dart';

@JsonSerializable()
class VaultObjectType {
  final int id;
  final String name;
  final String displayName;
  final bool isDocument;

  VaultObjectType({
    required this.id,
    required this.name,
    required this.displayName,
    required this.isDocument,
  });

  factory VaultObjectType.fromJson(Map<String, dynamic> json) =>
      _$VaultObjectTypeFromJson(json);

  Map<String, dynamic> toJson() => _$VaultObjectTypeToJson(this);
}