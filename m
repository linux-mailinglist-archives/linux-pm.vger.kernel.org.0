Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1AED92F5
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 15:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405570AbfJPNvV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 09:51:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405567AbfJPNvV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 16 Oct 2019 09:51:21 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5235A21848;
        Wed, 16 Oct 2019 13:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571233879;
        bh=HCdRDuHYzMBbEO0nrbpBojXNDkZQrE3bThDnWnyflKg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hOWQm9ByS5ZORydHhQKZjVIUuZvxknqO/TwgDkO2NBEqM65WZlnKiWY8VjhFhVIs8
         mL6HWiIAubrubhLSrrA6za5k4qFm4R6RNxX5NzVe38k3lJ32ceoQru8mgMNem/gfAr
         pipS/Lzlmn0CI0rsl9rQs87gPXuAMAwgHmYZqUIo=
Received: by mail-qk1-f173.google.com with SMTP id u184so22808767qkd.4;
        Wed, 16 Oct 2019 06:51:19 -0700 (PDT)
X-Gm-Message-State: APjAAAVgJJL3X9w7PqNEJGGjjiHpsDcOt9sMj7s5Ao5T/UwvffGYiByb
        htH2C8SQut4eIMwXv5EUhW6YaDzAOeB/uOhH3w==
X-Google-Smtp-Source: APXvYqx7BlcygeKrIYBNjMW/BUKQN2ZxX5edXsFDWH7JF43qkfOVAIHn+CnzgtR4eQlWfHy/eyt61P4z/30Axgg7KSo=
X-Received: by 2002:a37:2f81:: with SMTP id v123mr41956355qkh.254.1571233878318;
 Wed, 16 Oct 2019 06:51:18 -0700 (PDT)
MIME-Version: 1.0
References: <20191015162300.22024-1-brgl@bgdev.pl> <20191015162300.22024-2-brgl@bgdev.pl>
 <CAL_JsqKhGr6QDWZFR6cq6MH-0vghb9oSgkCCdi7bhiKmvrkY_w@mail.gmail.com> <CAMRc=Mdb7T6p7xXWJBS2UXq0E-FD4WRtaP7H-AvRH0s6-MyJ8A@mail.gmail.com>
In-Reply-To: <CAMRc=Mdb7T6p7xXWJBS2UXq0E-FD4WRtaP7H-AvRH0s6-MyJ8A@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 16 Oct 2019 08:51:06 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJZ9myO3Uwb6j_R3W8EpVtOaCZV6_tDfNAXwoaUZO+kNQ@mail.gmail.com>
Message-ID: <CAL_JsqJZ9myO3Uwb6j_R3W8EpVtOaCZV6_tDfNAXwoaUZO+kNQ@mail.gmail.com>
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
        devicetree <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 16, 2019 at 7:55 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> wt., 15 pa=C5=BA 2019 o 23:17 Rob Herring <robh+dt@kernel.org> napisa=C5=
=82(a):
> >
> > On Tue, Oct 15, 2019 at 11:23 AM Bartosz Golaszewski <brgl@bgdev.pl> wr=
ote:
> > >
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > Convert the binding document for MAX77650 core MFD module to YAML.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > ---
> > >  .../devicetree/bindings/mfd/max77650.txt      | 47 +----------
> > >  .../devicetree/bindings/mfd/max77650.yaml     | 83 +++++++++++++++++=
++
> > >  2 files changed, 84 insertions(+), 46 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/mfd/max77650.ya=
ml
> > >
> > > diff --git a/Documentation/devicetree/bindings/mfd/max77650.txt b/Doc=
umentation/devicetree/bindings/mfd/max77650.txt
> > > index b529d8d19335..080871686b3b 100644
> > > --- a/Documentation/devicetree/bindings/mfd/max77650.txt
> > > +++ b/Documentation/devicetree/bindings/mfd/max77650.txt
> > > @@ -1,46 +1 @@
> > > -MAX77650 ultra low-power PMIC from Maxim Integrated.
> > > -
> > > -Required properties:
> > > --------------------
> > > -- compatible:          Must be "maxim,max77650"
> > > -- reg:                 I2C device address.
> > > -- interrupts:          The interrupt on the parent the controller is
> > > -                       connected to.
> > > -- interrupt-controller: Marks the device node as an interrupt contro=
ller.
> > > -- #interrupt-cells:    Must be <2>.
> > > -
> > > -- gpio-controller:     Marks the device node as a gpio controller.
> > > -- #gpio-cells:         Must be <2>. The first cell is the pin number=
 and
> > > -                       the second cell is used to specify the gpio a=
ctive
> > > -                       state.
> > > -
> > > -Optional properties:
> > > ---------------------
> > > -gpio-line-names:       Single string containing the name of the GPIO=
 line.
