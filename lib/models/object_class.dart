class ObjectClass {
  final int id;
  final String name;
  final int objectTypeId;

  ObjectClass({
    required this.id,
    required this.name,
    required this.objectTypeId,
  });

  factory ObjectClass.fromJson(Map<String, dynamic> json, int objectTypeId) {
    return ObjectClass(
      id: (json['classId'] as num?)?.toInt() ?? 0,
      name: json['className'] ?? 'Unnamed Class',
      objectTypeId: objectTypeId,
    );
  }

  String get displayName => name;

  Map<String, dynamic> toJson() => {
        'classId': id,
        'className': name,
        'objectTypeId': objectTypeId,
      };
}
