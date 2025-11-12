import 'package:flutter/material.dart';
import '../models/exam_model.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final exam = ModalRoute.of(context)!.settings.arguments as Exam;

    String _timeUntilExam() {
      final diff = exam.dateTime.difference(DateTime.now());
      if (diff.isNegative) {
        return "Испитот е завршен.";
      }

      return "${diff.inDays} дена, ${diff.inHours % 24} часа";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(exam.name.toUpperCase()),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: SizedBox(
          width: double.infinity,
          child: Card(
            color: Colors.grey.shade200,
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Детали", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text("Датум на полагање: ${exam.dateTime.day}-${exam.dateTime.month}-${exam.dateTime.year}", style: TextStyle(fontSize: 18)),
                  Text("Време: ${exam.dateTime.hour} часот", style: TextStyle(fontSize: 18)),
                  Wrap(
                    children: [
                      Text("Простории: ${exam.rooms.join(', ')}", style: TextStyle(fontSize: 18))
                    ],
                  ),
                  Text("Преостанато време: ${_timeUntilExam()}", style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ),
        )
      )

    );
  }
}

