import 'package:covid19/paginas/buscar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaginaPaises extends StatefulWidget {
  @override
  _PaginaPaisesState createState() => _PaginaPaisesState();
}

class _PaginaPaisesState extends State<PaginaPaises> {
  List DatosPaises;
  buscarDatosPorPaises() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
    setState(() {
      DatosPaises = json.decode(response.body);
    });
  }

  @override
  void initState() {
    buscarDatosPorPaises();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search),onPressed: (){

            showSearch(context: context, delegate: Buscar(DatosPaises));

          },)
        ],
        title: Text('Estadisticas por paises'),
      ),
      body: DatosPaises == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(     // contenedor en estadisticas de paises
                  child: Container(
                    height: 130,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 150,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                DatosPaises[index]['country'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Image.network(
                                DatosPaises[index]['countryInfo']['flag'],
                                height: 50,
                                width: 60,
                              )
                            ],
                          ),
                        ),
                        Expanded(
                            child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'CONFIRMADOS: ' +
                                    DatosPaises[index]['cases'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                              Text(
                                'ACTIVOS: ' +
                                    DatosPaises[index]['active'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              Text(
                                'RECUPERADOS: ' +
                                    DatosPaises[index]['recovered'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                              Text(
                                'DECESOS: ' +
                                    DatosPaises[index]['deaths'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[250]),
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                );
              },
              itemCount: DatosPaises == null ? 0 : DatosPaises.length,
            ),
    );
  }
}
