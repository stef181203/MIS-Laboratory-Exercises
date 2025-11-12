import 'package:flutter/material.dart';
import '../models/exam_model.dart';

class ExamCard extends StatelessWidget {
  final Exam exam;

  const ExamCard({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    final isExamFinished = exam.dateTime.isBefore(DateTime.now());
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/details", arguments: exam);
      },
      child: Card(
        color: isExamFinished ? Colors.red.shade100 : Colors.green.shade50,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.green.shade500, width: 3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                    exam.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.calendar_month),
                  Text("${exam.dateTime.day}-${exam.dateTime.month}-${exam.dateTime.year}", style: TextStyle(fontSize: 15)),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.timelapse),
                  Text("${exam.dateTime.hour}ч", style: TextStyle(fontSize: 15)),
                ],
              ),
              const SizedBox(height: 4),
              Wrap(
                children: [
                  const Icon(Icons.room_outlined),
                  Text(exam.rooms.join(', '), style: TextStyle(fontSize: 15),)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
