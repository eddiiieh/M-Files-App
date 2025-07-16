class ObjectClass {
  final int id;
  final String name;
  final String displayName;
  final int objectTypeId;

  ObjectClass({
    required this.id,
    required this.name,
    required this.displayName,
    required this.objectTypeId,
  });

  factory ObjectClass.fromJson(Map<String, dynamic> json) {
    return ObjectClass(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      name: json['Name'] ?? 'Unnamed Class',
      displayName: json['DisplayName'] ?? 'Unknown',
      objectTypeId: (json['ObjectTypeID'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'ID': id,
        'Name': name,
        'DisplayName': displayName,
        'ObjectTypeID': objectTypeId,
      };
}
