import "package:flutter/material.dart";
import 'package:mytrain/trainstatus.dart';

class PNRscreen extends StatefulWidget {
  @override
  _PNRscreenState createState() => _PNRscreenState();
}

class _PNRscreenState extends State<PNRscreen> {
  TextEditingController pnrcontroller = TextEditingController();
var pnrdata;
 Future passpnrnumber() async{

   Pnrstatus pnrstatus = Pnrstatus(pnrcontroller.text);
   pnrdata = await pnrstatus.getpnrstatus();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    body:Container(
    
      decoration: BoxDecoration(
        image:DecorationImage(image: AssetImage("images/train.jpg"),
        fit:BoxFit.fill)
      ),
      child: Container(
       
                  child: Column(
                children: <Widget>[
                  Card(
                    elevation: 10,
                    margin: EdgeInsets.all(45),
                    child: TextField(
                    //  controller: trainnumbercontroller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          icon: Icon(Icons.train),
                          labelText: "Enter a Valid 10 Digit PNR number.....",
                          hintText: "Enter PNR Number.....",
                          hintStyle: TextStyle(fontSize: 13)),
                    ),
                  ),
                 
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: RaisedButton(
                      onPressed: () {
                        passpnrnumber();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>Pnrlaststatus(
                                  pnrnumber: pnrcontroller.text,
                                  )));
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.search),
                          Text("Find PNR Status"),
                        ],
                      ),
                      color: Colors.green,
                    ),
                  ),
     
       ]
      
      ))));
  
  }
}


//getpnrsatatus....


class Pnrlaststatus extends StatefulWidget {
  Pnrlaststatus({this.pnrnumber});
  final pnrnumber;
  @override
  _PnrlaststatusState createState() => _PnrlaststatusState();
}

class _PnrlaststatusState extends State<Pnrlaststatus> {
var trainpnrdata;
  @override
  void initState() {
    super.initState();

    getPnrData().then((trainpnrdata) {
      setState(() {
        this.trainpnrdata = trainpnrdata;
      });
    });
    // not part of this // updateui(traindata);
  }

  Future getPnrData() async {
    Pnrstatus pnrstatus = Pnrstatus(widget.pnrnumber);

    trainpnrdata = await pnrstatus.getpnrstatus();

    updateui(trainpnrdata);
    print(widget.pnrnumber);
    
    return trainpnrdata;
  }

  void updateui(dynamic traindata) {
    // Date = traindata["StartDate"];
    // serial = traindata["CurrentStation"]["SerialNo"];
    // Trainnumber = traindata["TrainNumber"];
    // currentstation = traindata["CurrentStation"]["StationName"];
    // delay = traindata["CurrentStation"]["DelayInArrival"];
    // scheduleDeparture = traindata["CurrentStation"]["ScheduleDeparture"];
    // actualDeparture = traindata["CurrentStation"]["ActualDeparture"];
    // scheduledarival = traindata["CurrentStation"]["ScheduleArrival"];
    // delayInDeparture = traindata["CurrentStation"]["DelayInDeparture"];
    // actualarival = traindata["CurrentStation"]["ActualArrival"];
    // trainroute = traindata["TrainRoute"]; //[0]["StationName"];

    // print(Date);
    // print(Trainnumber);
    // print(trainroute);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}