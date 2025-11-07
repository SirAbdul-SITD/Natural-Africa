import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:natural_africa/services/data_service.dart';
import 'package:natural_africa/providers/favorites_provider.dart';
import 'package:natural_africa/screens/splash_screen.dart';
import 'package:natural_africa/screens/home_screen.dart';
import 'package:natural_africa/screens/country_list_screen.dart';
import 'package:natural_africa/screens/country_detail_screen.dart';
import 'package:natural_africa/screens/resource_list_screen.dart';
import 'package:natural_africa/screens/resource_detail_screen.dart';
import 'package:natural_africa/screens/favorites_screen.dart';
import 'package:natural_africa/screens/search_screen.dart';
import 'package:natural_africa/screens/about_screen.dart';
import 'package:natural_africa/screens/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dataService = DataService();
  await dataService.loadAll(); // load JSON assets
  runApp(MyApp(dataService: dataService));
}

class MyApp extends StatelessWidget {
  final DataService dataService;
  const MyApp({required this.dataService, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DataService>.value(value: dataService),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: MaterialApp(
        title: 'Natural Africa',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1A5E2B)),
          useMaterial3: true,
          textTheme: Typography.material2018().black,
        ),
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (_) => const SplashScreen(),
          HomeScreen.routeName: (_) => const HomeScreen(),
          CountryListScreen.routeName: (_) => const CountryListScreen(),
          CountryDetailScreen.routeName: (_) => const CountryDetailScreen(),
          ResourceListScreen.routeName: (_) => const ResourceListScreen(),
          ResourceDetailScreen.routeName: (_) => const ResourceDetailScreen(),
          FavoritesScreen.routeName: (_) => const FavoritesScreen(),
          SearchScreen.routeName: (_) => const SearchScreen(),
          AboutScreen.routeName: (_) => const AboutScreen(),
          SettingsScreen.routeName: (_) => const SettingsScreen(),
        },
      ),
    );
  }
}
