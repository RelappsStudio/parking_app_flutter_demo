import 'package:flutter/material.dart';

class FormError extends StatelessWidget {
  const FormError({
    Key key,
    @required this.errors,
  }) : super(key: key);

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
      List.generate(errors.length, (index) => formErrorText(error: errors[index])),

    );
  }

  Row formErrorText({String error}) {
    return Row(
      children: <Widget>[
       Icon(Icons.error_outline, color: Colors.red,),
        SizedBox(width: 20,),
        Text(error),
      ],
    );
  }
}