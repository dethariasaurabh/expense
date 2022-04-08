import 'package:expense/ExpenseApp.dart';
import 'package:flutter/material.dart';
import 'package:expense/services/firebase_servcies.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseServices.initFirebase();
  runApp(const ExpenseApp());
}
