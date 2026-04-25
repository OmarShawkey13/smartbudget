import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbudget/core/di/injections.dart';
import 'package:smartbudget/core/network/local/cache_helper.dart';
import 'package:smartbudget/core/theme/theme.dart';
import 'package:smartbudget/core/utils/constants/my_bloc_observer.dart';
import 'package:smartbudget/core/utils/constants/routes.dart';
import 'package:smartbudget/core/utils/cubit/home_cubit.dart';
import 'package:smartbudget/core/utils/cubit/home_state.dart';
import 'package:smartbudget/firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInjections();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = MyBlocObserver();
  final bool isDark = CacheHelper.getData(key: 'isDark') ?? false;
  runApp(MyApp(isDark: isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;

  const MyApp({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeCubit>()..changeTheme(fromShared: isDark),
      child: BlocBuilder<HomeCubit, HomeStates>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            routes: Routes.routes,
            initialRoute: Routes.entry,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: HomeCubit.get(context).isDarkMode
                ? ThemeMode.dark
                : ThemeMode.light,
          );
        },
      ),
    );
  }
}
