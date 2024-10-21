import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SizeUtil {

  static double f6 = SizerUtil.deviceType == DeviceType.tablet ? 6.sp : 9.sp;
  static double f9 = SizerUtil.deviceType == DeviceType.tablet ? 7.sp : 9.sp;
  static double f10 = SizerUtil.deviceType == DeviceType.tablet ? 7.5.sp : 10.sp;
  static double f11 = SizerUtil.deviceType == DeviceType.tablet ? 8.5.sp : 11.sp;
  static double f12 = SizerUtil.deviceType == DeviceType.tablet ? 10.sp : 12.sp;
  static double f13 = SizerUtil.deviceType == DeviceType.tablet ? 11.sp : 13.sp;
  static double f14 = SizerUtil.deviceType == DeviceType.tablet ? 12.sp : 14.sp;
  static double f16 = SizerUtil.deviceType == DeviceType.tablet ? 13.sp : 16.sp;
  static double f18 = SizerUtil.deviceType == DeviceType.tablet ? 14.sp : 18.sp;
}
