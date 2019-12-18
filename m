Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A29BD1256A6
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 23:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfLRW1A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 17:27:00 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:37473 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfLRW07 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 17:26:59 -0500
Received: by mail-qv1-f67.google.com with SMTP id f16so1427202qvi.4;
        Wed, 18 Dec 2019 14:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qbWs72DR5XCjtRMaVF/M12LG91Dcbzm+NrYCmOJf9Lc=;
        b=OZHoOkf1lqlbsaOVytx/DPVbIJ4Y4RNrRnNOBsWJ6dcfMbMlcZ7n+0XfDcT+K3t08T
         zC615ySso5IGKCAfkh6MdB/2310SS8ETuKJd7E7NT13g8NCxJEyii7IFaoRBAZQzfxqD
         8MZxvCzVsglZniBhYzQR319BsQog2IXIP5RTmVzimyKm7jErJtVG1XkB83IBAnaTtNFQ
         dknJSx7p9lLTNk+V4NDLNsGr0naOcOKgXH169MW8aqr6xJ9a0Fenvzx72MQ2mWsrAiTU
         uT6gbG0gQruuORDjZjY+HgwvgD5mZh4HoQIx3IMG1Qk5r2QqA8dZnCcLC5IvWzGAlHWd
         k/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qbWs72DR5XCjtRMaVF/M12LG91Dcbzm+NrYCmOJf9Lc=;
        b=Dqp6+pFNpU/F+Lbi44GZYlfcijjQ5wYAAscckmzhGxtm5Pfw1gBgFeWPvXPBzS6i6z
         39UHzKrkodtO9nwjYQmR+X04R20g+u7PiwswadoBw3iq4mT0al+U/BgBXpd+65QfuzEq
         WFJcgXvp/HSyScNR3YDFTaHP6Q/B6Kv87xU+GXqQcAZbxj2l3Nv+RrqgiBVfGnYkboyY
         dsazSjsddhqK0D2VHGkowWyoCizlLjzOVR7DFghjUPA/Ed57a6BzSyzpCjh59lg0tZK2
         ve5Wqroo7mi0zCBLebQw6Ghv15gbirgXRrsQSdtv6DEo5w+NwdsGYcdLQBZaMeQmxLi+
         7ozQ==
X-Gm-Message-State: APjAAAX5+eG38FwtubZoGxsqHawEE5DDMpX/HiWRgzyleus/pyy0NyBo
        uo2bAyFk84LJ0smwKMB7rynlVAWCyPyoPcd1mGc=
X-Google-Smtp-Source: APXvYqxMv0f/TTmCyeAV6J2z1Xn737Nyu97jSxwUX5CQGXnesqQ/ZGUrsJGHlsgM+an3FHECx+EY/snEBfIMKOPK8i4=
X-Received: by 2002:ad4:450a:: with SMTP id k10mr4512847qvu.136.1576708017893;
 Wed, 18 Dec 2019 14:26:57 -0800 (PST)
MIME-Version: 1.0
References: <20191218042121.1471954-1-anarsoul@gmail.com> <20191218042121.1471954-3-anarsoul@gmail.com>
 <20191218220037.4g6pzdvrhroaj4qu@gilmour.lan>
In-Reply-To: <20191218220037.4g6pzdvrhroaj4qu@gilmour.lan>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Wed, 18 Dec 2019 14:27:00 -0800
Message-ID: <CA+E=qVdfV5LKBEar8eT286+ADrpygEkbe5OX1GVRw+khatrJhA@mail.gmail.com>
Subject: Re: [PATCH v7 2/7] dt-bindings: thermal: add YAML schema for
 sun8i-thermal driver bindings
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
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

