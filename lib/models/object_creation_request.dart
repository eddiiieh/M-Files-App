import 'package:json_annotation/json_annotation.dart';

part 'object_creation_request.g.dart';

@JsonSerializable()
class ObjectCreationRequest {
  final int objectTypeId;
  final int classId;
  final List<PropertyValueRequest> propertyValues;
  final String? uploadId; // For document objects

  ObjectCreationRequest({
    required this.objectTypeId,
    required this.classId,
    required this.propertyValues,
    this.uploadId,
  });

  factory ObjectCreationRequest.fromJson(Map<String, dynamic> json) =>
      _$ObjectCreationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ObjectCreationRequestToJson(this);
}

@JsonSerializable()
class PropertyValueRequest {
  final int propertyId;
  final dynamic value;

  PropertyValueRequest({
    required this.propertyId,
    required this.value,
  });

  factory PropertyValueRequest.fromJson(Map<String, dynamic> json) =>
      _$PropertyValueRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyValueRequestToJson(this);
}