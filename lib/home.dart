import 'package:flutter/material.dart';
import 'package:undangan_app/webservice/apiUndangan.dart';
import 'package:undangan_app/undanganList.dart';
import 'model/Undangan.dart';
import 'qr.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ApiUndangan? apiUndangan;
  @override
  void initState() {
    super.initState();
    apiUndangan = ApiUndangan();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[900],
        title: Text("E-Invitations"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10.0,
          ),
          Image.network(
              "https://media.qrtiger.com/blog/2021/02/Teaser.jpg"),
          SizedBox(
            height: 10.0,
          ),
          FlatButton(
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UndanganList()
                  )
              );
            },
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    "List Undangan",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.cyan[900],
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),

          Text(""),

          FlatButton(
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QRViewExample()
                  )
              );
            },
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child : Text(
                    "Scan QR Code",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.cyan[900],
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),

          Text(""),
          Text(""),
          Text(""),

          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  child: FutureBuilder<List<Undangan>?>(
                      future: apiUndangan!.getUndanganAll(),
                      builder:
                          (BuildContext context, AsyncSnapshot<List<Undangan>?> snapshot) {
                        if (snapshot.hasError) {
                          print(snapshot.error.toString());
                          return Center(
                            child: Text("Error ${snapshot.error.toString()}"),
                          );
                        } else if (snapshot.hasData) {
                          List<Undangan>? _undangan = snapshot.data;
                          if (_undangan != null) {
                            return ListTile(
                                leading: Icon(Icons.people, color: Colors.cyan[900]),
                                title: Text("Total Undangan : ${_undangan.length}"));
                          } else {
                            return Text("0");
                          }
                        } else {
                          return CircularProgressIndicator();
                        }
                      }),
                ),
                Card(
                  child:FutureBuilder<List<Undangan>?>(
                      future: apiUndangan!.getUndanganHadir(),
                      builder:
                          (BuildContext context, AsyncSnapshot<List<Undangan>?> snapshot) {
                        if (snapshot.hasError) {
                          print(snapshot.error.toString());
                          return Center(
                            child: Text("Error ${snapshot.error.toString()}"),
                          );
                        } else if (snapshot.hasData) {
                          List<Undangan>? _undangan = snapshot.data;
                          if (_undangan != null) {
                            return ListTile(
                                leading: Icon(  Icons.account_balance_outlined, color: Colors.cyan[900]),
                                title: Text("Hadir : ${_undangan.length}"));
                          } else {
                            return Text("0");
                          }
                        } else {
                          return CircularProgressIndicator();
                        }
                      }),
                ),
                Card(
                  child: FutureBuilder<List<Undangan>?>(
                      future: apiUndangan!.getUndanganTidakHadir(),
                      builder:
                          (BuildContext context, AsyncSnapshot<List<Undangan>?> snapshot) {
                        if (snapshot.hasError) {
                          print(snapshot.error.toString());
                          return Center(
                            child: Text("Error ${snapshot.error.toString()}"),
                          );
                        } else if (snapshot.hasData) {
                          List<Undangan>? _undangan = snapshot.data;
                          if (_undangan != null) {
                            return  ListTile(
                                leading: Icon(Icons.assignment_outlined, color: Colors.cyan[900]),
                                title: Text("Belum Hadir : ${_undangan.length}"));
                          } else {
                            return Text("0");
                          }
                        } else {
                          return CircularProgressIndicator();
                        }
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}