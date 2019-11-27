Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B820110B629
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 19:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfK0SxW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 13:53:22 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37069 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfK0SxW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Nov 2019 13:53:22 -0500
Received: by mail-oi1-f193.google.com with SMTP id 128so12983171oih.4;
        Wed, 27 Nov 2019 10:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=B7OdfyOfsvItvmaN0rYdNSg9G6SH0O4NS8qdePNGNsM=;
        b=N8vdY+vlJAQhjge4fCNhfz2W4+03pESQoSCgv88q2OlHXMyNb5KgDwo52mHKSK/4D5
         6+Ro8/dh5tdnzYBZTchIotY9Bliv0l+waCLXOhRzpqsPOwOfJlqMq6KAiDGTIHWIdxy4
         eNFZ4R6HMfsm//Y86ousrjQwK6cIajqJTjbWJSLMEreAY3VyYzy+6EX76/JpzO0N9mUa
         Ab3bg3doy/GnWBRHtoUin/0E0lzjBm/Q4jbyMuBVqasrsTA2zfyJm4+70JjmIu/m5PYe
         wBg3FPSV5rUVFe08TNISjx6zOXlxDNo6VChINu5JHQVzCx+Dskm3IBMiG0DbNWuTJM1S
         jTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=B7OdfyOfsvItvmaN0rYdNSg9G6SH0O4NS8qdePNGNsM=;
        b=mahTAn0wv+Ww4fhMVm2TOavbv/42UXdAIEdwXyRjiVdOpIVxVtYdwquBgG0g5uVfr1
         sRh7fne7CgzlmFgrfh2ANVhvbnYIz/5tQzKr7XVPtngGrnjC08x48Ct0Ok0x6Cny0sMw
         pJWTVY6W5nVR0DlBQE1MgIQ0DZc2VsyXVLDGTNzDj7YlawQ44XYHWljmoOnPElWFaBZc
         6GrxPQX/z7xeLa4CYuDs343q+lMu4oiUKrR1TLXWau2r8AgJ4S0nZONWPbgRXIfZy8c5
         Jn8CnOnN2QKF2GgvZlApKlJoXW84aLaHmF8wSBk1qgO9ScPnS4EgDT/egkYnOoetZuih
         6MtA==
X-Gm-Message-State: APjAAAUOZ8jeOKNrzMb9iaAY+CpAHdMqzCdRQwoDQG7U9fdPuuadmH3q
        tUdN3ohUI2sYDftb1E5nMZ1u7pziri7iNsk1/P89ZIJB
X-Google-Smtp-Source: APXvYqx+wTrJMMEAadlR2TvpMsiJs6MouGSI7S70yGV387JqMw+U7ZdD2Kjv46qQTOWW6lu42qDvJ/n1yjP4CpNThoM=
X-Received: by 2002:aca:5883:: with SMTP id m125mr5055567oib.145.1574880800897;
 Wed, 27 Nov 2019 10:53:20 -0800 (PST)
MIME-Version: 1.0
References: <20191127052935.1719897-1-anarsoul@gmail.com> <20191127052935.1719897-3-anarsoul@gmail.com>
 <20191127174434.wousbqosmm5vxcsu@gilmour.lan> <20191127180743.ww5npenlg2urxtjn@core.my.home>
In-Reply-To: <20191127180743.ww5npenlg2urxtjn@core.my.home>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Wed, 27 Nov 2019 10:52:55 -0800
Message-ID: <CA+E=qVeXhutfeJ6m8fuokzy8aRmNqWWyRGn0Lbtv_9hNCXzSeg@mail.gmail.com>
Subject: Re: [PATCH v6 2/7] dt-bindings: thermal: add YAML schema for
 sun8i-thermal driver bindings
