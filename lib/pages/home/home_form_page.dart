import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mydompet/providers/cash_provider.dart';
import 'package:mydompet/utils/color.dart';
import 'package:mydompet/utils/helper.dart';
import 'package:mydompet/utils/sizeconfig.dart';
import 'package:mydompet/widgets/custom_appbar.dart';
import 'package:mydompet/widgets/custom_textfield.dart';
import 'package:mydompet/widgets/custom_toast.dart';
import 'package:provider/provider.dart';

class HomeFormPage extends StatefulWidget {
  static const String routeName = "/formHome";

  const HomeFormPage({super.key});
  

  @override
  State<HomeFormPage> createState() => _HomeFormPageState();
}

class _HomeFormPageState extends State<HomeFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late CashProvider cashProvider;
  

  @override
  void dispose() {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      cashProvider.clearController();
    });
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      if (cashProvider.idCash != null) {
        cashProvider.fetchToController();
      }
    });
  }

  void submit(BuildContext context) async {
    final loader = context.loaderOverlay;
    loader.show();
    if (cashProvider.idCash != null) {
      cashProvider.updateCash().then((value){
        loader.hide();
        if (value == 1) {
          customToast("Update task success");
        }
      });
    } else {
      cashProvider.insertCash().then((value) {
        loader.hide();
        if (value.title.isNotEmpty) {
          customToast("Add task success");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    cashProvider = context.watch<CashProvider>();
    return Scaffold(
      appBar: const CustomAppBar(title: "Form", canBack: true),
      resizeToAvoidBottomInset: false,
      body: LoaderOverlay(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Column(
              children: [
                verticalSpaceMD(),
                CustomTextFields(
                  title: "Activity",
                  controller: cashProvider.activityController
                ),
                verticalSpaceMD(),
                 CustomTextFields(
                  title: "Price",
                  inputType: TextInputType.number,
                  controller: cashProvider.priceController
                ),
                verticalSpaceMD(),
                 CustomTextFields(
                  title: "Date",
                  isDate: true,
                  controller: cashProvider.dateController
                ),
                verticalSpaceMD(),
                Row(
                  children: [
                    Flexible(
                      child: RadioListTile(
                        title: const Text("Income"),
                        value: 0, 
                        groupValue: cashProvider.cashType, 
                        onChanged: (value) {
                          cashProvider.setCashType = value;
                        },
                      ),
                    ),
                    Flexible(
                      child: RadioListTile(
                        title: const Text("Expense"),
                        value: 1, 
                        groupValue: cashProvider.cashType, 
                        onChanged: (value) {
                          cashProvider.setCashType = value; 
                        },
                      ),
                    )
                  ],
                ),
                verticalSpaceMD(),
                SizedBox(
                  width: SizeConfig(context).parentWidth(100),
                  child: ElevatedButton(
                    onPressed: () {
                      submit(context);
                      cashProvider.clearController();
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(), 
                        backgroundColor: appTheme), 
                    child: const Text("Submit")
                  ),
                ),
              ],
            ),
          ) 
        ),
      ),
    );
  }
}