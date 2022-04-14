import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ongkos_kirim_getx_10_mar/model/cost.dart';

class HomeController extends GetxController {
  var hiddenCityAsal = true.obs;
  var provinceIdAsal = 0.obs;
  var kotaIdAsal = 0.obs;
  var hiddenCityTujuan = true.obs;
  var provinceIdTujuan = 0.obs;
  var kotaIdTujuan = 0.obs;
  var hiddenButton = true.obs;
  var kurir = "".obs;

  double weight = 0.0;
  String satuan = "gram";

  late TextEditingController weightController;

  void ongkosKirim() async {
    try {
      Uri url = Uri.parse("https://api.rajaongkir.com/starter/cost");

      final response = await http.post(
        url,
        body: {
          "origin": "$kotaIdAsal",
          "destination": "$kotaIdTujuan",
          "weight": "$weight",
          "courier": "$kurir",
        },
        headers: {
          "key": "9aa7eee41eb45328cf5e86dcf7690689",
          "content-type": " application/x-www-form-urlencoded",
        },
      );

      var data = json.decode(response.body) as Map<String, dynamic>;
      var results = data['rajaongkir']['results'] as List<dynamic>;

      var listAllCost = Cost.fromJsonList(results);
      var cost = listAllCost[0];

      Get.defaultDialog(
        titlePadding: EdgeInsets.all(10),
        title: cost.name!,
        content: Column(
          children: cost.costs!.map((e) {
            return ListTile(
              title: Text("${e.service}"),
              subtitle: Text("Rp ${e.cost![0].value}"),
              trailing: Column(
                children: [
                  Text("Estimasi"),
                  SizedBox(
                    height: 5,
                  ),
                  Text(cost.code == "pos"
                      ? "${e.cost![0].etd}"
                      : "${e.cost![0].etd} HARI"),
                ],
              ),
            );
          }).toList(),
        ),
      );
    } catch (e) {
      print(e);
      Get.defaultDialog(title: "Something Wrong", middleText: e.toString());
    }
  }

  void showButton() {
    if (kotaIdAsal != 0 && kotaIdTujuan != 0 && weight > 0 && kurir != "") {
      hiddenButton.value = false;
    } else {
      hiddenButton.value = true;
    }
  }

  void ubahBerat(String value) {
    weight = double.tryParse(value) ?? 0.0;
    String cekSatuan = satuan;
    switch (cekSatuan) {
      case "ton":
        weight = weight * 1000000;
        break;
      case "kwintal":
        weight = weight * 100000;
        break;
      case "kg":
        weight = weight * 1000;
        break;
      case "gram":
        weight = weight;
        break;
      case "gram":
        break;
      default:
        weight = weight;
    }

    print("$weight gram");
    showButton();
  }

  void ubahSatuan(String value) {
    weight = double.tryParse(weightController.text) ?? 0.0;
    switch (value) {
      case "ton":
        weight = weight * 1000000;
        break;
      case "kwintal":
        weight = weight * 100000;
        break;
      case "kg":
        weight = weight * 1000;
        break;
      case "gram":
        weight = weight;
        break;
      case "gram":
        break;
      default:
        weight = weight;
    }
    satuan = value;

    print("$weight gram");
    showButton();
  }

  @override
  void onInit() {
    weightController = TextEditingController(text: "$weight");
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // weightController.dispose();
    super.onClose();
  }
}
