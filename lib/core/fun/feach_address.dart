import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart' as geo;

Future<String?> getLocation() async {
  loc.Location location = loc.Location();
  bool serviceEnabled;
  loc.PermissionStatus permissionGranted;
  loc.LocationData? locationData;

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return "Service not enabled";
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == loc.PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != loc.PermissionStatus.granted) {
      return "Permission denied";
    }
  }

  locationData = await location.getLocation();
  if (locationData.latitude != null && locationData.longitude != null) {
    final latitude = locationData.latitude!;
    final longitude = locationData.longitude!;

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
