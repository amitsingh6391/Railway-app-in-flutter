import "datascreen.dart";

//const trainnumber=02554;
class Trainstatus {
// var trainnumber=02566;
// var date=20200610;
  Trainstatus(this.trainnumber, this.date);
  var trainnumber;
  var date;

  Future<dynamic> getcurrentstatus() async {
    NetworkHelper networkHelper = NetworkHelper(
        "https://indianrailapi.com/api/v2/livetrainstatus/apikey/f58f700da4de2cba34c389ef1a06c32c/trainnumber/$trainnumber/date/$date/");
    var traindata = await networkHelper.getData();

    return traindata;
  }
}

class Pnrstatus{



Pnrstatus(this.pnrnumber);

var pnrnumber;
  Future<dynamic> getpnrstatus() async{

  
NetworkHelper networkHelper = NetworkHelper("https://indianrailapi.com/api/v2/PNRCheck/apikey/f58f700da4de2cba34c389ef1a06c32c/PNRNumber/4857412584/");
 var traindata = await networkHelper.getData();

 return traindata;


}
}