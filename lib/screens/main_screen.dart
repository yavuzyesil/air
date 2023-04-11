import 'search_screen.dart';
import '../services/location_services.dart';
import '../services/weather_service.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  dynamic data;
  int temp = 0;
  dynamic city = "NOT FOUND";
  String country = "NOT FOUND";
  String weatherIcon = "NOT FOUND";
  String weatherMessage = "NOT FOUND";
  int condition = 0;
  final sMarPad = const EdgeInsets.all(8.0);
  late final double height;
  WeatherService weatherService = WeatherService();
  LocationService locationService = LocationService();
  TextStyle? bottomTextStyle;
  TextStyle? middleTextStyle;
  final iconCoord = const Icon(Icons.location_on);
  final iconCity = const Icon(Icons.location_city);

  final bgroundImage = const BoxDecoration(
    image: DecorationImage(
      image: AssetImage("images/location_background.jpg"),
      fit: BoxFit.fitHeight,
    ),
  );
  @override
  void initState() {
    super.initState();
    starter();
  }

  starter() async {
    await locationService.getLocation();
    data = await weatherService.getLocationFromCoord();
    updateUI(data: data);
  }

  void updateUI({required dynamic data}) async {
    this.data = data;
    double temp2 = data["main"]["temp"];
    setState(() {
      temp = temp2.toInt();
      city = data["name"];
      condition = data['weather'][0]['id'];
      weatherIcon = weatherService.getWeatherIcon(condition);
      weatherMessage = weatherService.getMessage(temp);
    });
  }

  void cityAir() async {
    city = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SearchScreen()));
    debugPrint("$city Empty city");
    WeatherService weatherService = WeatherService();
    if (city != "") {
      weatherService.city = city;
      data =
          await weatherService.getLocationFromInput(city: weatherService.city);
      debugPrint("$data empty map data");
      if (data != null && data is Map) {
        setState(() {
          updateUI(data: data);
        });
      } else {
        setState(() {
          temp = 0;
          city = "NOT FOUND";
          condition = 0;
          weatherIcon = "NOT FOUND";
          weatherMessage = "NOT FOUND";
        });
      }
    } else {
      setState(() {
        temp = 0;
        city = "NOT FOUND";
        condition = 0;
        weatherIcon = "NOT FOUND";
        weatherMessage = "NOT FOUND";
      });
    }
  }

  void coordAir() async {
    WeatherService weatherService = WeatherService();
    data = await weatherService.getLocationFromCoord();
    setState(() {
      updateUI(data: data);
    });
  }

  @override
  Widget build(BuildContext context) {
    bottomTextStyle = Theme.of(context)
        .textTheme
        .displayMedium
        ?.copyWith(fontWeight: FontWeight.bold);
    middleTextStyle = Theme.of(context).textTheme.displayMedium?.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: MediaQuery.of(context).size.height * 0.16);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          decoration: bgroundImage,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      iconSize: MediaQuery.of(context).size.height * 0.08,
                      icon: iconCoord,
                      onPressed: coordAir),
                  IconButton(
                      iconSize: MediaQuery.of(context).size.height * 0.08,
                      icon: iconCity,
                      onPressed: cityAir),
                ],
              ),
              Padding(
                padding: sMarPad,
                child: Text("$temp° $weatherIcon",
                    textAlign: TextAlign.center, style: middleTextStyle),
              ),
              Text(
                "$weatherMessage in $city",
                textAlign: TextAlign.end,
                style: bottomTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
