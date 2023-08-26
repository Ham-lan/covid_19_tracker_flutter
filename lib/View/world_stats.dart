import 'package:covid_tracker/Model/worldStatesModel.dart';
import 'package:covid_tracker/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Services/states_services.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({Key? key}) : super(key: key);

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen> with TickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 5) ,
      vsync: this)..repeat() ;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color> [
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .01 ,),
              FutureBuilder(
                future: statesServices.fetchWorldStatesRecords(),
                  builder: (context,AsyncSnapshot<WorldStatesModel> snapshot){
                if(!snapshot.hasData)
                  {
                    return Expanded(
                      flex: 1,
                        child: SpinKitFadingCircle(
                      color: Colors.white,
                      size: 50.0,
                      controller: _controller,
                    ) );
                  }
                else
                  {
                    return Column(
                      children: [
                        PieChart(
                          dataMap:  {
                            "Total":double.parse(snapshot.data!.cases.toString()),
                            "Recovered":double.parse(snapshot.data!.recovered.toString()),
                            "Deaths":double.parse(snapshot.data!.deaths.toString()),
                          },
                          chartValuesOptions: ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                          chartRadius: MediaQuery.of(context).size.width/3.2 ,
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left
                          ),
                          animationDuration: const Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          colorList: colorList,
                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .06 ),
                          child: Card(
                            child: Column(

                              children: [
                                SizedBox(height: 5),
                                ReUseAbleRow(title: 'Total', value: snapshot.data!.cases.toString()),
                                ReUseAbleRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                                ReUseAbleRow(title: 'Recoved', value: snapshot.data!.recovered.toString()),
                                ReUseAbleRow(title: 'Active', value: snapshot.data!.active.toString()),
                                ReUseAbleRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                                ReUseAbleRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                                ReUseAbleRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap:(){
                            print('On tap');
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CountriesListScreen()));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xff1aa268),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(child: Text('Track Countries')),
                          ),
                        ),
                      ],
                    );
                  }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class ReUseAbleRow extends StatelessWidget {
  String title,value;
  ReUseAbleRow({Key? key ,  required this.title , required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5,right: 10,left: 10,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 5,),
          Divider(),
        ],
      ),
    );
  }
}
