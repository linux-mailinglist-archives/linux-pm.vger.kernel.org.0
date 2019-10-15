Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 120C1D81B3
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 23:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389772AbfJOVRj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 17:17:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389595AbfJOVRi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Oct 2019 17:17:38 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9085222C3;
        Tue, 15 Oct 2019 21:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571174257;
        bh=jIfi3VFA+OegxDDpnwRnKq+fhutLut+9ZOueqNEQbPI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TGsjNywc3rHcmuEtXlu9Pn7r5K2nwIzu8e222f8Nbjk9TuHnDzqrtam2x0ERVY/JB
         36n8dtFtHu7k5LZ8Dvkpbc8Zv+3ycMqyZTVU+cm3LBE5DYQ0+21nstI40fLdjtgfv1
         MWkZtjuRXuUvKlYi61+M9UEwxQlssQ5Ihe5IXCbM=
Received: by mail-qt1-f173.google.com with SMTP id m61so32811378qte.7;
        Tue, 15 Oct 2019 14:17:37 -0700 (PDT)
X-Gm-Message-State: APjAAAWePWAwAGPprBaGSMsnFtTo+hJgi6H1oUm+0dB8LPEIC0Qv47tg
        2YOE5LklDkIoRzmPIBGzs5zWKH+N7P5oTmWtrw==
X-Google-Smtp-Source: APXvYqyevsC2cDcw4pd7YhFFGDFDowGK32qaUpls4A42LVTy8FkDCk4zGehTF79O/gchBXQMIX0BAqfbIm7HCGsf7Tk=
X-Received: by 2002:ac8:44d9:: with SMTP id b25mr42253694qto.300.1571174256837;
 Tue, 15 Oct 2019 14:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20191015162300.22024-1-brgl@bgdev.pl> <20191015162300.22024-2-brgl@bgdev.pl>
In-Reply-To: <20191015162300.22024-2-brgl@bgdev.pl>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 15 Oct 2019 16:17:25 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKhGr6QDWZFR6cq6MH-0vghb9oSgkCCdi7bhiKmvrkY_w@mail.gmail.com>
Message-ID: <CAL_JsqKhGr6QDWZFR6cq6MH-0vghb9oSgkCCdi7bhiKmvrkY_w@mail.gmail.com>
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
> +    maxItems: 1
> +    description:
> +      Single string containing the name of the GPIO line.
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

Examples are built now. Run 'make dt_binding_check' on bindings before
sending them:

Error: Documentation/devicetree/bindings/mfd/max77650.example.dts:24.29-30
syntax error
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:321: recipe for target
'Documentation/devicetree/bindings/mfd/max77650.example.dt.yaml'
failed
make[1]: *** [Documentation/devicetree/bindings/mfd/max77650.example.dt.yaml]
Error 1

You need to include any includes that you use.

Rob
