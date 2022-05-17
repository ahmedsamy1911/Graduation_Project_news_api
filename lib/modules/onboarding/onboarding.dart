import 'package:flutter/material.dart';
import 'package:newsapi_01/layout/news_app/news_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../PageModel.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late List<PageModel> pages;

  ValueNotifier<int> _pageViewNotifier = ValueNotifier(0);

  void _addPages() {
    pages = <PageModel>[];
    pages.add(PageModel(
        'الشاشة الاولى',
        '1- Making friends is easy as waving your hand back and forth in easy step',
        Icons.ac_unit,
        'assets/image/logo_a_01.png'));
    pages.add(PageModel(
        'Alarm',
        '2- Making friends is easy as waving your hand back and forth in easy step',
        Icons.access_alarms,
        'assets/image/logo_a_01.png'));
    pages.add(PageModel(
        'Print',
        '3- Making friends is easy as waving your hand back and forth in easy step',
        Icons.map,
        'assets/image/Default_Image.png'));
    pages.add(PageModel(
        'Map',
        '4- Making friends is easy as waving your hand back and forth in easy step',
        Icons.ac_unit,
        'assets/image/logo_a_01.png'));
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
                            // pages[index].image,
                            'assets/image/logo_a_01.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Transform.translate(
                        child: Icon(
                          Icons.ac_unit,
                          size: 150,
                          color: Colors.white,
                        ),
                        offset: Offset(0, -100),
                      ),
                      Text(
                        // pages[index].title,
                        'الشاشة الاولى',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 48, right: 48, top: 18),
                        child: Text(
                          // pages[index].description,
                          ' !!!! الشاشة الاولى',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
            itemCount: 3,
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
                color: Colors.red.shade900,
                child: Text(
                  'الدخول على التطبيق',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    letterSpacing: 1,
                    fontFamily: 'Cairo',
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        _updateSeen();
                        return NewsLayout();
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _updateSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('seen', true);
  }
}
