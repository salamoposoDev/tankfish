import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tank_fish/dashboard/screens/bloc/get_device_info.dart';
import 'package:tank_fish/dashboard/screens/bloc/get_sensors_realtime_bolc.dart';
import 'package:tank_fish/firebase_options.dart';
import 'package:tank_fish/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 808),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => RealtimeSensorCubit()..getData()),
              BlocProvider(create: (context) => DeviceInfoCubit()..getData()),
            ],
            child: HomePage(),
          ),
        );
      },
    );
  }
}
