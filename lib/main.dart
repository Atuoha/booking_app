import 'package:booking_app/screens/booking_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BookingApp());
}

class BookingApp extends StatelessWidget {
  const BookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Salon Booking',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            backgroundColor: Colors.deepPurple,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: const BookingScreen(),
    );
  }
}
