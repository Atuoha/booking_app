import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingList extends StatelessWidget {
  const BookingList({super.key, required this.bookings, required this.onDelete,});

  final List<Map<String, dynamic>> bookings;
  final Function(Map<String, dynamic>) onDelete;

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('EEE, MMM d, y');
    final timeFormatter = DateFormat('hh:mm a');

    return Column(
      children: [
        bookings.isEmpty
            ? const Center(child: Text('No bookings yet.'))
            : Column(
                children: bookings.reversed.map((booking) {
                  final date = DateTime.parse(booking['timestamp']);
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: const Icon(
                        Icons.event_note,
                        color: Colors.deepPurple,
                      ),
                      title: Text(booking['service']),
                      subtitle: Text(
                        '${dateFormatter.format(date)} at ${timeFormatter.format(date)}',
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red, size: 20,),
                        onPressed: () => onDelete(booking),
                      ),
                    ),
                  );
                }).toList(),
              ),
      ],
    );
  }
}
