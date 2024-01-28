class ProductModel {
  final String id;
  final String name;

  final String description;
  final String price;
  final String imageUrl;

  ProductModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.imageUrl});
}
