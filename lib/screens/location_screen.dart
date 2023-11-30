// ignore_for_file: unused_local_variable

import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import '../services/weather.dart';
import '../utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  static const String id = 'LocationScreen';
  final locationWeather;
  const LocationScreen(this.locationWeather, {super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  double? temp;
  int? condition;
  String? cityName;

  @override
  void initState() {
    updateUI(widget.locationWeather);
    super.initState();
  }

  updateUI(dynamic weatherData) {
    temp = weatherData['main']["temp"];
    condition = weatherData['weather'][0]['id'];
    cityName = weatherData['name'];
  }

  @override
  Widget build(BuildContext context) {
    WeatherModel weatherModel = WeatherModel();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                        onPressed: () async {
                          var weatherNewData =
                              await weatherModel.getLocationWeather();
                          setState(() {
                            if (weatherNewData == null) {
                              temp = 0;
                            } else {
                              temp = weatherNewData['main']["temp"];
                              condition = weatherNewData['weather'][0]['id'];
                              cityName = weatherNewData['name'];
                            }
                          });
                        },
                        child: const Icon(
                          Icons.near_me,
                          color: Colors.white,
                          size: 50.0,
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          var typedName =
                              await Navigator.pushNamed(context, CityScreen.id);
                          if (typedName != null) {
                            var weaterData = await weatherModel
                                .getCityWeather(typedName.toString());
                            print(weaterData);
                            setState(() {
                              temp = weaterData['main']["temp"];
                              condition = weaterData['weather'][0]['id'];
                              cityName = weaterData['name'];
                            });
                          }
                        },
                        child: const Icon(
                          Icons.location_city,
                          color: Colors.white,
                          size: 50.0,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '${(temp! - 273.15).toInt()}°',
                          style: kTempTextStyle,
                        ),
                        Text(
                          weatherModel.getWeatherIcon(condition!),
                          style: kConditionTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text(
                      '${weatherModel.getMessage(temp!.toInt())} in $cityName',
                      textAlign: TextAlign.right,
                      style: kMessageTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
