class DocModel {
  String? name;
  String? type;
  List<Files>? files;
  String? createdAt;
  String? updatedAt;
  String? path;
  late bool isPinned;

  DocModel({this.name, this.type, this.files, this.createdAt, this.updatedAt, this.path, this.isPinned = false});

  DocModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(Files.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    path = json['path'];
    isPinned = json['isPinned'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['type'] = type;
    if (files != null) {
      data['files'] = files!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['path'] = path;
    data['isPinned'] = isPinned;
    return data;
  }
}

class Files {
  String? mimeType;
  String? path;
  String? name;

  Files({this.mimeType, this.path, this.name});

  Files.fromJson(Map<String, dynamic> json) {
    mimeType = json['mimeType'];
    name = json['name'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mimeType'] = mimeType;
    data['name'] = name;
    data['path'] = path;
    return data;
  }
}
