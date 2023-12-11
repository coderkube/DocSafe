class FolderInfo {
  String name;
  DateTime creationDate;

  FolderInfo(this.name, this.creationDate);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'creationDate': creationDate.toIso8601String(),
    };
  }

  factory FolderInfo.fromJson(Map<String, dynamic> json) {
    return FolderInfo(
      json['name'],
      DateTime.parse(json['creationDate']),
    );
  }
}