import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tailor_app_final_final/screens/screens.dart';
import 'package:tailor_app_final_final/utils/widgets.dart';

class AddBiceps extends StatefulWidget {
  const AddBiceps({Key? key}) : super(key: key);

  @override
  State<AddBiceps> createState() => _AddBicepsState();
}

class _AddBicepsState extends State<AddBiceps> {
  String? value;
  @override
  Widget build(BuildContext context) {
    return CommonWidgets.addCustomerDetails(
        context: context,
        list: CommonWidgets.generateList(9, 9),
        stringAssetImg: 'assets/images/biceps-removebg-preview.png',
        name: 'Biceps',
        onPressed: (String? value) {
          setState(() {
            this.value = value;
          });
        },
        nextOnPressed: () {
          if (value == null || value!.isEmpty) {
            Fluttertoast.showToast(msg: 'Select Value');
          } else {
            CustomerPersonalDetails.modelAddCustomer.biceps = value!;
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: const AddWrist()));
          }
        },
        value: value);
  }
}
