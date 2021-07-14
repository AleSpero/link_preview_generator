import 'package:flutter/material.dart';

/// Large type LinkPreviewGenerator widget
class LinkViewLarge extends StatelessWidget {
  final Function(String) onTap;

  final Color? bgColor;
  final int? bodyMaxLines;
  final TextOverflow? bodyTextOverflow;
  final TextStyle? bodyTextStyle;
  final String description;
  final String domain;
  final TextStyle? domainTextStyle;
  final String imageUri;
  final bool isIcon;
  final double? radius;
  final bool? showMultiMedia;
  final String title;
  final TextStyle? titleTextStyle;
  final String url;

  const LinkViewLarge({
    Key? key,
    required this.url,
    required this.domain,
    required this.title,
    required this.description,
    required this.imageUri,
    required this.onTap,
    this.titleTextStyle,
    this.bodyTextStyle,
    this.domainTextStyle,
    this.showMultiMedia,
    this.bodyTextOverflow,
    this.bodyMaxLines,
    this.isIcon = false,
    this.bgColor,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      var layoutWidth = constraints.biggest.width;
      var layoutHeight = constraints.biggest.height;

      var _titleTS = titleTextStyle ??
          TextStyle(
            fontSize: computeTitleFontSize(layoutHeight),
            color: Colors.black,
            fontWeight: FontWeight.bold,
          );
      var _bodyTS = bodyTextStyle ??
          TextStyle(
            fontSize: computeTitleFontSize(layoutHeight) - 1,
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          );
      var _domainTS = bodyTextStyle ??
          TextStyle(
            fontSize: computeTitleFontSize(layoutHeight) - 1,
            color: Colors.blue,
            fontWeight: FontWeight.w400,
          );

      return InkWell(
          onTap: () => onTap(url),
          child: Column(
            children: <Widget>[
              showMultiMedia!
                  ? Expanded(
                      flex: 2,
                      child: imageUri == ''
                          ? Container(color: bgColor ?? Colors.grey)
                          : Container(
                              padding: const EdgeInsets.only(bottom: 15),
                              decoration: BoxDecoration(
                                borderRadius: radius == 0
                                    ? BorderRadius.zero
                                    : const BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                      ),
                                image: DecorationImage(
                                  image: NetworkImage(imageUri),
                                  fit:
                                      isIcon ? BoxFit.contain : BoxFit.fitWidth,
                                ),
                              ),
                            ),
                    )
                  : const SizedBox(height: 5),
              _buildTitleContainer(
                  _titleTS, computeTitleLines(layoutHeight, layoutWidth)),
              _buildBodyContainer(
                  _bodyTS, _domainTS, computeBodyLines(layoutHeight)),
            ],
          ));
    });
  }

  int? computeBodyLines(layoutHeight) {
    return layoutHeight ~/ 60 == 0 ? 1 : layoutHeight ~/ 60;
  }

  double computeTitleFontSize(double height) {
    var size = height * 0.13;
    if (size > 15) {
      size = 15;
    }
    return size;
  }

  int computeTitleLines(layoutHeight, layoutWidth) {
    return layoutHeight - layoutWidth < 50 ? 1 : 2;
  }

  Widget _buildBodyContainer(
      TextStyle _bodyTS, TextStyle _domainTS, _maxLines) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 5, 5),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Align(
                alignment: const Alignment(-1.0, -1.0),
                child: Text(
                  domain,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: _domainTS,
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: const Alignment(-1.0, -1.0),
                child: Text(
                  description,
                  style: _bodyTS,
                  overflow: bodyTextOverflow ?? TextOverflow.ellipsis,
                  maxLines:
                      bodyMaxLines == null ? _maxLines : bodyMaxLines! - 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleContainer(TextStyle _titleTS, _maxLines) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 5, 1),
      child: Container(
        alignment: const Alignment(-1.0, -1.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: _titleTS,
              overflow: TextOverflow.ellipsis,
              maxLines: _maxLines,
            ),
          ],
        ),
      ),
    );
  }
}
