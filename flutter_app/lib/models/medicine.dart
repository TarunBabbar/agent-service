class Medicine {
  final String id;
  final String name;
  final String category;
  final double price;
  final String imageUrl;
  final bool prescriptionRequired;

  Medicine({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
    required this.prescriptionRequired,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['_id'].toString(),
      name: json['name'] ?? 'Unknown',
      category: json['category'] ?? 'General',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      imageUrl: json['image'] ?? '',
      prescriptionRequired: json['prescriptionRequired'] ?? false,
    );
  }
}
