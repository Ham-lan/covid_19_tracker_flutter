import 'package:covid_tracker/Services/states_services.dart';
import 'package:covid_tracker/View/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchcontroller =  TextEditingController();
  @override
  Widget build(BuildContext context) {

    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
        body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (values){
                      setState(() {

                      });
                    },
                  controller: searchcontroller,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    hintText: 'Search with country name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: statesServices.counriesListApi(),
                      builder: (context,AsyncSnapshot<List<dynamic>> snapshot){
                        if(!snapshot.hasData)
                        {
                          return ListView.builder(
                              itemCount: 4,
                              itemBuilder: (context,index){
                                return Shimmer.fromColors(
                                    baseColor: Colors.grey.shade700,
                                    highlightColor: Colors.grey.shade100,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title:Container(height: 10, width: 89, color: Colors.white,),
                                      subtitle:Container(height: 10, width: 89, color: Colors.white,),
                                      leading: Container(height: 50, width: 50, color: Colors.white,),
                                    ),
                                  ],
                                ),);
                              });
                        }
                        else{
                          print('Test');
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context,index){
                                String name = snapshot.data![index]['country'];
                                if(searchcontroller.text.isEmpty)
                                  {
                                    return Column(
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            Navigator.push(context,
                                            MaterialPageRoute(builder: (context)=> DetailScreen(
                                                name: snapshot.data![index]['country'],
                                                image: snapshot.data![index]['countryInfo']['flag'],
                                                totalDeaths: snapshot.data![index]['deaths'],
                                                totalCases: snapshot.data![index]['cases'],
                                                totalRecovered: snapshot.data![index]['recovered'],
                                                critical: snapshot.data![index]['critical'],
                                                todayRecovered: snapshot.data![index]['todayRecovered'],
                                                test: snapshot.data![index]['tests'],
                                                active: snapshot.data![index]['active'],
                                            )
                                            ));
                                          },
                                          child: ListTile(
                                            title:Text(snapshot.data![index]['country']),
                                            subtitle: Text(snapshot.data![index]['cases'].toString()),
                                            leading: Image(
                                                height:50,
                                                width: 50,
                                                image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                else if(name.toLowerCase().contains(searchcontroller.text.toLowerCase()))
                                {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          Navigator.push(context,
                                             MaterialPageRoute(builder: (context)=> DetailScreen(
                                               name: snapshot.data![index]['country'],
                                               image: snapshot.data![index]['countryInfo']['flag'],
                                               totalDeaths: snapshot.data![index]['deaths'],
                                               totalCases: snapshot.data![index]['cases'],
                                               totalRecovered: snapshot.data![index]['recovered'],
                                               critical: snapshot.data![index]['critical'],
                                               todayRecovered: snapshot.data![index]['todayRecovered'],
                                               test: snapshot.data![index]['tests'],
                                               active: snapshot.data![index]['active'],
                                             ) ) );
                                        },
                                        child: ListTile(
                                          title:Text(snapshot.data![index]['country']),
                                          subtitle: Text(snapshot.data![index]['cases'].toString()),
                                          leading: Image(
                                              height:50,
                                              width: 50,
                                              image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                else
                                  {
                                    return Container();
                                  }
                          });
                        }

                      }
                  ),
                )
              ],
            ),
        ),
    );
  }
}
