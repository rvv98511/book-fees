import 'dart:io';

import '../resources/strings.dart';
import '../resources/widgets/alert_dialog_widget.dart';
import '../resources/widgets/button_widget.dart';
import '../resources/widgets/show_dialog_widget.dart';
import '../resources/widgets/text_and_text_field_widget.dart';
import '../resources/widgets/text_and_text_widget.dart';
import '../resources/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  TextEditingController? customerNameController, bookNumberController;
  FocusNode? focusNode;
  bool isVip = false;
  var bookMoney = 0;
  var customerTotal = 0;
  var vipCustomerTotal = 0;
  var revenueTotal = 0;
  SharedPreferences? sharedPreferences;
  final Future<SharedPreferences> _sharedPreferences = SharedPreferences.getInstance();
  Future<Map<String, int>>? saveOldResult;
  bool newSession = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    customerNameController = TextEditingController();
    bookNumberController = TextEditingController();
    focusNode = FocusNode();
    getInformationFromDatabase();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    customerNameController!.dispose();
    bookNumberController!.dispose();
    focusNode!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var heightStatusBar = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                // Trừ đi đoạn StatusBar (time, nhà mạng, cột sóng...)
                height: heightStatusBar,
              ),
              TextWidget(
                  textString: SELL_BOOK_ONLINE_TITLE,
                  textColor: Colors.white,
                  textAlignment: TextAlign.center,
                  widthBox: MediaQuery.of(context).size.width
              ),
              TextWidget(
                  textString: INVOICE_INFORMATION_TITLE,
                  textColor: Colors.black,
                  textAlignment: TextAlign.left,
                  widthBox: MediaQuery.of(context).size.width,
                  marginBox: EdgeInsets.only(bottom: 5)
              ),
              TextAndTextFieldWidget(
                  textString: CUSTOMER_NAME_LABEL,
                  textController: customerNameController,
                  hintText: HINT_CUSTOMER_NAME,
                  typeInput: TextInputType.text,
                  focusNode: focusNode
              ),
              TextAndTextFieldWidget(
                  textString: BOOK_NUMBER_LABEL,
                  textController: bookNumberController,
                  hintText: HINT_BOOK_NUMBER,
                  typeInput: TextInputType.number
              ),
              checkBoxVip(),
              TextAndTextWidget(
                  textString: INTO_MONEY,
                  colorBackgroundContentBox: Colors.black26,
                  textContentBox: bookMoney.toString(),
                  textAlignment: TextAlign.center
              ),
              Container(
                margin: const EdgeInsets.only(left: 5, right: 5),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: ButtonWidget(
                            buttonText: CALCULATED_INTO_MONEY,
                            buttonFunction: () {
                              setState(() {
                                bookMoney = caculateBillFunction();
                              });
                            }
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: ButtonWidget(
                            buttonText: NEXT,
                            buttonFunction: () {
                              saveInformation();
                            }
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: ButtonWidget(
                            buttonText: STATISTICAL,
                            buttonFunction: () {
                              showDialog<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ShowDialogWidget(
                                        titleDialog: ANNOUNCEMENT,
                                        messageDialog: REVENUE_TOTAL + " " + revenueTotal.toString() + " ₫",
                                        closeButtonText: CLOSE_ANNOUNCEMENT_STATISTICAL_REVENUE,
                                        onClosePress: () {
                                          // Xoá focus khỏi Text Field
                                          FocusScope.of(context).unfocus();
                                          Navigator.of(context).pop();
                                        }
                                    );
                                  }
                              );
                            }
                        )
                    ),
                  ],
                ),
              ),
              TextWidget(
                  textString: INFORMATION_STATISTICAL,
                  textColor: Colors.black,
                  textAlignment: TextAlign.left,
                  widthBox: MediaQuery.of(context).size.width
              ),
              newSession ? FutureBuilder<Map<String, int>> (
                future: saveOldResult,
                builder: (context, snapshot) {
                  if(snapshot.hasError)
                    return Center(
                      child: Text(ERROR_LOADING_SHARE_PREFERENCES),
                    );
                  if(!snapshot.hasData)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  Map<String, int> oldResultData = snapshot.data!;
                  newSession = false;
                  return Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Column(
                      children: [
                        TextAndTextWidget(
                            textString: CUSTOMER_TOTAL,
                            textContentBox: oldResultData["customer_total"].toString(),
                            colorBackgroundContentBox: Colors.white,
                            textAlignment: TextAlign.left
                        ),
                        TextAndTextWidget(
                            textString: CUSTOMER_VIP_TOTAL,
                            textContentBox: oldResultData["vip_customer_total"].toString(),
                            colorBackgroundContentBox: Colors.white,
                            textAlignment: TextAlign.left
                        ),
                        TextAndTextWidget(
                            textString: REVENUE_TOTAL,
                            textContentBox: oldResultData["revenue_total"].toString(),
                            colorBackgroundContentBox: Colors.white,
                            textAlignment: TextAlign.left
                        ),
                      ],
                    ),
                  );
                }
              ) :
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Column(
                  children: [
                    TextAndTextWidget(
                        textString: CUSTOMER_TOTAL,
                        textContentBox: customerTotal.toString(),
                        colorBackgroundContentBox: Colors.white,
                        textAlignment: TextAlign.left
                    ),
                    TextAndTextWidget(
                        textString: CUSTOMER_VIP_TOTAL,
                        textContentBox: vipCustomerTotal.toString(),
                        colorBackgroundContentBox: Colors.white,
                        textAlignment: TextAlign.left
                    ),
                    TextAndTextWidget(
                        textString: REVENUE_TOTAL,
                        textContentBox: revenueTotal.toString() + " ₫",
                        colorBackgroundContentBox: Colors.white,
                        textAlignment: TextAlign.left
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 30,
                color: Colors.green,
              ),
              _logoutButton()
            ],
          ),
        ),
      ),
    );
  }

  checkBoxVip() {
    return Container(
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: const SizedBox()),
          Expanded(
              flex: 3,
              child: CheckboxListTile(
                title: Text(CHECK_BOX_VIP),
                value: isVip,
                activeColor: Colors.red,
                onChanged: (bool? newIsVip) {
                  setState(() {
                    isVip = newIsVip!;
                  });
                },
                // leading là hiển hiển thị checkbox ở phía trước
                controlAffinity: ListTileControlAffinity.leading,
              ))
        ],
      ),
    );
  }

  int caculateBillFunction() {
    if(isVip)
      return (int.parse(bookNumberController!.text == "" ? "0" : bookNumberController!.text) * 20000 * 0.9).toInt();
    else
      return int.parse(bookNumberController!.text == "" ? "0" : bookNumberController!.text) * 20000;
  }

  void saveInformation() {
    if(customerNameController!.text != "" && bookNumberController!.text != "" && bookNumberController!.text != "0") {
      customerTotal++;
      if(isVip)
        vipCustomerTotal++;
      if(bookMoney != 0)
        revenueTotal += bookMoney;
      else {
        bookMoney = caculateBillFunction();
        revenueTotal += bookMoney;
      }
      customerNameController!.text = "";
      bookNumberController!.text = "";
      bookMoney = 0;
      setState(() {
        isVip = false;
      });
      focusNode!.requestFocus();
      saveInformationInDatabase(
          customerTotal: customerTotal,
          vipCustomerTotal: vipCustomerTotal,
          revenueTotal: revenueTotal
      );
    }
  }

  void saveInformationInDatabase({required int customerTotal, required int vipCustomerTotal, required int revenueTotal}) async {
    final SharedPreferences sharedPreferences = await _sharedPreferences;
    sharedPreferences.setInt("customer_total", customerTotal);
    sharedPreferences.setInt("vip_customer_total", vipCustomerTotal);
    sharedPreferences.setInt("revenue_total", revenueTotal);
  }

  getInformationFromDatabase() {
    saveOldResult = _sharedPreferences.then((SharedPreferences sharedPreferences) {
      customerTotal = sharedPreferences.getInt("customer_total") ?? 0;
      vipCustomerTotal = sharedPreferences.getInt("vip_customer_total") ?? 0;
      revenueTotal = sharedPreferences.getInt("revenue_total") ?? 0;
      return {
        "customer_total" : customerTotal,
        "vip_customer_total" : vipCustomerTotal,
        "revenue_total" : revenueTotal
      };
    });
  }

  void clearSharedPreference() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences!.clear();
  }

  _logoutButton() {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialogWidget(
                        titleDialog: ANNOUNCEMENT,
                        messageDialog: ANNOUNCEMENT_LOGOUT_CONTENT,
                        negativeButtonText: CONFIRM_NO_ANNOUNCEMENT,
                        positiveButtonText: CONFIRM_YES_ANNOUNCEMENT,
                        onNegativePress: () {
                          Navigator.of(context).pop();
                        },
                        onPositivePress: () {
                          clearSharedPreference();
                          exit(0);
                        }
                    );
                  }
                );
              },
              icon: Icon(Icons.logout)
          )
        ],
      ),
    );
  }
}
