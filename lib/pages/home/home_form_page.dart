import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mydompet/providers/cash_provider.dart';
import 'package:mydompet/utils/helper.dart';
import 'package:mydompet/utils/sizeconfig.dart';
import 'package:mydompet/widgets/custom_appbar.dart';
import 'package:mydompet/widgets/custom_textfield.dart';
import 'package:mydompet/widgets/custom_toast.dart';
import 'package:provider/provider.dart';

class HomeFormPage extends StatefulWidget {
  static const routeName = "/homeform";
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

  void submit(BuildContext context) async {
    final loader = context.loaderOverlay;
    loader.show();
    cashProvider.insertCash().then((value) {
       loader.hide();
      if (value.title.isNotEmpty) {
        customToast("Add task success");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    cashProvider = context.read<CashProvider>();
    return Scaffold(
      appBar: const CustomAppBar(title: "Textone", canBack: true),
      resizeToAvoidBottomInset: false,
      body: LoaderOverlay(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              children: [
                verticalSpaceMD(),
                CustomTextFields(
                  title: "Kegiatan",
                  controller: cashProvider.activityController
                ),
                verticalSpaceMD(),
                 CustomTextFields(
                  title: "Harga",
                  inputType: TextInputType.number,
                  controller: cashProvider.priceController
                ),
                verticalSpaceMD(),
                 CustomTextFields(
                  title: "Tanggal",
                  isDate: true,
                  controller: cashProvider.dateController
                ),
                verticalSpaceMD(),
                SizedBox(
                  width: SizeConfig(context).parentWidth(100),
                  child: ElevatedButton(
                    onPressed: () {
                      submit(context);
                      cashProvider.clearController();
                    },
                    style: ElevatedButton.styleFrom(shape: const StadiumBorder()), 
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