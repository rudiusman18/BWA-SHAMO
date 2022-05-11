import 'package:bwa_shamo/models/category_model.dart';
import 'package:bwa_shamo/models/gallery_model.dart';

class ProductModel {
  int? id;
  String? name;
  double? price;
  String? description;
  String? tags;
  List<GalleryModel>? galleries;
  CategoryModel? category;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProductModel({
    this.id,
    this.name,
    this.price,
    this.description,
    this.tags,
    this.galleries,
    this.category,
    this.createdAt,
    this.updatedAt,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = double.parse(json['price']);
    description = json['description'];
    tags = json['tags'];
    galleries = json['productgallery']
        .map<GalleryModel>((gallery) => GalleryModel.fromJson(gallery))
        .toList();
    category = CategoryModel.fromJson(json['productcategory']);
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price.toString(),
      'description': description,
      'tags': tags,
      'productgallery': galleries!.map((gallery) => gallery.toJson()).toList(),
      'productcategory': category!.toJson(),
    };
  }
}



// NOTE untuk diri sendiri: untuk mengakses data yang ada pada model lain, maka salah satu caranya adalah dengan mengakses model tersebut, seperti yang terlihat pada line 10 dan 11, variabel category akan memiliki semua atribut yang ada pada CategoryModel, sedangkan variabel galleries akan memiliki semua atribut dari GalleryModel dalam bentuk list, penggunaan list ataupun tidak disesuikan dengan API yang ada.