On Wed, Dec 18, 2019 at 2:00 PM Maxime Ripard <mripard@kernel.org> wrote:
>
> Hi,
>
> On Tue, Dec 17, 2019 at 08:21:16PM -0800, Vasily Khoruzhick wrote:
> > From: Yangtao Li <tiny.windzz@gmail.com>
> >
> > sun8i-thermal driver supports thermal sensor in wide range of Allwinner
> > SoCs. Add YAML schema for its bindings.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > ---
> >  .../thermal/allwinner,sun8i-a83t-ths.yaml     | 146 ++++++++++++++++++
> >  1 file changed, 146 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> > new file mode 100644
> > index 000000000000..8768c2450633
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> > @@ -0,0 +1,146 @@
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
> > +    enum:
> > +      - allwinner,sun8i-a83t-ths
> > +      - allwinner,sun8i-h3-ths
> > +      - allwinner,sun8i-r40-ths
> > +      - allwinner,sun50i-a64-ths
> > +      - allwinner,sun50i-h5-ths
> > +      - allwinner,sun50i-h6-ths
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
> > +  nvmem-cells:
> > +    maxItems: 1
> > +    description: Calibration data for thermal sensors
> > +
> > +  nvmem-cell-names:
> > +    const: calibration
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: allwinner,sun50i-h6-ths
> > +
> > +    then:
> > +      properties:
> > +        clocks:
> > +          minItems: 1
> > +          maxItems: 1
>
> When minItems and maxItems are equal, you can only set one, the other
> will be filled automatically.

Is it documented anywhere? I have a feeling like I'm shooting in the
dark. So far I've read Documentation/devicetree/writing-schema.rst,
Documentation/devicetree/bindings/example-schema.yaml and few other
schemas for inspiration but yet I don't have solid understanding how
it's supposed to be written. Examples are pretty scarce and figuring
out why certain construction doesn't work is pretty tricky.

> > +
> > +        clock-names:
> > +          minItems: 1
> > +          maxItems: 1
> > +          items:
> > +            - const: bus
>
> And this can even be just
>
> clock-names:
>   const: bus

OK

> > +
> > +    else:
> > +      properties:
> > +        clocks:
> > +          minItems: 1
> > +          maxItems: 2
> > +
> > +        clock-names:
> > +          minItems: 1
> > +          maxItems: 2
> > +          items:
> > +            - const: bus
> > +            - const: mod
>
> I'm not sure why you need the minItems set to 1 here though?
>
> it's always 2 for the !H6 case, right?
>
> if so, then we should even do something like:
>
> properties:
>   ...
>
>   # This is needed because we will need to check both the H6 and !H6
>   # case, and it must validate. So we make sure we match against the
>   # union of both cases.
>   clocks:
>     minItems: 1
>     maxItems: 2
>     items:
>       - description: Bus Clock
>       - description: Module Clock
>
>   # Same story here
>   clock-names:
>     minItems: 1
>     maxItems: 2
>     items:
>       - const: bus
>       - const: mod
>
> allOf:
>   - if:
>     properties:
>       compatible:
>         contains:
>           const: allwinner,sun50i-h6-ths
>
>     # Here we validate in the H6 case we only have one clock
>     then:
>       properties:
>         clocks:
>           maxItems: 1
>
>         clock-names:
>           maxItems: 1
>
>     # and here that in the other case we have two clocks, the names
>     # being validated by the schema above
>     else:
>       properties:
>         clocks:
>           maxItems: 2
>
>         clock-names:
>           maxItems: 2
>
> # And now we can set this since all our properties will have been
> # expressed in the upper level schema
> additionalProperties: false

OK

> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: allwinner,sun8i-h3-ths
> > +
> > +    then:
> > +      properties:
> > +        "#thermal-sensor-cells":
> > +          const: 0
> > +
> > +    else:
> > +      properties:
> > +        "#thermal-sensor-cells":
> > +          const: 1
>
> Same thing here, you should have an enum accepting both values in the
> upper schema, the condition here only making further checks. Also, in
> the case where #thermal-sensor-cells is one, then you need to document
> what that argument is.

OK

>
> Thanks!
> Maxime
