class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  // static const String baseUrl = "http://localhost:5000/api/";

  static const String baseUrl = "http://10.0.2.2:5000/api/";

  // static const String baseUrl = "http://192.168.1.65:5000/api/";

  static const String test = "/test";

  //* login / register
  static const String register = "user/create";
  static const String login = "user/login";
  static const String changePassword = "user/change_password";
  static const String forgotPassword = "user/forgot_password";
  static const String updateProfile = "user/update_profile/";
  static const String getUserById = "user/get_user_by_id/";
  static const String getAllUser = "user/get_all_users/";
//* admin
  static const String createProduct = "product/create_product";
  static const String deleteProduct = "product/delete_product/";
  static const String updateProduct = "product/update_product/";
  static const String createCategory = "category/create_category";
  static const String updateCategory = "category/update_category/";
  static const String deleteCategory = "category/delete_category/";

//* user
  static const String getAllProducts = "product/get_products";
  static const String getSingleProduct = "product/get_product/";
  static const String searchProducts = "product/search_products";
  static const String getProductsByCategory =
      "product/get_product_by_category/";
  static const String getSingleCategory = "category/get_category/";
  static const String getAllCategories = "category/get_category";
//cart
  static const String getCartById = "cart/get_cart/";
  static const String addToCart = "cart/addToCart";
  static const String deleteProductFromCart = "cart/deleteFromCart/";
//order
  static const String getOrderById = "order/get_order/";
  static const String addOrder = "order/add_order";

  static const limitPage = 6;
}
