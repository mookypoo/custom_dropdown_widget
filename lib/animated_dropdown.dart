/// dropdown with gradually opening and closing animation...work in progress

// import 'package:flutter/material.dart';
//
// class DropdownWidget extends StatefulWidget {
//   const DropdownWidget({Key? key,
//     this.height = 40.0,
//     this.borderRadius = 5.0,
//     this.width = 250.0,
//     required this.initText,
//     required this.options,
//     this.onTap,
//   }) : super(key: key);
//
//   final double height;
//   final double borderRadius;
//   final double width;
//   final String initText;
//   //final String selectedText;
//   final void Function(String)? onTap;
//   final List<String> options;
//
//   @override
//   State<DropdownWidget> createState() => _DropdownWidgetState();
// }
//
// class _DropdownWidgetState extends State<DropdownWidget> {
//   String? _selectedText;
//
//   Widget _dropDownWidget(String text) => Material(
//     child: Container(
//       alignment: Alignment.centerLeft,
//       height: this.widget.height,
//       padding: const EdgeInsets.symmetric(horizontal: 10.0),
//       width: this.widget.width,
//       child: Text(text),
//     ),
//   );
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       if (this.mounted) print(context.findRenderObject() as RenderBox);
//     });
//     // final RenderBox _box = context.findRenderObject() as RenderBox;
//     // print(_box);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         GestureDetector(
//
//           onTap: () async {
//             final RenderBox _box = context.findRenderObject() as RenderBox;
//             final Rect _rect = _box.localToGlobal(Offset.zero) & _box.size;
//
//             await Navigator.of(context).push(
//                 PageRouteBuilder(
//                     transitionDuration: const Duration(seconds: 1),
//                     transitionsBuilder: (_, Animation<double> a1, Animation<double> a2, widget) {
//                       final CurvedAnimation _curvedAnimation = CurvedAnimation(parent: a1, curve: Interval(0, 1.0));
//                       final Animation<double> _opacity = Tween<double>(begin: 0, end: 1.0).animate(_curvedAnimation);
//                       return FadeTransition(
//                         opacity: _opacity,
//                         child: widget,
//                       );
//                     },
//                     barrierDismissible: true,
//                     opaque: false,
//                     pageBuilder: (BuildContext ctx, Animation<double> a1, Animation<double> a2) {
//                       final CurvedAnimation _curvedAnimation = CurvedAnimation(parent: a1, curve: Interval(0, 1.0));
//                       final Animation<double> _opacity = Tween<double>(begin: 0, end: 1.0).animate(_curvedAnimation);
//
//                       return Stack(
//                         children: <Widget>[
//                           Positioned(
//                             top: _rect.bottom,
//                             width: _rect.width,
//                             left: _rect.left,
//                             child: Material(
//                                 child: Container(
//                                   child: ListView.builder(
//                                       itemCount: this.widget.options.length,
//                                       shrinkWrap: true,
//                                       itemBuilder: (_, int index) {
//                                         final double unit = 0.5 / (this.widget.options.length + 1.5);
//                                         final double start = clampDouble(0.5 + (index + 1) * unit, 0.0, 1.0);
//                                         final double end = clampDouble(start + 1.5 * unit, 0.0, 1.0);
//                                         print(this.widget.options[index]);
//                                         print(start);
//                                         return FadeTransition(
//                                           opacity: Tween<double>(begin: start, end: end).animate(_curvedAnimation),
//                                           child: this._dropDownWidget(this.widget.options[index]),
//                                         );
//                                       }
//                                   ),
//                                   // child: FadeTransition(
//                                   //   opacity: _opacity,
//                                   //   child: this._dropDownWidget("hi")),
//                                 )
//                             ),
//                           ),
//                         ],
//                       );
//                       /*
//                   ListView.builder(
//                             itemCount: this.widget.options.length,
//                             shrinkWrap: true,
//                             itemBuilder: (_, int index) {
//                               print(this.widget.options[index]);
//                               return FadeTransition(
//                                 opacity: Tween<double>(begin: 0, end: 1.0).animate(_curvedAnimation),
//                                 child: this._dropDownWidget(this.widget.options[index]),
//                               );
//                             }
//                           ),
//                    */
//
//                       return LayoutBuilder(
//                         builder: (_, __) => Container(
//                           height: 300.0,
//                           width: _rect.width,
//                           child: ListView.builder(
//                             itemCount: this.widget.options.length,
//                             shrinkWrap: true,
//                             itemBuilder: (BuildContext ctx, int i) {
//                               final double unit = 0.5 / (this.widget.options.length + 1.5);
//                               final double start = clampDouble(0.5 + (i + 1) * unit, 0.0, 1.0);
//                               final double end = clampDouble(start + 1.5 * unit, 0.0, 1.0);
//                               final CurvedAnimation _curvedAnimation = CurvedAnimation(parent: a1, curve: Interval(0, 1.0));
//                               print(this.widget.options[i]);
//                               return Stack(
//                                 children: <Widget>[
//                                   Positioned(
//                                     top: _rect.bottom + _rect.height * i,
//                                     width: _rect.width,
//                                     left: _rect.left,
//                                     height: _rect.height,
//                                     child: Material(
//                                       child: FadeTransition(
//                                         opacity: Tween<double>(begin: start, end: end).animate(_curvedAnimation),
//                                         child: this._dropDownWidget(this.widget.options[i]),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               );
//                             },
//                           ),
//                         ),
//                       );
//
//                     }
//                 )
//             );
//           },
//           child: Container(
//             constraints: BoxConstraints(
//                 maxWidth: this.widget.width,
//                 maxHeight: this.widget.height
//             ),
//             width: this.widget.width,
//             height: this.widget.height,
//             padding: const EdgeInsets.symmetric(horizontal: 10.0),
//             decoration: BoxDecoration(
//               border: Border.all(),
//               borderRadius: BorderRadius.circular(this.widget.borderRadius),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Text(this.widget.initText),
//                 const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.grey,),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class DropdownRoute extends PageRoute {
//   @override
//   Color? get barrierColor => null;
//
//   @override
//   // TODO: implement barrierLabel
//   String? get barrierLabel => "";
//
//   @override
//   Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
//     return LayoutBuilder(
//         builder: (BuildContext ctx, _) {
//           final CurvedAnimation _curvedAnimation = CurvedAnimation(parent: a1, curve: Interval(0, 1.0));
//           final Animation<double> _opacity = Tween<double>(begin: 0, end: 1.0).animate(_curvedAnimation);
//
//           return CustomSingleChildLayout(
//             delegate: _DropdownMenuRouteLayout<T>(
//               buttonRect: buttonRect,
//               route: route,
//               textDirection: textDirection,
//             ),
//             child: capturedThemes.wrap(menu),
//           );
//         },
//
//         return Stack(
//     children: <Widget>[
//     Positioned(
//         top: _rect.bottom,
//         width: _rect.width,
//     left: _rect.left,
//     child: Material(
//     child: Container(
//     child: ListView.builder(
//     itemCount: this.widget.options.length,
//     shrinkWrap: true,
//     itemBuilder: (_, int index) {
//       final double unit = 0.5 / (this.widget.options.length + 1.5);
//       final double start = clampDouble(0.5 + (index + 1) * unit, 0.0, 1.0);
//       final double end = clampDouble(start + 1.5 * unit, 0.0, 1.0);
//       print(this.widget.options[index]);
//       print(start);
//       return FadeTransition(
//         opacity: Tween<double>(begin: start, end: end).animate(_curvedAnimation),
//         child: this._dropDownWidget(this.widget.options[index]),
//       );
//     }
//     ),
//     // child: FadeTransition(
//     //   opacity: _opacity,
//     //   child: this._dropDownWidget("hi")),
//     )
//     ),
//     ),
//     ],
//     );
//   }
//   );
// }
//
// @override
// bool get maintainState => true;
//
// @override
// Duration get transitionDuration => const Duration(seconds: 1);
// }
//
// class CustomChildLayoutDelegate extends SingleChildLayoutDelegate {
//   final Rect rect;
//
//   CustomChildLayoutDelegate(this.rect);
//
//   @override
//   bool shouldRelayout(CustomChildLayoutDelegate oldDelegate) {
//     return rect != oldDelegate.rect;
//   }
//
// }