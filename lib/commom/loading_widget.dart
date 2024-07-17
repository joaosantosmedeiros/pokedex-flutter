import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

loadingIndicatorWidget(ValueListenable<bool> loading) {
  return ValueListenableBuilder(
      valueListenable: loading,
      builder: (context, bool isLoading, _) {
        return isLoading
            ? Positioned(
                left: (MediaQuery.of(context).size.width / 2) - 20,
                bottom: 24,
                child: const SizedBox(
                  width: 40,
                  height: 40,
                  child: CircleAvatar(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                ))
            : Container();
      });
}
