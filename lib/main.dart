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

  DioHelper.init();
  runApp(const MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            home: OnBoardingScreen(),
          );
        },
      ),
    );
  }
}
