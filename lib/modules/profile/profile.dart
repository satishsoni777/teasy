import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:take_it_easy/components/app_button.dart';
import 'package:take_it_easy/components/loader_widget.dart';
import 'package:take_it_easy/di/di_initializer.dart';
import 'package:take_it_easy/modules/authentication/model/gmail_user_data.dart';
import 'package:take_it_easy/storage/shared_storage.dart';
import 'package:take_it_easy/style/font.dart';
import 'package:take_it_easy/style/spacing.dart';

import '../../flutter_auth.dart';

class UserProfile extends StatelessWidget with FlutterAtuh {
  const UserProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<GmailUserData>(
          future: DI.inject<SharedStorage>().getUserData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return ProgressLoader();
            } else {
              final data = snapshot.data;
              return _body(context, gmailUserData: data);
            }
          }),
    );
  }

  Widget _body(BuildContext context, {GmailUserData gmailUserData}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 60.0,
          ),
          _profileFace(gmailUserData.photoURL),
          SizedBox(
            height: 30.0,
          ),
          Text(
            gmailUserData.displayName,
            style: const TextStyle(fontSize: FontSize.title),
          ),
          Text(gmailUserData.email ?? ''),
          Text(gmailUserData.phoneNumber ?? ''),
          const Spacer(),
          _logOutCta()
        ],
      ),
    );
  }

  Widget _profileFace(String url) {
    return Container(
      child: CircleAvatar(
        maxRadius: 50.0,
        backgroundImage: NetworkImage(url),
      ),
    );
  }

  Widget _logOutCta() {
    return Padding(
      padding: const EdgeInsets.all(Spacing.marginLarge),
      child: AppButton(
        onPressed: () {
          logOut();
        },
        buttonType: ButtonType.Border,
        text: "Log out",
      ),
    );
  }
}
