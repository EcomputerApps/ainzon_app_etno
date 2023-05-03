import 'package:etno_app/store/section.dart';
import 'package:etno_app/utils/WarningWidgetValueNotifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/constants.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/New.dart';
import '../../utils/Globals.dart';
import '../PageNewDetail.dart';

class TabBarGeneral extends StatefulWidget {
  const TabBarGeneral({super.key});

  @override
  State<StatefulWidget> createState() {
    return PageState();
  }
}

class PageState extends State<TabBarGeneral> {
  final Section section = Section();

  @override
  void initState() {
    section.getAllNewByLocality('${Globals.locality}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const WarningWidgetValueNotifier(),
      Observer(builder: (context) {
        if (section.getList.isNotEmpty) {
          return Expanded(
              child: ListView(
                  shrinkWrap: true,
                  children: section.getList
                      .map((e) => cardNew(e, context))
                      .toList()));
        } else {
          return Container(
              padding: const EdgeInsets.only(top: 250.0),
              child: Column(children: [
                Text(AppLocalizations.of(context)!.no_news,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Icon(Icons.newspaper, size: 50.0)
              ]));
        }
      })
    ]);
  }
}

Widget cardNew(New new_, BuildContext context) {
  return InkWell(
                onTap: () => {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  PageNewDetail(
                                      new_: New(
                                          new_.idNew,
                                          new_.username,
                                          renderTextTraslated(new_.category!,context),
                                          new_.title,
                                          new_.publicationDate,
                                          new_.description,
                                          new_.imageUrl)),
                              transitionDuration: Duration.zero,
                              reverseTransitionDuration: Duration.zero))
                    },
                child:  Card(
                  margin: EdgeInsets.all(16.0),
        child: Container(
          padding: EdgeInsets.all(10.0),
            height: 200.0,
            alignment: Alignment.bottomLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                    image: renderBackgroundImage(new_), fit: BoxFit.fill)),
            child: Container(
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.all(4.0),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(renderTextTraslated(new_.category!,context),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                                backgroundColor: Colors.black)),
                        const SizedBox(width: 4.0),
                        Text(new_.username!,
                            style: const TextStyle(
                                color: Colors.white,
                                backgroundColor: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0))
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Text(new_.description!,
                        style: const TextStyle(
                            color: Colors.black, backgroundColor: Colors.white),
                        maxLines: 2)
                  ]),
            )),
      ));
}

ImageProvider<Object> renderBackgroundImage(New news) {
  if (news.imageUrl == null)
    return AssetImage('assets/news.png');
  else
    return NetworkImage(news.imageUrl!);
}

String renderTextTraslated(String name, BuildContext context) {
  switch (name) {
    case 'Tecnología':
      return AppLocalizations.of(context)!.news_tecnology;
    case 'Salud':
      return AppLocalizations.of(context)!.news_heal;
    case 'Deporte':
      return AppLocalizations.of(context)!.sport;
    default:
      return '';
  }
}
