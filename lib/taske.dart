import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo/home.dart';
import 'package:flutter/material.dart';

class Taskes extends StatefulWidget {
  const Taskes({super.key});

  @override
  State<Taskes> createState() => _TaskesState();
}

class _TaskesState extends State<Taskes> {
  String selectedPriority = "Low";

  TextEditingController taskNameController = TextEditingController();
  TextEditingController subtasksContoller = TextEditingController();
  TextEditingController priorityController = TextEditingController();
  // TextEditingController dateContoller = TextEditingController();
  // TextEditingController timeContoller = TextEditingController();

  String formatDate(DateTime dateTime) {
    return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
  }

  String formatTime(DateTime dateTime) {
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  Future<void> addtofirebase() async {
    print('printtttt');
    FirebaseAuth auth = await FirebaseAuth.instance;
    final User? user = await auth.currentUser;
    String uid = user!.uid;
    var currentTime = DateTime.now();
    try {
      await FirebaseFirestore.instance
          .collection("Todo")
          .doc(uid)
          .collection('Mytaskes')
          .doc(currentTime.toString())
          .set({
        'Task': taskNameController.text,
        'Subtasks': subtasksContoller.text,
        'Priority': selectedPriority,
        'Date': formatDate(currentTime),
        'Time': formatTime(currentTime),
        // 'Date': dateContoller.text,
        // 'Time': timeContoller.text
      });
      print("Uploaded");
    } catch (e) {
      print("Error uploading task: $e");
      print("errorrrrrrrr");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New task'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              child: TextField(
                controller: taskNameController,
                decoration: InputDecoration(
                    labelText: "Enter your task", border: OutlineInputBorder()),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              child: TextField(
                controller: subtasksContoller,
                decoration: InputDecoration(
                    labelText: "Subtasks", border: OutlineInputBorder()),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Priority",
                  border: OutlineInputBorder(),
                ),
                value: selectedPriority,
                items: ["Low", "Medium", "High"].map((String priority) {
                  return DropdownMenuItem<String>(
                    value: priority,
                    child: Text(priority),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedPriority = value!;
                  });
                },
                onSaved: (String? value) {
                  priorityController.text = value ?? "";
                },
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(10),
          //   child: Container(
          //     child: TextField(
          //       controller: dateContoller,
          //       decoration: InputDecoration(
          //         labelText: "Enter date",
          //         border: OutlineInputBorder(),
          //       ),
          //       keyboardType: TextInputType.datetime,
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(10),
          //   child: Container(
          //     child: TextField(
          //       controller: timeContoller, 
          //       decoration: InputDecoration(
          //         labelText: "Enter time",
          //         border: OutlineInputBorder(),
          //       ),
          //       keyboardType: TextInputType.datetime,
          //     ),
          //   ),
          // ),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  addtofirebase();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                },
                child: Text("Add task")),
          )
        ],
      ),
    );
  }
}
