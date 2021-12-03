import 'package:flutter/material.dart';
import 'package:hafsa/ui/homepage/blood_banks/web_map_view.dart';
import 'package:hafsa/utils/hard_data.dart';

class BloodBanks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blood Banks"),
      ),
      body: SafeArea(
        child: ListView.builder(
            itemCount: bloodBanks.length,
            itemBuilder: (context, index) {
              return BloodBankTile(
                  name: bloodBanks[index].name,
                  phone: bloodBanks[index].phone,
                  url: bloodBanks[index].locationLink);
            }),
      ),
    );
  }
}

class BloodBankTile extends StatelessWidget {
  final String name;
  final String phone;
  final String url;

  BloodBankTile(
      {@required this.name, @required this.phone, @required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.black87)),
      child: Row(
        children: [
          Icon(
            Icons.bloodtype,
            size: 45,
            color: Colors.redAccent,
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  textScaleFactor: 1.5,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(Icons.phone),
                    Text(
                      phone,
                      textScaleFactor: 1.1,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Stack(
            children: [
              Positioned(
                bottom: 10,
                right: 10,
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              CustomWebView(url: url, title: name)));
                    },
                    icon: Icon(
                      Icons.map,
                      size: 30,
                    )),
              ),
              Positioned(
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              CustomWebView(url: url, title: name)));
                    },
                    icon: Icon(
                      Icons.directions,
                      size: 30,
                      color: Colors.black45,
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}
