import 'package:dropdown_widget/dropdown_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const CustomDropdown());

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DropdownProvider(),
      child: const MaterialApp(home: Main()),
    );
  }
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DropdownProvider _provider = Provider.of<DropdownProvider>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownWidget(
              initText: "Select a Drink",
              options: _provider.drinks,
              onTap: (String text) {
                print(text);
                _provider.changeDrink(text);
              }
            ),
          ],
        ),
      ),
    );
  }
}

class DropdownWidget extends StatefulWidget {
  const DropdownWidget({Key? key,
    this.height = 40.0,
    this.borderRadius = 5.0,
    this.width = 250.0,
    required this.initText,
    required this.options,
    this.onTap,
  }) : super(key: key);

  final double height;
  final double borderRadius;
  final double width;
  final String initText;
  final void Function(String)? onTap;
  final List<String> options;

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  String? _selectedText;

  Widget _dropDownWidget(String text, double height) => Container(
    alignment: Alignment.centerLeft,
    height: height,
    color: text == this._selectedText ? Colors.blueAccent.withOpacity(0.4) : null,
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    width: this.widget.width,
    child: Text(text),
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(

          onTap: () async {
            final RenderBox _box = context.findRenderObject() as RenderBox;
            final Rect _rect = _box.localToGlobal(Offset.zero) & _box.size;
            final String _text = await Navigator.of(context).push<String>(
              PageRouteBuilder(
                transitionsBuilder: (_, Animation<double> a1, Animation<double> a2, widget) {
                  final CurvedAnimation _curvedAnimation = CurvedAnimation(parent: a1, curve: Curves.fastLinearToSlowEaseIn);
                  return FadeTransition(
                    opacity: Tween<double>(begin: 0.0, end: 1.0).animate(_curvedAnimation),
                    child: widget,
                  );
                },
                transitionDuration: const Duration(seconds: 1),
                reverseTransitionDuration: const Duration(milliseconds: 300),
                opaque: false,
                barrierDismissible: true,
                pageBuilder: (BuildContext ctx, Animation<double> a1, Animation<double> a2) {
                  double _top = _rect.bottom;
                  if (this._selectedText != null) {
                    final int _index = this.widget.options.indexOf(this._selectedText!);
                    _top -= (_index + 1) * this.widget.height;
                  }
                  Widget _dropdowns = Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      Positioned(
                        top: _top,
                        height: _rect.height * this.widget.options.length + 1.0,
                        left: _rect.left,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(this.widget.borderRadius),
                            border: Border.all(strokeAlign: StrokeAlign.inside),
                            boxShadow: [
                              BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 2.0, spreadRadius: 1.0, offset: Offset(0.0, 2.0)),
                            ]
                          ),
                          width: this.widget.width,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: this.widget.options.map<Widget>((String text) {
                              final int _index = this.widget.options.indexOf(text);
                              double _height = _rect.height;
                              if (_index == 0 || _index == this.widget.options.length) {
                                _height -= 1.0;
                              }
                              return Material(
                                color: this._selectedText == text && _index != this.widget.options.length -1 && _index != 0
                                    ? Colors.white
                                    : Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(ctx).pop(text);
                                  },
                                  child: this._dropDownWidget(text, _height,),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ]);
                  return _dropdowns;
                }),
            ) ?? this._selectedText ?? this.widget.initText;
            this.setState(() {
              this._selectedText = _text;
            });
          },
          child: Container(

            width: this.widget.width,
            height: this.widget.height,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              border: Border.all(strokeAlign: StrokeAlign.inside),
              borderRadius: BorderRadius.circular(this.widget.borderRadius),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(this._selectedText ?? this.widget.initText),
                const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.grey,),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


