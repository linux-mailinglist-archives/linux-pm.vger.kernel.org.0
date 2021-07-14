Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B0A3C92AE
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jul 2021 23:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhGNVDC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Jul 2021 17:03:02 -0400
Received: from mail-yb1-f181.google.com ([209.85.219.181]:43901 "EHLO
        mail-yb1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhGNVDC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jul 2021 17:03:02 -0400
Received: by mail-yb1-f181.google.com with SMTP id g5so5401856ybu.10;
        Wed, 14 Jul 2021 14:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JxzyyREwq06Hzronh5MwIhSbRu7e1HNovcwkk/6kr5g=;
        b=JPcL+3i4Dth+38fdqJ4dXso3tUTu8CiFs1SKXKkEWx2bO8HxE278kLivJq0JPObr+N
         vPLl3s2zxZmJqronF+xQZ2PLoO2LG8OAdiGcGXfg2VLjxVYYWBPf337Qdrfrk9Xwf/cv
         Nk5HATOc2X4NNl0M2pVjfBJ0UnqwGvGbGpDtT+F0A8Zh98ZwfT0lYr05G4eWy/NiHiHu
         M1nXBQyFLymqgz5R2Psyi6S4t/iskNzEM5yLNObfud8vnkaZwHZLcAy9HK8aJ/mHFQe6
         5MZxFVg2x/vXnixE5i3VPhNjDzyq5hkBwuLTHHQNBOLdfQb1uwFZvB7br7xXWCm0Br9Z
         +otw==
X-Gm-Message-State: AOAM533y8m0Q4TUjZNohEzc/dA23219ITzv3V2kvt90RzBbM3v5SB1F2
        VJvTuNTkZtinbjlagHCfsJqw3pBsZ55KVf/nqPk=
X-Google-Smtp-Source: ABdhPJwBpmW9NBF5oy/Um3cWuJsyHmWSlrJSIAUML9hxE6ITzApsxqdoPcECaMY7eUN53+4mHEMrp2rdDZnRc15KruQ=
X-Received: by 2002:a25:8093:: with SMTP id n19mr16104389ybk.414.1626296409369;
 Wed, 14 Jul 2021 14:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210625224744.1020108-1-kernel@esmil.dk> <20210625224744.1020108-2-kernel@esmil.dk>
 <20210714204400.GB3476672@robh.at.kernel.org>
In-Reply-To: <20210714204400.GB3476672@robh.at.kernel.org>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Wed, 14 Jul 2021 22:59:57 +0200
Message-ID: <CANBLGcxonf7w9a3T78-8gkNy2YVkxR5RZVvWfYBP6VgvWQ+cxg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: mfd: convert tps65086.txt to YAML
To:     Rob Herring <robh@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 14 Jul 2021 at 22:44, Rob Herring <robh@kernel.org> wrote:
> On Sat, Jun 26, 2021 at 12:47:42AM +0200, Emil Renner Berthing wrote:
> > This converts the tps65086.txt binding description to YAML schema so
> > dts files can be verified automatically.
> >
> > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > ---
> > @Andrew: The dt-bindings meta schema requires a maintainer entry. I hope
> > it's ok that I've added you, otherwise I don't know who should be
> > listed.
>
> Anyone that knows the h/w and/or cares if the binding is changed or
> deleted. If you can't find anyone, then good, one less binding. :)

Hmm.. unless someone else responds I guess I'll just put myself then
since I at least care that it isn't deleted.

> >
> >  .../devicetree/bindings/mfd/ti,tps65086.yaml  | 127 ++++++++++++++++++
> >  .../devicetree/bindings/mfd/tps65086.txt      |  54 --------
> >  2 files changed, 127 insertions(+), 54 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/mfd/tps65086.txt
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml b/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
> > new file mode 100644
> > index 000000000000..ba638bd10a58
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
> > @@ -0,0 +1,127 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/ti,tps65086.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: TPS65086 Power Management Integrated Circuit (PMIC)
> > +
> > +maintainers:
> > +  - Andrew F. Davis <afd@ti.com>
>
> Not a valid email any more.
>
> > +
> > +properties:
> > +  compatible:
> > +    const: ti,tps65086
> > +
> > +  reg:
> > +    const: 0x5e
> > +    description: I2C slave address
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  interrupt-controller: true
> > +
> > +  '#interrupt-cells':
> > +    const: 2
> > +    description: |
> > +      The first cell is the IRQ number. The second cell is the flags,
> > +      encoded as trigger masks from ../interrupt-controller/interrupts.txt.
> > +
> > +  gpio-controller: true
> > +
> > +  '#gpio-cells':
> > +    const: 2
> > +    description: |
> > +      The first cell is the pin number and the second cell is used to specify
> > +      flags.  See ../gpio/gpio.txt for more information.
> > +
> > +  regulators:
> > +    type: object
> > +    description: |
> > +      List of child nodes that specify the regulator initialization data.
> > +      Child nodes must be named after their hardware counterparts:
> > +      buck[1-6], ldoa[1-3], swa1, swb[1-2], and vtt.
> > +      Each child node is defined using the standard binding for regulators and
> > +      the optional regulator properties defined below.
> > +
> > +    patternProperties:
> > +      "^buck[1-6]$":
> > +        type: object
> > +        $ref: ../regulator/regulator.yaml
> > +
> > +        properties:
> > +          regulator-name: true
> > +          regulator-boot-on: true
> > +          regulator-always-on: true
> > +          regulator-min-microvolt: true
> > +          regulator-max-microvolt: true
> > +          ti,regulator-step-size-25mv:
> > +            type: boolean
> > +            description: |
> > +              Set this if the regulator is factory set with a 25mv step voltage
> > +              mapping.
> > +          ti,regulator-decay:
> > +            type: boolean
> > +            description: |
> > +              Set this if the output needs to decay, default is for the output
> > +              to slew down.
> > +
> > +        additionalProperties: false
> > +
> > +      "^(ldoa[1-3]|swa1|swb[1-2]|vtt)$":
> > +        type: object
> > +        $ref: ../regulator/regulator.yaml
> > +
> > +        properties:
> > +          regulator-name: true
> > +          regulator-boot-on: true
> > +          regulator-always-on: true
> > +          regulator-min-microvolt: true
> > +          regulator-max-microvolt: true
> > +
> > +        additionalProperties: false
> > +
> > +additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - interrupt-controller
> > +  - '#interrupt-cells'
> > +  - gpio-controller
> > +  - '#gpio-cells'
> > +  - regulators
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    i2c0 {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        pmic: tps65086@5e {
>
> pmic@5e

Will fix, thanks!

> > +            compatible = "ti,tps65086";
> > +            reg = <0x5e>;
> > +            interrupt-parent = <&gpio1>;
> > +            interrupts = <28 IRQ_TYPE_LEVEL_LOW>;
> > +            interrupt-controller;
> > +            #interrupt-cells = <2>;
> > +            gpio-controller;
> > +            #gpio-cells = <2>;
> > +
> > +            regulators {
> > +                buck1 {
> > +                    regulator-name = "vcc1";
> > +                    regulator-min-microvolt = <1600000>;
> > +                    regulator-max-microvolt = <1600000>;
> > +                    regulator-boot-on;
> > +                    ti,regulator-decay;
> > +                    ti,regulator-step-size-25mv;
> > +                };
> > +            };
> > +        };
> > +    };
> > +
> > +...
> > diff --git a/Documentation/devicetree/bindings/mfd/tps65086.txt b/Documentation/devicetree/bindings/mfd/tps65086.txt
> > deleted file mode 100644
> > index 67eac0ed32df..000000000000
> > --- a/Documentation/devicetree/bindings/mfd/tps65086.txt
> > +++ /dev/null
> > @@ -1,54 +0,0 @@
> > -* TPS65086 Power Management Integrated Circuit (PMIC) bindings
> > -
> > -Required properties:
> > - - compatible                : Should be "ti,tps65086".
> > - - reg                       : I2C slave address.
> > - - interrupts                : The interrupt line the device is connected to.
> > - - interrupt-controller      : Marks the device node as an interrupt controller.
> > - - #interrupt-cells  : The number of cells to describe an IRQ, should be 2.
> > -                         The first cell is the IRQ number.
> > -                         The second cell is the flags, encoded as trigger
> > -                         masks from ../interrupt-controller/interrupts.txt.
> > - - gpio-controller      : Marks the device node as a GPIO Controller.
> > - - #gpio-cells          : Should be two.  The first cell is the pin number and
> > -                            the second cell is used to specify flags.
> > -                            See ../gpio/gpio.txt for more information.
> > - - regulators:          : List of child nodes that specify the regulator
> > -                            initialization data. Child nodes must be named
> > -                            after their hardware counterparts: buck[1-6],
> > -                            ldoa[1-3], swa1, swb[1-2], and vtt. Each child
> > -                            node is defined using the standard binding for
> > -                            regulators and the optional regulator properties
> > -                            defined below.
> > -
> > -Optional regulator properties:
> > - - ti,regulator-step-size-25mv       : This is applicable for buck[1-6], set this
> > -                                 if the regulator is factory set with a 25mv
> > -                                 step voltage mapping.
> > - - ti,regulator-decay                : This is applicable for buck[1-6], set this if
> > -                                 the output needs to decay, default is for
> > -                                 the output to slew down.
> > -
> > -Example:
> > -
> > -     pmic: tps65086@5e {
> > -             compatible = "ti,tps65086";
> > -             reg = <0x5e>;
> > -             interrupt-parent = <&gpio1>;
> > -             interrupts = <28 IRQ_TYPE_LEVEL_LOW>;
> > -             interrupt-controller;
> > -             #interrupt-cells = <2>;
> > -             gpio-controller;
> > -             #gpio-cells = <2>;
> > -
> > -             regulators {
> > -                     buck1 {
> > -                             regulator-name = "vcc1";
> > -                             regulator-min-microvolt = <1600000>;
> > -                             regulator-max-microvolt = <1600000>;
> > -                             regulator-boot-on;
> > -                             ti,regulator-decay;
> > -                             ti,regulator-step-size-25mv;
> > -                     };
> > -             };
> > -     };
> > --
> > 2.32.0
> >
> >
