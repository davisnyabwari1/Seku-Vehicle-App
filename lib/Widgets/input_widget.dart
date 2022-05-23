import 'package:flutter/material.dart';

class InputWidget extends StatefulWidget {
  final String label;
  final IconData icon;
  final Function(dynamic) onchange;

  InputWidget({
    required this.label,
    required this.icon,
    required this.onchange,
  });

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  late bool hideText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 40.0,
      ),
      height: 60.0,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 5,
        ),
        child: TextFormField(
          obscureText: widget.label == 'Password' ? hideText : !hideText,
          onChanged: widget.onchange,
          style: const TextStyle(
            fontSize: 20,
          ),
          decoration: InputDecoration(
            hintText: widget.label,
            prefixIcon: Icon(widget.icon),
            border: InputBorder.none,
            suffixIcon: widget.label == 'Password'
                ? InkWell(
                    child: hideText
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                    onTap: _revealPassword,
                  )
                : null,
          ),
        ),
      ),
    );
  }

  void _revealPassword() {
    setState(() {
      hideText = !hideText;
    });
  }
}
