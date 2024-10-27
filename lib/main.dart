import 'package:expense_tracker/screens/account/account_details_screen.dart';
import 'package:expense_tracker/screens/account/account_screen.dart';
import 'package:expense_tracker/screens/account/add_edit_account_screen.dart';
import 'package:expense_tracker/screens/auth_screen/forgot_password_screen.dart';
import 'package:expense_tracker/screens/auth_screen/login_screen.dart';
import 'package:expense_tracker/screens/auth_screen/otp_verification_screen.dart';
import 'package:expense_tracker/screens/auth_screen/reset_password_screen.dart';
import 'package:expense_tracker/screens/auth_screen/send_mail_success_screen.dart';
import 'package:expense_tracker/screens/auth_screen/setup_account_screen.dart';
import 'package:expense_tracker/screens/auth_screen/setup_pin_screen.dart';
import 'package:expense_tracker/screens/auth_screen/signup_screen.dart';
import 'package:expense_tracker/screens/budget/budget_detail_screen.dart';
import 'package:expense_tracker/screens/budget/budget_screen.dart';
import 'package:expense_tracker/screens/budget/create_budget_screen.dart';
import 'package:expense_tracker/screens/dashboard/dashboard_screen.dart';
import 'package:expense_tracker/screens/home/add_expenses_screen.dart';
import 'package:expense_tracker/screens/home/home_screen.dart';
import 'package:expense_tracker/screens/notification/notification_screen.dart';
import 'package:expense_tracker/screens/onboard_screens/onboard_screen.dart';
import 'package:expense_tracker/screens/settings/export_data_screen.dart';
import 'package:expense_tracker/screens/settings/set_notification_screen.dart';
import 'package:expense_tracker/screens/settings/setting_list_screen.dart';
import 'package:expense_tracker/screens/settings/setting_screen.dart';
import 'package:expense_tracker/screens/transaction/financial_report_screen.dart';
import 'package:expense_tracker/screens/transaction/full_financial_report_screen.dart';
import 'package:expense_tracker/screens/transaction/income_expense_details_screen.dart';
import 'package:expense_tracker/screens/transaction/trasaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'helper/shared_pref_helper.dart';
import 'provider/appdata_store_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesConst.initMySharedPreferences();
  await AppDataStore.instance.initialize();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppDataStore.instance),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          fontFamily: "Inter",
          primarySwatch: Colors.blue,
        ),
        // home: HomePage(),
        initialRoute: SharedPreferencesConst.getsAppPin() != ""
            ? "/setUpPin"
            : "/onBoard",
        routes: {
          "/onBoard": (context) => const OnBoardScreen(),
          "/signup": (context) => const SignUpScreen(),
          "/login": (context) => const LoginScreen(),
          "/otpVerification": (context) => const OtpVerificationScreen(),
          "/forgotPassword": (context) => const ForgotPasswordScreen(),
          "/sendMailSuccess": (context) => const SendMailSuccessScreen(),
          "/resetPassword": (context) => const ResetPasswordScreen(),
          "/setUpPin": (context) => const SetupPinScreen(),
          "/setUpAccount": (context) => const SetupAccountScreen(),
          "/dashBoard": (context) => const DashBoardScreen(),
          "/home": (context) => const HomeScreen(),
          "/addExpenses": (context) => const AddExpensesScreen(),
          "/notification": (context) => const NotificationScreen(),
          "/transaction": (context) => const TransactionScreen(),
          "/financialReport": (context) => const FinancialReportScreen(),
          "/fullFinancialReport": (context) =>
              const FullFinancialReportScreen(),
          "/incomeExpenseDetailScreen": (context) =>
              const IncomeExpenseDetailScreen(),
          "/budget": (context) => const BudgetScreen(),
          "/createBudget": (context) => const CreateBudgetScreen(),
          "/budgetDetail": (context) => const BudgetDetailScreen(),
          "/account": (context) => const AccountScreen(),
          "/accountDetails": (context) => const AccountDetailScreen(),
          "/addEditAccount": (context) => const AddEditAccountScreen(),
          "/setting": (context) => const SettingScreen(),
          "/settingList": (context) => const SettingListScreen(),
          "/setNotification": (context) => const SetNotificationScreen(),
          "/exportData": (context) => const ExportDataScreen(),
        },
      );
    });
  }
}
