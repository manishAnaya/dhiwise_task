import 'package:dhiwise_task/constant/exports.dart';
import 'package:intl/intl.dart';

const appName = 'FinWise Target';
const defaultPadding = 12.00;
const defaultMargin = 12.00;
const defaultRadius = 6.00;
const xsmallTextsize = 11.00;
const smallTextsize = 12.00;
const normalTextsize = 14.00;
const mediumTextsize = 16.00;
const largeTextsize = 18.00;
const xLargeTextsize = 22.00;
const iconsize = 16.00;
const appLogo = 'assets/images/app_logo.png';
const defaultDuration = Duration(seconds: 1);

final borderRadius = BorderRadius.circular(defaultRadius);
const defaultGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    primaryColor,
    secondaryColor,
  ],
);

const defaultShadow = [
  BoxShadow(
    offset: Offset(0.1, -1),
    color: Colors.black12,
    spreadRadius: 2,
    blurRadius: 2,
  )
];
const loading = Center(
  child: SizedBox(
    height: 35,
    width: 35,
    child: CircularProgressIndicator(
      strokeWidth: 3,
    ),
  ),
);

ThemeData myTheme() {
  return ThemeData(
    useMaterial3: true,
    primarySwatch: mycolor,
    visualDensity: VisualDensity.standard,
    scaffoldBackgroundColor: whiteColor,
    primaryColor: primaryColor,
    appBarTheme: const AppBarTheme(
      elevation: 1,
      centerTitle: true,
      backgroundColor: whiteColor,
      foregroundColor: blackColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
      ),
    ),
    checkboxTheme: const CheckboxThemeData(
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
    inputDecorationTheme: InputDecorationTheme(
        iconColor: primaryColor,
        fillColor: bgColor,
        filled: true,
        hintStyle: smallLightText,
        prefixIconColor: primaryColor,
        contentPadding: const EdgeInsets.all(defaultPadding),
        border: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: primaryColor),
        )),
  );
}

String convertDateTimeFormat(String inputDateTimeString) {
  DateTime dateTime = DateTime.parse(inputDateTimeString);
  // Format the DateTime object to the desired format
  final DateFormat formatter = DateFormat('HH:mm dd MMM y');
  String formattedDateTime = formatter.format(dateTime);
  return formattedDateTime;
}

logoutfn() {
  Get.defaultDialog(
    radius: defaultRadius,
    titleStyle: mediumText,
    middleTextStyle: normalLightText,
    title: 'Confirm Logout',
    middleText: 'Are you sure you want to logout?',
    confirmTextColor: whiteColor,
    confirm: ElevatedButton(
      onPressed: () => SharedPrefs.logout(),
      child: Text('Confirm', style: normalWhiteText),
    ),
    cancel: ElevatedButton(
      onPressed: () => Get.back(),
      child: Text(
        'Back',
        style: normalWhiteText,
      ),
    ),
  );
}
