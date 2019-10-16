Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4CBD958D
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 17:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731190AbfJPP3E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 11:29:04 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42545 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394131AbfJPP3E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 11:29:04 -0400
Received: by mail-ot1-f65.google.com with SMTP id c10so20518177otd.9
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 08:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V9VEJ6qCsL2ywbrpNNXgyPcRNbaXwu3Y4oOlJhBpLzQ=;
        b=cDMLHUXZK9cMI2/GCB64rQqpH3gxjuGZNiLW7PVaJUUcrSTGnUd89F+fe1nuIvO0Fa
         dUVOOVGMVkibaDN2U3QOAKuVrnTDKzqEFFR4aRPZ+x4DUecvR60CxRXNHTaYUIryLWlY
         GP0IdCOYERcI8Sv+trmIiCysCspwk3tTYzMpuyqF8ghLI/dVaDkab1XBRbwsBWkiF7ri
         tlOtabO/vY2XtZYqGhMjmjj9D9JbBqqFeLrO5JRvnUjYRWlm+2w3z57IanSq6eVS05QI
         N9/5GCdaCrwm7FkqeDEFdHd+D4o4aPwI4+EQ5AGN/AEpcAyOr6hbMepo9So70Ps3W8/Q
         dWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V9VEJ6qCsL2ywbrpNNXgyPcRNbaXwu3Y4oOlJhBpLzQ=;
        b=tITgQTDadG0MjYvxLOot54Ew5CQbMovCTOOnCJIkwQ6JoL9ULgZ6Co0A2Y+5m93AJc
         LJdarmIoVvoyDFhN0UIkOiqMhCq89ej1HRmkiTT9EmAJNsJqqUXss6pathcZ9CZUS379
         K+PryWea7NJ2lbXbHXxzBIWaKac9XwzW0R1DWcqrg0CuI5rIwr1YDN3FSfTLhG/GPnDz
         vCDNO6Cl3xo8RE1bY0cGqRIXksLwXSQh0+cixGBvfsiNOrEKrDrU1HQMpuqwDOv/pelY
         MgIqCBaFTvRtmCc62fvBCAeGAdXiB77wd5RO8/EmFd/5n9FIQu12a0c/9PR8nDKRv17R
         PiqA==
X-Gm-Message-State: APjAAAXIS5zHosbkyKXrEgrhA7q322ejaPvRBfO26cF+BCIIlI6yTz9P
        ST3BpghA3fNbYN+a2GmpD5f8zC93lm9wsY8Ofk5YbQ==
X-Google-Smtp-Source: APXvYqxwgp+zi0BPWcA5EYFlnLtpnZA5f6BadLLiWGM2ewOW44p8W5YP5jVes3s2F+Rtq1EiRqUqeBH/KPbq4q7mKqs=
X-Received: by 2002:a9d:6c96:: with SMTP id c22mr3645106otr.194.1571239742813;
 Wed, 16 Oct 2019 08:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191015162300.22024-1-brgl@bgdev.pl> <20191015162300.22024-2-brgl@bgdev.pl>
 <CAL_JsqKhGr6QDWZFR6cq6MH-0vghb9oSgkCCdi7bhiKmvrkY_w@mail.gmail.com>
 <CAMRc=Mdb7T6p7xXWJBS2UXq0E-FD4WRtaP7H-AvRH0s6-MyJ8A@mail.gmail.com> <CAL_JsqJZ9myO3Uwb6j_R3W8EpVtOaCZV6_tDfNAXwoaUZO+kNQ@mail.gmail.com>
In-Reply-To: <CAL_JsqJZ9myO3Uwb6j_R3W8EpVtOaCZV6_tDfNAXwoaUZO+kNQ@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 16 Oct 2019 17:28:51 +0200
Message-ID: <CAMpxmJUrwTn9cafnGD5KPJObhgYq0GN2EedwGiey2tAXwFmbvA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: mfd: max77650: convert the binding
 document to yaml
To:     Rob Herring <robh+dt@kernel.org>
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

