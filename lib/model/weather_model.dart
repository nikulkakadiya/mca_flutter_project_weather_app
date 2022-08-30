/*
{
"coord": {
"lon": 72.8333,
"lat": 21.1667
},
"weather": [
{
"id": 802,
"main": "Clouds",
"description": "scattered clouds",
"icon": "03d"
}
],
"base": "stations",
"main": {
"temp": 304.14,
},
"name": "Surat",

}*/
class SystemInfo{
  String? country;

  SystemInfo({this.country});

  factory SystemInfo.fromJson(Map<String,dynamic> json){
    final country=json['country'];
    return SystemInfo(country: country);
  }

}
class WeatherInfo{
  final String? main;
  final String? icon;
  final String? description;

  WeatherInfo({
    this.main,
    this.icon,
    this.description,
  });

  factory WeatherInfo.fromJson(Map<String,dynamic> json){
    final main=json['main'];
    final icon=json['icon'];
    final description=json['description'];
    return WeatherInfo(main: main,icon: icon,description: description);
  }

}
class TemperatureInfo{
  final double? temperatur;

  TemperatureInfo({this.temperatur});
  factory TemperatureInfo.fromJson(Map<String,dynamic> json){
    final temperatur=json['temp'];
    return TemperatureInfo(temperatur: temperatur);
  }
}

class WeatherResponse{
  final String? cityName;
  final TemperatureInfo? tempInfo;
  final WeatherInfo? weatherInfo;
  final SystemInfo? systemInfo;

  String get iconUrl{
    return 'https://openweathermap.org/img/wn/${weatherInfo!.icon}@2x.png';
  }

  WeatherResponse({
    this.cityName,
    this.tempInfo,
    this.weatherInfo,
    this.systemInfo,
  });

  factory WeatherResponse.fromJson(Map<String,dynamic> json){
    final cityName=json['name'];

    final systemInfoJson=json['sys'];
    final systemInfo=SystemInfo.fromJson(systemInfoJson);
    final tempInfoJson=json['main'];
    final tempInfo=TemperatureInfo.fromJson(tempInfoJson);

    final weatherInfoJson=json['weather'][0];
    final weatherInfo=WeatherInfo.fromJson(weatherInfoJson);

    return WeatherResponse(cityName: cityName,tempInfo: tempInfo,weatherInfo: weatherInfo,systemInfo: systemInfo);
  }
}