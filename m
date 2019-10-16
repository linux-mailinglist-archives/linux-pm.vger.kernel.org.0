Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54B42D95F1
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 17:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405815AbfJPPtK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 11:49:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbfJPPtK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 16 Oct 2019 11:49:10 -0400
Received: from mail-yw1-f44.google.com (mail-yw1-f44.google.com [209.85.161.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A87A121D7E;
        Wed, 16 Oct 2019 15:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571240948;
        bh=KRoUtKuSWHC21MlmiyXnJSejnSs4Eg2tbs0/xtaSdPA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HhPwUNZG7oQO35AWU9YlC7lrMoihlvhNo7elAcggSdKAdnQPN729+HqRaMVLI3A1N
         k1Ix2KifVAiHw3H+3JsQuC+lJZ5NdMz08X9dKsdYNi/3+00ECngfdAaxQkFnNNEXzM
         AfAgd/EGtQO9GkpvPkUCfZH5BFZO4mBK9g5JUOjA=
Received: by mail-yw1-f44.google.com with SMTP id x65so8791135ywf.12;
        Wed, 16 Oct 2019 08:49:08 -0700 (PDT)
X-Gm-Message-State: APjAAAVfTMhyii2/xtqTfSYTowsIluhihwOpkfY4EROaowQ2QV7KIDyO
        bfakHLquMX63BQm4OZk9UXC6dy+FOJ3ADVdbmw==
X-Google-Smtp-Source: APXvYqyI5XpnB7gsiyRC6ve6uohOEeb4WWODpnu85a3dD0wW1R0nAUvBrOLLqAxi1Q5y5ND9P0KsqOIHtDFEyQ0xH0E=
X-Received: by 2002:a81:57d4:: with SMTP id l203mr19272099ywb.281.1571240947703;
 Wed, 16 Oct 2019 08:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191015162300.22024-1-brgl@bgdev.pl> <20191015162300.22024-2-brgl@bgdev.pl>
 <CAL_JsqKhGr6QDWZFR6cq6MH-0vghb9oSgkCCdi7bhiKmvrkY_w@mail.gmail.com>
 <CAMRc=Mdb7T6p7xXWJBS2UXq0E-FD4WRtaP7H-AvRH0s6-MyJ8A@mail.gmail.com>
 <CAL_JsqJZ9myO3Uwb6j_R3W8EpVtOaCZV6_tDfNAXwoaUZO+kNQ@mail.gmail.com> <CAMpxmJUrwTn9cafnGD5KPJObhgYq0GN2EedwGiey2tAXwFmbvA@mail.gmail.com>
In-Reply-To: <CAMpxmJUrwTn9cafnGD5KPJObhgYq0GN2EedwGiey2tAXwFmbvA@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 16 Oct 2019 10:48:56 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ3YDW9fSF7kCb+Wqv1mmAnAL4uYHdWiVHXB9fZVUGk+g@mail.gmail.com>
Message-ID: <CAL_JsqJ3YDW9fSF7kCb+Wqv1mmAnAL4uYHdWiVHXB9fZVUGk+g@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: mfd: max77650: convert the binding
 document to yaml
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
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
        devicetree <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 16, 2019 at 10:29 AM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
>
> =C5=9Br., 16 pa=C5=BA 2019 o 15:51 Rob Herring <robh+dt@kernel.org> napis=
a=C5=82(a):
> >
> > On Wed, Oct 16, 2019 at 7:55 AM Bartosz Golaszewski <brgl@bgdev.pl> wro=
te:
> > >
> > > wt., 15 pa=C5=BA 2019 o 23:17 Rob Herring <robh+dt@kernel.org> napisa=
=C5=82(a):
> > > >
> > > > On Tue, Oct 15, 2019 at 11:23 AM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
> > > > >
> > > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > > >
> > > > > Convert the binding document for MAX77650 core MFD module to YAML=
.
> > > > >
> > > > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > > > ---
> > > > >  .../devicetree/bindings/mfd/max77650.txt      | 47 +----------
> > > > >  .../devicetree/bindings/mfd/max77650.yaml     | 83 +++++++++++++=
++++++
> > > > >  2 files changed, 84 insertions(+), 46 deletions(-)
> > > > >  create mode 100644 Documentation/devicetree/bindings/mfd/max7765=
0.yaml
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/mfd/max77650.txt b=
/Documentation/devicetree/bindings/mfd/max77650.txt
> > > > > index b529d8d19335..080871686b3b 100644
> > > > > --- a/Documentation/devicetree/bindings/mfd/max77650.txt
> > > > > +++ b/Documentation/devicetree/bindings/mfd/max77650.txt
> > > > > @@ -1,46 +1 @@
> > > > > -MAX77650 ultra low-power PMIC from Maxim Integrated.
> > > > > -
> > > > > -Required properties:
> > > > > --------------------
> > > > > -- compatible:          Must be "maxim,max77650"
> > > > > -- reg:                 I2C device address.
> > > > > -- interrupts:          The interrupt on the parent the controlle=
r is
> > > > > -                       connected to.
> > > > > -- interrupt-controller: Marks the device node as an interrupt co=
ntroller.
> > > > > -- #interrupt-cells:    Must be <2>.
> > > > > -
> > > > > -- gpio-controller:     Marks the device node as a gpio controlle=
r.
> > > > > -- #gpio-cells:         Must be <2>. The first cell is the pin nu=
mber and
> > > > > -                       the second cell is used to specify the gp=
io active
> > > > > -                       state.
> > > > > -
> > > > > -Optional properties:
> > > > > ---------------------
> > > > > -gpio-line-names:       Single string containing the name of the =
GPIO line.
> > > > > -
> > > > > -The GPIO-controller module is represented as part of the top-lev=
el PMIC
> > > > > -node. The device exposes a single GPIO line.
> > > > > -
> > > > > -For device-tree bindings of other sub-modules (regulator, power =
supply,
> > > > > -LEDs and onkey) refer to the binding documents under the respect=
ive
> > > > > -sub-system directories.
> > > > > -
> > > > > -For more details on GPIO bindings, please refer to the generic G=
PIO DT
> > > > > -binding document <devicetree/bindings/gpio/gpio.txt>.
> > > > > -
> > > > > -Example:
> > > > > ---------
> > > > > -
> > > > > -       pmic@48 {
> > > > > -               compatible =3D "maxim,max77650";
> > > > > -               reg =3D <0x48>;
> > > > > -
> > > > > -               interrupt-controller;
> > > > > -               interrupt-parent =3D <&gpio2>;
> > > > > -               #interrupt-cells =3D <2>;
> > > > > -               interrupts =3D <3 IRQ_TYPE_LEVEL_LOW>;
> > > > > -
> > > > > -               gpio-controller;
> > > > > -               #gpio-cells =3D <2>;
> > > > > -               gpio-line-names =3D "max77650-charger";
> > > > > -       };
> > > > > +This file has been moved to max77650.yaml.
> > > > > diff --git a/Documentation/devicetree/bindings/mfd/max77650.yaml =
b/Documentation/devicetree/bindings/mfd/max77650.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..5186ad287ec7
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/mfd/max77650.yaml
> > > > > @@ -0,0 +1,83 @@
> > > > > +# SPDX-License-Identifier: GPL-2.0
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/mfd/max77650.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: MAX77650 ultra low-power PMIC from Maxim Integrated.
> > > > > +
> > > > > +maintainers:
> > > > > +  - Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > > > +
> > > > > +description: |
> > > > > +  This document describes the DT properties of the core MFD cont=
roller.
> > > > > +
> > > > > +  The GPIO-controller module is represented as part of the top-l=
evel PMIC
> > > > > +  node. The device exposes a single GPIO line.
> > > > > +
> > > > > +  For device-tree bindings of other sub-modules (regulator, powe=
r supply,
> > > > > +  LEDs and onkey) refer to the binding documents under the respe=
ctive
> > > > > +  sub-system directories.
> > > > > +
> > > > > +  For more details on GPIO bindings, please refer to the generic=
 GPIO DT
> > > > > +  binding document <devicetree/bindings/gpio/gpio.txt>.
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    const: maxim,max77650
> > > > > +
> > > > > +  reg:
> > > > > +    description:
> > > > > +      I2C device address.
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  interrupts:
> > > > > +    description:
> > > > > +      The interrupt on the parent the controller is connected to=
.
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  interrupt-controller: true
> > > > > +
> > > > > +  "#interrupt-cells":
> > > > > +    const: 2
> > > > > +    description:
> > > > > +      The first cell is the IRQ number, the second cell is the t=
rigger type.
> > > > > +
> > > > > +  gpio-controller: true
> > > > > +
> > > > > +  "#gpio-cells":
> > > > > +    const: 2
> > > > > +    description:
> > > > > +      The first cell is the pin number and the second cell is us=
ed to specify
> > > > > +      the gpio active state.
> > > > > +
> > > > > +  gpio-line-names:
> > > > > +    $ref: '/schemas/types.yaml#/definitions/string-array'
> > > > > +    maxItems: 1
> > > > > +    description:
> > > > > +      Single string containing the name of the GPIO line.
> > > > > +
> > > > > +required:
> > > > > +  - compatible
> > > > > +  - reg
> > > > > +  - interrupts
> > > > > +  - interrupt-controller
> > > > > +  - "#interrupt-cells"
> > > > > +  - gpio-controller
> > > > > +  - "#gpio-cells"
> > > > > +
> > > > > +examples:
> > > > > +  - |
> > > > > +    pmic@48 {
> > > > > +        compatible =3D "maxim,max77650";
> > > > > +        reg =3D <0x48>;
> > > > > +
> > > > > +        interrupt-controller;
> > > > > +        interrupt-parent =3D <&gpio2>;
> > > > > +        #interrupt-cells =3D <2>;
> > > > > +        interrupts =3D <3 IRQ_TYPE_LEVEL_LOW>;
> > > >
> > > > Examples are built now. Run 'make dt_binding_check' on bindings bef=
ore
> > > > sending them:
> > > >
> > > > Error: Documentation/devicetree/bindings/mfd/max77650.example.dts:2=
4.29-30
> > > > syntax error
> > > > FATAL ERROR: Unable to parse input tree
> > > > scripts/Makefile.lib:321: recipe for target
> > > > 'Documentation/devicetree/bindings/mfd/max77650.example.dt.yaml'
> > > > failed
> > > > make[1]: *** [Documentation/devicetree/bindings/mfd/max77650.exampl=
e.dt.yaml]
> > > > Error 1
> > > >
> > > > You need to include any includes that you use.
> > > >
> > > > Rob
> > >
> > > Hi Rob,
> > >
> > > thanks for the review.
> > >
> > > I'm on v5.4-rc3 and when running dt_binding_check, the error I'm
> > > getting is this:
> > >
> > > # make dt_binding_check
> > > DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/mfd/max77650.yaml
> > >   SCHEMA  Documentation/devicetree/bindings/processed-schema.yaml
> > >   CHKDT   Documentation/devicetree/bindings/mfd/max77650.yaml
> > > make[1]: *** No rule to make target
> > > 'Documentation/devicetree/bindings/mfd/max77650.example.dt.yaml',
> > > needed by '__build'.  Stop.
> > > make: *** [Makefile:1263: dt_binding_check] Error 2
> > >
> > > Is this caused by the same issue or am I missing something?
> >
> > I believe that's because dtc needs to be built with libyaml support.
> >
>
> Indeed, I didn't have the development package installed, but
> surprisingly I didn't get the warning from scripts/dtc/Makefile about
> that either.

That's because CHECK_DTBS only gets set for 'dtbs_check' and not
'dt_binding_check'. I'm testing whether I can add it. The issue is I
also want to enable 'dt_binding_check', but not 'dtbs_check' for
all{yes,mod}config. I guess I need 2 variables or some other approach.

Rob
