import "package:flutter/material.dart";
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../trainstatus.dart';

class Trainstatusscreen extends StatefulWidget {
  Trainstatusscreen({this.trainstatus});

  final trainstatus;

  @override
  _TrainstatusscreenState createState() => _TrainstatusscreenState();
}

class _TrainstatusscreenState extends State<Trainstatusscreen> {
  var traindata;

  TextEditingController trainnumbercontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  var x = "";

  var Date;

  @override
  void initState() {
    super.initState();
  }

  Future passRailwayData() async {
    Trainstatus trainstatus =
        Trainstatus(trainnumbercontroller, datecontroller);

    traindata = await trainstatus.getcurrentstatus();
  }

  var date;
  var serial;
  var trainnumber;
  var currentstation;
  var scheduledarival;
  var actualarival;
  var trainroute;

  Future updateui(dynamic traindata) async {
    date = await traindata["StartDate"];
    serial = traindata["CurrentStation"]["SerialNo"];
    trainnumber = await traindata["TrainNumber"];
    currentstation = traindata["CurrentStation"]["StationName"];

    scheduledarival = traindata["CurrentStation"]["ScheduleArrival"];
    actualarival = traindata["CurrentStation"]["ActualArrival"];
    trainroute = traindata["TrainRoute"]; //[0]["StationName"];

    print(date);
    print(trainnumber);
    print(trainroute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/train.jpg"), fit: BoxFit.fill)),
              child: Container(
                  child: Column(
                children: <Widget>[
                  Card(
                    elevation: 10,
                    margin: EdgeInsets.all(15),
                    child: TextField(
                      controller: trainnumbercontroller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          icon: Icon(Icons.train),
                          labelText: "Enter a Valid 5 Digit Train number.....",
                          hintText: "Enter Train Number.....",
                          hintStyle: TextStyle(fontSize: 13)),
                    ),
                  ),
                  Card(
                    elevation: 10,
                    margin: EdgeInsets.all(20),
                    child: TextField(
                      controller: datecontroller,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                          icon: Icon(Icons.date_range),
                          labelText: "Enter date: Year/Month/Day......",
                          hintText: "Year/Month/Day",
                          hintStyle: TextStyle(fontSize: 13)),
                      onChanged: (text) {
                        x = text;
                        Date = x.replaceAll("/", "");
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: RaisedButton(
                      onPressed: () {
                        passRailwayData();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Trainstatuslast(
                                    trainnumber: trainnumbercontroller.text,
                                    date: Date)));
                      },
                      child: Text("Find Train"),
                      color: Colors.green,
                    ),
                  ),
                  Card(
                    shadowColor: Colors.amber,
                    elevation: 10,
                    margin: EdgeInsets.all(30),
                    child: Container(
                      height: 50,
                      child: Row(
                        children: <Widget>[
                          Text("Your last Train number:  "),
                          Text(trainnumbercontroller.text),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 10,
                    shadowColor: Colors.amber,
                    margin: EdgeInsets.only(left: 30, right: 30),
                    child: Container(
                      height: 50,
                      child: Row(
                        children: <Widget>[
                          Text("Your last Date of Joruney: "),
                          Text(datecontroller.text),
                        ],
                      ),
                    ),
                  ),
                ],
              )))),
    );
  }
}

//finalstatus of our current runing train...

class Trainstatuslast extends StatefulWidget {
  Trainstatuslast({this.trainnumber, this.date});

  final trainnumber, date;
  @override
  _TrainstatuslastState createState() => _TrainstatuslastState();
}

class _TrainstatuslastState extends State<Trainstatuslast> {
  var traindata;

  var Date;
  var serial;
  var Trainnumber;
  var currentstation;
  var scheduledarival;
  var actualarival;
  var trainroute;
  var delay;
  var scheduleDeparture;
  var actualDeparture;
  var delayInDeparture;

  @override
  void initState() {
    super.initState();

    getRailwayData().then((traindata) {
      setState(() {
        this.traindata = traindata;
      });
    });
    // not part of this // updateui(traindata);
  }

  Future getRailwayData() async {
    Trainstatus trainstatus = Trainstatus(widget.trainnumber, widget.date);

    traindata = await trainstatus.getcurrentstatus();

    updateui(traindata);
    print(widget.trainnumber);
    print(widget.date);
    return traindata;
  }

  void updateui(dynamic traindata) {
    Date = traindata["StartDate"];
    serial = traindata["CurrentStation"]["SerialNo"];
    Trainnumber = traindata["TrainNumber"];
    currentstation = traindata["CurrentStation"]["StationName"];
    delay = traindata["CurrentStation"]["DelayInArrival"];
    scheduleDeparture = traindata["CurrentStation"]["ScheduleDeparture"];
    actualDeparture = traindata["CurrentStation"]["ActualDeparture"];
    scheduledarival = traindata["CurrentStation"]["ScheduleArrival"];
    delayInDeparture = traindata["CurrentStation"]["DelayInDeparture"];
    actualarival = traindata["CurrentStation"]["ActualArrival"];
    trainroute = traindata["TrainRoute"]; //[0]["StationName"];

    print(Date);
    print(Trainnumber);
    print(trainroute);
  }

  @override
  Widget build(BuildContext context) {
    if (traindata == null) {
      getRailwayData();
      return Scaffold(body: Center(child: Text("loading")));
    } else {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              getRailwayData();
            },
            child: Icon(Icons.refresh)),
        body: SafeArea(
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/train.jpg"), fit: BoxFit.fill)),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: Card(
                      elevation: 10,
                      margin: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            children: <Widget>[
                              Icon(Icons.date_range),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  elevation: 10,
                                  child: Container(
                                      height: 50,
                                      child: Text("Journey Date:  $Date",
                                          style: TextStyle(fontSize: 20))),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                    elevation: 10,
                                    child: Container(
                                        child: Text(
                                            "Current Station:  $currentstation",
                                            style: TextStyle(fontSize: 20)))),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                    elevation: 10,
                                    child: Container(
                                        child: Text(
                                            "ScheduleArrival:  $scheduledarival",
                                            style: TextStyle(fontSize: 20)))),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                    elevation: 10,
                                    child: Container(
                                        child: Text(
                                            "ActualArrival: $actualarival",
                                            style: TextStyle(fontSize: 20)))),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                    elevation: 10,
                                    child: Container(
                                        child: Text("DelayInArrival:  $delay",
                                            style: TextStyle(fontSize: 20)))),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                    elevation: 10,
                                    child: Container(
                                        child: Text(
                                            "ScheduleDeparture:$scheduleDeparture",
                                            style: TextStyle(fontSize: 20)))),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                    elevation: 10,
                                    child: Container(
                                        child: Text(
                                            "ActualDeparture:  $actualDeparture",
                                            style: TextStyle(fontSize: 20)))),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                    elevation: 10,
                                    child: Container(
                                        child: Text(
                                            "DelayInDeparture:  $delayInDeparture",
                                            style: TextStyle(fontSize: 20)))),
                              ),
                            ],
                          ),
                          Icon(Icons.train, size: 70, color: Colors.black)
                        ],
                      ),
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.arrow_back, color: Colors.red, size: 70),
                    ],
                  ),
                )
              ])),
        ),
      );
    }
  }
}