To:     Maxime Ripard <mripard@kernel.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
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
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 27, 2019 at 10:07 AM Ond=C5=99ej Jirman <megous@megous.com> wro=
te:
>
> Hi,
>
> On Wed, Nov 27, 2019 at 06:44:34PM +0100, Maxime Ripard wrote:
> > Hi,
> >
> > On Tue, Nov 26, 2019 at 09:29:30PM -0800, Vasily Khoruzhick wrote:
> > > From: Yangtao Li <tiny.windzz@gmail.com>
> > >
> > > sun8i-thermal driver supports thermal sensor in wide range of Allwinn=
er
> > > SoCs. Add YAML schema for its bindings.
> > >
> > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > > ---
> > >  .../thermal/allwinner,sun8i-a83t-ths.yaml     | 103 ++++++++++++++++=
++
> > >  1 file changed, 103 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/thermal/allwinn=
er,sun8i-a83t-ths.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8=
i-a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i=
-a83t-ths.yaml
> > > new file mode 100644
> > > index 000000000000..e622f0a4be90
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-=
ths.yaml
> > > @@ -0,0 +1,103 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/thermal/allwinner,sun8i-a83t-ths.=
yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Allwinner SUN8I Thermal Controller Device Tree Bindings
> > > +
> > > +maintainers:
> > > +  - Yangtao Li <tiny.windzz@gmail.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - const: allwinner,sun8i-a83t-ths
> > > +      - const: allwinner,sun8i-h3-ths
> > > +      - const: allwinner,sun8i-r40-ths
> > > +      - const: allwinner,sun50i-a64-ths
> > > +      - const: allwinner,sun50i-h5-ths
> > > +      - const: allwinner,sun50i-h6-ths
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  resets:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    minItems: 1
> > > +    maxItems: 2
> > > +
> > > +  clock-names:
> > > +    anyOf:
> > > +      - items:
> > > +        - const: bus
> > > +        - const: mod
> > > +      - items:
> > > +        - const: bus
> >
> > This can be:
> >
> > clock-names:
> >   minItems: 1
>
> Additionally, minItems should be 0, since A83T doesn't have bus clock/res=
et. And
> then there should be a special case for A83T too with min/maxItems =3D 0 =
for both
> resets and clocks.

That's why I removed clocks, clock-names and resets from required
properties. If they're present min/maxItems should be 1 and 2
accordingly.

> regards,
>         o.
>
> >   maxItems: 2
> >   items:
> >     - const: bus
> >     - const: mod
> >
> > And the length should be checked based on the compatible value, with
> > something like
> >
> > if:
> >   properties:
> >     compatible:
> >       contains:
> >         const: allwinner,sun50i-h6-ths
> >
> > then:
> >   properties:
> >     clocks:
> >       maxItems: 1
> >
> >     clock-names:
> >       maxItems: 1
> >
> > else:
> >   properties:
> >     clocks:
> >       maxItems: 2
> >
> >     clock-names:
> >       maxItems: 2
> >
> > > +
> > > +  '#thermal-sensor-cells':
> > > +    enum: [ 0, 1 ]
> > > +    description: |
> > > +      Definition depends on soc version:
> > > +
> > > +      For "allwinner,sun8i-h3-ths",
> > > +      value must be 0.
> > > +      For all other compatibles
> > > +      value must be 1.
> >
> > This should be checked using an if as well.
> >
> > > +
> > > +  nvmem-cells:
> > > +    maxItems: 1
> > > +    items:
> > > +      - description: Calibration data for thermal sensors
> >
> > You can drop the items and just move the description up one level,
> > under nvmem-cells
> >
> > > +
> > > +  nvmem-cell-names:
> > > +    items:
> > > +      - const: calibration
> >
> > Ditto for the const
> >
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - interrupts
> > > +  - '#thermal-sensor-cells'
> >
> > Whether clocks, clock-names and resets are thereshould be check using
> > an if statement as well.
> >
> > > +
> > > +examples:
> > > +  - |
> > > +    ths_a83t: ths@1f04000 {
> >
> > You don't need the label at all, and the node name should be
> > temperature-sensor according to the DT spec, not ths. This applies to
> > all you examples.
> >
> > > +         compatible =3D "allwinner,sun8i-a83t-ths";
> > > +         reg =3D <0x01f04000 0x100>;
> > > +         interrupts =3D <0 31 0>;
> > > +         nvmem-cells =3D <&ths_calibration>;
> > > +         nvmem-cell-names =3D "calibration";
> > > +         #thermal-sensor-cells =3D <1>;
> > > +    };
> >
> > New line.
> >
> > Thanks!
> > Maxime
>
>
