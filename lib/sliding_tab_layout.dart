import 'package:flutter/material.dart';

import 'custom_underline_tab_indicator.dart';

enum TextBold {
  NONE,
  SELECT,
  BOTH,
}
///
/// 创建tabs 每个tab可以指定高度 默认是46
/// final List<Tab> tabs = [
//     Tab(height:10,text: "标题1"),
//     Tab(height:10,text: "标题1"),
//     Tab(height:10,text: "标题1"),
//   ];
class SlidingTabLayout extends StatefulWidget {
  final Color textSelectColor;
  final Color textUnselectColor;
  final double textSize;
  final TextBold textBold;
  final Color indicatorColor;
  final double indicatorHeight;
  final bool tabSpaceEqual;
  final bool isRoundedCorners;
  final List<Widget> tabs;
  final ValueChanged<int>? valueChanged;
  final EdgeInsets padding;
  final EdgeInsets labelPadding;
  final EdgeInsets indicatorPadding;
  final TabController tabController;

  const SlidingTabLayout(this.tabs,
      {Key? key,
      required this.tabController,
      this.textSelectColor = Colors.black,
      this.textUnselectColor = Colors.white,
      this.indicatorColor = Colors.black,
      this.textSize = 15,
      this.isRoundedCorners = false,
      this.indicatorHeight = 3,
      this.textBold = TextBold.SELECT,
      this.tabSpaceEqual = true,
      this.padding = EdgeInsets.zero,
      this.labelPadding = EdgeInsets.zero,
      this.indicatorPadding = EdgeInsets.zero,
      this.valueChanged})
      : super(key: key);

  @override
  State<SlidingTabLayout> createState() => SlidingTabLayoutState();
}

class SlidingTabLayoutState extends State<SlidingTabLayout>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return TabBar(
      padding: widget.padding,
      onTap: (tab) {
        widget.valueChanged?.call(tab);
      },
      //选中字样式
      labelStyle: TextStyle(
          fontSize: widget.textSize, fontWeight: getSelectFontWeight()),
      //未选中文字设置
      unselectedLabelStyle: TextStyle(
          fontSize: widget.textSize, fontWeight: getUnSelectFontWeight()),
      //未选中设置tabs 的长度超出屏幕宽度后，TabBar，是否可滚动,设置为false tab 将平分宽度，为true tab 将会自适应宽度
      isScrollable: !widget.tabSpaceEqual,
      controller: widget.tabController,
      //字对应的padding
      labelPadding: widget.labelPadding,
      //选中字体颜色
      labelColor: widget.textSelectColor,
      //未选中字的颜色
      unselectedLabelColor: widget.textUnselectColor,
      //指示器颜色
      indicatorColor: widget.indicatorColor,
      //指示器的高度
      indicatorWeight: widget.indicatorHeight,
      //设置指示器的padding 水平padding 最后控制指示器的宽度 要R重启才生效
      indicatorPadding: widget.indicatorPadding,
      //指示器大小计算方式，TabBarIndicatorSize.label跟文字等宽,TabBarIndicatorSize.tab跟每个tab等宽
      indicatorSize: TabBarIndicatorSize.label,
      //下面设置完了会使整个tab背景变色并设置圆角
      indicator: widget.isRoundedCorners
          ? buildCustomUnderlineTabIndicator()
          : UnderlineTabIndicator(
              borderSide: BorderSide(
                  width: widget.indicatorHeight, color: widget.indicatorColor)),
      tabs: widget.tabs,
    );
  }

  CustomUnderlineTabIndicator buildCustomUnderlineTabIndicator() {
    return CustomUnderlineTabIndicator(
        borderSide: BorderSide(
            width: widget.indicatorHeight, color: widget.indicatorColor));
  }

  FontWeight getSelectFontWeight() {
    if (widget.textBold == TextBold.NONE) {
      return FontWeight.normal;
    } else {
      return FontWeight.bold;
    }
  }

  FontWeight getUnSelectFontWeight() {
    if (widget.textBold == TextBold.BOTH) {
      return FontWeight.bold;
    } else {
      return FontWeight.normal;
    }
  }
}