> > > -
> > > -The GPIO-controller module is represented as part of the top-level P=
MIC
> > > -node. The device exposes a single GPIO line.
> > > -
> > > -For device-tree bindings of other sub-modules (regulator, power supp=
ly,
> > > -LEDs and onkey) refer to the binding documents under the respective
> > > -sub-system directories.
> > > -
> > > -For more details on GPIO bindings, please refer to the generic GPIO =
DT
> > > -binding document <devicetree/bindings/gpio/gpio.txt>.
> > > -
> > > -Example:
> > > ---------
> > > -
> > > -       pmic@48 {
> > > -               compatible =3D "maxim,max77650";
> > > -               reg =3D <0x48>;
> > > -
> > > -               interrupt-controller;
> > > -               interrupt-parent =3D <&gpio2>;
> > > -               #interrupt-cells =3D <2>;
> > > -               interrupts =3D <3 IRQ_TYPE_LEVEL_LOW>;
> > > -
> > > -               gpio-controller;
> > > -               #gpio-cells =3D <2>;
> > > -               gpio-line-names =3D "max77650-charger";
> > > -       };
> > > +This file has been moved to max77650.yaml.
> > > diff --git a/Documentation/devicetree/bindings/mfd/max77650.yaml b/Do=
cumentation/devicetree/bindings/mfd/max77650.yaml
> > > new file mode 100644
> > > index 000000000000..5186ad287ec7
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mfd/max77650.yaml
> > > @@ -0,0 +1,83 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/mfd/max77650.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: MAX77650 ultra low-power PMIC from Maxim Integrated.
> > > +
> > > +maintainers:
> > > +  - Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > +
> > > +description: |
> > > +  This document describes the DT properties of the core MFD controll=
er.
> > > +
> > > +  The GPIO-controller module is represented as part of the top-level=
 PMIC
> > > +  node. The device exposes a single GPIO line.
> > > +
> > > +  For device-tree bindings of other sub-modules (regulator, power su=
pply,
> > > +  LEDs and onkey) refer to the binding documents under the respectiv=
e
> > > +  sub-system directories.
> > > +
> > > +  For more details on GPIO bindings, please refer to the generic GPI=
O DT
> > > +  binding document <devicetree/bindings/gpio/gpio.txt>.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: maxim,max77650
> > > +
> > > +  reg:
> > > +    description:
> > > +      I2C device address.
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    description:
> > > +      The interrupt on the parent the controller is connected to.
> > > +    maxItems: 1
> > > +
> > > +  interrupt-controller: true
> > > +
> > > +  "#interrupt-cells":
> > > +    const: 2
> > > +    description:
> > > +      The first cell is the IRQ number, the second cell is the trigg=
er type.
> > > +
> > > +  gpio-controller: true
> > > +
> > > +  "#gpio-cells":
> > > +    const: 2
> > > +    description:
> > > +      The first cell is the pin number and the second cell is used t=
o specify
> > > +      the gpio active state.
> > > +
> > > +  gpio-line-names:
> > > +    $ref: '/schemas/types.yaml#/definitions/string-array'
> > > +    maxItems: 1
> > > +    description:
> > > +      Single string containing the name of the GPIO line.
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - interrupts
> > > +  - interrupt-controller
> > > +  - "#interrupt-cells"
> > > +  - gpio-controller
> > > +  - "#gpio-cells"
> > > +
> > > +examples:
> > > +  - |
> > > +    pmic@48 {
> > > +        compatible =3D "maxim,max77650";
> > > +        reg =3D <0x48>;
> > > +
> > > +        interrupt-controller;
> > > +        interrupt-parent =3D <&gpio2>;
> > > +        #interrupt-cells =3D <2>;
> > > +        interrupts =3D <3 IRQ_TYPE_LEVEL_LOW>;
> >
> > Examples are built now. Run 'make dt_binding_check' on bindings before
> > sending them:
> >
> > Error: Documentation/devicetree/bindings/mfd/max77650.example.dts:24.29=
-30
> > syntax error
> > FATAL ERROR: Unable to parse input tree
> > scripts/Makefile.lib:321: recipe for target
> > 'Documentation/devicetree/bindings/mfd/max77650.example.dt.yaml'
> > failed
> > make[1]: *** [Documentation/devicetree/bindings/mfd/max77650.example.dt=
.yaml]
> > Error 1
> >
> > You need to include any includes that you use.
> >
> > Rob
>
> Hi Rob,
>
> thanks for the review.
>
> I'm on v5.4-rc3 and when running dt_binding_check, the error I'm
> getting is this:
>
> # make dt_binding_check
> DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/mfd/max77650.yaml
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.yaml
>   CHKDT   Documentation/devicetree/bindings/mfd/max77650.yaml
> make[1]: *** No rule to make target
> 'Documentation/devicetree/bindings/mfd/max77650.example.dt.yaml',
> needed by '__build'.  Stop.
> make: *** [Makefile:1263: dt_binding_check] Error 2
>
> Is this caused by the same issue or am I missing something?

I believe that's because dtc needs to be built with libyaml support.

Rob
