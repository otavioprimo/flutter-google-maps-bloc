import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:location/location.dart';
import 'package:google_maps/models/userLocation.dart';

class GeolocationBloc implements BlocBase {
  UserLocation userLocation;

  final StreamController<UserLocation> _userLocationController =
      StreamController<UserLocation>();

  Stream<UserLocation> get outUserLocation => _userLocationController.stream;

  GeolocationBloc() {
    _getUserLocation();
  }

  _getUserLocation() {
    try {
      var location = new Location();
      location.getLocation().then((coords) {
        userLocation = UserLocation(
          latitude: coords.latitude,
          longitude: coords.longitude,
        );

        _userLocationController.sink.add(userLocation);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _userLocationController.close();
  }
}
