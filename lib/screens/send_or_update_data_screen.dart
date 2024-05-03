import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/home_screen.dart';

class SendOrUpdateData extends StatefulWidget {
  final String name;
  final String age;
  final String email;
  final String id;
  const SendOrUpdateData(
      {super.key,
      this.name = '',
      this.age = '',
      this.email = '',
      this.id = ''});
  @override
  State<SendOrUpdateData> createState() => _SendOrUpdateDataState();
}

class _SendOrUpdateDataState extends State<SendOrUpdateData> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool showProgressIndicator = false;

  @override
  void initState() {
    nameController.text = widget.name;
    ageController.text = widget.age;
    emailController.text = widget.email;
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.amber.shade500,
        centerTitle: true,
        title: Text(
          widget.id.isNotEmpty ? 'Edit Data' : 'Buat Data',
          style: const TextStyle(fontWeight: FontWeight.w300),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20)
            .copyWith(top: 60, bottom: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nama',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: 'e.g. Rhamdhan'),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Umur',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(hintText: 'e.g. 18'),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Email',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            TextField(
              controller: emailController,
              decoration:
                  const InputDecoration(hintText: 'e.g. ramdhan@gmail.com'),
            ),
            const SizedBox(
              height: 40,
            ),
            MaterialButton(
              onPressed: () async {
                setState(() {});
                if (nameController.text.isEmpty ||
                    ageController.text.isEmpty ||
                    emailController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Data tidak boleh kosong!'),
                      backgroundColor: Colors.amber,
                    ),
                  );
                } else if (int.tryParse(ageController.text) == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Gagal menambahkan data, Harap masukkan data yang sesuai!'),
                      backgroundColor: Colors.amber,
                    ),
                  );
                } else {
                  //reference to document
                  final dUser = FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.id.isNotEmpty ? widget.id : null);
                  String docID = '';
                  if (widget.id.isNotEmpty) {
                    docID = widget.id;
                  } else {
                    docID = dUser.id;
                  }
                  final jsonData = {
                    'name': nameController.text,
                    'age': int.parse(ageController.text),
                    'email': emailController.text,
                    'id': docID
                  };
                  showProgressIndicator = true;
                  if (widget.id.isEmpty) {
                    //create document and write data to firebase
                    await dUser.set(jsonData).then((value) {
                      nameController.text = '';
                      ageController.text = '';
                      emailController.text = '';
                      showProgressIndicator = false;
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                          (route) => false);
                    });
                  } else {
                    await dUser.update(jsonData).then((value) {
                      nameController.text = '';
                      ageController.text = '';
                      emailController.text = '';
                      showProgressIndicator = false;
                      setState(() {});
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                          (route) => false);
                    }).catchError((e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Gagal mengedit data, coba lagi! $e'),
                          backgroundColor: Colors.amber,
                        ),
                      );
                    });
                  }
                }
              },
              minWidth: double.infinity,
              height: 50,
              color: Colors.amber.shade500,
              child: showProgressIndicator
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text(
                      'Submit',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w300),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
