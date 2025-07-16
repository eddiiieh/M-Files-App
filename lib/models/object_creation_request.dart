class ObjectCreationRequest {
  final int objectTypeId;
  final int classId;
  final List<PropertyValueRequest> propertyValues;
  final String? uploadId;

  ObjectCreationRequest({
    required this.objectTypeId,
    required this.classId,
    required this.propertyValues,
    this.uploadId,
  });

  factory ObjectCreationRequest.fromJson(Map<String, dynamic> json) {
    return ObjectCreationRequest(
      objectTypeId: (json['ObjectTypeId'] as num?)?.toInt() ?? 0,
      classId: (json['ClassId'] as num?)?.toInt() ?? 0,
      propertyValues: (json['PropertyValues'] as List?)
              ?.map((item) => PropertyValueRequest.fromJson(item))
              .toList() ??
          [],
      uploadId: json['UploadId'],
    );
  }

  Map<String, dynamic> toJson() => {
        'ObjectTypeId': objectTypeId,
        'ClassId': classId,
        'PropertyValues':
            propertyValues.map((value) => value.toJson()).toList(),
        'UploadId': uploadId,
      };
}

class PropertyValueRequest {
  final int propertyId;
  final dynamic value;

  PropertyValueRequest({
    required this.propertyId,
    required this.value,
  });

  factory PropertyValueRequest.fromJson(Map<String, dynamic> json) {
    return PropertyValueRequest(
      propertyId: (json['PropertyId'] as num?)?.toInt() ?? 0,
      value: json['Value'],
    );
  }

  Map<String, dynamic> toJson() => {
        'PropertyId': propertyId,
        'Value': value,
      };
}
