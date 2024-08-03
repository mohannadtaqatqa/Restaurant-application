import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart' as geo;

Future<String?> getLocation() async {
  loc.Location location = loc.Location();
  bool _serviceEnabled;
  loc.PermissionStatus _permissionGranted;
  loc.LocationData? _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return "Service not enabled";
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == loc.PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != loc.PermissionStatus.granted) {
      return "Permission denied";
    }
  }

  _locationData = await location.getLocation();
  if (_locationData.latitude != null && _locationData.longitude != null) {
    final latitude = _locationData.latitude!;
    final longitude = _locationData.longitude!;

    return _fetchAddress(latitude, longitude);
  } else {
    return "Unable to fetch location";
  }
}

Future<String?> _fetchAddress(double latitude, double longitude) async {
  try {
    List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
      latitude,
      longitude,
    );
    if (placemarks.isNotEmpty) {
      geo.Placemark place = placemarks[0];
      return "${place.locality}, ${place.administrativeArea}, ${place.country}";
    } else {
      return "Unable to fetch address";
    }
  } catch (e) {
    return "Error fetching address: $e";
  }
}
