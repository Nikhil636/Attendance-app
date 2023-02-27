// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'calendar.dart';
import 'profile.dart';
import 'today.dart';
import 'usert.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

double screenh = 0;
double screenw = 0;
int currentIndex = 1;
String id = '';
List<IconData> navigationIcons = <IconData>[
  FontAwesomeIcons.calendarDays,
  FontAwesomeIcons.check,
  FontAwesomeIcons.user,
];

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 1;
  @override
  void initState() {
    super.initState();
    getId();
    _getCredentials();
    _getProfilePic();
  }

  Future<void> _getCredentials() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore
          .instance
          .collection('Employee')
          .doc('Rf9LKIsunYRsAt9PcEA4')
          .get();
      setState(() {
        User.canEdit = doc['canEdit'] as bool;
        User.firstName = doc['firstName'] as String;
        User.lastName = doc['lastName'] as String;
        User.birthDate = doc['birthDate'] as String;
        User.address = doc['address'] as String;
      });
    } catch (e) {
      return;
    }
  }

  Future<void> _getProfilePic() async {
    DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore
        .instance
        .collection('Employee')
        .doc('Rf9LKIsunYRsAt9PcEA4')
        .get();
    setState(() {
      //TODO: change this later as this is throwing an error due to non-existent profile picture
      // User.profilePicLink = doc['profilePic'] as String;
    });
  }

  Future<void> getId() async {
    QuerySnapshot<Map<String, dynamic>> snap = await FirebaseFirestore.instance
        .collection('Employee')
        .where('Id', isEqualTo: User.employeeId)
        .get();
    setState(() {
      //TODO: change this later as this is throwing an error
      // User.id = snap.docs[0].id;
    });
  }

  @override
  Widget build(BuildContext context) {
    screenh = MediaQuery.of(context).size.height;
    screenw = MediaQuery.of(context).size.width;
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: const <Widget>[
          Calendar(),
          Today(),
          Profile(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        margin: const EdgeInsets.only(
          left: 12,
          right: 12,
          bottom: 24,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (int i = 0; i < navigationIcons.length; i++) ...<Expanded>{
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = i;
                      });
                    },
                    child: Container(
                      height: screenh,
                      width: screenw,
                      color: Colors.white,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              navigationIcons[i],
                              color: i == currentIndex
                                  ? const Color.fromRGBO(2, 64, 116, 1)
                                  : Colors.black54,
                              size: i == currentIndex ? 30 : 26,
                            ),
                            i == currentIndex
                                ? Container(
                                    margin: const EdgeInsets.only(top: 6),
                                    height: 3,
                                    width: 22,
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(40)),
                                      color: Color.fromRGBO(2, 64, 116, 1),
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              }
            ],
          ),
        ),
      ),
    );
  }
}
