import 'package:courses_workshop/models/category_model.dart';
import 'package:courses_workshop/shared/colors/common_colors.dart';
import 'package:courses_workshop/shared/network/remote/dio_helper.dart';
import 'package:courses_workshop/shared/styles/style.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';

void initApp() {
  DioHelper();
}

Widget buildDefaultButton(
        {@required Function onPressed,
        @required String text,
        Color textColor = kWhiteColor,
        Color backgroundColor = kLightishPurpleColor,
        Color borderColor = kLightishPurpleColor}) =>
    Container(
      width: double.infinity,
      height: 58.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: backgroundColor,
          border: Border.all(
            width: 3,
            color: borderColor,
          )),
      child: FlatButton(
        textColor: textColor,
        onPressed: onPressed,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            fontFamily: "MontserratRegular",
          ),
        ),
      ),
    );

Widget buildDefaultTextField({
  String title = "title",
  String hint = '',
  @required TextEditingController controller,
  @required TextInputType type,
  bool isPassword = false,
}) =>
    Container(
      padding: EdgeInsetsDirectional.only(
        start: 16.0,
        end: 16.0,
        top: 12.0,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 3,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(12),
        color: kWhiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          writeQuickText(
            text: title,
            fontSize: 12,
            color: kDarkColor,
          ),
          TextFormField(
            controller: controller,
            keyboardType: type,
            obscureText: isPassword,
            decoration: InputDecoration(
              hintStyle: TextStyle(fontSize: 16.0, color: kGreyColor),
              hintText: hint,
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );

Widget drawLogo() => Column(
      children: [
        SizedBox(
          height: 25.0,
        ),
        Image.asset(
          "assets/images/logo_learn.png",
          color: kLightishPurpleColor,
        ),
        SizedBox(
          height: 60.0,
        ),
      ],
    );

Widget writeQuickText(
        {@required String text,
        double fontSize = 16.0,
        Color color = kDarkColor,
        FontWeight fontWeight = FontWeight.normal,
        TextAlign textAlign = TextAlign.center}) =>
    Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
        fontFamily: "MontserratRegular",
      ),
    );

Widget writeMainHeader(
        {@required String text,
        double fontSize = 32.0,
        Color fontColor = kLightishPurpleColor}) =>
    Column(
      children: [
        SizedBox(
          height: 80.0,
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSize,
            color: fontColor,
            fontFamily: "MontserratRegular",
          ),
        ),
      ],
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
void navigateToReplaceMe(context, widget) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (Route<dynamic> route) => false);

void buildProgressDialog({context, text, error = false}) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                if (!error) CircularProgressIndicator(),
                if (!error)
                  SizedBox(
                    width: 20.0,
                  ),
                Expanded(
                  child: Text(
                    text,
                  ),
                ),
              ],
            ),
            if (error) SizedBox(height: 20.0),
            if (error)
              buildDefaultButton(
                onPressed: () => Navigator.pop(context),
                text: "Cancel",
              ),
          ],
        ),
      ),
    );

showToast({@required String message, @required bool error}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: error ? Colors.red : Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);

Widget drawAppbar(
        {@required context, @required actionWidget, @required leadingWidget}) =>
    AppBar(
      backgroundColor: kPaleLilacColor,
      leading: leadingWidget,
      actions: [
        actionWidget,
        SizedBox(
          width: 20.0,
        ),
      ],
      elevation: 0.0,
    );

Widget drawProfileCard(
        {@required String title, @required Widget shape, @required function}) =>
    GestureDetector(
      onTap: function,
      child: Container(
        padding: EdgeInsets.all(16.0),
        width: 140.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            15.0,
          ),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              foregroundColor: kWhiteColor,
              backgroundColor: kLightishPurpleColor,
              radius: 30.0,
              child: shape,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              title.toString(),
              textAlign: TextAlign.center,
              style: kBlack16Bold().copyWith(
                fontFamily: "MontserratRegular",
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );

Widget drawSettingsCardItem({
  @required onTap,
  @required text,
}) =>
    Column(
      children: [
        ListTile(
          tileColor: Colors.white,
          onTap: onTap,
          title: Text(
            text.toString(),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 14.0,
          ),
        ),
        SizedBox(
          height: 3.0,
        )
      ],
    );

Widget buildExpandedCourseItem({
  @required Function startToday,
  @required String price,
  @required ImageProvider<Object> image,
  @required String title,
  @required String startDate,
  @required String description,
  bool initiallyExpanded = false,
}) =>
    Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          15.0,
        ),
      ),
      child: ExpansionTileCard(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        finalPadding: EdgeInsets.zero,
        baseColor: kWhiteColor,
        expandedColor: kWhiteColor,
        initiallyExpanded: initiallyExpanded,
        elevation: 0.0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
                color: kLightishPurpleColor,
                image: DecorationImage(image: image, fit: BoxFit.fill),
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // RatingBar.builder(
                      //   initialRating: 4,
                      //   minRating: 1,
                      //   direction: Axis.horizontal,
                      //   allowHalfRating: false,
                      //   itemCount: 5,
                      //   itemSize: 12.0,
                      //   ignoreGestures: true,
                      //   itemPadding: EdgeInsets.zero,
                      //   itemBuilder: (context, _) => Icon(
                      //     Icons.star,
                      //     color: kYellowColor,
                      //   ),
                      //   onRatingUpdate: (rating) {
                      //     print(rating);
                      //   },
                      // )
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: kGrey12(),
                  ),
                ],
              ),
            ),
          ],
        ),
        onExpansionChanged: (value) {},
        children: <Widget>[
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: writeQuickText(
                            textAlign: TextAlign.start,
                            text: "Starts at",
                            fontSize: 16,
                          ),
                        ),
                        Expanded(
                          child: writeQuickText(
                            textAlign: TextAlign.start,
                            text: "$startDate",
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        writeQuickText(
                            text: "Price",
                            fontSize: 10,
                            textAlign: TextAlign.start),
                        writeQuickText(
                            text: "\$$price",
                            fontSize: 20,
                            textAlign: TextAlign.start),
                        SizedBox(
                          height: 8.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 160,
                  height: 46.0,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.zero,
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.circular(16.0),
                    ),
                    color: kLightishPurpleColor,
                  ),
                  child: MaterialButton(
                    onPressed: startToday,
                    child: writeQuickText(
                      text: "Start Today",
                      color: kWhiteColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
Widget drawCategoryCard(CategoriesModel model) => GestureDetector(
      onTap: () {
        showToast(message: " Still developing ", error: false);
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        width: 140.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            15.0,
          ),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              foregroundColor: kWhiteColor,
              backgroundColor: kLightishPurpleColor,
              radius: 30.0,
              child: Icon(
                model.iconData,
                size: 25,
                color: kPaleLilacColor,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              model.title,
              textAlign: TextAlign.center,
              style: kBlack16Bold().copyWith(
                fontFamily: "MontserratRegular",
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
