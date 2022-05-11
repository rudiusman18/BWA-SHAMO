class GalleryModel {
  int? id;
  String? url;

  GalleryModel({this.id, this.url});

  GalleryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['img_url'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'img_url': url,
    };
  }
}
