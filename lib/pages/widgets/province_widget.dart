import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../controller/home_controller.dart';
import '../../model/province_model.dart';

class Provinsi extends GetView<HomeController> {
  const Provinsi({
    Key? key,
    required this.type,
  }) : super(key: key);

  final String type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: DropdownSearch<ResultsProvince>(
        showClearButton: true,
        popupItemBuilder: ((context, item, isSelected) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Text("${item.province}"),
          );
        }),
        label: type == "Asal" ? " Provinsi Asal" : "Provinsi Tujuan",
        onFind: (String) async {
          Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");

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

            var listOfProvince = data["rajaongkir"]["results"] as List<dynamic>;
            var models = ResultsProvince.fromJsonList(listOfProvince);
            return models;
          } catch (e) {
            print(e);
            return List<ResultsProvince>.empty();
          }
        },
        itemAsString: (item) => item!.province!,
        onChanged: (province) {
          if (province != null) {
            if (type == "Asal") {
              controller.hiddenCityAsal.value = false;
              controller.provinceIdAsal.value = int.parse(province.provinceId!);
            } else {
              controller.hiddenCityTujuan.value = true;
              controller.provinceIdTujuan.value =
                  int.parse(province.provinceId!);
            }
            controller.showButton();
          } else {
            if (type == "Asal") {
              controller.hiddenCityAsal.value = false;
              controller.provinceIdAsal.value = 0;
              controller.showButton();
            } else {
              controller.hiddenCityTujuan.value = true;
              controller.provinceIdTujuan.value = 0;
              controller.showButton();
            }
          }
        },
      ),
    );
  }
}
