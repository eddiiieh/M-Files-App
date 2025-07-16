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

  factory ClassProperty.fromJson(Map<String, dynamic> json) {
    return ClassProperty(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      name: json['Name'] ?? 'Unnamed Property',
      displayName: json['DisplayName'] ?? 'Unknown',
      dataType: (json['DataType'] as num?)?.toInt() ?? 0,
      isRequired: json['IsRequired'] ?? false,
      isAutomatic: json['IsAutomatic'] ?? false,
      isHidden: json['IsHidden'] ?? false,
      defaultValue: json['DefaultValue'],
      valuelist: (json['ValueList'] as List?)
          ?.map((item) => PropertyValue.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'ID': id,
        'Name': name,
        'DisplayName': displayName,
        'DataType': dataType,
        'IsRequired': isRequired,
        'IsAutomatic': isAutomatic,
        'IsHidden': isHidden,
        'DefaultValue': defaultValue,
        'ValueList': valuelist?.map((v) => v.toJson()).toList(),
      };
}

class PropertyValue {
  final String displayValue;
  final dynamic value;

  PropertyValue({
    required this.displayValue,
    required this.value,
  });

  factory PropertyValue.fromJson(Map<String, dynamic> json) {
    return PropertyValue(
      displayValue: json['DisplayValue'] ?? '',
      value: json['Value'],
    );
  }

  Map<String, dynamic> toJson() => {
        'DisplayValue': displayValue,
        'Value': value,
      };
}
