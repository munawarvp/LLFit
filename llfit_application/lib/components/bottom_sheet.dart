import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:llfit_application/services/user.dart';
import 'package:llfit_application/utils/config.dart';

class CustomeBottomSheet extends StatefulWidget {
  const CustomeBottomSheet({super.key});

  @override
  State<CustomeBottomSheet> createState() => _CustomeBottomSheetState();
}

class _CustomeBottomSheetState extends State<CustomeBottomSheet> {
  final _heightFieldController = TextEditingController();
  final _weightFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        onClosing: () {},
        builder: (context) {
          return SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  const Text('Add Metrics',
                      style: TextStyle(
                          fontSize: 27,
                          color: headingBase,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Courier New')),
                  const SizedBox(height: 30),
                  TextField(
                    controller: _weightFieldController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        labelText: 'Weight',
                        labelStyle: const TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: inputTwo,
                        border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                width: 0, style: BorderStyle.none))),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _heightFieldController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        labelText: 'Height',
                        labelStyle: const TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: inputTwo,
                        border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                width: 0, style: BorderStyle.none))),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 60,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () async {await createMetrics({'weight': _weightFieldController.text, 'height': _heightFieldController.text}, context);},
                      style:
                          ElevatedButton.styleFrom(backgroundColor: buttonTwo),
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
