import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_practice/views/Add_User_View.dart';
import 'package:flutter/material.dart';

import '../Utils/reusable.dart';

class FirebaseMethods {
  String id = DateTime.now().millisecondsSinceEpoch.toString();

  Map<String, dynamic> toJson() => {
        "Name": nameController.text,
        "Address": addressController.text,
        "Age": ageController.text.toString(),
        "ID": id.toString()
      };

  //Create

  saveUser(BuildContext context) {
    FirebaseFirestore.instance
        .collection("ProfileDetails")
        .doc(id)
        .set(toJson());
    Reusable.toastMessage("Saved Successfully", context, 500, Colors.green);
    nameController.clear();
    addressController.clear();
    ageController.clear();
  }

  //Read

  Stream<QuerySnapshot> getDataProfileDetails() {
    return FirebaseFirestore.instance.collection("ProfileDetails").snapshots();
  }

  //update

  Future updateDetails(
      String id, Map<String, dynamic> updateDetails, context) async {
    return await FirebaseFirestore.instance
        .collection("ProfileDetails")
        .doc(id)
        .update(updateDetails)
        .then((value) {
      Reusable.toastMessage("Update Successfully", context, 500, Colors.green);
    });
  }

  //delete

  Future deleteDetails(String id, context) async {
    return await FirebaseFirestore.instance
        .collection("ProfileDetails")
        .doc(id)
        .delete()
        .then((value) {
      Reusable.toastMessage("Delete Successfully", context, 500, Colors.red);

      Navigator.pop(context);
    });
  }
}
