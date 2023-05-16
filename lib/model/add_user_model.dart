class AddUserModel {
  String id;
  DateTime createdAt;

  AddUserModel({
    required this.id,
    required this.createdAt,
  });

  factory AddUserModel.fromJson(Map<String, dynamic> json) => AddUserModel(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
      };
}
