import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../authentication/presentation/login/login_screen.dart';
import 'usert.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String birth = 'Date of birth';

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  Future<void> pickUploadProfilePic() async {
    // final firebaseStorage = FirebaseStorage.instance;
    // final imagePicker = ImagePicker();
    // PickedFile? image;

    // await Permission.photos.request();

    // var permissionStatus = await Permission.photos.status;

    // if (permissionStatus.isGranted) {
    //   //Select Image
    //   image = await imagePicker.getImage(source: ImageSource.gallery);
    //   var file = File(image!.path);

    //   if (image != null) {
    //     //Upload to Firebase
    //     var snapshot = await firebaseStorage
    //         .ref()
    //         .child('${User.employeeId.toLowerCase()}_profilepic.jpg')
    //         .putFile(File(image.path));

    //     var downloadUrl = await snapshot.ref.getDownloadURL();
    //     setState(() {
    //       User.profilePicLink = downloadUrl;
    //     });
    //   } else {
    //     print('No Image Path Received');
    //   }
    // } else {
    //   print('Permission not granted. Try Again with permission access');
    // }
    XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 90,
    );

    Reference ref = FirebaseStorage.instance
        .ref()
        .child('${User.employeeId.toLowerCase()}_profilepic.jpg');
    await ref.putFile(File(image!.path));

    await ref.getDownloadURL().then((String value) async {
      setState(() {
        User.profilePicLink = value;
      });
      await FirebaseFirestore.instance
          .collection('Employee')
          .doc('Rf9LKIsunYRsAt9PcEA4')
          .update(<Object, Object>{
        'profilePic': value,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: pickUploadProfilePic,
              child: Container(
                margin: const EdgeInsets.only(top: 80, bottom: 24),
                height: 120,
                width: 120,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromRGBO(2, 64, 116, 1),
                ),
                child: Center(
                  child: User.profilePicLink == ' '
                      ? const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 80,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(User.profilePicLink),
                        ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Employee ${User.employeeId}',
                style: textTheme.labelMedium,
              ),
            ),
            const SizedBox(height: 24),
            User.canEdit
                ? textField(
                    'First Name', 'First name', firstNameController, textTheme)
                : field('First Name', User.firstName, textTheme),
            User.canEdit
                ? textField(
                    'Last Name', 'Last name', lastNameController, textTheme)
                : field('Last Name', User.lastName, textTheme),
            User.canEdit
                ? GestureDetector(
                    onTap: () {
                      showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime.now(),
                          builder: (BuildContext context, Widget? child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: const ColorScheme.light(
                                  primary: Color.fromRGBO(2, 64, 116, 1),
                                  secondary: Color.fromRGBO(2, 64, 116, 1),
                                  onSecondary: Colors.white,
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor:
                                        const Color.fromRGBO(2, 64, 116, 1),
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          }).then((DateTime? value) {
                        setState(() {
                          birth = DateFormat('MM/dd/yyyy').format(value!);
                        });
                      });
                    },
                    child: field('Date of Birth', birth, textTheme),
                  )
                : field('Date of Birth', User.birthDate, textTheme),
            User.canEdit
                ? textField('Address', 'Address', addressController, textTheme)
                : field('Address', User.address, textTheme),
            User.canEdit
                ? GestureDetector(
                    onTap: () async {
                      String firstName = firstNameController.text;
                      String lastName = lastNameController.text;
                      String birthDate = birth;
                      String address = addressController.text;

                      if (User.canEdit) {
                        if (firstName.isEmpty) {
                          showSnackBar('Please enter your first name!');
                        } else if (lastName.isEmpty) {
                          showSnackBar('Please enter your last name!');
                        } else if (birthDate.isEmpty) {
                          showSnackBar('Please enter your birth date!');
                        } else if (address.isEmpty) {
                          showSnackBar('Please enter your address!');
                        } else {
                          await FirebaseFirestore.instance
                              .collection('Employee')
                              .doc('Rf9LKIsunYRsAt9PcEA4')
                              .update(<Object, Object>{
                            'firstName': firstName,
                            'lastName': lastName,
                            'birthDate': birthDate,
                            'address': address,
                            'canEdit': false,
                          }).then((_) {
                            setState(() {
                              User.canEdit = false;
                              User.firstName = firstName;
                              User.lastName = lastName;
                              User.birthDate = birthDate;
                              User.address = address;
                            });
                          });
                        }
                      } else {
                        showSnackBar(
                            "You can't edit anymore, please contact support team.");
                      }
                    },
                    child: Container(
                      height: kToolbarHeight,
                      width: screenw,
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: const Color.fromRGBO(2, 64, 116, 1),
                      ),
                      child: Center(
                        child: Text(
                          'SAVE',
                          style: textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget field(String title, String text, TextTheme txtTheme) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: txtTheme.labelMedium?.copyWith(
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: kToolbarHeight,
          width: screenw,
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.only(left: 11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: Colors.black54,
            ),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: txtTheme.bodyMedium?.copyWith(
                color: Colors.black54,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget textField(String title, String hint, TextEditingController controller,
      TextTheme txtTheme) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: txtTheme.labelMedium?.copyWith(
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          height: 60,
          margin: const EdgeInsets.only(bottom: 12),
          child: TextFormField(
            controller: controller,
            cursorColor: Colors.black54,
            maxLines: 1,
            decoration: InputDecoration(
              hintText: hint,
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black54,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          text,
        ),
      ),
    );
  }
}
