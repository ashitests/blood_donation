import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:hafsa/models/donor_model.dart';
import 'package:hafsa/models/seeker_model.dart';

class UserServices {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  String collection = "users";

  Stream userChanges(String uid) {
    return _firebaseFirestore.collection(collection).doc(uid).snapshots();
  }

  Future fetchUser({String uid}) async {
    try {
      var data = await _firebaseFirestore
          .collection(collection)
          .doc(uid)
          .get(GetOptions(source: Source.server));
      return data.data();
    } catch (e) {
      print(e);
      print("error in try catch of user services method of donor regis");
      return null;
    }
  }

  List<DonorModel> donors = [];

  Future<List<DonorModel>> fetchAllDonors() async {
    try {
      await _firebaseFirestore.collection(collection).get().then((data) {
        data.docs.forEach((element) {
          if (element["type"] == "donor") {
            print('yes');
            donors.add(DonorModel.fromJson(element.data()['details']));
          }
        });
        print("no errors");
        print("returning results");
      });
      return donors;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String> signUpDonor({
    @required DonorModel donor,
    @required String uid,
  }) async {
    try {
      await _firebaseFirestore
          .collection(collection)
          .doc(uid)
          .set({'uid': uid, 'type': "donor", "details": donor.toJson()}).then(
              (value) {
        return "success";
      });
    } catch (e) {
      print(e);
      print("error in try catch of user services method of donor regis");
      return null;
    }
  }

  Future<String> signUpSeeker({
    @required SeekerModel seeker,
    @required String uid,
  }) async {
    try {
      await _firebaseFirestore
          .collection(collection)
          .doc(uid)
          .set({'uid': uid, 'type': "seeker", "details": seeker.toJson()}).then(
              (value) {
        return "Success";
      });
    } catch (e) {
      return null;
    }
  }

  Future updateDonor(DonorModel newDonorDetails, String uid) async {
    try {
      print("trying updateDonor");
      await _firebaseFirestore.collection(collection).doc(uid).update({
        "details": newDonorDetails.toJson(),
      }).then((value) {
        print("updated Successfully");
      });
    } catch (e) {
      print(e);
      print("error in try catch in updateDonor Method in user Services");

      return null;
    }
  }

  Future updateSeeker(SeekerModel newSeekerDetails, String uid) async {
    try {
      print("trying updateDonor");
      await _firebaseFirestore.collection(collection).doc(uid).update({
        "details": newSeekerDetails.toJson(),
      }).then((value) {
        print("updated Successfully");
      });
    } catch (e) {
      print(e);
      print("error in try catch in updateDonor Method in user Services");

      return null;
    }
  }

  /// delete user data
  Future<void> deleteUserData(String uid) async {
    await _firebaseFirestore.collection(collection).doc(uid).delete();
  }
}
