import 'package:flutter/material.dart';
import 'pagemodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late List<PageModel> pages;

  ValueNotifier<int> _pageViewNotifier = ValueNotifier(0);

  void _addPages() {
    pages = <PageModel>[];
    pages.add(PageModel('assets/image/newsapp_001_a_2.png'));
    pages.add(PageModel('assets/image/newsapp_002.png'));
    pages.add(PageModel('assets/image/newsapp_003.png'));
    pages.add(PageModel('assets/image/newsapp_004.png'));
    pages.add(PageModel('assets/image/newsapp_005.png'));
    pages.add(PageModel('assets/image/newsapp_006.png'));
    pages.add(PageModel('assets/image/newsapp_007.png'));
    pages.add(PageModel('assets/image/newsapp_008.png'));
  }

  @override
  Widget build(BuildContext context) {
    _addPages();

    return Stack(
      children: <Widget>[
        Scaffold(
          body: PageView.builder(
            itemBuilder: (context, index) {
              return Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage(
                          pages[index].image,
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              );
            },
            itemCount: pages.length,
            onPageChanged: (index) {
              _pageViewNotifier.value = index;
            },
          ),
        ),
        Transform.translate(
          offset: Offset(0, 175),
          child: Align(
            alignment: Alignment.center,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: RaisedButton(
                color: Colors.black45,
                child: Text(
                  'الرجوع إلى القائمة الرئيسية',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    letterSpacing: 1,
                    fontFamily: 'Cairo',
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
