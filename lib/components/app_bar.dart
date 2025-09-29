import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final Widget? leading;
  final List<Widget>? actions;
  final double elevation;
  final Color backgroundColor;
  final Color shadowColor;
  final bool centerTitle;
  final TextStyle? defaultTitleStyle;
  
 
  static const double customHeight = 110.8;

  const CustomAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.elevation = 0,
    this.backgroundColor = const Color.fromARGB(197, 238, 239, 241),
    this.shadowColor = const Color.fromRGBO(0, 0, 0, 0.0), 
    this.centerTitle = false,
    this.defaultTitleStyle
  });

  @override
  Size get preferredSize => const Size.fromHeight(customHeight);

  @override
  Widget build(BuildContext context) {
    Widget styledTitle = title;

  
    if (title is Text && defaultTitleStyle != null) {
      final original = title as Text;
      styledTitle = Text(
        original.data ?? '',
        style: defaultTitleStyle,
        overflow: original.overflow ?? TextOverflow.ellipsis,
        textAlign: original.textAlign,
        maxLines: original.maxLines,
      );
    }

   
    return Container(
      height: customHeight,
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: elevation * 1.5,
            offset: Offset(0, elevation / 2),
          ),
        ],
      ),
      child: AppBar(
        
        backgroundColor: backgroundColor,
        elevation: 0, 
        automaticallyImplyLeading: false, 
        toolbarHeight: customHeight, 
        title: centerTitle ? Center(child: styledTitle) : styledTitle,

        leading: leading, 
        
        actions: actions,
      ),
    );
  }
}