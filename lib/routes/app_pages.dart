import 'package:get/route_manager.dart';
import 'package:ongkos_kirim_getx_10_mar/bindings/home_binding.dart';
import 'package:ongkos_kirim_getx_10_mar/pages/home_page.dart';
import 'package:ongkos_kirim_getx_10_mar/pages/splash_page.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashPage(),
    ),
  ];
}
