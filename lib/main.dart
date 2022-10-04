import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'shared/components/constants.dart';
import 'shared/cubit/appcubit_cubit.dart';
import 'shared/cubit/appcubit_state.dart';
import 'shared/network/local/cahch_helper.dart';
import 'shared/styles/themes.dart';

import 'layout/layout_screen.dart';
import 'modules/login/login_screen.dart';
import 'modules/on_boarding_screen/on_boarding_screen.dart';
import 'shared/bloc_observer.dart';
import 'shared/network/remote/dio_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  bool isdark = CacheHelper.getData(key: 'isDark') ?? false;
  bool onBoarding = CacheHelper.getData(key: 'onBoarding') ?? false;
  Widget widget;
  token = CacheHelper.getData(key: 'token') ?? '';

  // ignore: unnecessary_null_comparison
  if (onBoarding != null) {
    if (token.isNotEmpty) {
      widget = const LayoutScreen();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }

  DioHelper.init();
  runApp(MyApp(
    startWidget: widget,
    isdark: isdark,
  ));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.startWidget, this.isdark}) : super(key: key);

  final Widget startWidget;
  bool? isdark;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AppCubit()..changeAppMode(fromShared: isdark)),
        // BlocProvider(
        //     create: (context) => ShopappCubit()
        //       ..getHomeData()
        //       ..getCategoriesData()
        //       ..getFavourites()
        //       ..getUserData()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: AppCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: startWidget);
        },
      ),
    );
  }
}
