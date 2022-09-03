import 'package:soiree/style/colors.dart';
import 'package:soiree/style/dimens.dart';
import 'package:soiree/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:soiree/utils/extension.dart';

class ButtonWidget extends StatelessWidget {
  final String? text;
  final Function? onTap;
  final double? btnWidth;
  final IconData? left;
  final IconData? right;

  const ButtonWidget(
      {Key? key, this.text, this.onTap, this.btnWidth, this.left, this.right})
      : super(key: key);

  Widget iconToLeft() {
    return Icon(
      this.left,
      color: Colors.white,
      size: 34,
    );
  }

  Widget iconToRight() {
    return Icon(
      this.right,
      color: Colors.white,
      size: 50,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: primaryColor)))),
        onPressed: onTap != null ? () => onTap!() : null,
        child: Ink(
          child: Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width *
                    (btnWidth != null ? btnWidth! : 1),
                minHeight: buttonHeight),
            alignment: Alignment.center,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  this.left != null
                      ? iconToLeft()
                      : SizedBox(width: 0, height: 0),
                  Text(
                    text!,
                    textAlign: TextAlign.center,
                    style: boldLargeTextStyle.copyWith(
                        color: Colors.white, fontSize: textSizeNormal),
                  ).addMarginLeft(16),
                  this.right != null
                      ? iconToRight()
                      : SizedBox(
                          width: 0,
                          height: 0,
                        )
                ]),
          ),
        ),
      ),
    );
  }
}
