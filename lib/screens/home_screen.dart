import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/send_or_update_data_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SendOrUpdateData(),
            ),
          );
        },
        backgroundColor: Colors.amber.shade500,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.amber.shade500,
        centerTitle: true,
        title: const Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.w300, color: Colors.white),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          return streamSnapshot.hasData
              ? ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 41),
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: ((context, index) {
                    return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20)
                            .copyWith(bottom: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(1),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.amber.shade500,
                                blurRadius: 5,
                                spreadRadius: 1,
                                offset: const Offset(2, 2),
                              )
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 31,
                                  color: Colors.amber.shade300,
                                ),
                                const SizedBox(width: 11),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      streamSnapshot.data!.docs[index]['name'],
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      streamSnapshot.data!.docs[index]['age']
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      streamSnapshot.data!.docs[index]['email'],
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => SendOrUpdateData(
                                          name: streamSnapshot.data!.docs[index]
                                              ['name'],
                                          age: streamSnapshot
                                              .data!.docs[index]['age']
                                              .toString(),
                                          email: streamSnapshot
                                              .data!.docs[index]['email'],
                                          id: streamSnapshot.data!.docs[index]
                                              ['id'],
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                    size: 21,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final docData = FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(streamSnapshot.data!.docs[index]
                                            ['id']);
                                    await docData.delete();
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red.shade500,
                                    size: 21,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ));
                  }))
              : const Center(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(
                      color: Colors.amber,
                    ),
                  ),
                );
        },
      ),
    );
  }
}
