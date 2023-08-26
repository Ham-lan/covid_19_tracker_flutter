import 'package:covid_tracker/View/world_stats.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String image;
  String name;
  int totalCases,totalDeaths,totalRecovered, active, critical, todayRecovered , test;
  DetailScreen({
    required this.name,
    required this.image,
    required this.totalDeaths,
    required this.totalCases,
    required this.totalRecovered,
    required this.critical,
    required this.todayRecovered,
    required this.test,
    required this.active
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * .067),
                      ReUseAbleRow(title: 'Cases', value: widget.totalCases.toString()),
                      ReUseAbleRow(title: 'Deaths', value: widget.totalDeaths.toString()),
                      ReUseAbleRow(title: 'Recovered', value: widget.totalRecovered.toString()),
                      ReUseAbleRow(title: 'Recovered Today', value: widget.todayRecovered.toString()),
                      ReUseAbleRow(title: 'Cases', value: widget.totalCases.toString()),
                      ReUseAbleRow(title: 'Critical', value: widget.critical.toString()),
                      ReUseAbleRow(title: 'Test', value: widget.test.toString()),
                      ReUseAbleRow(title: 'Active', value: widget.active.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(

                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
