import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void customNavigate( context, String path, {Object? extra, VoidCallback? onReturn}) {
  GoRouter.of(context).push(path, extra: extra).then((_) {
    if (onReturn != null) {
      onReturn();
    }
  });
}
void customReplacementNavigate(context, String path) {
  GoRouter.of(context).pushReplacement(path);
}

void customReplacementAndRemove(context, String path) {
  GoRouter.of(context).go(path);
}

void delayedNavigate(context, path) {
  Future.delayed(
    const Duration(seconds: 3),
    () {
      customReplacementNavigate(context, path);
    },
  );
}
