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
    final rawType = json['propertytype'];
    final parsedDataType = _parseDataType(rawType);

    // Debug print for verification
    print('🔍 Property ID: ${json['propId']}, Type: $rawType → Parsed DataType: $parsedDataType');
  return ClassProperty(
    id: (json['propId'] as num?)?.toInt() ?? 0,
    name: json['title'] ?? 'Unnamed Property',
    displayName: json['title'] ?? 'Unnamed Property', // updated here
    dataType: _parseDataType(json['propertytype']),
    isRequired: json['isRequired'] ?? false,
    isAutomatic: json['isAutomatic'] ?? false,
    isHidden: json['isHidden'] ?? false,
    defaultValue: null,
    valuelist: null,
  );
}

static int _parseDataType(String? type) {
  switch (type) {
    case 'MFDatatypeText':
      return 1;
    case 'MFDatatypeInteger':
      return 2;
    case 'MFDatatypeFloating':
      return 3;
    case 'MFDatatypeBoolean':
      return 8;
    case 'MFDatatypeDate':
      return 5;
    case 'MFDatatypeTime':
      return 6;
    case 'MFDatatypeTimestamp':
      return 7;
    case 'MFDatatypeLookup':
      return 9;
    case 'MFDatatypeMultiSelectLookup':
      return 10;
    case 'MFDatatypeMultiLineText':
      return 13;
    default:
      return 0; // Unknown
  }
}



  Map<String, dynamic> toJson() => {
        'propertyDef': id,
        'propertyName': name,
        'dataType': dataType,
        'isRequired': isRequired,
        'isAutomatic': isAutomatic,
        'isHidden': isHidden,
        'defaultValue': defaultValue,
        'valueList': valuelist?.map((v) => v.toJson()).toList(),
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
