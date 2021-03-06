import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_it_easy/di/di_initializer.dart';
import 'package:take_it_easy/modules/authentication/view/auth.dart';
import 'package:take_it_easy/modules/dialer/dialer.dart';
import 'package:take_it_easy/modules/home/home.dart';
import 'package:take_it_easy/modules/landing_page/landing_bloc/landing_page_bloc.dart';
import 'package:take_it_easy/modules/landing_page/landing_page.dart';
import 'package:take_it_easy/modules/video_call/video_call.dart';
import 'package:take_it_easy/modules/voice_call/voice_call.dart';
import 'package:take_it_easy/storage/shared_storage.dart';
import 'package:take_it_easy/utils/string_utils.dart';

class Routes {
  static const videoCall = '/video_call';
  static const voiceCall = '/voice_call';
  static const createStreamData = '/CreateStreamData';
  static const home = '/home';
  static const auth = '/auth';
  static const landingPage = '/landing_page';
  static const dialer = '/dialer';
  static onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case auth:
        return MaterialPageRoute(builder: (c) {
          return Authentication();
        });
      case home:
        return MaterialPageRoute(builder: (c) {
          return HomePage();
        });
      case dialer:
        return MaterialPageRoute(builder: (c) => Dialer());
    }
  }

  static onUnknownRoute(RouteSettings settings) {}

  static Map<String, Widget Function(BuildContext context)> getRoutes() => {
        Routes.voiceCall: (context) => VoiceCall(),
        Routes.videoCall: (context) => VideoCall(),
        Routes.home: (C) => HomePage(),
        Routes.auth: (C) => Authentication(),
        Routes.landingPage: (c) => BlocProvider<LandingPageBloc>(
              create: (c) => LandingPageBloc(),
              child: LandingPage(),
            )
      };
  static Future<String> get initialRoute async {
    final route = await DI.inject<SharedStorage>().getInitialRoute();
    if (isNullOrEmpty(route)) {
      return auth;
    } else
      return route;
  }
}
