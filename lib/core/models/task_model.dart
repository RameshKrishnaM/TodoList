class TaskModel {
  final String id;
  final String title;
  final String ownerId;
  final List<String> sharedWith;
  final DateTime createdAt;

  TaskModel({
    required this.id,
    required this.title,
    required this.ownerId,
    required this.sharedWith,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'ownerId': ownerId,
      'sharedWith': sharedWith,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map, String id) {
    return TaskModel(
      id: id,
      title: map['title'] ?? '',
      ownerId: map['ownerId'] ?? '',
      sharedWith: List<String>.from(map['sharedWith'] ?? []),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  TaskModel copyWith({
    String? id,
    String? title,
    String? ownerId,
    List<String>? sharedWith,
    DateTime? createdAt,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      ownerId: ownerId ?? this.ownerId,
      sharedWith: sharedWith ?? this.sharedWith,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
