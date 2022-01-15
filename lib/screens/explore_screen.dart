import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stc_pay/const/colors.dart';
import 'package:stc_pay/const/static_data.dart';
import 'package:stc_pay/models/add_money.dart';
import 'package:stc_pay/models/features.dart';
import 'package:stc_pay/models/payment.dart';
import 'package:stc_pay/screens/other_screens.dart';
import 'package:stc_pay/widgets/animated_button.dart';
import 'package:stc_pay/widgets/chart_graph.dart';
import 'package:stc_pay/widgets/repeated_widgets.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  // Following var will keep the width and height of this screen
  // and I will update it once screen is rendered
  double _width = 0.0, _height = 0.0;

  // Following funtion and other data will be responsible
  // for expand or collape the draggable bottom sheet
  static const double minExtent = 0.22;
  static const double maxExtent = 1.0;
  bool isExpanded = false;
  double initialExtent = minExtent;
  late BuildContext draggableSheetContext;
  void _toggleSheet() {
    if (draggableSheetContext.owner != null) {
      setState(() {
        initialExtent = isExpanded ? minExtent : maxExtent;
        isExpanded = !isExpanded;
        _isScrollingUp.value = isExpanded;
      });
      DraggableScrollableActuator.reset(draggableSheetContext);
    }
  }

  // Following funtion and bool flag will responsible
  // for changing and checking the arrow indicator icon
  // without using setState

  final ValueNotifier<bool> _isScrollingUp = ValueNotifier<bool>(false);
  _checkScrollingUpDown(DraggableScrollableNotification notification) {
    //User scrolling up
    if (notification.extent >= 0.50) {
      if (!_isScrollingUp.value) {
        _isScrollingUp.value = true;
      }
    }
    //User scrolling down
    else {
      if (_isScrollingUp.value) {
        _isScrollingUp.value = false;
      }
    }
  }

  //Initializing the class to access the static data
  final StaticData _staticData = StaticData();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    _width = _size.width;
    _height = _size.height;
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: DARK_BACKGROUND_COLOR,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
        leading: GestureDetector(
          onTap: printStcPay,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: 28,
              height: 28,
              padding: const EdgeInsets.all(7),
              child: Image.asset(
                'assets/images/user.png',
                color: Colors.white,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.15),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: printStcPay,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/notification.png',
                    color: PRIMARY_COLOR,
                    width: 25,
                    height: 25,
                  ),
                  Positioned(
                    width: 12,
                    height: 12,
                    right: 0,
                    top: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: GREEN_COLOR,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(width: 2, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: _currentPage != 0
          ? OtherScreens(currentPage: _currentPage)
          : Stack(
              children: [
                Container(
                  width: _width,
                  height: 550,
                  color: DARK_BACKGROUND_COLOR,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Balance widgets start from here
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Current balance',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                          horizontalSpace(5),
                          GestureDetector(
                            onTap: () => showAddBalanceBottoSheet(),
                            child: const Icon(
                              Icons.add_box,
                              color: GREEN_COLOR,
                              size: 20,
                            ),
                          )
                        ],
                      ),
                      verticalSpace(10),
                      RichText(
                        text: TextSpan(
                          text: 'SAR ',
                          style: _balanceTextStyle(),
                          children: [
                            const TextSpan(
                              text: "823",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 35,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -2,
                              ),
                            ),
                            TextSpan(
                              text: '.00',
                              style: _balanceTextStyle(),
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(15),

                      //Features widgets boxes begin here
                      Expanded(
                        child: PageView(
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (val) => setState(() {
                            currentIndex = val;
                          }),
                          children: [
                            GridView.builder(
                              itemCount: 6,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.5,
                              ),
                              itemBuilder: (_, int index) {
                                Features _features = Features(
                                  title: _staticData.titleList[index],
                                  image: _staticData.imgFileName[index],
                                  isNewFeature:
                                      _staticData.isNewFeaturesList[index],
                                );
                                return _featuresBoxWidget(_features);
                              },
                            ),
                            GridView.builder(
                              itemCount: 6 - 1,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.5,
                              ),
                              itemBuilder: (_, int index) {
                                Features _features = Features(
                                  title: _staticData.titleList[index],
                                  image: _staticData.imgFileName[index],
                                  isNewFeature:
                                      _staticData.isNewFeaturesList[index],
                                );
                                return _featuresBoxWidget(_features);
                              },
                            ),
                          ],
                        ),
                      ),

                      //This section is for showing the indicators
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _indicatorWidget(0),
                          horizontalSpace(5),
                          _indicatorWidget(1),
                        ],
                      ),
                      verticalSpace(20)
                    ],
                  ),
                ),
                NotificationListener<DraggableScrollableNotification>(
                  onNotification:
                      (DraggableScrollableNotification notification) {
                    _checkScrollingUpDown(notification);
                    return false;
                  },
                  child: DraggableScrollableSheet(
                      key: Key(initialExtent.toString()),
                      minChildSize: minExtent,
                      maxChildSize: maxExtent,
                      initialChildSize: initialExtent,
                      expand: true,
                      snap: true,
                      builder:
                          (BuildContext context, ScrollController controller) {
                        draggableSheetContext = context;
                        return Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 25),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                ),
                              ),
                              child: ListView(
                                controller: controller,
                                padding: EdgeInsets.zero,
                                children: [
                                  verticalSpace(35),
                                  //Qitaf features
                                  _getQitafWidget(),
                                  verticalSpace(30),
                                  //Offers slider begin here
                                  _offerSliderWidget(),
                                  verticalSpace(20),
                                  //Spending inforamtion start from here
                                  Container(
                                    width: _width,
                                    height: _height / 1.6,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(.2),
                                          spreadRadius: 1,
                                          blurRadius: 20,
                                          offset: const Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Spending analytics',
                                                style: spendingTextStyle,
                                              ),
                                              const Text(
                                                'View details',
                                                style: TextStyle(
                                                  color: PRIMARY_COLOR,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                              border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey[200]!,
                                            ),
                                          )),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    RichText(
                                                      text: TextSpan(
                                                        text: 'SAR ',
                                                        style:
                                                            _balanceTextStyle()
                                                                .copyWith(
                                                          color: Colors.red,
                                                          fontSize: 18,
                                                        ),
                                                        children: const [
                                                          TextSpan(
                                                            text: "3,281",
                                                            style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 35,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              letterSpacing: -2,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    verticalSpace(5),
                                                    const Text(
                                                      "Total spending this month",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.grey,
                                                        fontSize: 19,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 30),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          verticalSpace(25),
                                                          RichText(
                                                            text:
                                                                const TextSpan(
                                                              text: 'SAR ',
                                                              style: TextStyle(
                                                                color:
                                                                    GREEN_COLOR,
                                                                fontSize: 12,
                                                              ),
                                                              children: [
                                                                TextSpan(
                                                                  text: "3,085",
                                                                  style: TextStyle(
                                                                      color:
                                                                          GREEN_COLOR,
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      letterSpacing:
                                                                          -1,
                                                                      height:
                                                                          -5),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          verticalSpace(5),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              const CircleAvatar(
                                                                radius: 3,
                                                                backgroundColor:
                                                                    GREEN_COLOR,
                                                              ),
                                                              horizontalSpace(
                                                                  10),
                                                              const Text(
                                                                "Average spending",
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: _width,
                                                      height: 220,
                                                      alignment:
                                                          Alignment.center,
                                                      child: chartOptions == 0
                                                          ? gaugeChartWidget()
                                                          : lineChartWidget(),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        AnimatedSlidingButton(
                                          values: const [
                                            'assets/images/speedometer.png',
                                            'assets/images/graph.png',
                                          ],
                                          onToggleCallback: (index) {
                                            setState(() {
                                              chartOptions = index;
                                            });
                                          },
                                          buttonColor: Colors.white,
                                          backgroundColor:
                                              const Color(0xFFF9F9F9),
                                          textColor: Colors.grey,
                                          width: _width,
                                          height: 80,
                                        ),
                                      ],
                                    ),
                                  ),
                                  verticalSpace(20),
                                  //Transaction inforamtion widgets start from here
                                  Container(
                                    width: _width,
                                    height: 530,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(.2),
                                          spreadRadius: 1,
                                          blurRadius: 20,
                                          offset: const Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(15),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Spending history',
                                            style: spendingTextStyle,
                                          ),
                                          decoration: BoxDecoration(
                                              border: Border(
                                            bottom: BorderSide(
                                              width: .6,
                                              color: Colors.grey[300]!,
                                            ),
                                          )),
                                        ),
                                        SizedBox(
                                          height: 400,
                                          child: ListView.builder(
                                            itemCount: 4,
                                            physics:
                                                const ClampingScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            itemBuilder: (_, index) {
                                              PaymentInfo paymentInfo =
                                                  PaymentInfo.fromMap(
                                                      _staticData.expensesList[
                                                          index.isEven
                                                              ? 0
                                                              : 1]);
                                              return transactionHistoryWidget(
                                                  paymentInfo);
                                            },
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: printStcPay,
                                          child: Container(
                                            width: _width,
                                            height: 60,
                                            padding: const EdgeInsets.all(2),
                                            alignment: Alignment.center,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Text(
                                                  'See all transactions',
                                                  style: TextStyle(
                                                    color: PRIMARY_COLOR,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                horizontalSpace(10),
                                                Image.asset(
                                                  'assets/images/arrow.png',
                                                  color: PRIMARY_COLOR,
                                                  width: 13,
                                                  height: 13,
                                                ),
                                              ],
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  verticalSpace(30),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 0,
                              width: _width,
                              height: 50,
                              child: GestureDetector(
                                onTap: _toggleSheet,
                                child: Center(
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    padding: const EdgeInsets.all(16),
                                    child: ValueListenableBuilder(
                                        valueListenable: _isScrollingUp,
                                        builder: (context, bool isScrollingUp,
                                            child) {
                                          return RotatedBox(
                                            quarterTurns: isScrollingUp ? 1 : 3,
                                            child: Image.asset(
                                              'assets/images/arrow.png',
                                              color: GREEN_COLOR,
                                            ),
                                          );
                                        }),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(.1),
                                            blurRadius: 20,
                                            spreadRadius: 1,
                                            offset: const Offset(0, 0),
                                          )
                                        ]),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                ),
              ],
            ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: DARK_BACKGROUND_COLOR,
          border: Border(
            top: BorderSide(
              width: .5,
              color: Colors.grey[400]!,
            ),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          currentIndex: _currentPage,
          selectedItemColor: PRIMARY_COLOR,
          unselectedItemColor: Colors.black26,
          selectedLabelStyle: bottomBarTextStyle,
          unselectedLabelStyle: bottomBarTextStyle.copyWith(fontSize: 12),
          onTap: (val) => changePages(val),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: _getBottomBarIconImage(0),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: _getBottomBarIconImage(1),
              label: 'Accounts',
            ),
            BottomNavigationBarItem(
              icon: _getBottomBarIconImage(2),
              label: 'Cards',
            ),
            BottomNavigationBarItem(
              icon: _getBottomBarIconImage(3),
              label: 'Market',
            ),
            BottomNavigationBarItem(
              icon: _getBottomBarIconImage(4),
              label: 'More',
            ),
          ],
        ),
      ),
    );
  }

  Widget _getBottomBarIconImage(int index) {
    return Image.asset(
      'assets/images/${_staticData.pagesTitleIcons[index]}.png',
      width: _currentPage == index ? 18 : 17,
      color: _currentPage == index ? PRIMARY_COLOR : Colors.black26,
    );
  }

  //Spending text style
  TextStyle get spendingTextStyle => const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 19,
      );

  //Bottom bar title text style
  TextStyle get bottomBarTextStyle => const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: PRIMARY_COLOR,
      );
  //Balance text style
  TextStyle _balanceTextStyle() {
    return const TextStyle(
      color: Colors.black,
      fontSize: 17,
    );
  }

  Size activeIndicatorSize = const Size(13, 9);
  Size unActiveIndicatorSize = const Size(8, 8);
  int currentIndex = 0;
  int chartOptions = 0;

  // Features boxes widget begin from here
  Widget _featuresBoxWidget(Features features) {
    return GestureDetector(
      onTap: printStcPay,
      child: Container(
        width: 160,
        height: 100,
        margin: const EdgeInsets.all(10),
        padding: features.isNewFeature
            ? null
            : const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            features.isNewFeature
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        'assets/images/${features.image}.png',
                        color: PRIMARY_COLOR,
                        width: 28,
                        height: 28,
                      ),
                      horizontalSpace(10),
                      Container(
                        width: 60,
                        height: 25,
                        alignment: Alignment.center,
                        child: const Text(
                          "New",
                          style: TextStyle(
                            color: GREEN_COLOR,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: GREEN_COLOR.withOpacity(.1),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(3),
                            bottomLeft: Radius.circular(3),
                          ),
                        ),
                      ),
                    ],
                  )
                : Image.asset(
                    'assets/images/${features.image}.png',
                    color: PRIMARY_COLOR,
                    width: 28,
                    height: 28,
                  ),
            verticalSpace(10),
            Text(
              features.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.1),
                spreadRadius: 1,
                blurRadius: 20,
                offset: const Offset(0, 0),
              ),
            ]),
      ),
    );
  }

  //Page indicator widget start from here
  Widget _indicatorWidget(int index) {
    bool isActive = index == currentIndex;
    return GestureDetector(
      onTap: () => setState(() {
        currentIndex = index;
      }),
      child: AnimatedContainer(
        duration: const Duration(microseconds: 500),
        curve: Curves.easeInOut,
        width:
            isActive ? activeIndicatorSize.width : unActiveIndicatorSize.width,
        height: isActive
            ? activeIndicatorSize.height
            : unActiveIndicatorSize.height,
        color: isActive ? PRIMARY_COLOR : Colors.black26,
      ),
    );
  }

  //Qitaf widget start from here
  Widget _getQitafWidget() {
    return Container(
      width: _width,
      height: 120,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              "assets/images/qitaf.png",
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: const Text(
                "You have a qitaf account. Add it to your stc pay wallet to redeem your points quickly.",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.4,
                ),
                softWrap: true,
                maxLines: 3,
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(.2),
              spreadRadius: 1,
              blurRadius: 20,
              offset: const Offset(0, 0)),
        ],
      ),
    );
  }

  //Offer widget start from here
  Widget _offerSliderWidget() {
    return SizedBox(
      width: _width,
      height: 150,
      child: ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, int index) => Container(
          width: _width / 1.3,
          margin: const EdgeInsets.symmetric(horizontal: 12),
          height: 150,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/$index.jpeg'),
            ),
          ),
        ),
      ),
    );
  }

  //Following code will represent the transaction history
  Widget transactionHistoryWidget(PaymentInfo paymentInfo) {
    return Container(
      width: _width,
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: paymentInfo.isCashback
                ? GREEN_COLOR
                : Colors.blueGrey.withOpacity(.7),
            child: Image.asset(
              'assets/images/${paymentInfo.icon}',
              color: paymentInfo.isCashback ? Colors.white : Colors.white70,
              width: paymentInfo.isCashback ? 25 : 30,
              height: paymentInfo.isCashback ? 25 : 30,
            ),
          ),
          horizontalSpace(10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  paymentInfo.expenseTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                  ),
                ),
                verticalSpace(5),
                Text(
                  paymentInfo.isCashback ? 'Cashback' : 'E-Commerce Purchase',
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  (paymentInfo.isCashback
                          ? '+ ${paymentInfo.amount}'
                          : '- ${paymentInfo.amount}') +
                      ' SAR',
                  style: TextStyle(
                    color: paymentInfo.isCashback ? GREEN_COLOR : Colors.red,
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                  ),
                ),
                verticalSpace(5),
                Text(
                  paymentInfo.date,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.normal,
                    letterSpacing: -.5,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: .5,
            color: Colors.grey[300]!,
          ),
        ),
      ),
    );
  }

  //Next code will show an bottom sheet of add balance
  showAddBalanceBottoSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          height: _height / 1.8,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 120,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              verticalSpace(30),
              Text(
                'How do you want to add money?',
                style: spendingTextStyle.copyWith(fontSize: 15),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _staticData.addMoneySourcesTitle.length,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (_, index) {
                    AddMoneySource addMoneySource = AddMoneySource(
                        title: _staticData.addMoneySourcesTitle[index],
                        image: _staticData.addMoneySourcesIcons[index]);

                    return addMoneySourceWidget(addMoneySource);
                  },
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(_),
                child: const Center(
                  child: Text(
                    'Dismiss',
                    style: TextStyle(
                      color: Colors.black26,
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              verticalSpace(50),
            ],
          ),
        );
      },
    );
  }

  //Following code will represent the transaction history
  Widget addMoneySourceWidget(AddMoneySource addMoneySource) {
    // I don't want to put any color in Apple pay icon...
    bool isApplePay =
        addMoneySource.title == _staticData.addMoneySourcesTitle[0];

    return GestureDetector(
      onTap: printStcPay,
      child: Container(
        width: _width,
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/${addMoneySource.image}.png',
              color: isApplePay ? null : PRIMARY_COLOR,
              width: 30,
              height: 30,
            ),
            horizontalSpace(15),
            Text(
              addMoneySource.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 19,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: .7,
              color: Colors.grey[400]!,
            ),
          ),
        ),
      ),
    );
  }

  //This function is for changing the pages from navbar
  int _currentPage = 0;
  changePages(int currentPageIndex) {
    if (currentIndex != 0) currentIndex = 0;
    if (_currentPage != currentPageIndex) {
      setState(() {
        _currentPage = currentPageIndex;
      });
    }
  }
}
