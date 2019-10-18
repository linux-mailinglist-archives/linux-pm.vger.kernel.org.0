Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD645DBDD0
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 08:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409473AbfJRGoX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 02:44:23 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40121 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393594AbfJRGoV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 02:44:21 -0400
Received: by mail-ot1-f65.google.com with SMTP id y39so4065467ota.7
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2019 23:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PqrHMEru6U7zAeRhmkEeGaUX7eyVnHwu6NVw9nt+5n4=;
        b=X642gj4nqUg9O16iP8e6WyArE8LA8pUVECviq0/UcImbNqxGdjgPAlZIELXUUwhoGk
         JEy6vlFzYV1e4zjFjrotawnyNEqBJoUELB9mhoLsyG+o5JmbkK7xafoNf44NIbRe7eiq
         INgYICoOVclkvpuAlaWAJniume/jz29is7UUiFQZzcuBDdg6g76tK5ulCnP3o/wQV8Vi
         LmNODRkFB1hmny/qPqT4yW2YTxpbh4pkm3pFxbWbJYUkCQ3tBqVyNalduMrepdKIc0h9
         L8tcO0hgfz3i8EUJEytIhhQgfq68fd+sHa//Zy4yOWEVOYcRRtuj1qo6eXOkHM+GYHVM
         Pm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PqrHMEru6U7zAeRhmkEeGaUX7eyVnHwu6NVw9nt+5n4=;
        b=Edn0XLWiFGI6MOv1MHtYUEkFp54OGSdk3UWRU2kNEZWN/lNF6h8DsG1zEEcgid1T1y
         PWgmH8WpqwCRrOwp/nt77e13QkLYIJDGXgN5gD0Uuh0GJnZvMXRy7EX9tWy0O+FyA1qT
         0ef8Pt/ynUCz26VTVJmRWWUiH/FUzhSWC9rC+L6uqc4TZql1wkN2qy/IviAl/NSavqBe
         WhNe2Pj/38eLFmKIRM4f/DKaqgt9QEqF7HOI2ncTAHzcgHQxDcB2ObV/zxTGdwl7Qowp
         sEEvEJKB/jxsrmx6vqOrDeSPPwoDsNr0+LbLPSnVqLEIW67cXmOr5ZcPmKcmiGXuEwCs
         rsYg==
X-Gm-Message-State: APjAAAXUpsDAVyfmcn3+79bav2tXBZjLS62QuY+tEDpNI7V9EghTeDxh
        na7/Ycg4imMTULTGTQCFJIRekuSKYzs6ma25TnCWNA==
X-Google-Smtp-Source: APXvYqypuBiJnTlXuHGNsWMdVVjE2C9cyf1zOybXwkR8VjvVS0geUtcMoLmLtbul1PMl5xKFQTj18h1q6nMas8C698w=
X-Received: by 2002:a9d:7dd6:: with SMTP id k22mr6185960otn.256.1571381058667;
 Thu, 17 Oct 2019 23:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20191017071234.8719-1-brgl@bgdev.pl> <20191017071234.8719-2-brgl@bgdev.pl>
 <20191017183106.GA11667@bogus>
In-Reply-To: <20191017183106.GA11667@bogus>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 18 Oct 2019 08:44:07 +0200
Message-ID: <CAMpxmJXoA2GW9s9r0KZetfUjMKPxWMa5MDFSLchfZ-3gnE+JvA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: mfd: max77650: convert the binding
 document to yaml
To:     Rob Herring <robh@kernel.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        linux-pm <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

czw., 17 pa=C5=BA 2019 o 20:31 Rob Herring <robh@kernel.org> napisa=C5=82(a=
):
>
> On Thu, Oct 17, 2019 at 09:12:29AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Convert the binding document for MAX77650 core MFD module to YAML.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  .../devicetree/bindings/mfd/max77650.txt      |  46 ------
> >  .../devicetree/bindings/mfd/max77650.yaml     | 151 ++++++++++++++++++
> >  2 files changed, 151 insertions(+), 46 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/mfd/max77650.txt
> >  create mode 100644 Documentation/devicetree/bindings/mfd/max77650.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/max77650.txt b/Docum=
entation/devicetree/bindings/mfd/max77650.txt
> > deleted file mode 100644
> > index b529d8d19335..000000000000
> > --- a/Documentation/devicetree/bindings/mfd/max77650.txt
> > +++ /dev/null
> > @@ -1,46 +0,0 @@
> > -MAX77650 ultra low-power PMIC from Maxim Integrated.
> > -
> > -Required properties:
> > --------------------
> > -- compatible:                Must be "maxim,max77650"
> > -- reg:                       I2C device address.
> > -- interrupts:                The interrupt on the parent the controlle=
r is
> > -                     connected to.
> > -- interrupt-controller: Marks the device node as an interrupt controll=
er.
> > -- #interrupt-cells:  Must be <2>.
> > -
> > -- gpio-controller:   Marks the device node as a gpio controller.
> > -- #gpio-cells:               Must be <2>. The first cell is the pin nu=
mber and
> > -                     the second cell is used to specify the gpio activ=
e
> > -                     state.
> > -
> > -Optional properties:
> > ---------------------
> > -gpio-line-names:     Single string containing the name of the GPIO lin=
e.
> > -
> > -The GPIO-controller module is represented as part of the top-level PMI=
C
> > -node. The device exposes a single GPIO line.
> > -
> > -For device-tree bindings of other sub-modules (regulator, power supply=
,
> > -LEDs and onkey) refer to the binding documents under the respective
> > -sub-system directories.
> > -
> > -For more details on GPIO bindings, please refer to the generic GPIO DT
> > -binding document <devicetree/bindings/gpio/gpio.txt>.
> > -
> > -Example:
> > ---------
> > -
> > -     pmic@48 {
> > -             compatible =3D "maxim,max77650";
> > -             reg =3D <0x48>;
> > -
> > -             interrupt-controller;
> > -             interrupt-parent =3D <&gpio2>;
> > -             #interrupt-cells =3D <2>;
> > -             interrupts =3D <3 IRQ_TYPE_LEVEL_LOW>;
> > -
> > -             gpio-controller;
> > -             #gpio-cells =3D <2>;
> > -             gpio-line-names =3D "max77650-charger";
> > -     };
> > diff --git a/Documentation/devicetree/bindings/mfd/max77650.yaml b/Docu=
mentation/devicetree/bindings/mfd/max77650.yaml
> > new file mode 100644
> > index 000000000000..66a447e1cf56
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/max77650.yaml
> > @@ -0,0 +1,151 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/max77650.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MAX77650 ultra low-power PMIC from Maxim Integrated.
> > +
> > +maintainers:
> > +  - Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > +
> > +description: |
> > +  This document describes the DT properties of the core MFD controller=
.
>
> So does every file in this directory.
>
> Describe what this chip is.
>
> > +
> > +  The GPIO-controller module is represented as part of the top-level P=
MIC
> > +  node. The device exposes a single GPIO line.
> > +
> > +  For device-tree bindings of other sub-modules (regulator, power supp=
ly,
> > +  LEDs and onkey) refer to the binding documents under the respective
> > +  sub-system directories.
> > +
> > +  For more details on GPIO bindings, please refer to the generic GPIO =
DT
> > +  binding document <devicetree/bindings/gpio/gpio.txt>.
>
> Also fairly useless and another reference to maintain...
>
> > +
> > +properties:
> > +  compatible:
> > +    const: maxim,max77650
> > +
> > +  reg:
> > +    description:
> > +      I2C device address.
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  interrupt-controller: true
> > +
> > +  "#interrupt-cells":
> > +    const: 2
> > +    description:
> > +      The first cell is the IRQ number, the second cell is the trigger=
 type.
