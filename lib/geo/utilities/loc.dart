@JS('navigator.geolocation')
library jslocation;

import 'package:js/js.dart';

@JS('getCurrentPosition') //Geolocation API's getCurrentPosition
// ignore: use_function_type_syntax_for_parameters
external void getCurrentPosition(Function success(Geoposition pos));

@JS()
@anonymous
class GeolocationCoordinates {
  external factory GeolocationCoordinates({
    double latitude,
    double longitude,
  });

  external double get latitude;
  external double get longitude;
}

@JS()
@anonymous
class Geoposition {
  external factory Geoposition({GeolocationCoordinates coords});

  external GeolocationCoordinates get coords;
}
