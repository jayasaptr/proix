class DetailModel {
  int? id;
  String? code;
  DateTime? date;
  String? time;
  String? before;
  String? action;
  String? after;
  String? recommendAction;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  int? headerId;

  DetailModel({
    this.id,
    this.code,
    this.date,
    this.time,
    this.before,
    this.action,
    this.after,
    this.recommendAction,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.headerId,
  });

  factory DetailModel.fromJson(Map<String, dynamic> json) {
    return DetailModel(
      id: json['id'],
      code: json['code'],
      date: DateTime.parse(json['date']),
      time: json['time'],
      before: json['before'],
      action: json['action'],
      after: json['after'],
      recommendAction: json['recommend_action'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
      headerId: json['header_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'date': date?.toIso8601String(),
      'time': time,
      'before': before,
      'action': action,
      'after': after,
      'recommend_action': recommendAction,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'header_id': headerId,
    };
  }
}
