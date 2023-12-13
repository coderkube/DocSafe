class ImageDetails {
  String image;
  DateTime creationDate;

  ImageDetails(this.image, this.creationDate);

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'creationDate': creationDate.toIso8601String(),
    };
  }

  factory ImageDetails.fromJson(Map<String, dynamic> json) {
    return ImageDetails(
      json['image'],
      DateTime.parse(json['creationDate']),
    );
  }
}
