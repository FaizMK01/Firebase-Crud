import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_practice/views/Add_User_View.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../Utils/reusable.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.green.shade100,
          title: Reusable.text("Firebase Crud", 30, color: Colors.teal)
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: firebaseMethods.getDataProfileDetails(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                        child: Reusable.text("No Data Available", 20));
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot ds = snapshot.data!.docs[index];
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 110,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.orangeAccent.shade200,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Reusable.text("Name:"" ${ds["Name"]}", 15,
                                        color: Colors.white),
                                    const Spacer(),
                                    GestureDetector(
                                        onTap: () {
                                          nameController.text = ds["Name"];
                                          addressController.text =
                                              ds["Address"];
                                          ageController.text =
                                              ds["Age"].toString();
                                          edit(ds["ID"]);
                                        },
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.green,
                                        )),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      "Delete Details"),
                                                  content: const Text(
                                                      "Are You Want to sure Delete This"),
                                                  actions: [
                                                    Row(
                                                      children: [
                                                        const Spacer(),
                                                        Reusable.elevatedButton(
                                                            "OK",
                                                            Colors.teal,
                                                            Colors.white,
                                                            onTap: () async {
                                                          await firebaseMethods
                                                              .deleteDetails(
                                                                  ds["ID"],
                                                                  context);
                                                        }),
                                                        const SizedBox(
                                                            width: 5.0),
                                                        Reusable.elevatedButton(
                                                            "Cancel",
                                                            Colors.teal,
                                                            Colors.white,
                                                            onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        })
                                                      ],
                                                    )
                                                  ],
                                                );
                                              });
                                        },
                                        child: const Icon(Icons.delete,
                                            color: Colors.red))
                                  ],
                                ),
                                Reusable.text("Age:"" ${ds["Age"].toString()}", 20,
                                    color: Colors.black87),
                                Reusable.text("Address:"" ${ds["Address"]}", 15,
                                    color: Colors.white),

                                //SizedBox(height: 10,),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddUserView()));
        },
        backgroundColor: Colors.green.shade400,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Future edit(String id) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 450,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.cancel),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Reusable.text("Edit Profile Details", 20,
                            color: Colors.teal)
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Reusable.textField(nameController, "Enter Your Name"),
                    const Gap(20),
                    Reusable.textField(addressController, "Enter Your Address"),
                    const Gap(20),
                    Reusable.textField(ageController, "Enter Your Age"),
                    const Gap(50),
                    SizedBox(
                        width: 150,
                        child: Reusable.elevatedButton(
                            "Update", Colors.teal.shade500, Colors.white,
                            onTap: () async {
                          Map<String, dynamic> updateInfo() => {
                                "Name": nameController.text,
                                "Address": addressController.text,
                                "ID": id,
                                "Age": ageController.text.toString()
                              };
                          await firebaseMethods.updateDetails(
                              id, updateInfo(), context);
                          Navigator.pop(context);
                        }))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
