import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsapi_01/layout/news_app/news_cubit/cubit.dart';
import 'package:newsapi_01/layout/news_app/theme_cubit/theme_cubit.dart';
import 'package:newsapi_01/layout/news_app/theme_cubit/theme_states.dart';
import 'package:newsapi_01/shared/bloc_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapi_01/shared/network/local/cache_helper.dart';
import 'package:newsapi_01/shared/network/remote/dio_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'layout/news_app/news_cubit/states.dart';
import 'modules/splash_page.dart';

Database? dataBase;

Future<void> main() async {
  // next line to make sure each finished and then run the app
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'darkMode');

  runApp(MyApp(isDark));

  BlocOverrides.runZoned(
    () {},
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  late final bool? isDark;

  MyApp(this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ThemeCubit()..changeThemeMode(isDark: isDark),
          ),
          BlocProvider(
              create: (BuildContext context) => NewsCubit()
                ..getBusiness()
                ..getSports()
                ..getScience()
                ..getPolitic()
                ..getFavorite()
                ..createDatabase()),
        ],
        child: BlocConsumer<ThemeCubit, ThemeStates>(
          listener: (context, state) {
            if (state is AppInsertDatabaseState) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            print('isdark inside build  in main ${isDark.toString()}');

            print(
                'darkmode inside build  in main ${ThemeCubit.get(context).darkMode.toString()}');
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Directionality(
                textDirection: TextDirection.rtl,
                child: SplashScreen(),
              ),
              theme: ThemeData(
                primarySwatch: Colors.deepOrange,
                appBarTheme: AppBarTheme(
                  iconTheme: IconThemeData(color: Colors.deepOrange),
                  titleSpacing: 16,
                  actionsIconTheme: IconThemeData(color: Colors.deepOrange),
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark),
                  titleTextStyle: TextStyle(
                      fontFamily: 'Cairo',
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                scaffoldBackgroundColor: Colors.white,
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.deepOrange,
                    backgroundColor: Colors.white,
                    unselectedItemColor: Colors.grey,
                    elevation: 20),
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                  wordSpacing: 0.5,
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Cairo',
                )),
              ),
              darkTheme: ThemeData(
                primarySwatch: Colors.deepOrange,
                appBarTheme: AppBarTheme(
                  iconTheme: IconThemeData(color: Colors.white),
                  titleSpacing: 16,
                  actionsIconTheme: IconThemeData(color: Colors.white),
                  backgroundColor: HexColor('333739'),
                  elevation: 0.0,
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: HexColor('333739'),
                      statusBarIconBrightness: Brightness.light),
                  titleTextStyle: TextStyle(
                      fontFamily: 'Cairo',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                scaffoldBackgroundColor: HexColor('333739'),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.deepOrange,
                    backgroundColor: HexColor('333739'),
                    unselectedItemColor: Colors.grey,
                    elevation: 20),
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Cairo',
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                ),
              ),
              themeMode: ThemeCubit.get(context).darkMode
                  ? ThemeMode.dark
                  : ThemeMode.light,
            );
          },
        ));
  }
}
