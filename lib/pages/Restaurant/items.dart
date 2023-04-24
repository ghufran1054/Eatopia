class Item {
  final String name;
  final String ImageURL;
  final double price;
  final String desc;
  final String category;
  final Map<String, dynamic> addOns;

  Item(
      {required this.name,
      required this.ImageURL,
      required this.price,
      required this.desc,
      required this.category,
      required this.addOns});
}
