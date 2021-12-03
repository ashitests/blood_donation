import 'package:flutter/cupertino.dart';
import 'package:hafsa/models/donor_model.dart';
import 'package:hafsa/services/firebase_user.dart';

class SearchDonorController extends ChangeNotifier {
  List<DonorModel> allDonors = [];
  List<DonorModel> filteredDonors = [];

  Status status = Status.loading;

  fetchAllDonorsInitially() async {
    status = Status.loading;
    notifyListeners();
    var responce = await UserServices().fetchAllDonors();
    print(responce);
    List<DonorModel> result = await UserServices().fetchAllDonors();
    print(result);
    if (result == null) {
      print("error block");
      status = Status.error;
      notifyListeners();
    } else {
      print("success block");
      allDonors = result;
      filteredDonors = result;
      status = Status.success;
      notifyListeners();
    }
  }

  sortDonors({String bloodType, String city}) {
    if (bloodType == "all" && city != "all") {
      print("blood - all and City - not all");
      print(bloodType + "  " + city);

      filteredDonors = [];
      allDonors.forEach((element) {
        if (element.city == city) {
          filteredDonors.add(element);
        }
        print(filteredDonors.length);
      });
      notifyListeners();
    } else if (city == "all" && bloodType != "all") {
      print("blood - not all and City - all");
      print(bloodType + "  " + city);

      filteredDonors = [];

      allDonors.forEach((element) {
        if (element.bloodType == bloodType) {
          filteredDonors.add(element);
        }
        print(filteredDonors.length);
      });
      notifyListeners();
    } else if (city != "all" && bloodType != "all") {
      print("blood - not all and City - not all");
      print(bloodType + "  " + city);

      filteredDonors = [];

      allDonors.forEach((element) {
        if (element.city == city && element.bloodType == bloodType) {
          filteredDonors.add(element);
          print(filteredDonors.length);
        }
      });
      notifyListeners();
    } else {
      print("blood - all and City - all");
      print(bloodType + "  " + city);
      filteredDonors = allDonors;
      print(filteredDonors.length);

      notifyListeners();
    }
  }
}

enum Status { loading, success, error }
