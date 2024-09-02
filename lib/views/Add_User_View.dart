import 'package:firebase_practice/services/firebase_methods.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../Utils/reusable.dart';

class AddUserView extends StatefulWidget {
  const AddUserView({super.key});

  @override
  State<AddUserView> createState() => _AddUserViewState();
}

TextEditingController nameController = TextEditingController();
TextEditingController addressController = TextEditingController();
TextEditingController ageController = TextEditingController();

FirebaseMethods firebaseMethods = FirebaseMethods();

class _AddUserViewState extends State<AddUserView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green.shade100,
        title: Reusable.text("Add User", 30, color: Colors.teal)
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Reusable.textField(nameController, "Enter Your Name",
                    validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Your Name";
                  }
                }),
                const Gap(20),
                Reusable.textField(addressController, "Enter Your Address",
                    validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Your Address";
                  }
                }),
                const Gap(20),
                Reusable.textField(ageController, "Enter Your Age",
                    type: TextInputType.number, validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Pleae Enter Your Age";
                  }
                }),
                const Gap(50),
                SizedBox(
                    width: 250,
                    child: Reusable.elevatedButton(
                        "Save", Colors.teal, Colors.white, onTap: () {
                      if (_formKey.currentState!.validate()) {
                        firebaseMethods.saveUser(context);
                      }
                    }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
