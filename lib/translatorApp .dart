import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class TranslatorApp extends StatefulWidget {
  const TranslatorApp({super.key});

  @override
  State<TranslatorApp> createState() => _TranslatorAppState();
}

class _TranslatorAppState extends State<TranslatorApp> {
  var languages = [
    "English",
    "Arabic",
  ];
  var originalLanguage = "From";
  var destenationLanguage = "To";
  var outPut = "";

  TextEditingController langController = TextEditingController();
  void translate(String src, String dst, String input) async {
    GoogleTranslator translator = GoogleTranslator();
    var translation = await translator.translate(input, from: src, to: dst);
    setState(() {
      outPut = translation.text.toString();
    });
    if (src == '--' || dst == '--') {
      outPut = 'faild translation';
    }
  }

  String getLanguageCode(String lang) {
    if (lang == "English") {
      return 'en';
    } else if (lang == "Arabic") {
      return 'ar';
    }
    return '--';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff10223d),
      appBar: AppBar(
        backgroundColor: Color(0xff10223d),
        title: Text(
          'coo',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton(
                  focusColor: Colors.white,
                  iconDisabledColor: Colors.white,
                  iconEnabledColor: Colors.white,
                  items: languages.map((e) {
                    return DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      originalLanguage = value!;
                    });
                  },
                  hint: Text(
                    originalLanguage,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  icon: Icon(Icons.keyboard_arrow_down),
                  dropdownColor: Colors.white,
                ),
                SizedBox(
                  width: 40,
                ),
                Icon(
                  Icons.arrow_right_alt_outlined,
                  color: Colors.white,
                  size: 40,
                ),
                SizedBox(
                  width: 40,
                ),
                DropdownButton(
                  focusColor: Colors.white,
                  iconDisabledColor: Colors.white,
                  iconEnabledColor: Colors.white,
                  items: languages.map((e) {
                    return DropdownMenuItem(
                      child: Text(
                        e,
                        // style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      value: e,
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      destenationLanguage = value!;
                    });
                  },
                  hint: Text(
                    destenationLanguage,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  icon: Icon(Icons.keyboard_arrow_down),
                  dropdownColor: Colors.white,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(
                8,
              ),
              child: TextFormField(
                cursorColor: Colors.white,
                autofocus: false,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  label: Text('please enter your text ...'),
                  labelStyle: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1),
                  ),
                  errorStyle: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                  ),
                ),
                controller: langController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter text..';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Color(0xff2b3c5a)),
                  onPressed: () {
                    translate(
                        getLanguageCode(originalLanguage),
                        getLanguageCode(destenationLanguage),
                        langController.text.toString());
                  },
                  child: Text('Translate')),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "\n$outPut",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
