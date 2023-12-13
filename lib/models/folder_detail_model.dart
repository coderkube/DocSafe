class DocModel {
  String? name;
  String? type;
  List<Files>? files;
  String? createdAt;
  String? updatedAt;

  DocModel({this.name, this.type, this.files, this.createdAt, this.updatedAt});

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
    return data;
  }
}

class Files {
  String? mimeType;
  String? base64;
  String? name;

  Files({this.mimeType, this.base64});

  Files.fromJson(Map<String, dynamic> json) {
    mimeType = json['mimeType'];
    name = json['name'];
    base64 = json['base64'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mimeType'] = mimeType;
    data['name'] = name;
    data['base64'] = base64;
    return data;
  }
}
