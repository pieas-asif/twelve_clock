import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:twelve_clock/services/weather.dart';
import 'dart:core';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String hour = "00";
  String minute = "00";
  String date = "";
  String temp = "";

  @override
  void initState() {
    super.initState();
    _getWeather();
    Timer.periodic(Duration(seconds: 1), (timer) => _getTime());
    Timer.periodic(Duration(minutes: 30), (timer) => _getWeather());
  }

  void _getTime() {
    setState(() {
      hour = DateFormat('kk').format(DateTime.now()).toString();
      minute = DateFormat('mm').format(DateTime.now()).toString();
      date = DateFormat('EEE, MMM dd').format(DateTime.now()).toString();
    });
  }

  void _getWeather() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getLocationWeather();
    setState(() {
      temp = weatherData["main"]["temp"].round().toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background-1.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: screenWidth * .65,
                padding: EdgeInsets.only(top: screenHeight * .2),
                child: DateWidget(
                  date: date,
                  temp: temp,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: screenHeight * .1),
                child: ClockWidget(
                  hour: hour,
                  minute: minute,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ClockWidget extends StatelessWidget {
  final String hour;
  final String minute;

  const ClockWidget({Key key, @required this.hour, @required this.minute})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            hour,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 192,
              height: .9,
              color: Color(0xFFD6AFAF),
            ),
          ),
          Text(
            minute,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 192,
              height: .9,
              color: Color(0xFFD6AFAF),
            ),
          ),
        ],
      ),
    );
  }
}

class DateWidget extends StatelessWidget {
  final String date;
  final String temp;
  const DateWidget({Key key, @required this.date, @required this.temp})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            date,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFFE5E5E5),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 18,
                height: 5,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Color(0xFFD6AFAF)),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "$temp°C",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE5E5E5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
