import 'package:flutter/material.dart';
import 'package:mydompet/pages/home/home_form_page.dart';
import 'package:mydompet/providers/cash_provider.dart';
import 'package:mydompet/utils/asset.dart';
import 'package:mydompet/utils/color.dart';
import 'package:mydompet/utils/dimen.dart';
import 'package:mydompet/utils/helper.dart';
import 'package:mydompet/utils/sizeconfig.dart';
import 'package:mydompet/utils/style.dart';
import 'package:mydompet/widgets/custom_appbar.dart';
import 'package:mydompet/widgets/custom_toast.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
   const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  get bottomNavActive => null;

  Widget cardButton(IconData icon, String title, Color bgColor) {
    return Card(
      color: bgColor,
      child: Padding(
        padding: const EdgeInsets.all(sizeLarge),
        child: Column(
          children: [
            Icon(icon, size: 35, color: Colors.white),
            verticalSpaceSM(),
            Text(title, style: defaultTextWhite,)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Home", canBack: false),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(sizeSmall),
          child: Consumer<CashProvider>(
            builder: (context, provider, child) {
              return Column(
                children: [
                  Card(
                    color: Colors.black.withOpacity(0.6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: sizeMedium, horizontal: sizeSmall),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("My Balance", style: defaultTextWhite),
                                Text(formatCurrency(
                                        provider.balanceAmount), 
                                    style: balanceText),
                              ],
                            )
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: const CircleBorder()
                            ),
                            onPressed: () {
                              
                            }, 
                            child: const Icon(Icons.add, color: Colors.black,)
                          ),
                        ],
                      ),
                    ),
                  ),
                  verticalSpaceMD(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      cardButton(Icons.telegram, "Send", Colors.blue),
                      cardButton(Icons.card_giftcard, "Card", Colors.purple),
                      cardButton(Icons.more, "More", Colors.orange),
                    ],
                  ),
                  verticalSpaceMD(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Recent Activity", style: recentActivity),
                      verticalSpaceSM(),
                      SizedBox(
                        height: SizeConfig(context).parentHeight(50),
                        child: provider.cashList == null || provider.cashList!.isEmpty 
                        ? const Center(child: Text("No Activity Found"))
                        : ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: provider.cashList?.length ?? 0,
                            itemBuilder: (_, index) {
                              final balance = provider.cashList!.elementAt(index);
                              return ListTile(
                                onTap: () {
                                    provider.setIdCash = balance.id;
                                    Navigator.push(context, 
                                        MaterialPageRoute(
                                          builder: (_) => const HomeFormPage()));
                                },
                                onLongPress: () {
                                  showDialog(context: context, builder: (context) {
                                    return  AlertDialog(
                                      title: const Text("Delete data ?"),
                                      content: const Text("Data will be permanently deleted"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            provider.setIdCash = balance.id;
                                            provider.deleteCash().then((value) {
                                              if(value == 1) {
                                                Navigator.pop(context);
                                                customToast("Success Deleted");
                                              }
                                            });
                                          }, 
                                          child: const Text("Yes")),
                                        TextButton(
                                          onPressed: () => Navigator.pop(context), 
                                          child: const Text("No")
                                        ),
                                      ],
                                    );
                                  });
                                },
                                leading: Image.asset(SPLASH_LOGO),
                                title: Text(
                                    balance.title, 
                                    style: listTileTitle,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis
                                ),
                                subtitle: Text(
                                    balance.date, 
                                    style: listTileSubtitle,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis
                                ),
                                trailing: Text(
                                    formatCurrency(balance.price),
                                    style: listTileTrailing(balance.cashType == 1 ? statusExpense : appDefault)),
                              );
                            },
                          ),
                        )
                    ],
                  ),
                  verticalSpaceMD()
                ],
              );
            }
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appTheme,
        onPressed: () {
          Navigator.push(context, 
              MaterialPageRoute(
                builder: (_) => const HomeFormPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}