class MerchItem {
  final String itemName;
  final double cost;
  final double? discount;
  final String category;
  final List<String> imageUrls;
  final String description;
  final String primaryDisplayImage;
  final bool productAvailability;

  MerchItem({
    required this.itemName,
    required this.cost,
    this.discount,
    required this.category,
    required this.imageUrls,
    required this.description,
    required this.primaryDisplayImage,
    required this.productAvailability,
  });

  factory MerchItem.fromJson(Map<String, dynamic> json) {
    return MerchItem(
      itemName: json["itemName"],
      cost: json["itemName"],
      category: json["itemName"],
      imageUrls: List<String>.from(json["imageUrls"].map((x) => x)),
      description: json["description"],
      primaryDisplayImage: json["primaryDisplayImage"],
      productAvailability: json["productAvailability"],
      discount: json["discount"] ?? 0.0,
    );
  }
}
