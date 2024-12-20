import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_fit/core/cache/cache_helper.dart';
import 'package:healthy_fit/core/routes/router.dart';
import 'package:healthy_fit/core/utils/bloc_observer.dart';
import 'package:healthy_fit/features/auth/presentation/cubit/auth_cubit.dart';

import 'core/api/dio_consumer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
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
          return BlocProvider(
            create: (context) => AuthCubit(DioConsumer(dio: Dio())),
            child: MaterialApp.router(
              title: 'Healthy Fit',
              routerConfig: router,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                useMaterial3: true,
                textTheme: Theme.of(context).textTheme.apply(
                      fontFamily: 'Poppins',
                    ),
              ),
            ),
          );
        });
  }
}
