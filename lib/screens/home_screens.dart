import 'package:flutter/material.dart';
import 'package:weak_five_studentlist_main/widgets/search_student.dart';

import '../db/functions/db_functions.dart';
import '../widgets/add_students.dart';
import '../widgets/student_list.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    getAllStudents();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: WidgetSearch());
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: const WidgetStudentList(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => const WidgetAddStudent(),
            ),
          );
        },
        label: Row(
          children: const [
            Icon(Icons.add),
            SizedBox(
              width: 10,
            ),
            Text('Add person'),
          ],
        ),
      ),
    );
  }
}
