import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../models/rental_model.dart';

class StorageService {
  static const String _userKey = 'user_data';
  static const String _rentalsKey = 'rentals_data';
  static const String _currentUserKey = 'current_user';

  static Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final users = await getAllUsers();
    users.add(user);
    final usersJson = users.map((u) => u.toJson()).toList();
    await prefs.setString(_userKey, json.encode(usersJson));
  }

  static Future<List<UserModel>> getAllUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersString = prefs.getString(_userKey);
    if (usersString == null) return [];
    final List<dynamic> usersJson = json.decode(usersString);
    return usersJson.map((u) => UserModel.fromJson(u)).toList();
  }

  static Future<UserModel?> login(String username, String password) async {
    final users = await getAllUsers();
    try {
      final user = users.firstWhere(
        (u) =>
            (u.username == username || u.nik == username) &&
            u.password == password,
      );
      await setCurrentUser(user);
      return user;
    } catch (e) {
      return null;
    }
  }

  static Future<void> setCurrentUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentUserKey, json.encode(user.toJson()));
  }

  static Future<UserModel?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString(_currentUserKey);
    if (userString == null) return null;
    return UserModel.fromJson(json.decode(userString));
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentUserKey);
  }

  static Future<void> saveRental(RentalModel rental) async {
    final prefs = await SharedPreferences.getInstance();
    final rentals = await getAllRentals();
    rentals.add(rental);
    final rentalsJson = rentals.map((r) => r.toJson()).toList();
    await prefs.setString(_rentalsKey, json.encode(rentalsJson));
  }

  static Future<List<RentalModel>> getAllRentals() async {
    final prefs = await SharedPreferences.getInstance();
    final rentalsString = prefs.getString(_rentalsKey);
    if (rentalsString == null) return [];
    final List<dynamic> rentalsJson = json.decode(rentalsString);
    return rentalsJson.map((r) => RentalModel.fromJson(r)).toList();
  }

  static Future<void> updateRental(RentalModel rental) async {
    final prefs = await SharedPreferences.getInstance();
    final rentals = await getAllRentals();
    final index = rentals.indexWhere((r) => r.id == rental.id);
    if (index != -1) {
      rentals[index] = rental;
      final rentalsJson = rentals.map((r) => r.toJson()).toList();
      await prefs.setString(_rentalsKey, json.encode(rentalsJson));
    }
  }
}
