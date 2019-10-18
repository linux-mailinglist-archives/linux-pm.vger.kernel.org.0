Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C26E4DCF10
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 21:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443268AbfJRTJA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 15:09:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:59168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2443216AbfJRTI7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 18 Oct 2019 15:08:59 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD7F2222C9;
        Fri, 18 Oct 2019 19:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571425738;
        bh=GmnsYtHJlL/5yxZfKlw6PRpT4uy/4qUReZoxvsBsi1A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Yzkb7O7kToMr9ftoJIsljRgPzqeY2SH+sT26HuU4kIKWFrb7ilYaeEZRB+M/FrexE
         MEZ21PsBxIZ12PSDEx0CTVd+lU+RIc+As8k86sYzqoxW/lMHMMx+o17Yq1/qTabGIG
         MPkvil9K++tYpUbqFk9N8tfSNy7Gz9RCledj00r0=
Received: by mail-qk1-f182.google.com with SMTP id 71so2430896qkl.0;
        Fri, 18 Oct 2019 12:08:57 -0700 (PDT)
X-Gm-Message-State: APjAAAWPTGVIErsQpV9L5ULLQxS7fJPsfviO5YoaqomYYv5JvXN77GKk
        WOZEGGhkQS0+TkwdpFWfXnD+i2N4olAwskpABg==
X-Google-Smtp-Source: APXvYqzvveMwPyNyUPS6FKiuGC/+W7xzJ9dudNA/QUPWCwfDT6mTtkpqAPxNed471TqkRHs19WUG0vAz2nR9XcZAlYU=
X-Received: by 2002:a05:620a:12b4:: with SMTP id x20mr6347242qki.254.1571425736980;
 Fri, 18 Oct 2019 12:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <20191017071234.8719-1-brgl@bgdev.pl> <20191017071234.8719-4-brgl@bgdev.pl>
 <20191017183543.GA28403@bogus> <CAMpxmJUMgqocphdPhS_zCYX3ib_hnwhnhBfQEVaY8hnpi4vxQg@mail.gmail.com>
In-Reply-To: <CAMpxmJUMgqocphdPhS_zCYX3ib_hnwhnhBfQEVaY8hnpi4vxQg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 18 Oct 2019 14:08:45 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKCbFWsozuaUbz5nBYUUT_jUtP03qRQ8Y9eGVs1knf77A@mail.gmail.com>
Message-ID: <CAL_JsqKCbFWsozuaUbz5nBYUUT_jUtP03qRQ8Y9eGVs1knf77A@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] dt-bindings: regulator: max77650: convert the
 binding document to yaml
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

On Fri, Oct 18, 2019 at 1:45 AM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
>
> czw., 17 pa=C5=BA 2019 o 20:35 Rob Herring <robh@kernel.org> napisa=C5=82=
(a):
> >
> > On Thu, Oct 17, 2019 at 09:12:31AM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > Convert the binding document for MAX77650 regulator module to YAML.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > ---
> > >  .../bindings/regulator/max77650-regulator.txt | 41 -----------------=
--
> > >  .../regulator/max77650-regulator.yaml         | 31 ++++++++++++++
> > >  2 files changed, 31 insertions(+), 41 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/regulator/max77=
650-regulator.txt
> > >  create mode 100644 Documentation/devicetree/bindings/regulator/max77=
650-regulator.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/regulator/max77650-reg=
ulator.txt b/Documentation/devicetree/bindings/regulator/max77650-regulator=
.txt
> > > deleted file mode 100644
> > > index f1cbe813c30f..000000000000
> > > --- a/Documentation/devicetree/bindings/regulator/max77650-regulator.=
txt
> > > +++ /dev/null
> > > @@ -1,41 +0,0 @@
> > > -Regulator driver for MAX77650 PMIC from Maxim Integrated.
> > > -
> > > -This module is part of the MAX77650 MFD device. For more details
> > > -see Documentation/devicetree/bindings/mfd/max77650.txt.
> > > -
> > > -The regulator controller is represented as a sub-node of the PMIC no=
de
> > > -on the device tree.
> > > -
> > > -The device has a single LDO regulator and a SIMO buck-boost regulato=
r with
> > > -three independent power rails.
> > > -
> > > -Required properties:
> > > ---------------------
> > > -- compatible:                Must be "maxim,max77650-regulator"
> > > -
> > > -Each rail must be instantiated under the regulators subnode of the t=
op PMIC
> > > -node. Up to four regulators can be defined. For standard regulator p=
roperties
> > > -refer to Documentation/devicetree/bindings/regulator/regulator.txt.
> > > -
> > > -Available regulator compatible strings are: "ldo", "sbb0", "sbb1", "=
sbb2".
> > > -
> > > -Example:
> > > ---------
> > > -
> > > -     regulators {
> > > -             compatible =3D "maxim,max77650-regulator";
> > > -
> > > -             max77650_ldo: regulator@0 {
> > > -                     regulator-compatible =3D "ldo";
> > > -                     regulator-name =3D "max77650-ldo";
> > > -                     regulator-min-microvolt =3D <1350000>;
> > > -                     regulator-max-microvolt =3D <2937500>;
> > > -             };
> > > -
> > > -             max77650_sbb0: regulator@1 {
> > > -                     regulator-compatible =3D "sbb0";
> > > -                     regulator-name =3D "max77650-sbb0";
> > > -                     regulator-min-microvolt =3D <800000>;
> > > -                     regulator-max-microvolt =3D <1587500>;
> > > -             };
> > > -     };
> > > diff --git a/Documentation/devicetree/bindings/regulator/max77650-reg=
ulator.yaml b/Documentation/devicetree/bindings/regulator/max77650-regulato=
r.yaml
> > > new file mode 100644
> > > index 000000000000..a8770742836d
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/regulator/max77650-regulator.=
yaml
> > > @@ -0,0 +1,31 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/regulator/max77650-regulator.yaml=
#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Regulator driver for MAX77650 PMIC from Maxim Integrated.
> > > +
> > > +maintainers:
> > > +  - Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > +
> > > +description: |
> > > +  This module is part of the MAX77650 MFD device. For more details
> > > +  see Documentation/devicetree/bindings/mfd/max77650.txt.
> >
> > .yaml?
> >
>
> Is there any better way of referencing the main document than
> mentioning it in the description?

No.

Rob
