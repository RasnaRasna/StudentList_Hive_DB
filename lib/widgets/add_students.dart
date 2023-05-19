import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weak_five_studentlist_main/db/model/data_model.dart';

import '../db/functions/db_functions.dart';

class WidgetAddStudent extends StatefulWidget {
  const WidgetAddStudent({super.key});

  @override
  State<WidgetAddStudent> createState() => _WidgetAddStudentState();
}

class _WidgetAddStudentState extends State<WidgetAddStudent> {
  final nameController = TextEditingController();

  final ageController = TextEditingController();

  final phoneController = TextEditingController();

  final addressController = TextEditingController();

  bool imageAlert = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: [
            const SizedBox(
              height: 40,
            ),
            Column(
              children: [
                userPhoto?.path == null
                    ? const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/user.webp'),
                        radius: 70,
                      )
                    : CircleAvatar(
                        radius: 70,
                        backgroundImage: FileImage(File(userPhoto!.path)),
                      ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    getPhoto();
                  },
                  icon: const Icon(Icons.photo),
                  label: const Text('Add Image'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(40),
                  )),
                  hintText: 'Enter name Here',
                  label: Text('Name')),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required Name';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                SizedBox(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: ageController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40),
                          ),
                        ),
                        hintText: 'XX',
                        label: Text('Age')),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: phoneController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(40),
                        ),
                      ),
                      hintText: 'XXXXXXXXXX',
                      label: Text('Phone'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: addressController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(40),
                  ),
                ),
                hintText: 'Text Address',
                label: Text('Address'),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    if (userPhoto != null) {
                      onAddStudentButtonClicked(context);
                    } else {
                      imageSnackBar();
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onAddStudentButtonClicked(BuildContext ctx) async {
    final name = nameController.text.trim();
    final age = ageController.text.trim();
    final phone = phoneController.text.trim();
    final address = addressController.text.trim();
    if (name.isEmpty ||
        age.isEmpty ||
        phone.isEmpty ||
        address.isEmpty ||
        userPhoto!.path.isEmpty) {
      return showSnackbarMessage();
    }
    final studentAdd = StudentModel(
        name: name,
        age: age,
        phoneNumber: phone,
        address: address,
        photo: userPhoto!.path);
    addStudent(studentAdd);
    Navigator.of(context).pop();
  }

  Future<void> showSnackbarMessage() async {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(30),
      content: Text('Items are Requierd'),
      backgroundColor: Colors.red,
    ));
  }

  File? userPhoto;

  Future<void> getPhoto() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (photo == null) {
      return;
    } else {
      final photoTemp = File(photo.path);
      setState(() {
        userPhoto = photoTemp;
      });
    }
  }

  Future<void> imageSnackBar() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(30),
        content: Text('Add Image'),
      ),
    );
  }
}
