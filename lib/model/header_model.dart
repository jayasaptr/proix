class HeaderModel {
  final int? id;
  final String? code;
  final String? name;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  HeaderModel({
    this.id,
    this.code,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory HeaderModel.fromJson(Map<String, dynamic> json) {
    return HeaderModel(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }
}
