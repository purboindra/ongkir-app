import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:ongkos_kirim_getx_10_mar/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:ongkos_kirim_getx_10_mar/pages/widgets/city_widget.dart';
import 'package:ongkos_kirim_getx_10_mar/pages/widgets/province_widget.dart';
import 'package:ongkos_kirim_getx_10_mar/pages/widgets/weight.dart';
import 'package:ongkos_kirim_getx_10_mar/service/theme_service.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        title: const Text("Cek Ongkos Kirim"),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Provinsi(type: "Asal"),
            Obx(
              () => controller.hiddenCityAsal.isTrue
                  ? const SizedBox()
                  : Kota(
                      provinceId: controller.provinceIdAsal.value,
                      type: "Asal",
                    ),
            ),
            Provinsi(type: "Tujuan"),
            Obx(
              () => controller.hiddenCityAsal.isTrue
                  ? const SizedBox()
                  : Kota(
                      provinceId: controller.provinceIdTujuan.value,
                      type: "tujuan",
                    ),
            ),
            const SizedBox(
              height: 20,
            ),
            const WeightWidget(),
            const SizedBox(
              height: 20,
            ),
            DropdownSearch<Map<String, dynamic>>(
              mode: Mode.BOTTOM_SHEET,
              items: const [
                {
                  "code": "jne",
                  "nama": "Jalu Nugraha Ekakurir (JNE)",
                },
                {
                  "code": "tiki",
                  "nama": "Titipan Kilat (TIKI)",
                },
                {
                  "code": "pos",
                  "nama": "Perusahaan Opsional Surat (Post Indonesia)",
                },
              ],
              label: "Kurir",
              hint: "Pilih kurir",
              popupItemBuilder: (context, items, isSelected) => Container(
                padding: EdgeInsets.all(20),
                child: Text("${items["nama"]}"),
              ),
              showClearButton: true,
              itemAsString: (items) => "${items!["nama"]}",
              onChanged: (value) {
                if (value != null) {
                  controller.kurir.value = value["code"];
                  controller.showButton();
                } else {
                  controller.hiddenButton.value = true;
                  controller.kurir.value = "";
                }
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Obx(
              () => controller.hiddenButton.isTrue
                  ? SizedBox()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Get.isDarkMode
                            ? Color.fromARGB(255, 255, 123, 0)
                            : Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      onPressed: () => controller.ongkosKirim(),
                      child: const Text("Ongkos Kirim"),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor:
              Get.isDarkMode ? Color.fromARGB(255, 255, 123, 0) : Colors.blue,
          child: Get.isDarkMode
              ? Icon(
                  Icons.light_mode,
                  color: Colors.white,
                )
              : Icon(Icons.dark_mode),
          onPressed: () {
            ThemeService().switchTheme();
          }),
    );
  }
}
