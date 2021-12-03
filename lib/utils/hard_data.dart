import 'package:hafsa/models/blood_bank_model.dart';

// enum APIStatus { Nothing, Loading, Success, Error }

String aboutUs =
    "Blood donation app is a free mobile app for finding blood donors. \n\nOur mission is to gather blood donors and blood seekers under one platform to facilitate the process of finding blood donors.";

List<String> genders = ["Male", "Female"];
String selectedGender;

List<String> professions = [
  "Doctor",
  "Nurse",
  "Lab Technician",
  "Medical Assistant",
  "Other"
];
String selectedProfession;

List<String> bloodGroups = ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"];
List<String> allBloodGroups = [
  "All",
  "A+",
  "A-",
  "B+",
  "B-",
  "O+",
  "O-",
  "AB+",
  "AB-"
];

String selectedBloodType;

List<String> cities = ["Sohar", "Saham", "Barka", "Khoudh", "Ruwi"];
List<String> allCities = ["All", "Sohar", "Saham", "Barka", "Khoudh", "Ruwi"];

String selectedCity;

List<BloodBank> bloodBanks = [
  BloodBank(
      name: "Sohar Poly Clinics",
      phone: "+96824840043",
      locationLink:
          "https://www.google.com/maps/place/Sohar+Poly+Clinics/@24.3459582,56.7338236,15z/data=!4m5!3m4!1s0x0:0xacf750329960f653!8m2!3d24.3459582!4d56.7338236"),
  BloodBank(
      name: "Saham Poly Clinic",
      phone: "+96826855148",
      locationLink:
          "https://www.google.com/maps/place/Saham+Polyclinic+visa+Medical+Center/@24.1386707,56.8721008,15z/data=!4m5!3m4!1s0x0:0xe88ba6847d6c0b21!8m2!3d24.1386707!4d56.8721008"),
  BloodBank(
      name: "Barka Poly Clinic",
      phone: "+96826882055",
      locationLink:
          "https://www.google.com/maps/place/%D9%85%D8%AC%D9%85%D8%B9+%D8%A8%D8%B1%D9%83%D8%A7%D8%A1+%D8%A7%D9%84%D8%B5%D8%AD%D9%8A+Barkaa+Polyclinic%E2%80%AD/@23.6649947,57.8765452,15z/data=!4m5!3m4!1s0x0:0xc341b40c54ef3d29!8m2!3d23.6649947!4d57.8765452"),
  BloodBank(
      name: "Khoudh Health Center",
      phone: "+96824537443",
      locationLink:
          "https://www.google.com/maps/place/Khoudh+Health+Center/@23.6225388,58.2036408,15z/data=!4m2!3m1!1s0x0:0x25665fb388611318?sa=X&ved=2ahUKEwihgNzUpN7zAhUC4YUKHRXWAyAQ_BJ6BAhXEAU"),
  BloodBank(
      name: "Ruwi Health Cener",
      phone: "+96824786088",
      locationLink:
          "https://www.google.com/maps/place/Ruwi+Health+Center+%D9%85%D8%AC%D9%85%D8%B9+%D8%B1%D9%88%D9%8A+%D8%A7%D9%84%D8%B5%D8%AD%D9%8A%E2%80%AD/@23.6023332,58.5380136,15z/data=!4m5!3m4!1s0x0:0x39498949f95d961f!8m2!3d23.6023332!4d58.5380136")
];

String about =
    "Blood donation app is a free mobile app for finding blood donors.\nOur mission is to gather blood donors and blood seekers under one platform to facilitate the process of finding blood donors.";
