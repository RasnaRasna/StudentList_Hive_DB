import 'dart:io';

import 'package:flutter/material.dart';
import 'package:weak_five_studentlist_main/widgets/student_details.dart';

import '../db/functions/db_functions.dart';
import '../db/model/data_model.dart';
import 'edit_students.dart';

class WidgetStudentList extends StatelessWidget {
  const WidgetStudentList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: studentListNotifier,
        builder:
            (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
          return ListView.separated(
              itemBuilder: (ctx, index) {
                final data = studentList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => WidgetStudentDetails(
                                photo: data.photo,
                                name: data.name,
                                age: data.age,
                                address: data.address,
                                phone: data.phoneNumber,
                                index: index)));
                      },
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: FileImage(File(data.photo)),
                      ),
                      title: Text(data.name),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => WidgetEiditStudent(
                                      image: data.photo,
                                      photo: '',
                                      name: data.name,
                                      age: data.age,
                                      address: data.address,
                                      phone: data.phoneNumber,
                                      index: index)));
                            },
                            icon: const Icon(Icons.edit),
                            color: Colors.teal,
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                  context: ctx,
                                  builder: (ctx1) {
                                    return AlertDialog(
                                      backgroundColor: Colors.teal,
                                      title: const Text(
                                        'Sure',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      content: Text(
                                        'Delete ${data.name.toUpperCase()} ?',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              deleteStudent(index);
                                              Navigator.of(ctx1).pop();
                                            },
                                            child: const Text(
                                              'Yes',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(ctx1).pop();
                                            },
                                            child: const Text(
                                              'No',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))
                                      ],
                                    );
                                  });
                            },
                            icon: const Icon(Icons.delete),
                            color: Colors.teal,
                          ),
                        ],
                      )),
                );
              },
              separatorBuilder: (ctx, index) {
                return const Divider();
              },
              itemCount: studentList.length);
        });
  }
}
