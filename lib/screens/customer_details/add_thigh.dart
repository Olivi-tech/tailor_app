import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tailor_app_final_final/screens/screens.dart';
import 'package:tailor_app_final_final/utils/widgets.dart';

class AddThigh extends StatefulWidget {
  const AddThigh({Key? key}) : super(key: key);

  @override
  State<AddThigh> createState() => _AddThighState();
}

class _AddThighState extends State<AddThigh> {
  String? value;
  @override
  Widget build(BuildContext context) {
    return CommonWidgets.addCustomerDetails(
        context: context,
        list: CommonWidgets.generateList(15, 14),
        stringAssetImg: 'assets/images/thigh.png',
        name: 'Thigh',
        onPressed: (String? value) {
          setState(() {
            this.value = value;
          });
        },
        nextOnPressed: () {
          if (value == null || value!.isEmpty) {
            Fluttertoast.showToast(msg: 'Select Value');
          } else {
            CustomerPersonalDetails.modelAddCustomer.thigh = value!;
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: const AddInseam()));
          }
        },
        value: value);
  }
}
