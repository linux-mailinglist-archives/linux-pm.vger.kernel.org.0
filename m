Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89864D91A6
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 14:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732067AbfJPMz4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 08:55:56 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:41989 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbfJPMz4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 08:55:56 -0400
Received: by mail-il1-f194.google.com with SMTP id o18so2469742ilo.9
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 05:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qda5ffDTblUU8JGu4nuH5ZD05Te45+ZgViZmocYeACs=;
        b=rMb84r8iQLAC38MibQ/V2rXDvCRSxVxzno6NbsIzxdlfKVTv7g9nB9NYrdUDcgAApl
         lSIlnR2DTcieW1lRkZLQVqW5pmXG2SQjFI2DC43m5t/5ouLpQx/Xa/6vJZBjujhgckcY
         NbBYt2E3njmocjuZnaY08M1VHVxPQJEUnlOYN3zx+n3OAiJp6pTfNR6fYd8hn78RcIUr
         8oqLdjQD3hRFmP5gqwCpu/N1k7Qcft/LDxjNIoBHOg/OLgKyvq2P0AT5CrchnU2+fcqp
         34CZuqFitVM4rvaRHIHyJe7nPvRpw7Nsb8b/SstNs3DGscazROWSN77PogwtiK659w40
         /n/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qda5ffDTblUU8JGu4nuH5ZD05Te45+ZgViZmocYeACs=;
        b=C6mRIFmKBeOlwzBEYhEGtT+CAVKJpyy922eajrN3zL+MoHoWdnct794CwrNbFgyLe2
         1UYjf+WD2ASJWRN742nh60OWoHDG3c5aZq1R3iY1bcytpi/OIA6zvJwt4wlVdH4A6crc
         U5lbgWp+n4R74TtsKBUicqsElocMT3KJnHFqtJilzh0iFEeyhZt40qViA5UrkybwD8sk
         WONQH0kVe+ZuonqVZq4e5aVoYTg+R7M1xME34uZAX1YTtkGD8+EXZlQVHTbdH9dw+doy
         98L3QRb4SPN2uC6p1H0loxo0yLawlJqH4uPznaQ4B7+JuZZXnWaupytxCCkge5opRJvq
         4pBg==
X-Gm-Message-State: APjAAAX3J9VJort7hHWosQkX2ucuSkB3aAXIQFV7Or9I8gqdJcY8jCfl
        +/x7PWprOtHwwqXYHuhRN4TewTlPmi2YuriJU5GNmw==
X-Google-Smtp-Source: APXvYqz9HunDNQdJFmbx8opch7P0KRYwL8eqX945ccJM9byllYNV8ONZFcYgXsZYUiZxX1DMDKZ3FWfRFjX+qCP3bFo=
X-Received: by 2002:a92:c80b:: with SMTP id v11mr12242511iln.6.1571230554866;
 Wed, 16 Oct 2019 05:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191015162300.22024-1-brgl@bgdev.pl> <20191015162300.22024-2-brgl@bgdev.pl>
 <CAL_JsqKhGr6QDWZFR6cq6MH-0vghb9oSgkCCdi7bhiKmvrkY_w@mail.gmail.com>
In-Reply-To: <CAL_JsqKhGr6QDWZFR6cq6MH-0vghb9oSgkCCdi7bhiKmvrkY_w@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 16 Oct 2019 14:55:43 +0200
Message-ID: <CAMRc=Mdb7T6p7xXWJBS2UXq0E-FD4WRtaP7H-AvRH0s6-MyJ8A@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: mfd: max77650: convert the binding
 document to yaml
To:     Rob Herring <robh+dt@kernel.org>
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

