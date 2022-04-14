import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../controller/home_controller.dart';
import '../../model/city_model.dart';

class Kota extends GetView<HomeController> {
  const Kota({
    required this.provinceId,
    required this.type,
    Key? key,
  }) : super(key: key);
  final String type;
  final int provinceId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: DropdownSearch<Results>(
        showClearButton: true,
        popupItemBuilder: ((context, item, isSelected) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Text("${item.type} ${item.cityName}"),
          );
        }),
        label: type == "Asal"
            ? "Pilih Kabupaten/Kota Asal"
            : "Pilih Kabupaten/Kota Tujuan",
        onFind: (String) async {
          Uri url = Uri.parse(
              "https://api.rajaongkir.com/starter/city?province=$provinceId");

          try {
            final response = await http.get(
              url,
              headers: {
                "key": "9aa7eee41eb45328cf5e86dcf7690689",
              },
            );

            var data = json.decode(response.body);

            var statusCode = data["rajaongkir"]["status"]["code"];

            if (statusCode != 200) {
              throw data["rajaongkir"]["status"]["description"];
            }

            var listOfCity = data["rajaongkir"]["results"] as List<dynamic>;
            var models = Results.fromJsonList(listOfCity);
            return models;
          } catch (e) {
            print(e);
            return List<Results>.empty();
          }
        },
        itemAsString: (item) => "${item!.type} ${item.cityName}",
        onChanged: (cityValue) {
          if (cityValue != null) {
            if (type == "Asal") {
              controller.kotaIdAsal.value = int.parse(cityValue.cityId!);
            } else {
              controller.kotaIdTujuan.value = int.parse(cityValue.cityId!);
            }
            controller.showButton();
          } else {
            if (type == "Asal") {
              print("Tidak memilih kota/kabupaten asal apapun");
              controller.kotaIdAsal.value = 0;
              controller.showButton();
            } else {
              print("Tidak memilih kota/kabupaten tujuan apapun");
              controller.kotaIdTujuan.value = 0;
              controller.showButton();
            }
          }
        },
      ),
    );
  }
}
