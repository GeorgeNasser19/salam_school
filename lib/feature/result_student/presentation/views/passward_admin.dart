import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:salam_school/feature/result_student/data/mangemant_repo_imp.dart';
import 'package:salam_school/feature/result_student/presentation/views/admin_view.dart';

class PasswardAdmin extends StatelessWidget {
  const PasswardAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textcontroller = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          TextField(
            controller: textcontroller,
            decoration: const InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                if (textcontroller.text == "999") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminView(
                            mangemantRepoImp:
                                MangemantRepoImp(FirebaseFirestore.instance)),
                      ));
                }
              },
              child: const Text("go"))
        ],
      ),
    );
  }
}
