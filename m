Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCEE10B75F
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 21:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfK0UYU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 15:24:20 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43695 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfK0UYU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Nov 2019 15:24:20 -0500
Received: by mail-ot1-f67.google.com with SMTP id l14so20227061oti.10;
        Wed, 27 Nov 2019 12:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MixxgPNvg3pUnry2JzNoXYx2kY3tKkdeMgXAkzkyNYs=;
        b=Q8xCo+ZbqsfjOgoXWTnHWNvKIjvPEEcwP+yXEBzmj2ekJJlDCBa94VFtCAGp2f+bzq
         elQN5VZ0Q6MrI3M85kFAM7EcRpIT6dOyhTlaodtLBSugf0KJru8davD/6imekZuJmkNx
         PKcyk5pw+9Yw45suj7kCI5epoouGLLTi0kYP0fey25mulV3BNtcIR6WKxFwJiFpSvh39
         r+fZZtaHTh8Vqg56FBTN6g91jdzGaHCpToEq7ANGcvTUaONmosJTjEnzZ0amMb7T/Dfh
         2sMqDroQQ4rqoAnUrp4pRzTkVcUnPo3MZ6ZYkFQ/jv9nMvj+GO/NOi53qfubSe832egJ
         s8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MixxgPNvg3pUnry2JzNoXYx2kY3tKkdeMgXAkzkyNYs=;
        b=a0VItJa3X0pfxxUXygSTuVIzLf+Jj1Ay9e7FNkFGehThv21Ac1QcAL0TgBFNrMKmav
         76BK+Ug/xqscFobx0z5J4N8o0c1Qp64bMbAFjtfbCUBsbGSO47Nsg/f/xNGPRyxgpiVC
         LdKTDGXfnB8+OiMsUtO2OQkSKNtSOOklxfWoE5MCVCH2v6Ju2EbZRTVqPWJHSo0qhhoV
         9ibM5I5NzvPvQ8stHX2KVQ5S336wB5gi3kXR1dBQcXOOWKTluRLcTtA/uY8kA5b3cB3A
         IUZChD2dcYWYyJxnxE9FFuJPQwYELakbrdDle8kTr5JQ1aMHMtYhrln5MdxemGLT8SJX
         U25g==
X-Gm-Message-State: APjAAAWFvwoHQdx1EOs+H00bN/xGUtlX3cTzNYxPbu3gyAI6BxPN4N/R
        Cy9gWWNYkmuTbICHGNGpWpdzpMH8htGFV8DmPpw=
X-Google-Smtp-Source: APXvYqzQ//Ez72MjlZ6tnpozQgzvE/hhO0Vn1XVq9GxyZPcPEL2qouYxRSGFV+mE8Gods9QDh7e/ODo46N4kJh7VLCE=
X-Received: by 2002:a9d:6acf:: with SMTP id m15mr5155723otq.312.1574886258682;
 Wed, 27 Nov 2019 12:24:18 -0800 (PST)
MIME-Version: 1.0
References: <20191127052935.1719897-1-anarsoul@gmail.com> <20191127052935.1719897-3-anarsoul@gmail.com>
 <20191127174434.wousbqosmm5vxcsu@gilmour.lan>
In-Reply-To: <20191127174434.wousbqosmm5vxcsu@gilmour.lan>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Wed, 27 Nov 2019 12:23:53 -0800
Message-ID: <CA+E=qVe22T1uhUo6iq9a82Y9bC014CZSkAtSJJNX4qsn6dJL9w@mail.gmail.com>
Subject: Re: [PATCH v6 2/7] dt-bindings: thermal: add YAML schema for
 sun8i-thermal driver bindings
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 27, 2019 at 9:44 AM Maxime Ripard <mripard@kernel.org> wrote:
>
> Hi,
>
> On Tue, Nov 26, 2019 at 09:29:30PM -0800, Vasily Khoruzhick wrote:
> > From: Yangtao Li <tiny.windzz@gmail.com>
> >
> > sun8i-thermal driver supports thermal sensor in wide range of Allwinner
> > SoCs. Add YAML schema for its bindings.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > ---
> >  .../thermal/allwinner,sun8i-a83t-ths.yaml     | 103 ++++++++++++++++++
> >  1 file changed, 103 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> > new file mode 100644
> > index 000000000000..e622f0a4be90
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> > @@ -0,0 +1,103 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/thermal/allwinner,sun8i-a83t-ths.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Allwinner SUN8I Thermal Controller Device Tree Bindings
> > +
> > +maintainers:
> > +  - Yangtao Li <tiny.windzz@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - const: allwinner,sun8i-a83t-ths
> > +      - const: allwinner,sun8i-h3-ths
> > +      - const: allwinner,sun8i-r40-ths
> > +      - const: allwinner,sun50i-a64-ths
> > +      - const: allwinner,sun50i-h5-ths
> > +      - const: allwinner,sun50i-h6-ths
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  clock-names:
> > +    anyOf:
> > +      - items:
> > +        - const: bus
> > +        - const: mod
> > +      - items:
> > +        - const: bus
>
> This can be:
>
> clock-names:
>   minItems: 1
>   maxItems: 2
>   items:
>     - const: bus
>     - const: mod
>
> And the length should be checked based on the compatible value, with
> something like
>
> if:
>   properties:
>     compatible:
>       contains:
>         const: allwinner,sun50i-h6-ths
>
> then:
>   properties:
>     clocks:
>       maxItems: 1
>
>     clock-names:
>       maxItems: 1
>
> else:
>   properties:
>     clocks:
>       maxItems: 2
>
>     clock-names:
>       maxItems: 2

OK, will do

> > +
> > +  '#thermal-sensor-cells':
> > +    enum: [ 0, 1 ]
> > +    description: |
> > +      Definition depends on soc version:
> > +
> > +      For "allwinner,sun8i-h3-ths",
> > +      value must be 0.
> > +      For all other compatibles
> > +      value must be 1.
>
> This should be checked using an if as well.

Will do.

> > +
> > +  nvmem-cells:
> > +    maxItems: 1
> > +    items:
> > +      - description: Calibration data for thermal sensors
>
> You can drop the items and just move the description up one level,
> under nvmem-cells

Will do.

> > +
> > +  nvmem-cell-names:
> > +    items:
> > +      - const: calibration
>
> Ditto for the const

Sorry, I don't quite get it. What exactly do you want me to do with
this one? nvmem-cell-names must be "calibration"

> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - '#thermal-sensor-cells'
>
> Whether clocks, clock-names and resets are thereshould be check using
> an if statement as well.

Will do

> > +
> > +examples:
> > +  - |
> > +    ths_a83t: ths@1f04000 {
>
> You don't need the label at all, and the node name should be
> temperature-sensor according to the DT spec, not ths. This applies to
> all you examples.

OK

> > +         compatible = "allwinner,sun8i-a83t-ths";
> > +         reg = <0x01f04000 0x100>;
> > +         interrupts = <0 31 0>;
> > +         nvmem-cells = <&ths_calibration>;
> > +         nvmem-cell-names = "calibration";
> > +         #thermal-sensor-cells = <1>;
> > +    };
>
> New line.

OK

>
> Thanks!
> Maxime
