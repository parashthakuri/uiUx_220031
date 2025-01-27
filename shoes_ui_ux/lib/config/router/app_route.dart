import 'package:sneakers_point/features/admin_home/presentation/view/admin_home_view.dart';
import 'package:sneakers_point/features/auth/presentation/view/login_view.dart';
import 'package:sneakers_point/features/auth/presentation/view/register_view.dart';
import 'package:sneakers_point/features/product/presentation/view/product_detail_view.dart';
import 'package:sneakers_point/features/user_home/presentation/view/bottom_view/cart_page_view.dart';
import 'package:sneakers_point/features/user_home/presentation/view/user_home_view.dart';
import 'package:sneakers_point/features/product/presentation/view/all_product_view.dart';
import 'package:sneakers_point/features/splash/presentation/view/splashscreen_view.dart';

class AppRoute {
  AppRoute._();

  static const String splashRoute = '/splash';
  static const String userHomeRoute = '/home';
  static const String adminHomeRoute = '/adminhome';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String allProductRoute = '/allProduct';
  static const String singleProductRoute = '/singleProduct';
  static const String googleMapRoute = '/googleMap';
  static const String cartRoute = '/cart';

  static getApplicationRoute() {
    return {
      splashRoute: (context) => const SplashScreens(),
      loginRoute: (context) => const LoginView(),
      userHomeRoute: (context) => const UserHomeView(),
      adminHomeRoute: (context) => const AdminHomeView(),
      allProductRoute: (context) => const AllProductView(),
      singleProductRoute: (context) => const ProductDetailView(),
      registerRoute: (context) => const RegisterView(),
      cartRoute: (context) => const CartPageView(),
    };
  }
}
