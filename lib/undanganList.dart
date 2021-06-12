import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:undangan/model/Undangan.dart';
import 'package:undangan/webservice/apiUndangan.dart';
import 'home.dart';
class UndanganList extends StatefulWidget {
  const UndanganList({Key? key}) : super(key: key);

  @override
  _UndanganListState createState() => _UndanganListState();
}

class _UndanganListState extends State<UndanganList> {
  ApiUndangan? apiUndangan;
  @override
  void initState() {
    super.initState();
    apiUndangan = ApiUndangan();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
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
                return _buildListView(_undangan);
              } else {
                return Text("Kosong");
              }
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }

  Widget _buildListView(List<Undangan> undangan) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[900],
        title: Text('Daftar Undangan'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          },
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 7,
              child: ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: undangan.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        title: Text(undangan[index].nama),
                        subtitle: Text(undangan[index].email),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://debly.cc/api/${undangan[index].foto}"),
                        ),
                        trailing: Icon(
                          Icons.star,
                          color: undangan[index].statusDatang == '1'
                              ? Colors.blue
                              : Colors.black12,
                        ),
                      ),
                    );
                  }),
            ),
              FlatButton(
                onPressed: () {
                  apiUndangan!.resetKehadiran();
                  setState(() {});
                },
                child: Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0, top: 20.0),
                    child: Center(
                      child: Text(
                        "Reset Kehadiran",
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
            SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}
