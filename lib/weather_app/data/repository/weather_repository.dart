import 'dart:convert';
import 'package:bloc_tutorial/weather_app/data/data_provider/weather_data_provider.dart';
import 'package:bloc_tutorial/weather_app/models/weather_model.dart';

class WeatherRepository {
  final WeatherDataProvider weatherDataProvider;
  WeatherRepository(this.weatherDataProvider);

  Future<WeatherModel> getCurrentWeather() async {
    try {
      String cityName = 'London';
      final weatherData = await weatherDataProvider.getCurrentWeather(cityName);

      final data = jsonDecode(weatherData);
      print(data['cod']);
      if (data['cod'] != 200) {
        throw "An unexpetced error occured";
      }

      return WeatherModel.fromJson(weatherData);
    } catch (e) {
      throw e.toString();
    }
  }
}
