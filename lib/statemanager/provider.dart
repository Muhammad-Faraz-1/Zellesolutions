import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../pages/landingPage.dart';

// import 'dart:js' as js;
// import 'package:firebase_auth_web/firebase_auth_web.dart';

class Provider1 extends ChangeNotifier {
  var dataExist;
  String? name_;
  String? age_;
  String? email_;
  Duration timeInSec = Duration(seconds: 0);
  bool isRunning = false;
  String formattedHours = "00";
  String formattedMinutes = "00";
  String formattedSeconds = "00";
  bool? startbuttonenabled = null;
  String? lastAction = null;
  String? callbutton;
  var namazBreakHistory = {};
  var namazBreak = [];
  var callBreakHistory = {};
  var callBreak = [];
  var lunchBreakHistory = {};
  var lunchBreak = [];
  var casualLeaveHistory = {};
  var casualLeave = [];
  var summitLeaveHistory = {};
  var summitLeave = [];
  var shiftTimeHistory = {};
  var shiftTime = [];

  final TextEditingController _textController = TextEditingController();
  String? savedText = '';
  Timer? timer;

  void saveText() {
    savedText = _textController.text;
  }

  void startTimer() {
    if (lastAction == 'call break') {
      var endTime = DateTime.now().toString().substring(10, 19);
      callBreakHistory['endTime'] = endTime.toString();
      //print(endTime);
      lastAction = null;
      notifyListeners();
      callBreak.add(callBreakHistory);
      callBreakHistory = {};
      print(callBreak);
      print(callBreakHistory);
      lastAction = null;
    }
    if (lastAction == 'summit leave') {
      var endTime = DateTime.now().toString().substring(10, 19);
      summitLeaveHistory['endTime'] = endTime.toString();
      //print(endTime);
      lastAction = null;
      notifyListeners();
      summitLeave.add(summitLeaveHistory);
      summitLeaveHistory = {};
      print(summitLeave);
      print(summitLeaveHistory);
    }
    if (lastAction == 'casual leave') {
      var endTime = DateTime.now().toString().substring(10, 19);
      casualLeaveHistory['endTime'] = endTime.toString();
      //print(endTime);
      lastAction = null;
      notifyListeners();
      casualLeave.add(casualLeaveHistory);
      casualLeaveHistory = {};
      print(casualLeave);
      print(casualLeaveHistory);
    }
    if (lastAction == 'lunch break') {
      var endTime = DateTime.now().toString().substring(10, 19);
      lunchBreakHistory['endTime'] = endTime.toString();
      //print(endTime);
      lastAction = null;
      notifyListeners();

      lunchBreak.add(lunchBreakHistory);
      lunchBreakHistory = {};
      print(lunchBreak);
      print(lunchBreakHistory);
      lastAction = null;
    }
    if (lastAction == 'namaz break') {
      //print("${namazBreakHistory['startTime']}  start time is here");
      var endTime = DateTime.now().toString().substring(10, 19);
      namazBreakHistory['endTime'] = endTime.toString();
      //print(endTime);
      lastAction = null;
      notifyListeners();

      namazBreak.add(namazBreakHistory);
      namazBreakHistory = {};
      print(namazBreak);
      print(namazBreakHistory);
    }
    if (startbuttonenabled == true) {
      var startTime = DateTime.now().toString().substring(10, 19);
      shiftTimeHistory['StartTime'] = startTime.toString();
      startbuttonenabled = false;
      notifyListeners();
    }
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      timeInSec = timeInSec + Duration(seconds: 1);
      notifyListeners();
    });
    isRunning = true;
    notifyListeners();
  }

  void stopTimer() {
    if (lastAction == 'namaz break') {
      var startTime = DateTime.now().toString().substring(10, 19);
      namazBreakHistory['startTime'] = startTime.toString();
      //print(startTime);
      print(namazBreakHistory);
    }
    if (lastAction == 'casual leave') {
      var startTime = DateTime.now().toString().substring(10, 19);
      casualLeaveHistory['startTime'] = startTime.toString();
      //print(startTime);
      print(casualLeaveHistory);
    }
    if (lastAction == 'summit leave') {
      var startTime = DateTime.now().toString().substring(10, 19);
      summitLeaveHistory['startTime'] = startTime.toString();
      //print(startTime);
      print(summitLeaveHistory);
    }
    if (lastAction == 'call break') {
      var startTime = DateTime.now().toString().substring(10, 19);
      callBreakHistory['startTime'] = startTime.toString();
      //print(startTime);
      print(callBreakHistory);
    }
    if (lastAction == 'lunch break') {
      var startTime = DateTime.now().toString().substring(10, 19);
      lunchBreakHistory['startTime'] = startTime.toString();
      //print(startTime);
      print(lunchBreakHistory);
    }
    isRunning = false;
    timer?.cancel();
    notifyListeners();
  }

  void resetTimer() {
    if (startbuttonenabled == false) {
      var endTime = DateTime.now().toString().substring(10, 19);
      shiftTimeHistory['endTime'] = endTime.toString();
      shiftTime.add(shiftTimeHistory);
      print(shiftTimeHistory);
      shiftTimeHistory = {};
      print(shiftTime);
      print(shiftTimeHistory);
    }
    isRunning = false;
    timeInSec = Duration(seconds: 0);
    timer?.cancel();
    notifyListeners();
  }

  // void buttonCheck() {
  //   if (lastAction == 'break') {
  //     callbutton = 'enabeled';
  //   }
  // }

  @override
  notifyListeners();

  //login user//
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? uid;
  String? shift_;
  String? empId_;
  String? hours_;
  String? in_;
  String? out_;
  String? profile_;
  String? userEmail;

  ResetPassword(String email) async {
    await Firebase.initializeApp();
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
    }
  }

  bool loginState = false;

  changeStateTrue() {
    loginState = true;
    notifyListeners();
  }

  changeStateFalse() {
    loginState = false;
    notifyListeners();
  }

  Future<User?> signInWithEmailPassword(
      String email, String password, BuildContext context) async {
    await Firebase.initializeApp();
    User? user;

    try {
      await changeStateTrue();
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;

      if (user != null) {
        FirebaseFirestore.instance
            .collection('Employes')
            .doc(user.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            Map<String, dynamic> data =
                documentSnapshot.data() as Map<String, dynamic>;

            uid = user!.uid;
            name_ = data['name'];
            hours_ = data['hours'];
            empId_ = data['empID'];
            in_ = data['in'];
            out_ = data['out'];
            profile_ = data['profile'];
            shift_ = data['shift'];
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LandingPage()));
            print(email_);
          } else {
            print('Document does not exist on the database');
          }
        });
        uid = user.uid;
        userEmail = user.email;
        print(uid);
        await changeStateFalse();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
      await changeStateFalse();
    }

    return user;
  }

  CollectionReference morning_Shift =
      FirebaseFirestore.instance.collection('morning_Shift');
  Future<void> checkData() async {
    final collectionName = DateTime.now().toString().substring(0, 10);
    final collectionReference =
        morning_Shift.doc(uid).collection(collectionName);

    // Check if the collection exists
    final collectionSnapshot = await collectionReference.get();
    dataExist = collectionSnapshot;
  }

  Future<void> addemployeeData() async {
    notifyListeners();
    final collectionName = DateTime.now().toString().substring(0, 10);
    final collectionReference =
        morning_Shift.doc(uid).collection(collectionName);

    // Check if the collection exists
    final collectionSnapshot = await collectionReference.get();

    if (collectionSnapshot.docs.isEmpty) {
      // Collection doesn't exist, create a new one
      return collectionReference.doc(uid).set({
        'startShift': DateTime.now().toString(),
        'endShift': "",
        "namazBreak": [],
        // 'callBreak':[],
        "lunchBreak": [],
        "Break": [],
        "casualLeave": [],
        "summitLeave": [],
        'reason': "",
      });
    } else {
      // Collection exists, update it
      // return collectionReference.doc(uid).update({
      //   'startShift': DateTime.now().toString(),
      //}
      //);
    }
  }

  Future<void> endShiftDataBase() {
    notifyListeners();
    return morning_Shift
        .doc(uid)
        .collection(DateTime.now().toString().substring(0, 10))
        .doc(uid)
        .update({
      'endShift': DateTime.now().toString(),
    });
  }

  var lastList = [];
  // Future<void> callBreakDataBase() {
  //   notifyListeners();
  //   return morning_Shift
  //       .doc(uid)
  //       .collection(DateTime.now().toString().substring(0, 10))
  //       .doc(uid)
  //       .update({
  //     "callBreak":callBreak,
  //   });
  // }
  Future<void> BreakDataBase() {
    notifyListeners();
    return morning_Shift
        .doc(uid)
        .collection(DateTime.now().toString().substring(0, 10))
        .doc(uid)
        .update({
      "Break": callBreak,
    });
  }

  Future<void> reasonDataBase() {
    notifyListeners();
    return morning_Shift
        .doc(uid)
        .collection(DateTime.now().toString().substring(0, 10))
        .doc(uid)
        .update({
      "reason": savedText,
    });
  }

  Future<void> namazBreakDataBase() {
    return morning_Shift
        .doc(uid)
        .collection(DateTime.now().toString().substring(0, 10))
        .doc(uid)
        .update({
      "namazBreak": namazBreak,
    });
  }

  Future<void> lunchBreakDataBase() {
    return morning_Shift
        .doc(uid)
        .collection(DateTime.now().toString().substring(0, 10))
        .doc(uid)
        .update({
      "lunchBreak": lunchBreak,
    });
  }

  Future<void> casualLeaveDataBase() {
    return morning_Shift
        .doc(uid)
        .collection(DateTime.now().toString().substring(0, 10))
        .doc(uid)
        .update({
      "casualLeave": casualLeave,
    });
  }

  Future<void> summitLeaveDataBase() {
    return morning_Shift
        .doc(uid)
        .collection(DateTime.now().toString().substring(0, 10))
        .doc(uid)
        .update({
      "summitLeave": summitLeave,
    });
  }

  String findTimeDifference(String startTime, String endTime) {
    // Define a time format pattern to parse the time strings
    final timeFormat = DateFormat("HH:mm:ss");

    try {
      // Trim the input strings to remove leading and trailing spaces
      startTime = startTime.trim();
      endTime = endTime.trim();

      // Parse the time strings into DateTime objects
      final start = timeFormat.parse(startTime);
      final end = timeFormat.parse(endTime);

      // Calculate the time difference
      final difference = end.difference(start);

      // Convert the duration to a string in "HH:mm:ss" format
      final durationFormatted =
          "${difference.inHours}:${difference.inMinutes.remainder(60).toString().padLeft(2, '0')}:${difference.inSeconds.remainder(60).toString().padLeft(2, '0')}";

      return durationFormatted;
    } catch (e) {
      // Handle any parsing errors here
      print("Error parsing time: $e");
      return ""; // Return an empty string in case of an error
    }
  }
}
