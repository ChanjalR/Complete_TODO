import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo/details.dart';
import 'package:firebase_todo/profiles.dart';
import 'package:firebase_todo/taske.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String uid = '';

  getuid() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = await auth.currentUser;
    setState(() {
      uid = user!.uid;
    });
  }

  @override
  void initState() {
    setState(() {
      
      getuid();
    });
    super.initState();
  }

  Future<void> deleteFromFirebase(String documentId) async {
    FirebaseAuth auth = await FirebaseAuth.instance;
    final User? user = await auth.currentUser;
    String uid = user!.uid;

    try {
      await FirebaseFirestore.instance
          .collection("Todo")
          .doc(uid)
          .collection('Mytaskes')
          .doc(documentId)
          .delete();
      print("Deleted");
    } catch (e) {
      print("Error deleting task: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO list'),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => profiles()),
            );
          },
          icon: Icon(Icons.supervised_user_circle),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                color: Color.fromARGB(255, 224, 224, 224),
                child: Center(child: Text('Tasks')),
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Todo')
                    .doc(uid)
                    .collection('Mytaskes')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                        child: Center(child: CircularProgressIndicator()));
                  } else {
                    final docs = snapshot.data!.docs;
                    print('uiddddddddddddddddd');
                    print(uid);
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: docs.length,
                        itemBuilder: (context, Index) {
                          var document = docs[Index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Details(
                                      task: docs[Index]['Task'],
                                      subtask: docs[Index]['Subtasks'],
                                      priority: docs[Index]['Priority'],
                                      date: docs[Index]['Date'],
                                      time: docs[Index]['Time'],
                                    ),
                                  ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                width: 180,
                                height: 100,
                                color: Colors.amber,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            margin: EdgeInsets.only(
                                              left: 20,
                                            ),
                                            child: Text(
                                              docs[Index]['Task'],
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 20),
                                          child: Text(
                                            'Date: ${docs[Index]['Date']}       Time: ${docs[Index]['Time']}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      child: IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () async {
                                          await deleteFromFirebase(document.id);
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  }
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Taskes()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
