import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/car_model.dart';
import '../models/rental_model.dart';
import '../services/storage_service.dart';
import '../data/car_data.dart';
import 'rental_history_page.dart';

class CarRentalFormPage extends StatefulWidget {
  final CarModel? selectedCar;

  const CarRentalFormPage({super.key, this.selectedCar});

  @override
  State<CarRentalFormPage> createState() => _CarRentalFormPageState();
}

class _CarRentalFormPageState extends State<CarRentalFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _renterNameController = TextEditingController();
  final _rentalDaysController = TextEditingController();
  DateTime? _startDate;
  CarModel? _selectedCar;
  List<CarModel> _cars = [];

  @override
  void initState() {
    super.initState();
    _cars = CarData.getCars();
    if (widget.selectedCar != null) {
      _selectedCar = _cars.firstWhere(
        (car) => car.id == widget.selectedCar!.id,
        orElse: () => widget.selectedCar!,
      );
    }
  }

  @override
  void dispose() {
    _renterNameController.dispose();
    _rentalDaysController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.yellow,
              onPrimary: Colors.black,
              surface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  Future<void> _submitRental() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedCar == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a car'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (_startDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a start date'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final rentalDays = int.parse(_rentalDaysController.text);
      final totalCost = _selectedCar!.pricePerDay * rentalDays;

      final rental = RentalModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        car: _selectedCar!,
        renterName: _renterNameController.text,
        rentalDays: rentalDays,
        startDate: _startDate!,
        totalCost: totalCost,
        status: 'active',
      );

      await StorageService.saveRental(rental);

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const RentalHistoryPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade50,
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        elevation: 0,
        title: const Text(
          'New Rental',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Select Car',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonFormField<CarModel>(
                    initialValue: _selectedCar,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.directions_car,
                        color: Colors.black87,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.yellow,
                          width: 2,
                        ),
                      ),
                    ),
                    hint: const Text('Choose a car'),
                    items: _cars.map((car) {
                      return DropdownMenuItem(
                        value: car,
                        child: Text('${car.name} - ${car.type}'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCar = value;
                      });
                    },
                  ),
                ),
                if (_selectedCar != null) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            _selectedCar!.imageUrl,
                            height: 160,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 160,
                                color: Colors.grey.shade300,
                                child: const Icon(
                                  Icons.directions_car,
                                  size: 64,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _selectedCar!.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Rp ${_selectedCar!.pricePerDay.toStringAsFixed(0)} / day',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                const Text(
                  'Rental Details',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _renterNameController,
                  decoration: InputDecoration(
                    labelText: 'Renter Name',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.yellow,
                        width: 2,
                      ),
                    ),
                    prefixIcon: const Icon(Icons.person, color: Colors.black87),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter renter name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _rentalDaysController,
                  decoration: InputDecoration(
                    labelText: 'Rental Days',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.yellow,
                        width: 2,
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.calendar_today,
                      color: Colors.black87,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter rental days';
                    }
                    final days = int.tryParse(value);
                    if (days == null || days <= 0) {
                      return 'Please enter a valid number of days';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: _selectDate,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.event, color: Colors.black87),
                        const SizedBox(width: 12),
                        Text(
                          _startDate == null
                              ? 'Select Start Date'
                              : DateFormat('dd MMMM yyyy').format(_startDate!),
                          style: TextStyle(
                            fontSize: 16,
                            color: _startDate == null
                                ? Colors.black54
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (_selectedCar != null &&
                    _rentalDaysController.text.isNotEmpty &&
                    int.tryParse(_rentalDaysController.text) != null) ...[
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Cost',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Rp ${(_selectedCar!.pricePerDay * int.parse(_rentalDaysController.text)).toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _submitRental,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Submit Rental',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
