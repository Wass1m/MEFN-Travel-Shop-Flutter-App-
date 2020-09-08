class Product {
  final String title;
  final int price;
  final images;
  final String _id;
  final String description;
  Product(this.title, this.price, this.images, this._id, this.description);

  Map toJson() => {
        'title': title,
        'price': price,
        'images': images,
        'description': description,
        '_id': _id
      };

  Product.fromJson(Map json)
      : title = json['title'],
        price = json['price'],
        images = json['images'],
        _id = json['_id'],
        description = json['description'];
}
