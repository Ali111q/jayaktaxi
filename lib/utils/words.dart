class Words {
   String language;
   void changeLanguage (String language){
this.language = language;
   }
  String loginTitle() {
    if (language == 'ar') {
      return 'اهلا بكم في تطبيق جايك';
    }
    return 'Welcome in jayak';
  }

  String loginSubtitle() {
    if (language == 'ar') {
      return 'قم بإدخال رقم الهاتف لكي تبدأ عملية التسجيل';
    }
    return 'Type Your Phone Number Please';
  }

  String loginButton() {
    if (language == 'ar') {
      return 'تأكيد';
    }
    return 'Continue';
  }

  String loginFieldHint() {
    if (language == 'ar') {
      return 'رقم هاتفك';
    }
    return 'Your Phone Number ex:078*****';
  }

  String otpSubTitle() {
    if (language == 'ar') {
      return 'قم بإدخال الرمز الذي تم ارساله لرقم هاتفك';
    }
    return 'Please Type Verfication Code';
  }
List<String> HomeScreen(){
  if (language == 'ar') {
    return ['تكسي','طعام','توك توك','كرين' ];
  }return ['Taxi', 'Food', 'Tok tok', 'truck'];
}
String searchhint(){
  if (language == 'ar') {
    return 'ابحث عن اكلك المفضل...';
  }
  return 'Search for your food...';
}
String resturantSearchHint(){
   if (language == 'ar') {
    return 'ابحث عن مطعم...';
  }
  return 'Search for resturant...';
}
String favorateSearchHint(){
   if (language == 'ar') {
    return '...ابحث في المفضلة';
  }
  return 'Search for favorate...';
}
String nearbyResturants(){
  if (language == 'ar') {
    return "مطاعم قريبة عليك";
  }
  return "Nearby Restaurants";
}
String mainPage(){
  if (language == 'ar') {
    return 'الصفحة الرسمية';
  }
  return "Main Page";
}
String orders(){
  if (language == 'ar') {
    return 'الطلبات';
  }
  return "Order";
}

  Words(this.language);
}
