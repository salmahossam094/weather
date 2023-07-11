import 'package:dio/dio.dart';
import 'package:location/location.dart';
import 'package:weather_app/models/CurrentResponseModel.dart';
import 'package:weather_app/models/ForecastModel.dart';
import 'package:weather_app/shared/constants/constants.dart';

class ApiManager {
  Dio dio = Dio();

  Future<CurrentResponseModel> getCurrentWeather(
      LocationData locationData) async {
    var response = await dio.get('$apiBase$currentEndpoint', queryParameters: {
      "appid": apiKey,
      "lon": locationData.longitude,
      "lat": locationData.latitude,
      "units": "metric"
    });
    if (response.statusCode == 200) {
      return CurrentResponseModel.fromJson(response.data);
    } else {
      throw Exception('Bad Request');
    }
  }

  Future<ForecastModel> getForecast({required num lat,required num lon}) async {
    var response = await dio.get('$apiBase$forecastEndpoint', queryParameters: {
      "appid": apiKey,
      "lon": lon,
      "lat": lat,
      "units": "metric"
    });

      return ForecastModel.fromJson(response.data);

  }
}
