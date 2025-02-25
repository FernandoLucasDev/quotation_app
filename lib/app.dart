import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotation/data/api/exchange_api.dart';
import 'package:quotation/domain/repositories/exchange_repositorie.dart';
import 'package:quotation/services/quotation_service.dart';
import 'package:quotation/utils/colors.dart';
import 'package:quotation/view_model/graphics_view_model.dart';
import 'package:quotation/view_model/quotation_view_model.dart';
import 'package:quotation/views/graphics_screen.dart';
import 'package:quotation/views/quotation_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  var currentIndex = 1;

  @override
  Widget build(BuildContext context) {

    Map<int, Widget> page = {
      0: GraphicsScreen(),
      1: QuotationScreen(),
      2: GraphicsScreen(),
      3: QuotationScreen(),
    };

    return MultiProvider(
      providers: [
        Provider<ExchangeApi>(
          create: (_) => ExchangeApi(),
        ),
        ProxyProvider<ExchangeApi, ExchangeRepository>(
          update: (_, api, __) => ExchangeRepository(api: api),
        ),
        ChangeNotifierProxyProvider<ExchangeRepository, QuotationViewModel>(
          create: (_) => QuotationViewModel(
            service: QuotationService(
              exchangeRepository: ExchangeRepository(api: ExchangeApi()),
            ),
          ),
          update: (_, repository, model) => model!..updateRepository(repository),
        ),
        ChangeNotifierProxyProvider<ExchangeRepository, GraphicsViewModel>(
          create: (_) => GraphicsViewModel(
            service: QuotationService(
              exchangeRepository: ExchangeRepository(api: ExchangeApi()),
            ),
          ),
          update: (_, repository, model) => model!..updateRepository(repository),
        ),
      ],
      child: MaterialApp(
        title: 'Quotation App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primaryTextColor),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: page[currentIndex],
          bottomNavigationBar: SalomonBottomBar(
            currentIndex: currentIndex,
            onTap: (i) => setState(() => currentIndex = i),
            backgroundColor: appBackgroundColor,
            items: [
              SalomonBottomBarItem(
                icon: Icon(
                  Icons.newspaper_outlined,
                  color: secondaryTextColor,
                ),
                title: Text("News"),
                selectedColor: btnBackgroundColor,
              ),
              SalomonBottomBarItem(
                icon: Icon(
                    Icons.currency_exchange_outlined,
                    color: secondaryTextColor,
                ),
                title: Text("Exchanges"),
                selectedColor: btnBackgroundColor,
              ),
              SalomonBottomBarItem(
                icon: Icon(
                    Icons.trending_up_outlined,
                    color: secondaryTextColor
                ),
                title: Text("Graphics"),
                selectedColor: btnBackgroundColor,
              ),
              SalomonBottomBarItem(
                icon: Icon(
                    Icons.manage_accounts_outlined,
                    color: secondaryTextColor
                ),
                title: Text("Settings"),
                selectedColor: btnBackgroundColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
