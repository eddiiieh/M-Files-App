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

  factory VaultObjectType.fromJson(Map<String, dynamic> json) {
  return VaultObjectType(
    id: (json['id'] as num?)?.toInt() ?? 0,
    name: json['name'] ?? 'Unnamed',
    displayName: json['displayName'] ?? 'Unknown',
    isDocument: json['isDocument'] ?? false,
  );
}


  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Name': name,
      'DisplayName': displayName,
      'IsDocument': isDocument,
    };
  }
}
