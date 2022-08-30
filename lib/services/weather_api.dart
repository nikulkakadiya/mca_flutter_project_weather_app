import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../model/weather_model.dart';


class DetaService{
  // https://api.openweathermap.org/data/2.5/weather?q=surat&appid=b1014e87f26fd77af6d675fffc791d9b&units=metric

  Future<WeatherResponse> getWeather(Position position) async {
    // final queryPeramiter={'q':city,'appid':'b1014e87f26fd77af6d675fffc791d9b','units':'metric'};
    final queryPeramiter={'lat':'${position.latitude}','lon':'${position.longitude}','appid':'b1014e87f26fd77af6d675fffc791d9b','units':'metric'};

    final uri=Uri.http('api.openweathermap.org', '/data/2.5/weather',queryPeramiter);

    final response=await http.get(uri);
    print(response.body);
    final json=jsonDecode(response.body);
    return WeatherResponse.fromJson(json);
  }

  Future<WeatherResponse> getCityWeather(String city) async {
    final queryPeramiter={'q':city,'appid':'b1014e87f26fd77af6d675fffc791d9b','units':'metric'};
    // final queryPeramiter={'lat':'${position.latitude}','lon':'${position.longitude}','appid':'b1014e87f26fd77af6d675fffc791d9b','units':'metric'};

    final uri=Uri.http('api.openweathermap.org', '/data/2.5/weather',queryPeramiter);

    final response=await http.get(uri);
    print(response.body);
    final json=jsonDecode(response.body);
    return WeatherResponse.fromJson(json);
  }
}