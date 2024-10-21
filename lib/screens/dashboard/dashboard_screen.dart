import 'package:expense_tracker/model/income_expense_model.dart';
import 'package:expense_tracker/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../res/strings.dart';
import '../account/account_screen.dart';
import '../budget/budget_screen.dart';
import '../home/home_screen.dart';
import '../transaction/trasaction_screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  AnimationController? animationController;
  Animation? degOneTranslationAnimation;
  Animation? rotationAnimation;
  bool showOverlay = false;

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 250));
    degOneTranslationAnimation = Tween(begin: 0.0,end: 1.0).animate(animationController!);
    rotationAnimation = Tween(begin: 0.0,end: 45.0).animate(CurvedAnimation(parent: animationController!, curve: Curves.easeInOut));
    animationController?.addListener(() {
      if(animationController!.status == AnimationStatus.forward){
        showOverlay = true;
      } else if(animationController!.status == AnimationStatus.reverse){
        showOverlay = false;
      }
      setState(() {

    });});
  }

  double getRadiantRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  final List<Widget> _pageList = const [
    HomeScreen(),
    TransactionScreen(),
    BudgetScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(55),
      body: Stack(
        children: [
          _pageList[currentIndex],
          showOverlay ? Container(
            height: 100.h,
            width: 100.w,
            decoration: BoxDecoration(
                gradient:  LinearGradient(
                    colors: [
                      const Color.fromRGBO(139, 80, 255, 0),
                      const Color.fromRGBO(139, 80, 255, 0.24),
                    ],
                    stops: const [0.0, 1.0],
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    tileMode: TileMode.clamp
                )
            ),
          ): SizedBox(),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: size.width,
              color: showOverlay ? Colors.transparent : Color(0xFFFCFCFC),
              height: SizerUtil.deviceType == DeviceType.tablet ? 120 : 90,
              child:   CustomPaint(
                size: Size(size.width, 100),
                painter: BNBCustomPainter(),
              ),

              // Stack(
              //   clipBehavior: Clip.none,
              //   children: [
              //     CustomPaint(
              //       size: Size(size.width, 100),
              //       painter: BNBCustomPainter(),
              //     ),
              //     Center(
              //       heightFactor: 0.45,
              //       child: Visibility(
              //         child: Stack(
              //           alignment: Alignment.center,
              //           children: [
              //             Transform.translate(
              //               offset: Offset.fromDirection(
              //                   getRadiantRadiansFromDegree(215), degOneTranslationAnimation!.value * 90),
              //               child: GestureDetector(
              //                   onTap: (){
              //                     Navigator.pushNamed(context, "/addExpenses",arguments: StringRes.income);
              //                   },
              //                   child: Image.asset(StringRes.incomeBottomIcon,width: 56,height: 56)),
              //             ),
              //             Transform.translate(
              //               offset: Offset.fromDirection(
              //                   getRadiantRadiansFromDegree(270), degOneTranslationAnimation!.value * 110),
              //               child: Image.asset(StringRes.transactionBottomIcon,width: 56,height: 56),
              //             ),
              //             Transform.translate(
              //               offset:
              //               Offset.fromDirection(getRadiantRadiansFromDegree(325), degOneTranslationAnimation!.value * 90),
              //               child: GestureDetector(
              //                   onTap: (){
              //                     Navigator.pushNamed(context, "/addExpenses",arguments: StringRes.expense);
              //                   },
              //                   child: Image.asset(StringRes.expenseBottomIcon,width: 56,height: 56)),
              //             ),
              //             SizedBox(
              //               height: 65.0,
              //               width: 65.0,
              //               child: FittedBox(
              //                 child: FloatingActionButton(
              //                   backgroundColor: AppColors.buttonColor,
              //                   elevation: 0.1,
              //                   onPressed: () {
              //                     if(animationController!.isCompleted) {
              //                       animationController!.reverse();
              //                     }else{
              //                       animationController!.forward();
              //                     }
              //                   },
              //                   child: Transform(
              //                       transform: Matrix4.rotationZ(getRadiantRadiansFromDegree(rotationAnimation?.value)),
              //                       alignment: Alignment.center,
              //                       child: Image.asset(StringRes.addIcon)),
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //     Container(
              //       width: size.width,
              //       height: 90,
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           _bottomItem(
              //               index: 0,
              //               name: StringRes.home,
              //               image: StringRes.homeIcon),
              //           _bottomItem(
              //               index: 1,
              //               name: StringRes.transaction,
              //               image: StringRes.transactionIcon),
              //           Container(
              //             width: size.width * 0.20,
              //           ),
              //           _bottomItem(
              //               index: 2,
              //               name: StringRes.budget,
              //               image: StringRes.budgetIcon),
              //           _bottomItem(
              //               index: 3,
              //               name: StringRes.profile,
              //               image: StringRes.profileIcon),
              //         ],
              //       ),
              //     )
              //   ],
              // ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: size.width,
              height: SizerUtil.deviceType == DeviceType.tablet ? 120 : 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _bottomItem(
                      index: 0,
                      name: StringRes.home,
                      image: StringRes.homeIcon),
                  _bottomItem(
                      index: 1,
                      name: StringRes.transaction,
                      image: StringRes.transactionIcon),
                  Container(
                    width: size.width * 0.20,
                  ),
                  _bottomItem(
                      index: 2,
                      name: StringRes.budget,
                      image: StringRes.budgetIcon),
                  _bottomItem(
                      index: 3,
                      name: StringRes.profile,
                      image: StringRes.profileIcon),
                ],
              ),
            ),
          ),

          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Center(
              heightFactor: 2.65,
              child: Transform.translate(
                offset: Offset.fromDirection(
                    getRadiantRadiansFromDegree(215), SizerUtil.deviceType == DeviceType.tablet ? degOneTranslationAnimation!.value * 150 :degOneTranslationAnimation!.value * 90),
                child: GestureDetector(
                    onTap: (){
                      animationController!.reverse();
                      Navigator.pushNamed(context, "/addExpenses",arguments: IncomeExpenseModel(type: StringRes.income));
                    },
                    child: Image.asset(StringRes.incomeBottomIcon,width: SizerUtil.deviceType == DeviceType.tablet ? 90 :56,height: SizerUtil.deviceType == DeviceType.tablet ? 90 :56)),
              ),
            ),
          ),
          Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              child: Center(
            heightFactor: 2.65,
              child: Transform.translate(
                offset: Offset.fromDirection(
                    getRadiantRadiansFromDegree(270),SizerUtil.deviceType == DeviceType.tablet ? degOneTranslationAnimation!.value * 180 : degOneTranslationAnimation!.value * 110),
                child: Image.asset(StringRes.transactionBottomIcon,width: SizerUtil.deviceType == DeviceType.tablet ? 90 :56,height: SizerUtil.deviceType == DeviceType.tablet ? 90 :56),
              ),
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Center(
              heightFactor: 2.65,
              child: Transform.translate(
                offset:
                Offset.fromDirection(getRadiantRadiansFromDegree(325), SizerUtil.deviceType == DeviceType.tablet ? degOneTranslationAnimation!.value * 150 : degOneTranslationAnimation!.value * 90),
                child: GestureDetector(
                    onTap: (){
                      animationController!.reverse();
                      Navigator.pushNamed(context, "/addExpenses",arguments: IncomeExpenseModel(type: StringRes.expense));
                    },
                    child: Image.asset(StringRes.expenseBottomIcon,
                        width: SizerUtil.deviceType == DeviceType.tablet ? 90 : 56,
                        height:SizerUtil.deviceType == DeviceType.tablet ? 90 : 56)),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              heightFactor: SizerUtil.deviceType == DeviceType.tablet ? 1.5 : 2.3,
              child: SizedBox(
                height:SizerUtil.deviceType == DeviceType.tablet ? 140 :  65.0,
                width: SizerUtil.deviceType == DeviceType.tablet ? 140 : 65.0,
                child: FittedBox(
                  child: FloatingActionButton(
                    backgroundColor: AppColors.buttonColor,
                    elevation: 0.1,
                    onPressed: () {
                      if(animationController!.isCompleted) {
                        animationController!.reverse();
                      }else{
                        animationController!.forward();
                      }
                    },
                    child: Transform(
                        transform: Matrix4.rotationZ(getRadiantRadiansFromDegree(rotationAnimation?.value)),
                        alignment: Alignment.center,
                        child: Image.asset(StringRes.addIcon)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomItem({
    required String image,
    required String name,
    required int index,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Container(
        alignment: Alignment.center,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: SizerUtil.deviceType == DeviceType.tablet ? 48 : 28,
              color: currentIndex == index
                  ? AppColors.buttonColor
                  : const Color(0xFFC6C6C6),
            ),
            const SizedBox(height: 3),
            Text(
              name,
              style: TextStyle(
                fontSize:SizerUtil.deviceType == DeviceType.tablet ? 20 : 12,
                color: currentIndex == index
                    ? AppColors.buttonColor
                    : const Color(0xFFC6C6C6),
              ),
            ),
            const SizedBox(height: 7),
          ],
        ),
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Color(0xFFFCFCFC)
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 12); // Start
    path.quadraticBezierTo(size.width * 0, 0, size.width * 0.05, 0);
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 15);
    path.arcToPoint(Offset(size.width * 0.60, 15),
        radius: Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width * 0.95, 0);
    path.quadraticBezierTo(size.width, 0, size.width, 12);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
