import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_fit/core/routes/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp.router(
            title: 'Healthy Fit',
            routerConfig: router,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              textTheme: Theme.of(context).textTheme.apply(
                    fontFamily: 'Poppins',
                  ),
            ),
          );
        });
  }
}
