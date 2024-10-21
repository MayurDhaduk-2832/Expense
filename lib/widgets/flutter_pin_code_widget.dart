import 'package:expense_tracker/res/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sizer/sizer.dart';
import '../res/strings.dart';

class PinCodeWidget extends StatefulWidget {
   PinCodeWidget(
      {Key? key,
      required this.onFullPin,
      this.firstEnterInApp,
      required this.initialPinLength,
      required this.onChangedPin,
      this.onChangedPinLength,
      this.leftBottomWidget = const SizedBox(),
      this.clearOnFilled = true,
      this.reEnterPin})
      : super(key: key);

  /// reenter pin
  bool? reEnterPin;

  /// first time enter
  bool? firstEnterInApp;

  /// Callback after all pins input
  final void Function(String pin, PinCodeState state) onFullPin;

  /// Callback onChange
  final void Function(String pin) onChangedPin;

  /// Callback onChange length
  final void Function(int length)? onChangedPinLength;

  /// How many pins to use
  final int initialPinLength;

  /// Any widgets on the empty place, usually - 'forgot?'
  final Widget leftBottomWidget;

  /// clear indicators when all digits are filled
  final bool clearOnFilled;

  @override
  State<StatefulWidget> createState() => PinCodeState();
}

class PinCodeState<T extends PinCodeWidget> extends State<T> {
  static const defaultPinLength = fourPinLength;
  static const sixPinLength = 6;
  static const fourPinLength = 4;
  final _gridViewKey = GlobalKey();
  final _key = GlobalKey<ScaffoldState>();

  late int pinLength;
  late String pin;
  late double _aspectRatio;

  int currentPinLength() => pin.length;

  @override
  void initState() {
    super.initState();
    pinLength = widget.initialPinLength;
    pin = '';
    _aspectRatio = 0;
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  void clear() {
    if (_key.currentState?.mounted != null && _key.currentState!.mounted) {
      setState(() => pin = '');
    }
  }

  void reset() => setState(() {
        pin = '';
        pinLength = widget.initialPinLength;
      });

  void changePinLength(int length) {
    setState(() {
      pinLength = length;
      pin = '';
    });

    widget.onChangedPinLength?.call(length);
  }

  void setDefaultPinLength() => changePinLength(widget.initialPinLength);

  void calculateAspectRatio() {
    final renderBox =
        _gridViewKey.currentContext!.findRenderObject() as RenderBox;
    final cellWidth = renderBox.size.width / 3;
    final cellHeight = renderBox.size.height / 4;
    if (cellWidth > 0 && cellHeight > 0) {
      _aspectRatio = cellWidth / cellHeight;
    }

    setState(() {});
  }

  void changeProcessText(String text) {}

  void close() {
    Navigator.of(_key.currentContext!).pop();
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(key: _key, body: body(context), resizeToAvoidBottomInset: false);

  Widget body(BuildContext context) {
    return Container(
      color: AppColors.buttonColor,
      key: _gridViewKey,
      padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 0.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10.h),
          Text( widget.firstEnterInApp == false ? "Enter your Pin":
            widget.reEnterPin == true
                ? "Ok. Re type your PIN again."
                : "Let’s  setup your PIN",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15.sp,
                color: AppColors.whiteTextColor),
          ),
          SizedBox(height: SizerUtil.deviceType == DeviceType.tablet ? 6.h : 10.h),
          SizedBox(
            width: SizerUtil.deviceType == DeviceType.tablet ? 270 : 180,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(pinLength, (index) {
                double size = SizerUtil.deviceType == DeviceType.tablet ? 40 : 32.0;
                final isFilled = pin.length > index ? true : false;
                return Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0xFFEEE5FF).withOpacity(0.4), width: 3),
                      shape: BoxShape.circle,
                      color: isFilled
                          ? AppColors.whiteTextColor
                          : AppColors.buttonColor,
                    ));
              }),
            ),
          ),
          const Spacer(),
          Container(
              child: _aspectRatio > 0
                  ? GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      childAspectRatio: 1.4,
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(12, (index) {
                        if (index == 9) {
                          return widget.leftBottomWidget;
                        } else if (index == 10) {
                          index = 0;
                        } else if (index == 11) {
                          return GestureDetector(
                            onTap: () => _onRemove(),
                            child: Image.asset(StringRes.forwardIcon),
                          );
                        } else {
                          index++;
                        }

                        return GestureDetector(
                          onTap: () => _onPressed(index),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              '$index',
                              style: TextStyle(
                                  color: AppColors.whiteTextColor,
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        );
                      }),
                    )
                  : null),
        ],
      ),
    );
  }

  void _onPressed(int num) async {
    setState(() {
      if (currentPinLength() >= pinLength) {
        return;
      }

      pin += num.toString();

      widget.onChangedPin(pin);

      if (pin.length == pinLength) {
        widget.onFullPin(pin, this);
      }
    });
    if (widget.clearOnFilled && pin.length == pinLength) {
      await Future.delayed(const Duration(milliseconds: 300));
      clear();
    }
  }

  void _onRemove() {
    if (currentPinLength() == 0) {
      return;
    }
    setState(() => pin = pin.substring(0, pin.length - 1));
  }

  void _afterLayout(dynamic _) {
    setDefaultPinLength();
    calculateAspectRatio();
  }
}

// Credits for the code below for https://stackoverflow.com/a/60868972/7198006
typedef OnWidgetSizeChange = void Function(Size size);

class _MeasureSizeRenderObject extends RenderProxyBox {
  Size? oldSize;
  final OnWidgetSizeChange onChange;

  _MeasureSizeRenderObject(this.onChange);

  @override
  void performLayout() {
    super.performLayout();

    Size newSize = child!.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onChange(newSize);
    });
  }
}

class MeasureSize extends SingleChildRenderObjectWidget {
  const MeasureSize({
    Key? key,
    required this.onChange,
    required Widget child,
  }) : super(key: key, child: child);

  /// Function to be called when layout changes
  final OnWidgetSizeChange onChange;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _MeasureSizeRenderObject(onChange);
  }
}