> > +
> > +  gpio-controller: true
> > +
> > +  "#gpio-cells":
> > +    const: 2
> > +    description:
> > +      The first cell is the pin number and the second cell is used to =
specify
> > +      the gpio active state.
> > +
> > +  gpio-line-names:
> > +    maxItems: 1
> > +    description:
> > +      Single string containing the name of the GPIO line.
> > +
> > +  regulators:
> > +    $ref: ../regulator/max77650-regulator.yaml
>
> Not bisectable... This patch needs to come last.
>
> > +
> > +  charger:
> > +    $ref: ../power/supply/max77650-charger.yaml
> > +
> > +  leds:
> > +    $ref: ../leds/leds-max77650.yaml
> > +
> > +  onkey:
> > +    $ref: ../input/max77650-onkey.yaml
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - interrupt-controller
> > +  - "#interrupt-cells"
> > +  - gpio-controller
> > +  - "#gpio-cells"
>
> None of the child nodes are required?
>

Technically no, and now when I think about it, neither are the
following two properties really:

  - gpio-controller
  - "#gpio-cells"

You can define an empty device, it's just going to be useless. For
practical purposes you can use any combination of modules, so I
wouldn't make any of them required.

Bart

> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/input/linux-event-codes.h>
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        pmic@48 {
> > +            compatible =3D "maxim,max77650";
> > +            reg =3D <0x48>;
> > +
> > +            interrupt-controller;
> > +            interrupt-parent =3D <&gpio2>;
> > +            #interrupt-cells =3D <2>;
> > +            interrupts =3D <3 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +            gpio-controller;
> > +            #gpio-cells =3D <2>;
> > +            gpio-line-names =3D "max77650-charger";
> > +
> > +            regulators {
> > +                compatible =3D "maxim,max77650-regulator";
> > +
> > +                max77650_ldo: regulator@0 {
> > +                    regulator-compatible =3D "ldo";
> > +                    regulator-name =3D "max77650-ldo";
> > +                    regulator-min-microvolt =3D <1350000>;
> > +                    regulator-max-microvolt =3D <2937500>;
> > +                };
> > +
> > +                max77650_sbb0: regulator@1 {
> > +                    regulator-compatible =3D "sbb0";
> > +                    regulator-name =3D "max77650-sbb0";
> > +                    regulator-min-microvolt =3D <800000>;
> > +                    regulator-max-microvolt =3D <1587500>;
> > +                };
> > +            };
> > +
> > +            charger {
> > +                compatible =3D "maxim,max77650-charger";
> > +                input-voltage-min-microvolt =3D <4200000>;
> > +                input-current-limit-microamp =3D <285000>;
> > +            };
> > +
> > +            leds {
> > +                compatible =3D "maxim,max77650-led";
> > +                #address-cells =3D <1>;
> > +                #size-cells =3D <0>;
> > +
> > +                led@0 {
> > +                    reg =3D <0>;
> > +                    label =3D "blue:usr0";
> > +                };
> > +
> > +                led@1 {
> > +                    reg =3D <1>;
> > +                    label =3D "red:usr1";
> > +                    linux,default-trigger =3D "heartbeat";
> > +                };
> > +
> > +                led@2 {
> > +                    reg =3D <2>;
> > +                    label =3D "green:usr2";
> > +                };
> > +            };
> > +
> > +            onkey {
> > +                compatible =3D "maxim,max77650-onkey";
> > +                linux,code =3D <KEY_END>;
> > +                maxim,onkey-slide;
> > +            };
> > +        };
> > +    };
> > --
> > 2.23.0
> >
