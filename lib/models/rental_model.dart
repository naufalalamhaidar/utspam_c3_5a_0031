import 'car_model.dart';

class RentalModel {
  final String id;
  final CarModel car;
  final String renterName;
  final int rentalDays;
  final DateTime startDate;
  final double totalCost;
  String status;

  RentalModel({
    required this.id,
    required this.car,
    required this.renterName,
    required this.rentalDays,
    required this.startDate,
    required this.totalCost,
    this.status = 'active',
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'car': car.toJson(),
      'renterName': renterName,
      'rentalDays': rentalDays,
      'startDate': startDate.toIso8601String(),
      'totalCost': totalCost,
      'status': status,
    };
  }

  factory RentalModel.fromJson(Map<String, dynamic> json) {
    return RentalModel(
      id: json['id'],
      car: CarModel.fromJson(json['car']),
      renterName: json['renterName'],
      rentalDays: json['rentalDays'],
      startDate: DateTime.parse(json['startDate']),
      totalCost: json['totalCost'],
      status: json['status'] ?? 'active',
    );
  }
}
