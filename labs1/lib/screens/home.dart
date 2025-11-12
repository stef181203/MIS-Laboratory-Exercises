import 'package:flutter/material.dart';
import 'package:labs1/widgets/exam_grid.dart';
import '../models/exam_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Exam> exams = [
    Exam(id: 0, name: 'Алгоритми', dateTime: DateTime(2025, 11, 10, 9, 0), rooms: ["Lab13", "Lab2"]),
    Exam(id: 1, name: 'EMT', dateTime: DateTime(2025, 11, 11, 10, 0), rooms: ["Lab13", "Lab2"]),
    Exam(id: 2, name: 'Бази', dateTime: DateTime(2025, 11, 12, 11, 0), rooms: ["Lab13", "Lab2"]),
    Exam(id: 3, name: 'Калкулус 1', dateTime: DateTime(2025, 11, 13, 12, 0), rooms: ["Lab13", "Lab2"]),
    Exam(id: 4, name: 'Калкулус 2', dateTime: DateTime(2025, 11, 14, 13, 0), rooms: ["Lab13", "Lab2"]),
    Exam(id: 5, name: 'Дискретна 1', dateTime: DateTime(2025, 11, 17, 14, 0), rooms: ["Lab13", "Lab2"]),
    Exam(id: 6, name: 'Веб дизајн', dateTime: DateTime(2025, 11, 18, 15, 0), rooms: ["Lab13", "Lab2"]),
    Exam(id: 7, name: 'Интегрирани', dateTime: DateTime(2025, 11, 19, 16, 0), rooms: ["Lab13", "Lab2"]),
    Exam(id: 8, name: 'Софтверско', dateTime: DateTime(2025, 11, 20, 17, 0), rooms: ["Lab13", "Lab2"]),
    Exam(id: 9, name: 'Дискретна 2', dateTime: DateTime(2025, 11, 20, 13, 0), rooms: ["Lab13", "Lab2"]),
    Exam(id: 10, name: 'Оперативни', dateTime: DateTime(2025, 11, 19, 12, 0), rooms: ["Lab13", "Lab2"]),
    Exam(id: 11, name: 'Веројатност', dateTime: DateTime(2025, 11, 17, 16, 0), rooms: ["Lab13", "Lab2"])
  ];

  @override
  Widget build(BuildContext context) {
    exams.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(child: ExamGrid(exams: exams)),
            const SizedBox(height: 5),
            Text("Вкупен број на испити: ${exams.length}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
          ],
        )
      ),
    );
  }
}

