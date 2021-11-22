import 'package:flutter/material.dart';
import 'package:startup_funding_prediction/authenticate/auth_service.dart';
import 'package:startup_funding_prediction/services/ml_prediction.dart';
import 'package:startup_funding_prediction/utilities/input_fields.dart';
import 'package:provider/provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:startup_funding_prediction/utilities/object_converter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loading = true;

  TextEditingController _market = TextEditingController();
  TextEditingController _fund = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _month = TextEditingController();
  TextEditingController _year = TextEditingController();
  String code = '';

  Map<String, dynamic> fields = {};

  @override
  void initState() {
    super.initState();

    loadJsonFile('asset_files/fields.json').then((data) {
      setState(() {
        fields = data;
      });
    });

    Future.delayed(Duration(seconds: 6), () {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        actions: [
                          TextButton(
                              onPressed: () async {
                                await context.read<Authenticate>().signOut();
                                Navigator.of(context).pop();
                              },
                              child: Text("Yes")),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("No")),
                        ],
                        title: Text('Are you sure you want to logout?'),
                      ));
            },
            icon: Icon(Icons.person, color: Colors.white),
          )
        ],
        title: Text(
          'Funding Prediction',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.lightBlue[50],
      body: (loading == true)
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          : SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: SafeArea(
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 16, 8, 15),
                            child: Text(
                              'Enter Details',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.purple,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TypeAheadField(
                              textFieldConfiguration: TextFieldConfiguration(
                                  controller: _market,
                                  autofocus: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Market",
                                    labelStyle: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700),
                                    hintText: "Select Market Type",
                                    hintStyle: TextStyle(
                                        color: Colors.green[500],
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  )),
                              suggestionsCallback: (pattern) {
                                return textSuggestion(pattern,
                                    ObjectToContainer.toList(fields['market']));
                              },
                              itemBuilder: (context, suggestion) {
                                return ListTile(
                                  title: Text(suggestion.toString()),
                                );
                              },
                              onSuggestionSelected: (suggestion) {
                                setState(() {
                                  _market.text = suggestion!.toString();
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TypeAheadField(
                              textFieldConfiguration: TextFieldConfiguration(
                                  controller: _fund,
                                  autofocus: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Fund Type",
                                    labelStyle: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700),
                                    hintText: "Select the type of funding",
                                    hintStyle: TextStyle(
                                        color: Colors.green[500],
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  )),
                              suggestionsCallback: (pattern) {
                                return textSuggestion(pattern,
                                    ObjectToContainer.toList(fields['fund']));
                              },
                              itemBuilder: (context, suggestion) {
                                return ListTile(
                                  title: Text(suggestion.toString()),
                                );
                              },
                              onSuggestionSelected: (suggestion) {
                                setState(() {
                                  _fund.text = suggestion!.toString();
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TypeAheadField(
                              textFieldConfiguration: TextFieldConfiguration(
                                  controller: _city,
                                  autofocus: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "City",
                                    labelStyle: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700),
                                    hintText: "Select City",
                                    hintStyle: TextStyle(
                                        color: Colors.green[500],
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  )),
                              suggestionsCallback: (pattern) {
                                return textSuggestion(pattern,
                                    ObjectToContainer.toList(fields['city']));
                              },
                              itemBuilder: (context, suggestion) {
                                return ListTile(
                                  title: Text(suggestion.toString()),
                                );
                              },
                              onSuggestionSelected: (suggestion) {
                                setState(() {
                                  _city.text = suggestion!.toString();
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TypeAheadField(
                              textFieldConfiguration: TextFieldConfiguration(
                                  controller: _month,
                                  autofocus: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Month",
                                    labelStyle: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700),
                                    hintText: "Enter Funding Month",
                                    hintStyle: TextStyle(
                                        color: Colors.green[500],
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  )),
                              suggestionsCallback: (pattern) {
                                return textSuggestion(
                                    pattern,
                                    ObjectToContainer.toJson(fields['month'])
                                        .keys
                                        .toList());
                              },
                              itemBuilder: (context, suggestion) {
                                return ListTile(
                                  title: Text(suggestion.toString()),
                                );
                              },
                              onSuggestionSelected: (suggestion) {
                                setState(() {
                                  _month.text = suggestion!.toString();
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              controller: _year,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Year",
                                labelStyle: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700),
                                hintText: "Enter Funding Year",
                                hintStyle: TextStyle(
                                    color: Colors.green[500],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 8, 0, 2),
                            width: (3 / 5) * MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10)),
                            child: MaterialButton(
                              onPressed: () async {
                                try {
                                  Map<String, String> startupData = {
                                    'company_market': _market.text,
                                    'company_country_code':
                                        ObjectToContainer.toJson(
                                                fields['code'])[_city.text]
                                            .toString(),
                                    'company_city': _city.text,
                                    'funding_round_type': _fund.text,
                                    'month': ObjectToContainer.toJson(
                                            fields['month'])[_month.text]
                                        .toString(),
                                    'year': _year.text
                                  };
                                  String pred = 
                                      await XgboostRegressor.getPrediction(
                                          startupData);
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            actions: [
                                              TextButton(
                                                  onPressed: () async {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("ok")),
                                            ],
                                            title: Text(
                                                'Estimated Funding: \$$pred'),
                                          ));
                                } catch (e) {
                                  print(e.toString());
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            actions: [
                                              TextButton(
                                                  onPressed: () async {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("ok")),
                                            ],
                                            title: Text('Invalid Input'),
                                          ));
                                }
                              },
                              child: Center(
                                child: Text('Submit',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                              ),
                            ),
                          ),
                        ],
                      )))),
    );
  }
}
