import 'dart:io';

import 'package:flutter/material.dart';
import 'package:weak_five_studentlist_main/widgets/edit_students.dart';

class WidgetStudentDetails extends StatelessWidget {
  final String name;
  final String photo;
  final String age;
  final String address;
  final String phone;
  final int index;
  const WidgetStudentDetails(
      {super.key,
      required this.name,
      required this.age,
      required this.address,
      required this.phone,
      required this.index,
      // required String photo,
      required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: ListView(children: [
        Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            CircleAvatar(
              backgroundImage: FileImage(File(photo)),
              radius: 150,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              name.toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 25,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Age      :  $age',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Phone      :  $phone',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Address   :  $address',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (ctx) => WidgetEiditStudent(
                                name: name,
                                age: age,
                                address: address,
                                phone: phone,
                                index: index,
                                image: photo,
                                photo: photo,
                              )));
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit'),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                  )
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}
