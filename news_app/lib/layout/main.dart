import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:news_app/layout/homeScreen.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cacheHelper.dart';
import 'package:news_app/shared/network/remote/dioHelper.dart';
import 'package:news_app/shared/observer/blocObserver.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp( {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool? isDark = CacheHelper.getDark(key: 'isDark');
    return BlocProvider(
      create: (context) => NewsCubit()..getBusiness()..changeTheme(
          fromShared: isDark ,
      ),
      child: BlocConsumer<NewsCubit,NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          NewsCubit cubit = NewsCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              primarySwatch: Colors.deepOrange,
              appBarTheme: const AppBarTheme(
                elevation: 0,
                titleSpacing: 20,
                iconTheme: IconThemeData(
                  color: Colors.black54,
                ),
                color: Colors.white,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarBrightness: Brightness.light,
                ),
              ),
              scaffoldBackgroundColor: Colors.white,
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                unselectedItemColor: Colors.grey,
                type: BottomNavigationBarType.fixed,
                selectedLabelStyle: TextStyle(
                  color: Colors.grey,
                ),
                selectedItemColor: Colors.deepOrange,
                elevation: 50,
              ),
            ),
            darkTheme:ThemeData(
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              primarySwatch: Colors.deepOrange,
              appBarTheme: AppBarTheme(
                elevation: 0,
                titleSpacing: 20,
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
                color: HexColor('3c3f41'),
                titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('3c3f41'),
                  statusBarBrightness: Brightness.dark,
                ),
              ),
              scaffoldBackgroundColor: HexColor('3c3f41'),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                unselectedItemColor: Colors.grey,
                backgroundColor: HexColor('3c3f41'),
                type: BottomNavigationBarType.fixed,
                selectedLabelStyle: const TextStyle(
                  color: Colors.grey,
                ),
                selectedItemColor: Colors.deepOrange,
                elevation: 50,
              ),
            ),
            themeMode: cubit.isDark==true? ThemeMode.dark : ThemeMode.light,
            home:  const HomeScreen(),
          );
        },
      ),
    );
  }
}
