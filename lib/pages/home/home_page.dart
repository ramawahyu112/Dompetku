import 'package:flutter/material.dart';
import 'package:mydompet/providers/balance_provider.dart';
import 'package:mydompet/providers/cash_provider.dart';
import 'package:mydompet/utils/asset.dart';
import 'package:mydompet/utils/dimen.dart';
import 'package:mydompet/utils/helper.dart';
import 'package:mydompet/utils/sizeconfig.dart';
import 'package:mydompet/utils/style.dart';
import 'package:mydompet/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
   const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late BalanceProvider balanceProvider;

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
    balanceProvider = context.watch<BalanceProvider>(); 
    return Scaffold(
      appBar: const CustomAppBar(title: "Home", canBack: false),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(sizeSmall),
          child: Column(
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
                            Text("Rp. ${balanceProvider.balanceAmount}", 
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
              Consumer<CashProvider>(
                builder: (context, provider, child){
                  print("test");
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Recent Activity", style: recentActivity),
                      verticalSpaceSM(),
                      SizedBox(
                        height: SizeConfig(context).parentHeight(50),
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: provider.cashList?.length ?? 0,
                          itemBuilder: (context, index) {
                            final balance = provider.cashList!.elementAt(index);
                            return ListTile(
                              leading: Image.asset(SPLASH_LOGO),
                              title: Text(balance.title, style: listTileTitle),
                              subtitle: Text(balance.date, style: listTileSubtitle),
                              trailing: Text("Rp ${balance.price}", style: listTileTrailing),
                            );
                          },
                        ),
                      )
                    ],
                  );
                }
              ),
              verticalSpaceMD()
            ],
          ),
        ),
      ),
    );
  }
}

class RecentActivity extends StatefulWidget {
  final String title;
  final String date;
  final String price;
  const RecentActivity({
    super.key,
    this.title = "-", 
    this.date = "-", 
    this.price = "0"
  });

  @override
  State<RecentActivity> createState() => _RecentActivityState();
}

class _RecentActivityState extends State<RecentActivity> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Recent Activity", style: recentActivity),
        verticalSpaceSM(),
        SizedBox(
          height: SizeConfig(context).parentHeight(50),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 10,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.asset(SPLASH_LOGO),
                title: Text(widget.title, style: listTileTitle),
                subtitle: Text(widget.date, style: listTileSubtitle),
                trailing: Text("Rp ${widget.price}", style: listTileTrailing),
              );
            },
          ),
        )
      ],
    );
  }
}