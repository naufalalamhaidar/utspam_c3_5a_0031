import '../models/car_model.dart';

class CarData {
  static List<CarModel> getCars() {
    return [
      CarModel(
        id: '1',
        name: 'Toyota Avanza',
        type: 'MPV',
        imageUrl:
            'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?w=500',
        pricePerDay: 350000,
      ),
      CarModel(
        id: '2',
        name: 'Honda CR-V',
        type: 'SUV',
        imageUrl:
            'https://images.unsplash.com/photo-1519641471654-76ce0107ad1b?w=500',
        pricePerDay: 550000,
      ),
      CarModel(
        id: '3',
        name: 'Mitsubishi Xpander',
        type: 'MPV',
        imageUrl:
            'https://images.unsplash.com/photo-1511919884226-fd3cad34687c?w=500',
        pricePerDay: 400000,
      ),
      CarModel(
        id: '4',
        name: 'Suzuki Ertiga',
        type: 'MPV',
        imageUrl:
            'https://images.unsplash.com/photo-1549399542-7e3f8b79c341?w=500',
        pricePerDay: 320000,
      ),
      CarModel(
        id: '5',
        name: 'Toyota Fortuner',
        type: 'SUV',
        imageUrl:
            'https://images.unsplash.com/photo-1606664515524-ed2f786a0bd6?w=500',
        pricePerDay: 700000,
      ),
      CarModel(
        id: '6',
        name: 'Daihatsu Terios',
        type: 'SUV',
        imageUrl:
            'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?w=500',
        pricePerDay: 380000,
      ),
      CarModel(
        id: '7',
        name: 'Honda Jazz',
        type: 'Hatchback',
        imageUrl:
            'https://images.unsplash.com/photo-1583121274602-3e2820c69888?w=500',
        pricePerDay: 380000,
      ),
      CarModel(
        id: '8',
        name: 'Toyota Innova',
        type: 'MPV',
        imageUrl:
            'https://images.unsplash.com/photo-1568605117036-5fe5e7bab0b7?w=500',
        pricePerDay: 450000,
      ),
    ];
  }
}
