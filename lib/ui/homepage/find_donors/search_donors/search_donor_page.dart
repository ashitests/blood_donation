import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hafsa/models/donor_model.dart';
import 'package:hafsa/ui/homepage/find_donors/search_donors/search_donor_controller.dart';
import 'package:hafsa/utils/hard_data.dart';
import 'package:provider/provider.dart';

class SearchDonorPage extends StatefulWidget {
  @override
  _SearchDonorPageState createState() => _SearchDonorPageState();
}

class _SearchDonorPageState extends State<SearchDonorPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SearchDonorController>(context, listen: false)
          .fetchAllDonorsInitially();
      setState(() {
        selectedBloodType = "All";
        selectedCity = "All";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Search Blood Donors"),
        ),
        body: Consumer<SearchDonorController>(
          builder: (context, searchPageProvider, child) {
            return Container(
              child: searchPageProvider.status == Status.loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : searchPageProvider.status != Status.success
                      ? Center(
                          child: Text(
                            "Error",
                            textScaleFactor: 2.0,
                          ),
                        )
                      : Container(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height: 100,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          width: 40,
                                        ),
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Blood Type :",
                                                  textScaleFactor: 1.5),
                                              DropdownButton(
                                                isExpanded: true,
                                                hint: selectedBloodType == null
                                                    ? Text("All",
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300))
                                                    : Text(selectedBloodType,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .redAccent,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400)),
                                                items: allBloodGroups.map(
                                                  (val) {
                                                    return DropdownMenuItem<
                                                            String>(
                                                        value: val,
                                                        child: Text(val));
                                                  },
                                                ).toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedBloodType = value;
                                                  });
                                                  searchPageProvider.sortDonors(
                                                      bloodType: selectedBloodType ==
                                                                  null ||
                                                              selectedBloodType ==
                                                                  "All"
                                                          ? "all"
                                                          : selectedBloodType,
                                                      city: selectedCity ==
                                                                  null ||
                                                              selectedCity ==
                                                                  "All"
                                                          ? "all"
                                                          : selectedCity);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 60,
                                        ),
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "City :",
                                                textScaleFactor: 1.5,
                                              ),
                                              DropdownButton(
                                                isExpanded: true,
                                                hint: selectedCity == null
                                                    ? Text("All",
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300))
                                                    : Text(selectedCity,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .redAccent,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400)),
                                                items: allCities.map(
                                                  (val) {
                                                    return DropdownMenuItem<
                                                            String>(
                                                        value: val,
                                                        child: Text(val));
                                                  },
                                                ).toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedCity = value;
                                                  });
                                                  searchPageProvider.sortDonors(
                                                      bloodType: selectedBloodType ==
                                                                  null ||
                                                              selectedBloodType ==
                                                                  "All"
                                                          ? "all"
                                                          : selectedBloodType,
                                                      city: selectedCity ==
                                                                  null ||
                                                              selectedCity ==
                                                                  "All"
                                                          ? "all"
                                                          : selectedCity);
                                                },
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: searchPageProvider
                                            .filteredDonors.isEmpty
                                        ? 1
                                        : searchPageProvider
                                            .filteredDonors.length,
                                    itemBuilder: (context, index) {
                                      return searchPageProvider
                                              .filteredDonors.isEmpty
                                          ? Center(
                                              child: Text("Empty List."),
                                            )
                                          : UserTile(searchPageProvider
                                              .filteredDonors
                                              .elementAt(index));
                                    }),
                              ],
                            ),
                          ),
                        ),
            );
          },
        ));
  }
}

class UserTile extends StatelessWidget {
  final DonorModel donorModel;

  UserTile(this.donorModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.black45)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.redAccent.shade200,
          child: Text(
            donorModel.name[0].toUpperCase(),
            textScaleFactor: 1.5,
          ),
        ),
        title: Text(
          donorModel.name,
          textScaleFactor: 1.5,
          style: TextStyle(),
        ),
        subtitle: Row(
          children: [
            donorModel.gender.toString().toLowerCase() == "male"
                ? Icon(Icons.male)
                : Icon(Icons.female)
          ],
        ),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          /// navigate to donor details screen
        },
      ),
    );
  }
}
