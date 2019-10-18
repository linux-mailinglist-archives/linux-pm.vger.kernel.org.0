Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD611DBDD5
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 08:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393594AbfJRGpO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 02:45:14 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40164 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732469AbfJRGpL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 02:45:11 -0400
Received: by mail-ot1-f65.google.com with SMTP id y39so4066918ota.7
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2019 23:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1lF1MIdaENKkNdKHx3QF8806cfpyw2N47Ri2S6zNu+A=;
        b=fdz+n06HECsJp9I5yC12MLoPyso3cVdDWSygC4Y7XVo2s+raIUe7Kh+aLwemhLMU5k
         i7dVQR2xfPsax9aa+5VJyUvt0/X84pN8bZr2I1IqodPrl3WJd8v/DQvU0Mn7HPDL3F9G
         p2zjMx/ktE9PQCFIGtVBeHWjl+r/xzysY7yUr0+lRii3jz18vN6MqHlkSU45xQ55o05m
         G1FSO9291SHGdzv4XiuXv+oNdb3MCs2XWDCdELcJYSDl+uaG/muocWgujsYLr1TZ5iXU
         5ElzuYwPbcYqYAwmJUKvQibj3nrYv8cN7CxOJQhhzGPFEDhOSpyWjgAwj+3CpwrqQEHf
         a/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1lF1MIdaENKkNdKHx3QF8806cfpyw2N47Ri2S6zNu+A=;
        b=AA093Qgk7E/AN8Tz8rwKt+M7jG6f/mqxzPNxTX6vizF58WeSkorxAA5Ve2X3KpCfM1
         RCJTbpZZsBdWMHGxYA/s//l2HCZ/Ip2kNkCXfJlsXl5oC6yXZkO5E/3LYi8/obohxxx2
         5N+D2lpkr2JpKVWlOThiO+eml0NYzJUFSLDx5zcTNMcHZ0iYBpDi15YVkRWOYAMGByyi
         EIE50fsg/SOj2O/Jhdp77b65HPgqBJhWQf3mBaOKzRG0dIQnvltJ5YDGlHPsZESKYYXX
         8UnbRocWt1JmzVK1Z0DL4lwJdEyI0Ow7KD1oR9Bxa9leIuDUvyTBG+djRqdVyqHXDwMd
         HTaw==
X-Gm-Message-State: APjAAAVEqCP0rRWOZC5AiiFOnLqN4S2DyE5lHXOFJ1upsMJQvIRt9U0q
        VyfPOkqcLT3kp6azTViRx+aPhjDtmRzD3KdZswnzWQ==
X-Google-Smtp-Source: APXvYqxyM+v+SYTdyxQ4dtigF5DDcYtT8ndNrsXVrCyXLrBJJzjjCW0hbJvIcRwuifhyrCsk7IlYvVPciQR043PPUQs=
X-Received: by 2002:a9d:7d09:: with SMTP id v9mr6404595otn.292.1571381108752;
 Thu, 17 Oct 2019 23:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <20191017071234.8719-1-brgl@bgdev.pl> <20191017071234.8719-4-brgl@bgdev.pl>
 <20191017183543.GA28403@bogus>
In-Reply-To: <20191017183543.GA28403@bogus>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 18 Oct 2019 08:44:57 +0200
Message-ID: <CAMpxmJUMgqocphdPhS_zCYX3ib_hnwhnhBfQEVaY8hnpi4vxQg@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] dt-bindings: regulator: max77650: convert the
 binding document to yaml
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

czw., 17 pa=C5=BA 2019 o 20:35 Rob Herring <robh@kernel.org> napisa=C5=82(a=
):
>
> On Thu, Oct 17, 2019 at 09:12:31AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Convert the binding document for MAX77650 regulator module to YAML.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  .../bindings/regulator/max77650-regulator.txt | 41 -------------------
> >  .../regulator/max77650-regulator.yaml         | 31 ++++++++++++++
> >  2 files changed, 31 insertions(+), 41 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/regulator/max7765=
0-regulator.txt
> >  create mode 100644 Documentation/devicetree/bindings/regulator/max7765=
0-regulator.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/regulator/max77650-regul=
ator.txt b/Documentation/devicetree/bindings/regulator/max77650-regulator.t=
xt
> > deleted file mode 100644
> > index f1cbe813c30f..000000000000
> > --- a/Documentation/devicetree/bindings/regulator/max77650-regulator.tx=
t
> > +++ /dev/null
> > @@ -1,41 +0,0 @@
> > -Regulator driver for MAX77650 PMIC from Maxim Integrated.
> > -
> > -This module is part of the MAX77650 MFD device. For more details
> > -see Documentation/devicetree/bindings/mfd/max77650.txt.
> > -
> > -The regulator controller is represented as a sub-node of the PMIC node
> > -on the device tree.
> > -
> > -The device has a single LDO regulator and a SIMO buck-boost regulator =
with
> > -three independent power rails.
> > -
> > -Required properties:
> > ---------------------
> > -- compatible:                Must be "maxim,max77650-regulator"
> > -
> > -Each rail must be instantiated under the regulators subnode of the top=
 PMIC
> > -node. Up to four regulators can be defined. For standard regulator pro=
perties
> > -refer to Documentation/devicetree/bindings/regulator/regulator.txt.
> > -
> > -Available regulator compatible strings are: "ldo", "sbb0", "sbb1", "sb=
b2".
> > -
> > -Example:
> > ---------
> > -
> > -     regulators {
> > -             compatible =3D "maxim,max77650-regulator";
> > -
> > -             max77650_ldo: regulator@0 {
> > -                     regulator-compatible =3D "ldo";
> > -                     regulator-name =3D "max77650-ldo";
> > -                     regulator-min-microvolt =3D <1350000>;
> > -                     regulator-max-microvolt =3D <2937500>;
> > -             };
> > -
> > -             max77650_sbb0: regulator@1 {
> > -                     regulator-compatible =3D "sbb0";
> > -                     regulator-name =3D "max77650-sbb0";
> > -                     regulator-min-microvolt =3D <800000>;
> > -                     regulator-max-microvolt =3D <1587500>;
> > -             };
> > -     };
> > diff --git a/Documentation/devicetree/bindings/regulator/max77650-regul=
ator.yaml b/Documentation/devicetree/bindings/regulator/max77650-regulator.=
yaml
> > new file mode 100644
> > index 000000000000..a8770742836d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/regulator/max77650-regulator.ya=
ml
> > @@ -0,0 +1,31 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/regulator/max77650-regulator.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Regulator driver for MAX77650 PMIC from Maxim Integrated.
> > +
> > +maintainers:
> > +  - Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > +
> > +description: |
> > +  This module is part of the MAX77650 MFD device. For more details
> > +  see Documentation/devicetree/bindings/mfd/max77650.txt.
>
> .yaml?
>

Is there any better way of referencing the main document than
mentioning it in the description?

Bart

> > +
> > +  The regulator controller is represented as a sub-node of the PMIC no=
de
> > +  on the device tree.
> > +
> > +  The device has a single LDO regulator and a SIMO buck-boost regulato=
r with
> > +  three independent power rails.
> > +
> > +properties:
> > +  compatible:
> > +    const: maxim,max77650-regulator
> > +
> > +patternProperties:
> > +  "^regulator@[0-3]$":
> > +    $ref: "regulator.yaml#"
> > +
> > +required:
> > +  - compatible
> > --
> > 2.23.0
> >
