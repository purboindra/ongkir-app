import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ongkos_kirim_getx_10_mar/controller/home_controller.dart';

class WeightWidget extends GetView<HomeController> {
  const WeightWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            autocorrect: false,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            controller: controller.weightController,
            decoration: InputDecoration(
              hintText: "Input Weight",
              labelText: "Wieght",
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => controller.ubahBerat(value),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          width: 150,
          child: DropdownSearch<String>(
              mode: Mode.BOTTOM_SHEET,
              showSearchBox: true,
              showSelectedItems: true,
              // dropdownSearchDecoration: InputDecoration(
              //     hintText: "Weight", border: OutlineInputBorder()),
              items: [
                "ton",
                "kwintal",
                "kg",
                "gram",
              ],
              label: "Satuan",
              popupItemDisabled: (String s) => s.startsWith('I'),
              onChanged: (value) => controller.ubahSatuan(value!),
              selectedItem: "Gram"),
        ),
      ],
    );
  }
}
