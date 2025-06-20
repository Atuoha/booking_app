import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingList extends StatelessWidget {
  const BookingList({
    super.key,
    required this.bookings,
    required this.onDelete,
  });

  final List<Map<String, dynamic>> bookings;
  final Function(Map<String, dynamic>) onDelete;

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('EEE, MMM d, y');
    final timeFormatter = DateFormat('hh:mm a');

    if (bookings.isEmpty) {
      return const Center(
        child: Text('No bookings yet.'),
      );
    }

    final int itemCount = bookings.length;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        // reversed index
        final booking = bookings[itemCount - 1 - index];
        final date = DateTime.parse(booking['timestamp']);

        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
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
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
                size: 20,
              ),
              onPressed: () => onDelete(booking),
            ),
          ),
        );
      },
    );
  }
}
