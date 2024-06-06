import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final Stream<DocumentSnapshot<Map<String, dynamic>>> _categories =
  FirebaseFirestore.instance.collection('read_more').doc(FirebaseAuth.instance.currentUser?.uid).snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Categories"),),
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>
          (stream: _categories , builder: (context, snapshot ) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          List data = snapshot.data?.get("categories");

          return ListView.builder(
              itemCount: data.length ?? 0,
              itemBuilder: (context, position) {
            return ListTile(title: Text(data.elementAt(position)),);
          });
        }));
  }
}
