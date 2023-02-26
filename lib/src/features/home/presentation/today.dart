import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../app/provider/providers.dart';
import 'home.dart';
import 'usert.dart';

class Today extends ConsumerStatefulWidget {
  const Today({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodayState();
}

class _TodayState extends ConsumerState<Today> {
  String checkIn = '--/--';
  String checkOut = '--/--';
  String? location;
  @override
  void initState() {
    super.initState();
    getrecord();
  }

  Future<void> getrecord() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snap = await FirebaseFirestore
          .instance
          .collection('Employee')
          .where('id', isEqualTo: User.employeeId)
          .get();
      DocumentSnapshot<Map<String, dynamic>> snap2 = await FirebaseFirestore
          .instance
          .collection('Employee')
          .doc(snap.docs[0].id)
          .collection('Record')
          .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
          .get();
      setState(() {
        checkIn = snap2['checkIn'] as String;
        checkOut = snap2['checkOut'] as String;
      });
    } catch (e) {
      setState(() {
        checkIn = '--/--';
        checkOut = '--/--';
      });
      log(checkIn);
      log(checkOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 32),
              child: Text(
                'Welcome,',
                style: textTheme.bodyMedium?.copyWith(
                  color: Colors.black54,
                  fontSize: screenw / 20,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Employee ${User.employeeId}',
                style: textTheme.bodyMedium?.copyWith(fontSize: screenw / 18),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 32),
              child: Text(
                "Today's Status",
                style: textTheme.bodyMedium?.copyWith(
                  fontSize: screenw / 18,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 32),
              height: 150,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(2, 2),
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Check In',
                          style: textTheme.bodyMedium
                              ?.copyWith(fontSize: screenw / 18),
                        ),
                        Text(
                          checkIn,
                          style: textTheme.bodyMedium
                              ?.copyWith(fontSize: screenw / 18),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Text>[
                        Text(
                          'Check Out',
                          style: textTheme.bodyMedium?.copyWith(
                            fontSize: screenw / 20,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          checkOut,
                          style: textTheme.bodyMedium
                              ?.copyWith(fontSize: screenw / 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  text: DateTime.now().day.toString(),
                  style: textTheme.bodyMedium?.copyWith(
                    color: const Color.fromRGBO(2, 64, 116, 1),
                    fontSize: screenw / 18,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: DateFormat(' MMMM yyyy').format(DateTime.now()),
                      style: textTheme.bodyMedium
                          ?.copyWith(fontSize: screenw / 20),
                    ),
                  ],
                ),
              ),
            ),
            StreamBuilder<dynamic>(
              stream: Stream<dynamic>.periodic(const Duration(seconds: 1)),
              builder: (BuildContext context, AsyncSnapshot<Object?> snapshot) {
                return Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    DateFormat('hh:mm:ss a').format(DateTime.now()),
                    style: textTheme.bodyMedium?.copyWith(
                      fontSize: screenw / 20,
                      color: Colors.black54,
                    ),
                  ),
                );
              },
            ),
            ref.watch(checkInNotifierProvider).when(
                  initial: SizedBox.shrink,
                  success: (Position data) => checkOut == '--/--'
                      ? Container(
                          margin: const EdgeInsets.only(top: 24),
                          child: Builder(builder: (BuildContext context) {
                            GlobalKey<SlideActionState> key = GlobalKey();
                            return SlideAction(
                                text: checkIn == '--/--'
                                    ? 'Slide to Check In'
                                    : 'Slide to Check Out',
                                textStyle: textTheme.bodyMedium?.copyWith(
                                  fontSize: screenw / 20,
                                  color: Colors.black54,
                                ),
                                outerColor: Colors.white,
                                innerColor: const Color.fromRGBO(2, 64, 116, 1),
                                key: key,
                                onSubmit: () async {
                                  Timer(const Duration(seconds: 1), () {
                                    key.currentState!.reset();
                                  });
                                  QuerySnapshot<Map<String, dynamic>> snap =
                                      await FirebaseFirestore.instance
                                          .collection('Employee')
                                          .where('id',
                                              isEqualTo: User.employeeId)
                                          .get();
                                  DocumentSnapshot<Map<String, dynamic>> snap2 =
                                      await FirebaseFirestore.instance
                                          .collection('Employee')
                                          .doc(snap.docs[0].id)
                                          .collection('Record')
                                          .doc(DateFormat('dd MMMM yyyy')
                                              .format(DateTime.now()))
                                          .get();
                                  try {
                                    String checkIn = snap2['checkIn'] as String;
                                    setState(() {
                                      checkOut = DateFormat('hh:mm')
                                          .format(DateTime.now());
                                    });

                                    await FirebaseFirestore.instance
                                        .collection('Employee')
                                        .doc(snap.docs[0].id)
                                        .collection('Record')
                                        .doc(DateFormat('dd MMMM yyyy')
                                            .format(DateTime.now()))
                                        .update(
                                      <Object, Object?>{
                                        'date': Timestamp.now(),
                                        'checkIn': checkIn,
                                        'checkOut': DateFormat('hh:mm')
                                            .format(DateTime.now())
                                      },
                                    );
                                  } catch (e) {
                                    setState(() {
                                      checkIn = DateFormat('hh:mm')
                                          .format(DateTime.now());
                                    });

                                    await FirebaseFirestore.instance
                                        .collection('Employee')
                                        .doc(snap.docs[0].id)
                                        .collection('Record')
                                        .doc(DateFormat('dd MMMM yyyy')
                                            .format(DateTime.now()))
                                        .set(
                                      <String, dynamic>{
                                        'date': Timestamp.now(),
                                        'checkIn': DateFormat('hh:mm')
                                            .format(DateTime.now()),
                                        'checkOut': '--/--',
                                      },
                                    );
                                  }
                                });
                          }),
                        )
                      : Container(
                          margin: const EdgeInsets.only(top: 32, bottom: 32),
                          child: Text(
                            'You have completed this day!',
                            style: textTheme.headlineMedium?.copyWith(
                              fontSize: screenw / 20,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                  loading: () => const CircularProgressIndicator.adaptive(),
                  failure: (String error) {
                    return Container(
                      margin: const EdgeInsets.only(top: 32, bottom: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              error,
                              style: textTheme.headlineMedium?.copyWith(
                                fontSize: screenw / 20,
                                overflow: TextOverflow.ellipsis,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => ref
                                .read(checkInNotifierProvider.notifier)
                                .askLocationService(),
                            child: const Icon(
                              Icons.refresh,
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
          ],
        ),
      ),
    );
  }
}
