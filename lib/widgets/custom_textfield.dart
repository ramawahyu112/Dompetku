import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mydompet/utils/style.dart';

class CustomTextFields extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final String placeholder;
  final TextInputType inputType;
  final bool isDate;
  final Function()? onTap;
  const CustomTextFields({
    super.key, 
    this.title = "", 
    required this.controller, 
    this.placeholder = "",
    this.inputType = TextInputType.text,
    this.isDate = false,
    this.onTap,
  });

  @override
  State<CustomTextFields> createState() => _CustomTextFieldsState();
}

class _CustomTextFieldsState extends State<CustomTextFields> {
  late OutlineInputBorder normalBorder;

  @override
  void initState() {
    normalBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: const BorderSide(color: Colors.black),
    );
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(widget.title, style: textFieldTitle),
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.inputType,
          readOnly: widget.isDate ? true : false,
          onTap: !widget.isDate 
              ? widget.onTap 
              : () async {
               DateTime? date = await showDatePicker(
                context: context, 
                initialDate: DateTime.now(), 
                firstDate: DateTime(1945), 
                lastDate: DateTime(2030),
              );
              if (date != null ){
                String dateFormated = DateFormat('dd-MM-yyyy').format(date);
                widget.controller.text = dateFormated;
              }
              },
        )
      ],
    );
  }
}