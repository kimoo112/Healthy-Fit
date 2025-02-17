import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_fit/core/cache/cache_helper.dart';
import 'package:healthy_fit/core/routes/router.dart';
import 'package:healthy_fit/core/utils/app_colors.dart';
import 'package:healthy_fit/core/utils/bloc_observer.dart';
import 'package:healthy_fit/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:healthy_fit/features/home/cubit/home_cubit.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/api/dio_consumer.dart';
import 'features/notes/presentation/cubit/notes_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Hive.initFlutter();
  await Hive.openBox('nutritionBox');
  Bloc.observer = MyBlocObserver();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const HealthyFit());
}

class HealthyFit extends StatelessWidget {
  const HealthyFit({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AuthCubit(DioConsumer(dio: Dio())),
              ),
              BlocProvider(
                create: (context) => HomeCubit(DioConsumer(dio: Dio())),
              ),
              BlocProvider(
                create: (context) => NotesCubit()..fetchNotes(),
              )
            ],
            child: MaterialApp.router(
              title: 'Healthy Fit',
              routerConfig: router,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                textSelectionTheme: TextSelectionThemeData(
                    selectionColor: AppColors.primaryColor,
                    selectionHandleColor: AppColors.primaryColor),
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
