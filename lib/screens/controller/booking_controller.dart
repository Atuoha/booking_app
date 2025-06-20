import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingController {
  static Future<List<Map<String, dynamic>>> loadBookings() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('bookings') ?? [];
    return data.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
  }

  static Future<DateTime?> pickDateTime(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (date == null) return null;

    final time = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 10, minute: 0),
    );
    if (time == null) return null;

    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  static Future<void> submitBooking({
    required BuildContext context,
    required String service,
    required DateTime? selectedDateTime,
    required Function(Map<String, dynamic>) onBookingSaved,
    required VoidCallback onResetDateTime,
  }) async {
    if (selectedDateTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please pick a date and time.')),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final booking = {
      'service': service,
      'timestamp': selectedDateTime.toIso8601String(),
    };

    final existing = prefs.getStringList('bookings') ?? [];
    existing.add(jsonEncode(booking));
    await prefs.setStringList('bookings', existing);

    onBookingSaved(booking);
    onResetDateTime();


    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Booking confirmed!')),
    );
  }

  static Future<void> deleteBooking(Map<String, dynamic> booking) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getStringList('bookings') ?? [];
    existing.remove(jsonEncode(booking));
    await prefs.setStringList('bookings', existing);
  }
}