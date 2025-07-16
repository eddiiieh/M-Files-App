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
      id: (json['objectid'] as num?)?.toInt() ?? 0,
      name: json['namesingular'] ?? 'Unnamed',
      displayName: json['nameplural'] ?? 'Unknown',
      isDocument: json['objectid'] == 0, // treat object ID 0 as 'document'
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'objectid': id,
      'namesingular': name,
      'nameplural': displayName,
      'isDocument': isDocument,
    };
  }
}