=C5=9Br., 16 pa=C5=BA 2019 o 15:51 Rob Herring <robh+dt@kernel.org> napisa=
=C5=82(a):
>
> On Wed, Oct 16, 2019 at 7:55 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote=
:
> >
> > wt., 15 pa=C5=BA 2019 o 23:17 Rob Herring <robh+dt@kernel.org> napisa=
=C5=82(a):
> > >
> > > On Tue, Oct 15, 2019 at 11:23 AM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
> > > >
> > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > >
> > > > Convert the binding document for MAX77650 core MFD module to YAML.
> > > >
> > > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > > ---
> > > >  .../devicetree/bindings/mfd/max77650.txt      | 47 +----------
> > > >  .../devicetree/bindings/mfd/max77650.yaml     | 83 +++++++++++++++=
++++
> > > >  2 files changed, 84 insertions(+), 46 deletions(-)
> > > >  create mode 100644 Documentation/devicetree/bindings/mfd/max77650.=
yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/mfd/max77650.txt b/D=
ocumentation/devicetree/bindings/mfd/max77650.txt
> > > > index b529d8d19335..080871686b3b 100644
> > > > --- a/Documentation/devicetree/bindings/mfd/max77650.txt
> > > > +++ b/Documentation/devicetree/bindings/mfd/max77650.txt
> > > > @@ -1,46 +1 @@
> > > > -MAX77650 ultra low-power PMIC from Maxim Integrated.
> > > > -
> > > > -Required properties:
> > > > --------------------
> > > > -- compatible:          Must be "maxim,max77650"
> > > > -- reg:                 I2C device address.
> > > > -- interrupts:          The interrupt on the parent the controller =
is
> > > > -                       connected to.
> > > > -- interrupt-controller: Marks the device node as an interrupt cont=
roller.
> > > > -- #interrupt-cells:    Must be <2>.
> > > > -
> > > > -- gpio-controller:     Marks the device node as a gpio controller.
> > > > -- #gpio-cells:         Must be <2>. The first cell is the pin numb=
er and
> > > > -                       the second cell is used to specify the gpio=
 active
> > > > -                       state.
> > > > -
> > > > -Optional properties:
> > > > ---------------------
> > > > -gpio-line-names:       Single string containing the name of the GP=
IO line.
> > > > -
> > > > -The GPIO-controller module is represented as part of the top-level=
 PMIC
> > > > -node. The device exposes a single GPIO line.
> > > > -
> > > > -For device-tree bindings of other sub-modules (regulator, power su=
pply,
> > > > -LEDs and onkey) refer to the binding documents under the respectiv=
e
> > > > -sub-system directories.
> > > > -
> > > > -For more details on GPIO bindings, please refer to the generic GPI=
O DT
> > > > -binding document <devicetree/bindings/gpio/gpio.txt>.
> > > > -
> > > > -Example:
> > > > ---------
> > > > -
> > > > -       pmic@48 {
> > > > -               compatible =3D "maxim,max77650";
> > > > -               reg =3D <0x48>;
> > > > -
> > > > -               interrupt-controller;
> > > > -               interrupt-parent =3D <&gpio2>;
> > > > -               #interrupt-cells =3D <2>;
> > > > -               interrupts =3D <3 IRQ_TYPE_LEVEL_LOW>;
> > > > -
> > > > -               gpio-controller;
> > > > -               #gpio-cells =3D <2>;
> > > > -               gpio-line-names =3D "max77650-charger";
> > > > -       };
> > > > +This file has been moved to max77650.yaml.
> > > > diff --git a/Documentation/devicetree/bindings/mfd/max77650.yaml b/=
Documentation/devicetree/bindings/mfd/max77650.yaml
> > > > new file mode 100644
> > > > index 000000000000..5186ad287ec7
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/mfd/max77650.yaml
> > > > @@ -0,0 +1,83 @@
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/mfd/max77650.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: MAX77650 ultra low-power PMIC from Maxim Integrated.
> > > > +
> > > > +maintainers:
> > > > +  - Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > > +
> > > > +description: |
> > > > +  This document describes the DT properties of the core MFD contro=
ller.
> > > > +
> > > > +  The GPIO-controller module is represented as part of the top-lev=
el PMIC
> > > > +  node. The device exposes a single GPIO line.
> > > > +
> > > > +  For device-tree bindings of other sub-modules (regulator, power =
supply,
> > > > +  LEDs and onkey) refer to the binding documents under the respect=
ive
> > > > +  sub-system directories.
> > > > +
> > > > +  For more details on GPIO bindings, please refer to the generic G=
PIO DT
> > > > +  binding document <devicetree/bindings/gpio/gpio.txt>.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: maxim,max77650
> > > > +
> > > > +  reg:
> > > > +    description:
> > > > +      I2C device address.
> > > > +    maxItems: 1
> > > > +
> > > > +  interrupts:
> > > > +    description:
> > > > +      The interrupt on the parent the controller is connected to.
> > > > +    maxItems: 1
> > > > +
> > > > +  interrupt-controller: true
> > > > +
> > > > +  "#interrupt-cells":
> > > > +    const: 2
> > > > +    description:
> > > > +      The first cell is the IRQ number, the second cell is the tri=
gger type.
> > > > +
> > > > +  gpio-controller: true
> > > > +
> > > > +  "#gpio-cells":
> > > > +    const: 2
> > > > +    description:
> > > > +      The first cell is the pin number and the second cell is used=
 to specify
