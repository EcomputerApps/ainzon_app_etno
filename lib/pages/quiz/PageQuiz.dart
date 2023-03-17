import 'package:etno_app/models/quiz/Quiz.dart';
import 'package:etno_app/store/section.dart';
import 'package:etno_app/widgets/appbar_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PageQuiz extends StatefulWidget {
  const PageQuiz({super.key});

  @override
  State<StatefulWidget> createState() => PageState();
}

class PageState extends State<PageQuiz>{
  final Section section = Section();
  bool? check1 = false, check2 = true, check3 = false;
  String? answer;
  String dni = '';
  bool isValid = false;
  int option = 0;

 bool isDNIValid(String input) {
   final dniRegExp = RegExp(r'^(\d{8})([A-Z])$');
   return dniRegExp.hasMatch(input);
 }

 @override
  void initState()  {
    section.getQuiz('Bolea');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz Page',
      home: Scaffold(
        appBar: appBarCustom('Encuesta', Icons.language, () => null),
        body: SafeArea(
          child: Observer(builder: (context){
            if (section.getQuizzes.isNotEmpty){
             return Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                          children: [
                            Image.asset('assets/quiz_decide.png', width: 50.0, height: 50.0),
                            Text(section.getQuizzes[0].question!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0))
                          ]
                      ),
                      const Divider(thickness: 1.0),

                      Visibility(
                        visible: section.getQuizzes[0].answerOne == null ? false : true,
                          child: RadioListTile(
                        title: Text('1. ${section.getQuizzes[0].answerOne}'),
                        value: "1",
                        groupValue: answer,
                        onChanged: (value){
                          setState(() => answer = value!);
                        },
                      )),
                      Visibility(
                        visible: section.getQuizzes[0].answerTwo == null ? false : true,
                          child: RadioListTile(
                        title: Text('2. ${section.getQuizzes[0].answerTwo}'),
                        value: "2",
                        groupValue: answer,
                        onChanged: (value){
                          setState(() => answer = value!);
                        },
                      )),
                      Visibility(
                        visible: section.getQuizzes[0].answerThree == null ? false : true,
                          child: RadioListTile(
                        title: Text('3. ${section.getQuizzes[0].answerThree}'),
                        value: "3",
                        groupValue: answer,
                        onChanged: (value){
                          setState(() => answer = value!);
                        },
                      )),
                      Visibility(
                          visible: section.getQuizzes[0].answerFour == null ? false : true,
                          child: RadioListTile(
                        title: Text('4. ${section.getQuizzes[0].answerFour}'),
                        value: "4",
                        groupValue: answer,
                        onChanged: (value){
                          setState(() => answer = value!);
                        },
                      )),
                      const SizedBox(height: 16.0),
                      const Text('Indentificación', style: TextStyle(color: Colors.red)),
                      TextFormField(
                        onChanged: (value) => setState(() {
                          dni = value;
                        }),
                      ),
                      ElevatedButton(onPressed: () {
                        if (isDNIValid(dni)) {
                          section.sendResultQuiz('Bolea', section.getQuizzes[0].idQuiz!, int.parse(answer!));
                        } else {
                          Fluttertoast.showToast(
                              msg: 'No es valido el DNI',
                              toastLength: Toast.LENGTH_SHORT,
                              fontSize: 12,
                              textColor: Colors.white,
                              backgroundColor: Colors.red
                          );
                        }
                      }, style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red)), child: const Text('Votar'))
                    ],
                  )
              );
            } else {
              return Container(
                alignment: Alignment.center,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.block, size: 120.0),
                      Text('No hay encuesta disponible')
                    ]
                ),
              );
            }
          })
        ),
      ),
    );
  }
}

