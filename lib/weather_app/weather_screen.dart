import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc_tutorial/weather_app/components/weather_card.dart';
import 'package:bloc_tutorial/weather_app/components/weather_forecast_item.dart';
import 'package:bloc_tutorial/weather_app/components/weather_temp_top_view.dart';
import 'package:flutter/material.dart';

const OPEN_WEATHER_API_KEY = "c894335f9060dd4919b86b83754ca81e";

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String cityName = "London";
  late Future<Map<String, dynamic>> weather;
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      final result = await http.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$cityName,uk&APPID=$OPEN_WEATHER_API_KEY",
        ),
      );
      print(result.body);

      final data = jsonDecode(result.body);
      print(data['cod']);
      if (data['cod'] != 200) {
        throw "An unexpetced error occured";
      }

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    weather = getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    const double maxColumnWidth = 500.0;
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: maxColumnWidth,
        ),
        child: FutureBuilder(
            future: getCurrentWeather(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              final data = snapshot.data!;
              final currentTemp = data['main']['temp'];
              final pressure = data['main']['pressure'];
              final humidity = data['main']['humidity'];
              final windSpeed = data['wind']['speed'];
              final tempMin = data['main']['temp_min'];
              final tempMax = data['main']['temp_max'];
              final statusWeather = data['weather'][0]['main'];
              final description = data['weather'][0]['description'];
              print("status $statusWeather");
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WeaherTempTopView(
                      currentTemp: currentTemp,
                      tempMin: tempMin,
                      tempMax: tempMax,
                      statusWeather: "$statusWeather - $description",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Weather Forecast",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(width: 16),
                            // ...List.generate(
                            //   30,
                            //   (index) => Padding(
                            //     padding: const EdgeInsets.only(right: 16.0),
                            //     child: WeatherCard(),
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 120,
                            //   child: ListView.builder(
                            //       scrollDirection: Axis.horizontal,
                            //       itemCount: 10,
                            //       itemBuilder: (context, index) {
                            //         return WeatherCard();
                            //       }),
                            // ),
                            SizedBox(width: 16),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return const WeatherCard();
                          }),
                    ),
                    const Text(
                      "Additional Information",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        WeatherForecastItem(
                            textInfo: "$humidity",
                            icon: Icons.water_drop,
                            textValue: "Huminidty"),
                        WeatherForecastItem(
                            textInfo: "$windSpeed",
                            icon: Icons.storm_rounded,
                            textValue: "Wind Speed"),
                        WeatherForecastItem(
                            textInfo: "$pressure",
                            icon: Icons.umbrella,
                            textValue: "Pressure")
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Placeholder(
                      fallbackHeight: 150,
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