> > > > +      the gpio active state.
> > > > +
> > > > +  gpio-line-names:
> > > > +    $ref: '/schemas/types.yaml#/definitions/string-array'
> > > > +    maxItems: 1
> > > > +    description:
> > > > +      Single string containing the name of the GPIO line.
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +  - interrupts
> > > > +  - interrupt-controller
> > > > +  - "#interrupt-cells"
> > > > +  - gpio-controller
> > > > +  - "#gpio-cells"
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    pmic@48 {
> > > > +        compatible =3D "maxim,max77650";
> > > > +        reg =3D <0x48>;
> > > > +
> > > > +        interrupt-controller;
> > > > +        interrupt-parent =3D <&gpio2>;
> > > > +        #interrupt-cells =3D <2>;
> > > > +        interrupts =3D <3 IRQ_TYPE_LEVEL_LOW>;
> > >
> > > Examples are built now. Run 'make dt_binding_check' on bindings befor=
e
> > > sending them:
> > >
> > > Error: Documentation/devicetree/bindings/mfd/max77650.example.dts:24.=
29-30
> > > syntax error
> > > FATAL ERROR: Unable to parse input tree
> > > scripts/Makefile.lib:321: recipe for target
> > > 'Documentation/devicetree/bindings/mfd/max77650.example.dt.yaml'
> > > failed
> > > make[1]: *** [Documentation/devicetree/bindings/mfd/max77650.example.=
dt.yaml]
> > > Error 1
> > >
> > > You need to include any includes that you use.
> > >
> > > Rob
> >
> > Hi Rob,
> >
> > thanks for the review.
> >
> > I'm on v5.4-rc3 and when running dt_binding_check, the error I'm
> > getting is this:
> >
> > # make dt_binding_check
> > DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/mfd/max77650.yaml
> >   SCHEMA  Documentation/devicetree/bindings/processed-schema.yaml
> >   CHKDT   Documentation/devicetree/bindings/mfd/max77650.yaml
> > make[1]: *** No rule to make target
> > 'Documentation/devicetree/bindings/mfd/max77650.example.dt.yaml',
> > needed by '__build'.  Stop.
> > make: *** [Makefile:1263: dt_binding_check] Error 2
> >
> > Is this caused by the same issue or am I missing something?
>
> I believe that's because dtc needs to be built with libyaml support.
>

Indeed, I didn't have the development package installed, but
surprisingly I didn't get the warning from scripts/dtc/Makefile about
that either.

Bart

> Rob
