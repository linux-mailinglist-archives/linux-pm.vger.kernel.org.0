Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6404C2232C1
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jul 2020 07:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgGQFHP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jul 2020 01:07:15 -0400
Received: from condef-05.nifty.com ([202.248.20.70]:27280 "EHLO
        condef-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgGQFHP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jul 2020 01:07:15 -0400
X-Greylist: delayed 374 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Jul 2020 01:07:13 EDT
Received: from conssluserg-05.nifty.com ([10.126.8.84])by condef-05.nifty.com with ESMTP id 06H4sjue024010
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2020 13:54:45 +0900
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 06H4sIHU031108;
        Fri, 17 Jul 2020 13:54:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 06H4sIHU031108
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1594961659;
        bh=sviaHrnMJZujQ/kfSzVdyLTKRQoxe3KftF0ksGJHZt0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sEdbXhZ4rXqBlMoeE+YoAkoj9rNKhW56osfU1/fkgOUzj40HDe2oCN3I4FdzwX7nX
         vSY9+Ycd29xngkdcrgYXCShqg725WYwrGtSmrCUXpp0PxHYK4olic6aVP2OFnHVl5/
         i5mGFfVxUPINVktnU9CyirkF7NPxyGDwFxPyHcMHOeoIeRKt0UhixohbkcawRh5Ulb
         HNKfo2bXbu3yYHNU8C2oLZ8fkDRQ11aOfhrt0oSN5sRpFQt+TJ+oOBJIy/fZo0qvSI
         4H8fCVlvH5WooExGNixwia9phCIsCYcsQkpf/pfd15zm0z50Z99RUckEWlj8jtpUUV
         stX4e8osGOpkg==
X-Nifty-SrcIP: [209.85.222.50]
Received: by mail-ua1-f50.google.com with SMTP id j21so2492814ual.11;
        Thu, 16 Jul 2020 21:54:18 -0700 (PDT)
X-Gm-Message-State: AOAM531CSrm2RwmUXPJJrtNVfPFuSJQChNowzuUR199h+HVcceifc0Z8
        05DrPF+HAE3DZG7BiQYi1c8xmy/7l+EAH0wWFuA=
X-Google-Smtp-Source: ABdhPJy8QAUyiGsYNoe7J//N9aC1WKkuYpuvH9y8BqfVTTPpOtmEC3WdCNovEUTiKXjxWrl0eMOA6w9tffFl3RYrSX8=
X-Received: by 2002:ab0:71d3:: with SMTP id n19mr6086967uao.25.1594961657690;
 Thu, 16 Jul 2020 21:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200707102338.989660-1-yamada.masahiro@socionext.com> <20200716230451.GA3041278@bogus>
In-Reply-To: <20200716230451.GA3041278@bogus>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 17 Jul 2020 13:53:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQN04i14VwrWspTJ7+Y87rgsopv88Dyv_8+4Hk8Kx0Fdw@mail.gmail.com>
Message-ID: <CAK7LNAQN04i14VwrWspTJ7+Y87rgsopv88Dyv_8+4Hk8Kx0Fdw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: uniphier-thermal: add minItems to socionext,tmod-calibration
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 17, 2020 at 8:09 AM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Jul 07, 2020 at 07:23:38PM +0900, Masahiro Yamada wrote:
> > As the description says, this property contains a pair of calibration
> > values. The number of items must be exactly 2.
> >
> > Add minItems to check a too short property.
> >
> > While I was here, I also added this property to the example because
> > this is the case in the real DT file,
> > arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> >
> > Also, fix the interrupt type (edge -> level) to align with the
> > real DT.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  .../bindings/thermal/socionext,uniphier-thermal.yaml          | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml b/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
> > index 553c9dcdaeeb..57ffd0c4c474 100644
> > --- a/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
> > +++ b/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
> > @@ -29,6 +29,7 @@ properties:
> >
> >    socionext,tmod-calibration:
> >      $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    minItems: 2
>
> The intent was if minItems is not defined, then the default is the same
> as maxItems. This is not the default for json-schema, so the tooling is
> supposed to add it.


This implication is unclear.

maxItems should literally only define the max, and
we should stick to json-schema as much as possible, IMHO.




It would be nice if json-schema had something like:

numItems: 2

as a shorthand for

minItems: 2
maxItems: 2


Masahiro Yamada




> But looking at processed-schema.yaml, it doesn't
> seem to be happening for one case here. I'm working on a fix in the
> tools.
>
> Rob



--
Best Regards
Masahiro Yamada
