/*-----------Common Numbers---------*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const numD001 = 0.001;
const numD0015 = 0.0015;
const numD003 = 0.003;
const numD005 = 0.005;
const numD01 = 0.01;
const numD014 = 0.014;
const numD015 = 0.015;
const numD016 = 0.016;
const numD017 = 0.017;
const numD018 = 0.018;
const numD019 = 0.019;
const numD02 = 0.02;
const numD025 = 0.025;
const numD03 = 0.03;
const numD035 = 0.035;
const numD036 = 0.036;
const numD037 = 0.037;
const numD038 = 0.038;
const numD039 = 0.039;
const numD04 = 0.04;
const numD040 = 0.040;
const numD043 = 0.043;
const numD045 = 0.045;
const numD046 = 0.046;
const numD047 = 0.047;
const numD048 = 0.048;
const numD049 = 0.049;
const numD05 = 0.05;
const numD055 = 0.055;
const numD06 = 0.06;
const numD065 = 0.065;
const numD07 = 0.07;
const numD075 = 0.075;
const numD08 = 0.08;
const numD085 = 0.085;
const numD09 = 0.09;
const numD095 = 0.095;
const numD1 = 0.1;
const numD11 = 0.11;
const numD12 = 0.12;
const numD13 = 0.13;
const numD14 = 0.14;
const numD15 = 0.15;
const numD16 = 0.16;
const numD17 = 0.17;
const numD18 = 0.18;
const numD19 = 0.19;
const numD20 = 0.20;
const numD21 = 0.21;
const numD22 = 0.22;
const numD23 = 0.23;
const numD24 = 0.24;
const numD25 = 0.25;
const numD26 = 0.26;
const numD27 = 0.27;
const numD28 = 0.28;
const numD29 = 0.29;
const numD30 = 0.30;
const numD31 = 0.31;
const numD32 = 0.32;
const numD33 = 0.33;
const numD34 = 0.34;
const numD35 = 0.35;
const numD36 = 0.36;
const numD37 = 0.37;
const numD38 = 0.38;
const numD39 = 0.39;
const numD40 = 0.40;
const numD41 = 0.41;
const numD43 = 0.43;
const numD44 = 0.44;
const numD48 = 0.48;
const numD50 = 0.50;
const numD53 = 0.53;
const numD54 = 0.54;
const numD55 = 0.55;
const numD56 = 0.56;
const numD57 = 0.57;
const numD58 = 0.58;
const numD59 = 0.59;
const numD60 = 0.60;
const numD62 = 0.62;
const numD65 = 0.65;
const numD68 = 0.68;
const numD70 = 0.70;
const numD71 = 0.71;
const numD72 = 0.72;
const numD73 = 0.73;
const numD75 = 0.75;
const numD80 = 0.80;
const numD81 = 0.81;
const numD82 = 0.82;
const numD83 = 0.83;
const numD84 = 0.84;
const numD90 = 0.90;
const numD92 = 0.92;
const num0 = 0.0;
const num1 = 1.0;
const num12 = 1.2;
const num13 = 1.35;
const num14 = 1.4;
const num18 = 1.85;
const num2 = 2.0;
const num21 = 2.1;
const num22 = 2.2;
const num225 = 2.25;
const num23 = 2.3;
const num24 = 2.4;
const num25 = 2.5;
const num26 = 2.6;
const num27 = 2.7;
const num28 = 2.8;
const num29 = 2.9;
const num3 = 3.0;
const num31 = 3.1;
const num32 = 3.2;
const num33 = 3.3;
const num34 = 3.4;
const num35 = 3.5;
const num36 = 3.6;
const num37 = 3.7;
const num39 = 3.9;
const num4 = 4.0;
const num5 = 5.0;
const num51 = 5.1;
const num52 = 5.2;
const num53 = 5.3;
const num54 = 5.4;
const num55 = 5.5;
const num56 = 5.6;
const num57 = 5.7;
const num58 = 5.8;
const num59 = 5.9;
const num6 = 6.0;
const num7 = 7.0;
const num8 = 8.0;
const num9 = 9.0;
const num10 = 10.0;
const num15 = 15.0;
const num20 = 20.0;
const numInt0 = 0;
const numInt1 = 1;
const numInt2 = 2;
const numInt3 = 3;
const numInt4 = 4;
const numInt5 = 5;
const numInt6 = 6;
const numInt7 = 7;
const numInt8 = 8;
const numInt9 = 9;
const numInt10 = 10;
const numD063 = 0.63;

/*------images path----------*/
const image = "assets/image/";
const icon = "assets/icon/";

//TextEditForm
Widget commonTextEditForm(
    {required Size size,
    required TextEditingController controller,
    required String hintText,
    required String validation}) {
  return TextFormField(
    style: const TextStyle(
      fontFamily: 'comfortaa',
      fontWeight: FontWeight.w400,
    ),
    controller: controller,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return validation;
      }
      return null;
    },
    decoration: InputDecoration(
      border: OutlineInputBorder(
          borderSide:
              BorderSide(width: size.width * numD001, color: Colors.grey),
          borderRadius: BorderRadius.circular(
            size.width * numD015,
          )),
      hintText: hintText,
      hintStyle: TextStyle(
        fontFamily: 'comfortaa',
        fontWeight: FontWeight.w400,
        color: Colors.grey,
        fontSize: size.width * numD035,
      ),
      contentPadding: EdgeInsets.only(
          left: size.width * numD055, right: size.width * numD055),
      enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(width: size.width * numD001, color: Colors.grey),
          borderRadius: BorderRadius.circular(
            size.width * numD015,
          )),
    ),
  );
}

Widget commonText({
  required String text,
}) {
  return Text(
    text,
    textAlign: TextAlign.start,
    textDirection: TextDirection.ltr,
    style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
  );
}
