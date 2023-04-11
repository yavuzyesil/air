import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final sMarPad = const EdgeInsets.all(8.0);
  TextStyle? smallBottomTextStyle;
  String? city = "";
  final getWeather = "Get Weather";
  final bgroundImage = const BoxDecoration(
      image: DecorationImage(
    image: AssetImage("images/city_background.jpg"),
    fit: BoxFit.fitHeight,
  ));

  @override
  Widget build(BuildContext context) {
    smallBottomTextStyle = Theme.of(context)
        .textTheme
        .displaySmall
        ?.copyWith(fontWeight: FontWeight.bold);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: sMarPad,
          decoration: bgroundImage,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  IconButton(
                    iconSize: MediaQuery.of(context).size.height * 0.08,
                    icon: const Icon(Icons.chevron_left),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Container(
                margin: sMarPad,
                child: TextFormField(
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.black),
                  onChanged: (value) {
                    setState(() {
                      city = value;
                    });
                  },
                  decoration: inputDecoration(context),
                ),
              ),
              Padding(
                padding: sMarPad,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context, city);
                  },
                  child: Text(getWeather,
                      textAlign: TextAlign.center, style: smallBottomTextStyle),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration inputDecoration(BuildContext context) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(24.0),
      icon: Icon(
        Icons.location_city_rounded,
        color: Colors.white,
        size: MediaQuery.of(context).size.height * 0.08,
      ),
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: BorderSide.none,
      ),
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide.none),
      hintText: 'City',
      hintStyle: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(color: Colors.black, fontWeight: FontWeight.w400),
    );
  }
}
