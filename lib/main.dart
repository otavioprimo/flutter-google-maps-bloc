import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:google_maps/util/colors.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import 'package:google_maps/bloc/map_bloc.dart';
import 'package:google_maps/bloc/geolocation_bloc.dart';

import 'package:google_maps/views/tabs.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Color(AppColors.backgroundColor2));
    FlutterStatusbarcolor.setNavigationBarColor(
        Color(AppColors.backgroundColor2));
    return BlocProvider(
      bloc: MapBloc(),
      child: BlocProvider(
        bloc: GeolocationBloc(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Maps',
          home: Tabs(),
        ),
      ),
    );
  }
}
