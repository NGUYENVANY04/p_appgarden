import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:p_appgarden/noti_overlay.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:p_appgarden/data/dataTempApi.dart';
import 'package:p_appgarden/home.dart';
import 'package:p_appgarden/widget/temp_widget/widget_temp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyDPhwsq3aEL3LrniauOpBhdIvTDCXR772s',
        appId: '1:1012124243868:android:9831380cb461213d1d5a59',
        messagingSenderId: '1012124243868',
        projectId: 'giahuy-7d9bc',
        databaseURL: 'https://giahuy-7d9bc-default-rtdb.firebaseio.com',
        storageBucket: 'giahuy-7d9bc.firebasestorage.app',
      ),
    );
    print("Firebase initialized without exceptions.");
  } catch (e) {
    print(e.toString());
  }

  Provider.debugCheckInvalidValueType = null;
  runApp(const MyApp());
}

@pragma("vm:entry-point")
void overlayMain() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TrueCallerOverlay(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    getTempData();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Temperature>(
          create: (_) => Temperature(),
          child: const InfoWidgetTemp(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: MyHome(),
        ),
      ),
    );
  }
}

Future<void> getTempData() async {
  // Request overlay permission if not already granted
  final bool status = await FlutterOverlayWindow.isPermissionGranted();
  if (!status) {
    await FlutterOverlayWindow.requestPermission();
  }

  try {
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('temp');
    starCountRef.onValue.listen(
      (DatabaseEvent event) async {
        final dynamic data = event.snapshot.value;

        if (data != null) {
          final double temperature = double.tryParse(data.toString()) ?? 0.0;

          log("Temperature: $temperature");

          if (temperature > 37) {
            ringNoti();
            FlutterOverlayWindow.showOverlay(
              enableDrag: true,
              overlayTitle: "X-SLAYER",
              overlayContent: 'Overlay Enabled',
              flag: OverlayFlag.defaultFlag,
              visibility: NotificationVisibility.visibilityPublic,
              positionGravity: PositionGravity.auto,
              height: 600,
              width: WindowSize.matchParent,
            );
          } else {
            stopRingtone();
          }
        } else {
          log("Temperature data is null.");
        }
      },
    );
  } catch (e) {
    log("Error in getTempData: ${e.toString()}");
  }
}

void ringNoti() {
  // Play a custom warning ringtone
  FlutterRingtonePlayer().play(
    fromAsset: "assets/audios/warning.wav",
    ios: IosSounds.glass,
    looping: true, // Android only - API >= 28
    volume: 1, // Android only - API >= 28
    asAlarm: false, // Android only - all APIs
  );
}

void stopRingtone() {
  // Stop the ringtone
  FlutterRingtonePlayer().stop();
}
