import 'package:booking_app/screens/widgets/booking_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'controller/booking_controller.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String selectedService = 'Haircut';
  DateTime? selectedDateTime;
  List<Map<String, dynamic>> bookings = [];
  final dateFormatter = DateFormat('EEE, MMM d, y');
  final timeFormatter = DateFormat('hh:mm a');

  final List<String> services = [
    'Haircut',
    'Makeup',
    'Braids',
    'Pedicure',
    'Facial',
  ];

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  Future<void> _loadBookings() async {
    final loaded = await BookingController.loadBookings();
    setState(() => bookings = loaded);
  }

  Future<void> _confirmDelete(Map<String, dynamic> booking) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Booking'),
        content: const Text('Are you sure you want to delete this booking?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete')),
        ],
      ),
    );

    if (confirm == true) {
      await BookingController.deleteBooking(booking);
      setState(() => bookings.remove(booking));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Salon Booking')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Select a Service:', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedService,
                  isExpanded: true,
                  onChanged: (value) =>
                      setState(() => selectedService = value!),
                  items: services
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () async {
                final picked = await BookingController.pickDateTime(context);
                if (picked != null) {
                  setState(() => selectedDateTime = picked);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.deepPurple),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        selectedDateTime == null
                            ? 'Pick Date & Time'
                            : '${dateFormatter.format(selectedDateTime!)} at ${timeFormatter.format(selectedDateTime!)}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => BookingController.submitBooking(
                context: context,
                service: selectedService,
                selectedDateTime: selectedDateTime,
                onBookingSaved: (booking) => setState(() => bookings.add(booking)),
                onResetDateTime: () => setState(() => selectedDateTime = null),
              ),
              icon: const Icon(Icons.send, color: Colors.white),
              label: const Text(
                'Submit Booking',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Your Bookings:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            BookingList(bookings: bookings,onDelete: (booking) => _confirmDelete(booking),),
          ],
        ),
      ),
    );
  }
}
