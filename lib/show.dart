import "package:flutter/material.dart";
import 'package:mytrain/screens/Pnrscreen.dart';
import 'package:mytrain/screens/trainonstation.dart';
import 'package:mytrain/screens/trainstatusscreen.dart';

class Show extends StatefulWidget {
  // Show({this.trainstatus});

  // final trainstatus;

  @override
  _ShowState createState() => _ShowState();
}

class _ShowState extends State<Show> with SingleTickerProviderStateMixin{
  // var date;
  // var serial;
  // var trainnumber;
  // var currentstation;
  // var scheduledarival;
  // var actualarival;
  // var trainroute;
  TabController tabcontroller;
  @override
  void initState() {
    super.initState();
 //  updateui(widget.trainstatus);
 // print(widget.trainstatus);

 //here we also intili..

 tabcontroller = TabController(vsync:this,length:3);
 
  }

  void updateui(dynamic traindata) {
    // date = traindata["StartDate"];
    // serial = traindata["CurrentStation"]["SerialNo"];
    // trainnumber = traindata["TrainNumber"];
    // currentstation = traindata["CurrentStation"]["StationName"];

    // scheduledarival = traindata["CurrentStation"]["ScheduleArrival"];
    // actualarival = traindata["CurrentStation"]["ActualArrival"];
    // trainroute = traindata["TrainRoute"];//[0]["StationName"];

    // print(date);
    // print(trainnumber);
    // print(trainroute);
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       backgroundColor: Colors.amber,
      bottom: TabBar(tabs: [
        Tab(text:"Train status",),
        Tab(text: "PNR",),
        Tab(text:"Train on station"),
      ],
      controller:tabcontroller,
      indicatorColor:Colors.white,
      indicatorWeight: 5,
      labelColor: Colors.black
      ),
      
      ),
        body: TabBarView(
          controller: tabcontroller,
         children: <Widget>[
           Trainstatusscreen(),
           
          
           PNRscreen(),
           Trainonstation(),
          
         ],
        ));
  }

 
}



//second ne


