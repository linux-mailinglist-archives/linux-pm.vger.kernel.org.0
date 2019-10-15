Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E264CD8188
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 23:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfJOVNR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 17:13:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfJOVNR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Oct 2019 17:13:17 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD8062168B;
        Tue, 15 Oct 2019 21:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571173995;
        bh=HJVfx0qraMvuuMLZzhNC9btRgIHEXiyCNSL/C+C6Qxo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C66u0c1yyINa0hcqT4JcZbugTLbq3fLsxufOVpuH2SlBVIX214TfjcnrbeXYjS4OA
         0gshGH607BJ8LIOqLSbe8g6ofovIBf6g3+gj5Th3f6U0bbq1deH3s0oAekQKnK8mxT
         C6F8xVsX+WsJ+KZgknVkZ22gNOBJiCz8AvysD8RI=
Received: by mail-qt1-f177.google.com with SMTP id n17so13439771qtr.4;
        Tue, 15 Oct 2019 14:13:15 -0700 (PDT)
X-Gm-Message-State: APjAAAX96G2gfZUD+sXo6i9e+eYLcZHNQri4PtqjShH1KHVXwcVhxmwA
        CncHaD+f+rA+6mSb1ZcX17k/iR2nB1pr4jsQUw==
X-Google-Smtp-Source: APXvYqwScYelT0zfAWBhgX1CBaYGJb7woplnj45bvSqWKWHTsqdVt/NwsjjaJIojq28e119Knusj0IJuPtlKAbokxwA=
X-Received: by 2002:a05:6214:407:: with SMTP id z7mr38220174qvx.79.1571173994745;
 Tue, 15 Oct 2019 14:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191015162300.22024-1-brgl@bgdev.pl> <20191015162300.22024-2-brgl@bgdev.pl>
In-Reply-To: <20191015162300.22024-2-brgl@bgdev.pl>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 15 Oct 2019 16:13:03 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKHVL=hoxH+nxiU6397PX3rzDNDv3C3evrd8bON-=YJUg@mail.gmail.com>
Message-ID: <CAL_JsqKHVL=hoxH+nxiU6397PX3rzDNDv3C3evrd8bON-=YJUg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: mfd: max77650: convert the binding
 document to yaml
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 15, 2019 at 11:23 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Convert the binding document for MAX77650 core MFD module to YAML.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  .../devicetree/bindings/mfd/max77650.txt      | 47 +----------
>  .../devicetree/bindings/mfd/max77650.yaml     | 83 +++++++++++++++++++
>  2 files changed, 84 insertions(+), 46 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/max77650.yaml
>
> diff --git a/Documentation/devicetree/bindings/mfd/max77650.txt b/Documentation/devicetree/bindings/mfd/max77650.txt
> index b529d8d19335..080871686b3b 100644
> --- a/Documentation/devicetree/bindings/mfd/max77650.txt
> +++ b/Documentation/devicetree/bindings/mfd/max77650.txt
> @@ -1,46 +1 @@
> -MAX77650 ultra low-power PMIC from Maxim Integrated.
> -
> -Required properties:
> --------------------
> -- compatible:          Must be "maxim,max77650"
> -- reg:                 I2C device address.
> -- interrupts:          The interrupt on the parent the controller is
> -                       connected to.
> -- interrupt-controller: Marks the device node as an interrupt controller.
> -- #interrupt-cells:    Must be <2>.
> -
> -- gpio-controller:     Marks the device node as a gpio controller.
> -- #gpio-cells:         Must be <2>. The first cell is the pin number and
> -                       the second cell is used to specify the gpio active
> -                       state.
> -
> -Optional properties:
> ---------------------
> -gpio-line-names:       Single string containing the name of the GPIO line.
> -
> -The GPIO-controller module is represented as part of the top-level PMIC
> -node. The device exposes a single GPIO line.
> -
> -For device-tree bindings of other sub-modules (regulator, power supply,
> -LEDs and onkey) refer to the binding documents under the respective
> -sub-system directories.
> -
> -For more details on GPIO bindings, please refer to the generic GPIO DT
> -binding document <devicetree/bindings/gpio/gpio.txt>.
> -
> -Example:
> ---------
> -
> -       pmic@48 {
> -               compatible = "maxim,max77650";
> -               reg = <0x48>;
> -
> -               interrupt-controller;
> -               interrupt-parent = <&gpio2>;
> -               #interrupt-cells = <2>;
> -               interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> -
> -               gpio-controller;
> -               #gpio-cells = <2>;
> -               gpio-line-names = "max77650-charger";
> -       };
> +This file has been moved to max77650.yaml.

We do this for common files with lots of references. I don't think
that applies here.

> diff --git a/Documentation/devicetree/bindings/mfd/max77650.yaml b/Documentation/devicetree/bindings/mfd/max77650.yaml
> new file mode 100644
> index 000000000000..5186ad287ec7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/max77650.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/max77650.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MAX77650 ultra low-power PMIC from Maxim Integrated.
> +
> +maintainers:
> +  - Bartosz Golaszewski <bgolaszewski@baylibre.com>
> +
> +description: |
> +  This document describes the DT properties of the core MFD controller.
> +
> +  The GPIO-controller module is represented as part of the top-level PMIC
> +  node. The device exposes a single GPIO line.
> +
> +  For device-tree bindings of other sub-modules (regulator, power supply,
> +  LEDs and onkey) refer to the binding documents under the respective
> +  sub-system directories.
> +
> +  For more details on GPIO bindings, please refer to the generic GPIO DT
> +  binding document <devicetree/bindings/gpio/gpio.txt>.
> +
> +properties:
> +  compatible:
> +    const: maxim,max77650
> +
> +  reg:
> +    description:
> +      I2C device address.
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      The interrupt on the parent the controller is connected to.

No need for 'description' if there's only one entry and you have
nothing specific about this device.

> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 2
> +    description:
> +      The first cell is the IRQ number, the second cell is the trigger type.
> +
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +    description:
> +      The first cell is the pin number and the second cell is used to specify
> +      the gpio active state.
> +
> +  gpio-line-names:
> +    $ref: '/schemas/types.yaml#/definitions/string-array'

*-names already has a type, so you can drop this.

> +    maxItems: 1
> +    description:
> +      Single string containing the name of the GPIO line.

You need to link all the child node schemas into here. Something like this:

onkey:
  $ref: ../input/max77650-onkey.yaml

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +  - gpio-controller
> +  - "#gpio-cells"
> +
> +examples:
> +  - |
> +    pmic@48 {
> +        compatible = "maxim,max77650";
> +        reg = <0x48>;
> +
> +        interrupt-controller;
> +        interrupt-parent = <&gpio2>;
> +        #interrupt-cells = <2>;
> +        interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> +
> +        gpio-controller;
> +        #gpio-cells = <2>;
> +        gpio-line-names = "max77650-charger";

I'd prefer to see a complete example here rather than piecemeal
examples scattered.

Rob

> +    };
> --
> 2.23.0
>
