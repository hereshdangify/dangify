import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_test/backend/services/my_audio_handler.dart';
import 'package:my_test/helpers/theme_helper.dart';
import 'package:my_test/modules/home/pages/home_page.dart';

MyAudioHandler myAudioHandler = MyAudioHandler();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  myAudioHandler = await AudioService.init(
    builder: () => MyAudioHandler(),
    config: AudioServiceConfig(
      androidNotificationChannelId: 'com.dangify.music',
      androidNotificationChannelName: 'dangify music player',
      androidNotificationOngoing: true,
      androidShowNotificationBadge: true,
    ),
  );

  runApp(MainWidget());
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MainWidget extends StatelessWidget {
  MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(
      init: ThemeHelper(),
      builder: (controller) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'dangify',
          theme: controller.defaultTheme,
          home: Scaffold(
            body: HomePage(),
          ),
        );
      },
    );
  }
}
