import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/additionalInformation.dart';
import 'package:weather_app/secretKey.dart';
import 'package:weather_app/weatherForecast.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Map<String, dynamic>> weather;
  Future<Map<String, dynamic>> getcurrentWeather() async {
    try {
      String cityName = "Pattukkottai";
      final res = await http.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$openweatherAPI",
        ),
      );

      final data = jsonDecode(res.body);
      if (data['cod'].toString() != "200") {
        //print("Erro: ${res.body}");
        throw 'An unexpected error occured';
      }

      return data;

      //data['main']['temp'];
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    weather = getcurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.red),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                weather = getcurrentWeather();
              });
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),

      body: FutureBuilder(
        future: weather,
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final data = snapshot.data!;
          final currentweatherData = data['list'][0];

          final currentTemp = currentweatherData['main']['temp'];

          final currentSky = currentweatherData['weather'][0]['main'];
          final currentPressure = currentweatherData['main']['pressure'];
          final currentWind = currentweatherData['wind']['speed'];
          final currentHumidity = currentweatherData['main']['humidity'];
          final currentsea_level = currentweatherData['main']['sea_level'] ?? 0;
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),

                child: Column(
                  children: [
                    //Main content
                    Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),

                          child: Column(
                            children: [
                              SizedBox(width: double.infinity, height: 10),
                              Text(
                                '$currentTemp K',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Icon(
                                currentSky == 'Clouds' || currentSky == "Rain"
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 62,
                              ),
                              SizedBox(height: 10),
                              Text(currentSky, style: TextStyle(fontSize: 24)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),

                    //second contetn
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Weather ForeCast",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    //another approach:

                    // Padding(
                    //   padding: const EdgeInsets.all(5.0),
                    //   child: SingleChildScrollView(
                    //     scrollDirection: Axis.horizontal,
                    //     child: Row(
                    //       children: [
                    //         //SizedBox(height: 20),
                    //         //second-first part
                    //         for (int i = 0; i < 39; i++)
                    //           WeatherForecast(
                    //             time: data['list'][i + 1]['dt'].toString(),
                    //             icon:
                    //                 data['list'][i + 1]['weather'][0]['main'] ==
                    //                         'Clouds' ||
                    //                     data['list'][i +
                    //                             1]['weather'][0]['main'] ==
                    //                         'Rain'
                    //                 ? Icons.cloud
                    //                 : Icons.sunny,
                    //             degree: data['list'][i+1]['main']['temp'].toString(),
                    //           ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    //another approach:
                    SizedBox(
                      height: 140,
                      child: ListView.builder(
                        itemCount: 30,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final weatherData = data['list'][index + 1];
                          final hourlySky =
                              data['list'][index + 1]['weather'][0]['main'];
                          final hourlyTemp = weatherData['main']['temp']
                              .toString();
                          final time = DateTime.parse(
                            weatherData['dt_txt'].toString(),
                          );
                          return WeatherForecast(
                            time: DateFormat.j().format(time),
                            degree: hourlyTemp,
                            icon: hourlySky == 'Clouds' || hourlySky == 'Rain'
                                ? Icons.cloud
                                : Icons.sunny,
                          );
                        },
                      ),
                    ),

                    //third part
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Additional Information",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    //SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: SizedBox(
                        height: 150,
                        child: ListView(
                          scrollDirection: Axis.horizontal,

                          children: [
                            AdditionalInformation(
                              icon: Icons.water_drop,
                              label: "Humidity",
                              value: currentHumidity.toString(),
                            ),
                            SizedBox(width: 25),
                            AdditionalInformation(
                              icon: Icons.air,
                              label: "Wind Speed",
                              value: currentWind.toString(),
                            ),

                            SizedBox(width: 25),
                            AdditionalInformation(
                              icon: Icons.beach_access,
                              label: "Pressure",
                              value: currentPressure.toString(),
                            ),
                            SizedBox(width: 25),
                            AdditionalInformation(
                              icon: Icons.waterfall_chart,
                              label: "Sea Level",
                              value: currentsea_level.toString(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
