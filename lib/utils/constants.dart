import 'package:flutter/material.dart';

class Constants {
  //design principals
  static const EdgeInsets pageContentPadding =
      EdgeInsets.symmetric(horizontal: 10);
  static const double inputFieldSpacing = 10.0;
  static const EdgeInsets textFieldContentSpacingHorizontal =
      EdgeInsets.symmetric(horizontal: 20.0);
  static const double inputFieldBorderWidth = 2;
  static const EdgeInsets inputFieldPrefixIconPadding =
      EdgeInsets.only(left: 30, right: 20);
  static const double inputFieldSkewX = 0;
  static const double inputFieldSkewY = 0;
  static const double inputFieldXOffsetCenterSkew = -(inputFieldSkewX * 50);
  static const double inputFieldYOffsetCenterSkew = -(inputFieldSkewY * 50);
  static const EdgeInsets textFieldPadding =
      EdgeInsets.symmetric(horizontal: 20, vertical: 15);
  static List<Shadow> iconShadow = <Shadow>[
    Shadow(color: Colors.black.withOpacity(0.15), blurRadius: 20.0),
    Shadow(color: Colors.black.withOpacity(0.2), blurRadius: 35.0)
  ];

  //fontweights
  static BorderRadius borderRadiusSmall = BorderRadius.circular(10.0);
  static BorderRadius borderRadiusMedium = BorderRadius.circular(20.0);
  static BorderRadius borderRadiusLarge = BorderRadius.circular(30.0);

  static EdgeInsets paddingSmallAll = const EdgeInsets.all(10.0);
  static EdgeInsets paddingMediumAll = const EdgeInsets.all(20.0);
  static EdgeInsets paddingLargeAll = const EdgeInsets.all(30.0);

  static double paddingSmallOnly = 10.0;
  static double paddingMediumOnly = 20.0;
  static double paddingLargeOnly = 30.0;

  //custom methods
  static Border inputFieldBorder(color) {
    return Border.all(
      color: color,
      width: inputFieldBorderWidth,
    );
  }

  static OutlineInputBorder textFormFieldBorder(color) {
    return OutlineInputBorder(
        borderRadius: borderRadiusMedium,
        borderSide: inputFieldBorderSide(color));
  }

  static BorderSide inputFieldBorderSide(color) {
    return BorderSide(
      color: color,
      width: inputFieldBorderWidth,
    );
  }

  static TextStyle usernameTextFieldTextStyle(color) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      color: color,
      fontSize: 25,
    );
  }

  static TextStyle buttonTextStyle(color) {
    return TextStyle(
      fontWeight: FontWeight.w600,
      color: color,
      fontSize: 22,
    );
  }

  static TextStyle smallTextStyle(color) {
    return TextStyle(
      fontWeight: FontWeight.w400,
      color: color,
      fontSize: 14,
    );
  }

  static TextStyle titleTextStyle(color) {
    return TextStyle(
      fontWeight: FontWeight.w800,
      color: color,
      fontSize: 70,
    );
  }

  static TextStyle appBarTitleTextStyle(color) {
    return TextStyle(
      fontFamily: "poppins",
      fontWeight: FontWeight.w800,
      fontStyle: FontStyle.italic,
      color: color,
      fontSize: 30,
    );
  }

  static TextStyle smallTitleTextStyle(color) {
    return TextStyle(
      fontWeight: FontWeight.w800,
      color: color,
      fontSize: 30,
    );
  }

  static TextStyle mediumTitleTextStyle(color) {
    return TextStyle(
      fontWeight: FontWeight.w800,
      color: color,
      fontSize: 45,
    );
  }

  static BorderRadius getOffsetBorder(distanceToInner, borderRadius) {
    var radius = distanceToInner + borderRadius.topLeft.x;
    return BorderRadius.all(Radius.circular(radius > 0 ? radius : 0));
  }

  //profile page
  static Widget profilePagePost(image) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: borderRadiusMedium,
        child: Image(
          gaplessPlayback: true,
          image: image.image,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  //animations
  static Duration elementAnimationDuration = const Duration(milliseconds: 1000);
  static Duration elementAnimationDurationLong =
      const Duration(milliseconds: 2000);

  static double smoothAnimation(value) {
    const curve = Curves.easeInOut;
    var interpolatedValue = curve.transform(value);
    return interpolatedValue;
  }

  /*static Curve elementAnimationCurveLong = CatmullRomCurve(
      const [
        Offset(0.3, 0),
        Offset(0.6, 1),
      ],
      tension: 0
  );*/
  static Curve elementAnimationCurveLong = const Cubic(0, 0, 0, 1);
}
