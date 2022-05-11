class TransactionModel {
  int? id;
  int? userId;
  String? address;
  String? totalPrice;
  String? shippingPrice;
  String? payment;
  String? status;

  List<Transactionitem>? transactionitem;

  TransactionModel(
      {this.id,
      this.userId,
      this.address,
      this.totalPrice,
      this.shippingPrice,
      this.payment,
      this.status,
      this.transactionitem});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    address = json['address'];
    totalPrice = json['total_price'];
    shippingPrice = json['shipping_price'];
    payment = json['payment'];
    status = json['status'];
    if (json['transactionitem'] != null) {
      transactionitem = <Transactionitem>[];
      json['transactionitem'].forEach((v) {
        transactionitem!.add(new Transactionitem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['address'] = this.address;
    data['total_price'] = this.totalPrice;
    data['shipping_price'] = this.shippingPrice;
    data['payment'] = this.payment;
    data['status'] = this.status;
    if (this.transactionitem != null) {
      data['transactionitem'] =
          this.transactionitem!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transactionitem {
  int? id;
  int? userId;
  int? productId;
  int? transactionId;
  int? quantity;
  String? createdAt;
  String? updatedAt;
  Product? product;
  Productgallery? productgallery;

  Transactionitem(
      {this.id,
      this.userId,
      this.productId,
      this.transactionId,
      this.quantity,
      this.createdAt,
      this.updatedAt,
      this.product,
      this.productgallery});

  Transactionitem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    transactionId = json['transaction_id'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    productgallery = json['productgallery'] != null
        ? new Productgallery.fromJson(json['productgallery'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['transaction_id'] = this.transactionId;
    data['quantity'] = this.quantity;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.productgallery != null) {
      data['productgallery'] = this.productgallery!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  int? productCategoryId;
  String? name;
  String? price;
  String? description;
  String? tags;
  String? createdAt;
  String? updatedAt;

  Product(
      {this.id,
      this.productCategoryId,
      this.name,
      this.price,
      this.description,
      this.tags,
      this.createdAt,
      this.updatedAt});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productCategoryId = json['product_category_id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    tags = json['tags'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_category_id'] = this.productCategoryId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    data['tags'] = this.tags;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Productgallery {
  int? id;
  int? productId;
  String? imgUrl;
  String? createdAt;
  String? updatedAt;

  Productgallery(
      {this.id, this.productId, this.imgUrl, this.createdAt, this.updatedAt});

  Productgallery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    imgUrl = json['img_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['img_url'] = this.imgUrl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
