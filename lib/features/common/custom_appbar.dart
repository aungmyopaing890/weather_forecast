import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:weather_forecast/core/master_colors.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar(
      {super.key,
      this.title,
      this.titleWidget,
      this.leadingWidth,
      this.showLeading = true,
      this.leadingIconColor,
      this.leading,
      this.onLeadingPressed,
      this.titleColor,
      this.actions,
      this.centerTitle,
      this.fontSize,
      this.bottom,
      this.showShadow = false,
      this.systemOverlayStyle,
      this.backgroundColor,
      this.onTitleTap});
  final double? leadingWidth;
  final String? title;
  final Widget? titleWidget;
  final Color? titleColor;
  final bool showLeading;
  final Color? leadingIconColor;
  final Widget? leading;
  final Color? backgroundColor;
  final Function()? onLeadingPressed;
  final List<Widget>? actions;
  final bool? centerTitle;
  final double? fontSize;
  final bool showShadow;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final Widget? bottom;
  final Function()? onTitleTap;
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? MasterColors.transparent,
      title: titleWidget ??
          InkWell(
            splashColor: Colors.transparent, // No ripple
            highlightColor: Colors.transparent, // No highlight
            onTap: () {
              if (onTitleTap != null) {
                onTitleTap!();
              }
            },
            child: Text(title ?? "",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: titleColor ?? MasterColors.black,
                      fontSize: fontSize ?? 20,
                    )),
          ),
      centerTitle: centerTitle ?? true,
      actions: actions,
      elevation: showShadow ? 1 : 0, // ← Add this for shadow
      shadowColor: showShadow ? MasterColors.textSecondary : MasterColors.white,
      // automaticallyImplyLeading: true,
      leading: leading ??
          ((showLeading && (ModalRoute.of(context)?.canPop ?? false))
              ? InkWell(
                  onTap: onLeadingPressed ??
                      () {
                        Navigator.of(context).pop();
                      },
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: leadingIconColor ?? MasterColors.black,
                  ),
                )
              : null),
      leadingWidth: leadingWidth ?? 56,
      iconTheme: IconThemeData(
        color: leadingIconColor ?? MasterColors.primary, // Custom icon color
      ),
      systemOverlayStyle: systemOverlayStyle ??
          SystemUiOverlayStyle.dark, // This is the key line
      bottom: bottom != null
          ? PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: bottom!,
            )
          : null,
    );
  }
}
