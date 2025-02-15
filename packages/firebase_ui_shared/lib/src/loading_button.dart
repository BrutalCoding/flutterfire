// Copyright 2022, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:firebase_ui_shared/firebase_ui_shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class _LoadingButtonContent extends StatelessWidget {
  final String label;
  final bool isLoading;
  final Color? color;
  const _LoadingButtonContent({
    Key? key,
    required this.label,
    required this.isLoading,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isCupertino = CupertinoUserInterfaceLevel.maybeOf(context) != null;
    Widget child;

    if (color != null) {
      final theme = Theme.of(context).textTheme.labelLarge;
      child = Text(
        label,
        style: theme?.copyWith(color: color),
      );
    } else {
      child = Text(label);
    }

    if (isLoading) {
      child = LoadingIndicator(
        size: isCupertino ? 20 : 16,
        borderWidth: 1,
        color: color,
      );
    }

    return child;
  }
}

/// Button widget that uses [CupertinoButton] under [CupertinoApp] and
/// [TextButton], [ElevatedButton] or [OutlinedButton] under [MaterialApp]
/// which is also capable of displaying a loading indicator when [isLoading] is
/// set to true.
class LoadingButton extends StatelessWidget {
  /// Indicates that a loading indicator should be displayed.
  final bool isLoading;

  /// The text to display in the button.
  final String label;

  /// The icon to display in the button.
  final IconData? icon;

  /// The color of the button background.
  final Color? color;

  /// The color of the button content.
  final Color? labelColor;

  /// A callback that is called when the button is pressed.
  final VoidCallback onTap;

  /// The variant of the button. See [ButtonVariant] for more information.
  final ButtonVariant variant;

  const LoadingButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.isLoading = false,
    this.icon,
    this.color,
    this.labelColor,
    this.variant = ButtonVariant.outlined,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMaterial3 = theme.useMaterial3;

    final resolvedColor = variant == ButtonVariant.filled && !isMaterial3
        ? theme.colorScheme.onPrimary
        : null;

    final contentColor = labelColor ?? resolvedColor;

    final content = _LoadingButtonContent(
      label: label,
      isLoading: isLoading,
      color: contentColor,
    );

    return UniversalButton(
      color: color,
      icon: icon,
      contentColor: contentColor,
      onPressed: onTap,
      variant: variant,
      child: content,
    );
  }
}