wt., 15 pa=C5=BA 2019 o 23:17 Rob Herring <robh+dt@kernel.org> napisa=C5=82=
(a):
>
> On Tue, Oct 15, 2019 at 11:23 AM Bartosz Golaszewski <brgl@bgdev.pl> wrot=
e:
> >
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Convert the binding document for MAX77650 core MFD module to YAML.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  .../devicetree/bindings/mfd/max77650.txt      | 47 +----------
> >  .../devicetree/bindings/mfd/max77650.yaml     | 83 +++++++++++++++++++
> >  2 files changed, 84 insertions(+), 46 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/max77650.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/max77650.txt b/Docum=
entation/devicetree/bindings/mfd/max77650.txt
> > index b529d8d19335..080871686b3b 100644
> > --- a/Documentation/devicetree/bindings/mfd/max77650.txt
> > +++ b/Documentation/devicetree/bindings/mfd/max77650.txt
> > @@ -1,46 +1 @@
> > -MAX77650 ultra low-power PMIC from Maxim Integrated.
> > -
> > -Required properties:
> > --------------------
> > -- compatible:          Must be "maxim,max77650"
> > -- reg:                 I2C device address.
> > -- interrupts:          The interrupt on the parent the controller is
> > -                       connected to.
> > -- interrupt-controller: Marks the device node as an interrupt controll=
er.
> > -- #interrupt-cells:    Must be <2>.
> > -
> > -- gpio-controller:     Marks the device node as a gpio controller.
> > -- #gpio-cells:         Must be <2>. The first cell is the pin number a=
nd
> > -                       the second cell is used to specify the gpio act=
ive
> > -                       state.
> > -
> > -Optional properties:
> > ---------------------
> > -gpio-line-names:       Single string containing the name of the GPIO l=
ine.
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
> > -       pmic@48 {
> > -               compatible =3D "maxim,max77650";
> > -               reg =3D <0x48>;
> > -
> > -               interrupt-controller;
> > -               interrupt-parent =3D <&gpio2>;
> > -               #interrupt-cells =3D <2>;
> > -               interrupts =3D <3 IRQ_TYPE_LEVEL_LOW>;
> > -
> > -               gpio-controller;
> > -               #gpio-cells =3D <2>;
> > -               gpio-line-names =3D "max77650-charger";
> > -       };
> > +This file has been moved to max77650.yaml.
> > diff --git a/Documentation/devicetree/bindings/mfd/max77650.yaml b/Docu=
mentation/devicetree/bindings/mfd/max77650.yaml
> > new file mode 100644
> > index 000000000000..5186ad287ec7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/max77650.yaml
> > @@ -0,0 +1,83 @@
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
> > +    description:
> > +      The interrupt on the parent the controller is connected to.
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
> > +    $ref: '/schemas/types.yaml#/definitions/string-array'
> > +    maxItems: 1
> > +    description:
> > +      Single string containing the name of the GPIO line.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - interrupt-controller
> > +  - "#interrupt-cells"
> > +  - gpio-controller
> > +  - "#gpio-cells"
> > +
> > +examples:
> > +  - |
> > +    pmic@48 {
> > +        compatible =3D "maxim,max77650";
> > +        reg =3D <0x48>;
> > +
> > +        interrupt-controller;
> > +        interrupt-parent =3D <&gpio2>;
> > +        #interrupt-cells =3D <2>;
> > +        interrupts =3D <3 IRQ_TYPE_LEVEL_LOW>;
>
> Examples are built now. Run 'make dt_binding_check' on bindings before
> sending them:
>
> Error: Documentation/devicetree/bindings/mfd/max77650.example.dts:24.29-3=
0
> syntax error
> FATAL ERROR: Unable to parse input tree
> scripts/Makefile.lib:321: recipe for target
> 'Documentation/devicetree/bindings/mfd/max77650.example.dt.yaml'
> failed
> make[1]: *** [Documentation/devicetree/bindings/mfd/max77650.example.dt.y=
aml]
> Error 1
>
> You need to include any includes that you use.
>
> Rob

Hi Rob,

thanks for the review.

I'm on v5.4-rc3 and when running dt_binding_check, the error I'm
getting is this:

# make dt_binding_check
DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/mfd/max77650.yaml
  SCHEMA  Documentation/devicetree/bindings/processed-schema.yaml
  CHKDT   Documentation/devicetree/bindings/mfd/max77650.yaml
make[1]: *** No rule to make target
'Documentation/devicetree/bindings/mfd/max77650.example.dt.yaml',
needed by '__build'.  Stop.
make: *** [Makefile:1263: dt_binding_check] Error 2

Is this caused by the same issue or am I missing something?

Bartosz
