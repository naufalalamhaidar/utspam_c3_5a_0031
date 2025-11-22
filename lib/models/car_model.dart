class CarModel {
  final String id;
  final String name;
  final String type;
  final String imageUrl;
  final double pricePerDay;

  CarModel({
    required this.id,
    required this.name,
    required this.type,
    required this.imageUrl,
    required this.pricePerDay,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'imageUrl': imageUrl,
      'pricePerDay': pricePerDay,
    };
  }

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      imageUrl: json['imageUrl'],
      pricePerDay: json['pricePerDay'],
    );
  }
}
