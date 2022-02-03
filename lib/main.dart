import 'package:flutter/material.dart';
import 'dart:async';
import 'package:numberpicker/numberpicker.dart';
void main(){
  runApp(myapp());
}
class myapp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Time",
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>with TickerProviderStateMixin {
  TabController tb;
  int hour=0;
  int min=0;
  int sec=0;
  String timetodisplay="";
  bool started=true;
  bool stopped=true;
  int timefortime=0;
  bool canceltimer=false;
  final dur=const Duration(seconds: 1);
  @override
  void initState(){
    tb=TabController(
        length: 2,
        vsync: this,
    );
    super.initState();
  }
  void start(){
    setState(() {
      started=false;
      stopped=false;
    });



    timefortime=((hour*3600)+(min*60)+sec);
   // debugPrint(timefortime.toString());
    Timer.periodic(dur, (Timer t) {
     setState(() {
       if(timefortime<1|| canceltimer==true){
         t.cancel();
         Navigator.pushReplacement(context, MaterialPageRoute(
           builder: (context)=>HomePage(),
         ));
       }
       else if
         (timefortime <60) {
         timetodisplay = timefortime.toString();
         timefortime = timefortime - 1;
       }
       else if(timefortime <3600) {
         int m = timefortime ~/ 60;
         int s = timefortime - (60 * m);
         timetodisplay = m.toString() + ":" + s.toString();
         timefortime = timefortime - 1;
       }else{
         int h=timefortime~/3600;
         int t=timefortime-(3600*h);
         int m=t~/60;
         int s=t-(60*m);
         timetodisplay=
             h.toString()+":"+m.toString()+":"+s.toString();
         timefortime=timefortime-1;
        // timefortime=timefortime-1;
         //timetodisplay=timefordisplay.toString();
       }
     });
    });
  }

  void stop(){
    setState(() {
      started=true;
      stopped=true;
      canceltimer=true;
      timetodisplay="";
    });

  }
  Widget  timer(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10.0,
                      ),
                      child: Text(
                        "HH",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),

                      ),
                    ),
                    NumberPicker.integer(
                      initialValue:min,
                        minValue: 0, maxValue: 23,
                        onChanged: (val){
                      setState(() {
                        min=val;
                      });
                        }
                    ),

                  ],
                ),


                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10.0,
                      ),
                      child: Text(
                        "MM",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),

                      ),
                    ),
                    NumberPicker.integer(
                      initialValue:min ,
                      minValue:0,
                      maxValue: 23,
                      listViewWidth:60.0,
                      onChanged:(val){
                        setState(() {
                          min=val;

                        });
                      },
                    ),
                  ],
                ),



                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10.0,
                      ),
                      child: Text(
                        "SS",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),

                      ),
                    ),
                    NumberPicker.integer(
                      initialValue:sec ,
                      minValue:0,
                      maxValue: 23,
                      listViewWidth:60.0,
                      onChanged:(val){
                        setState(() {
                          sec=val;

                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              timetodisplay,
              style: TextStyle(
                fontSize: 40.0,
               fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed:started? start:null ,
                  color: Colors.green,
                  padding: EdgeInsets.symmetric(
                    horizontal: 35.0,
                    vertical: 12.0,
                  ),
                  child: Text(
                    "Start",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),


                RaisedButton(
                  onPressed:stopped?null:stop,
                  color: Colors.green,
                  padding: EdgeInsets.symmetric(
                    horizontal: 35.0,
                    vertical: 12.0,
                  ),
                  child: Text(
                    "Stop",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          )
          
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Text(
          "Watch",

        ),
        centerTitle: true,
        bottom: TabBar(
          tabs: <Widget>[
            Text(
              "Timer",
            ),
            Text(
              "Stoppwatch",
            ),
          ],
          labelStyle: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
          labelPadding: EdgeInsets.only(
            bottom: 10.0,
          ),
          unselectedLabelColor: Colors.white60,
          controller: tb,
        ),

        ),
      body: TabBarView(
      children: <Widget>[
       timer(),
        Text(
            "StopWatch",
        )
      ],
        controller: tb,

      ),
    );
  }
}
