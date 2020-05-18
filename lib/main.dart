import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/country_provider.dart';
import 'package:sample/provider/daily_provider.dart';
import 'package:sample/provider/home_provider.dart';
import 'package:sample/provider/province_provider.dart';
import 'package:sample/ui/screen/home_views.dart';

void main() => runApp(MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => CountryProvider()),
        ChangeNotifierProvider(create: (_) => ProvinceProvider()),
        ChangeNotifierProvider(create: (_) => DailyProvince())
], child: MyApp(),));

class MyApp extends StatelessWidget{
  @override
  
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Covid19 Statictik",
      theme: ThemeData(
         primarySwatch: Colors.deepPurple,
      ),
      home: HomePage(),
    );
  }
}