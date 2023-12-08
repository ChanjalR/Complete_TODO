import 'package:firebase_todo/taske.dart';
import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final String task, subtask, priority, date, time;

  const Details(
      {super.key,
      required this.task,
      required this.subtask,
      required this.priority,
      required this.date,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 400,
              height: 750,
              color: Colors.amber,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      task,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    'Subtask:$subtask',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Priority: $priority',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                  Text(
                    'Time: $time',
                    style: TextStyle(
                        fontSize: 15,
                        ),),
                        Text(
                    'Date: $date',
                    style: TextStyle(
                        fontSize: 15,
                        
                        ),)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
