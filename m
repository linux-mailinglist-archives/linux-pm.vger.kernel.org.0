Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF61224338
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jul 2020 20:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgGQSgN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jul 2020 14:36:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728022AbgGQSgN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 17 Jul 2020 14:36:13 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38FFD21702;
        Fri, 17 Jul 2020 18:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595010972;
        bh=6IhYIKmVZDeZrypbI87Kz8pgaQhaQha5rJV8Ik5J7bk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s6sCGYdNX1R9qYXHHidspLXuFmtNrCsbL2kIbUlxAtc26Ua7C0ChuGqSMrMxcE/Q+
         6R3kR+qo1eQ0iYYDZl4fMNgTUOl7lQplKoP3nbgBhX//diF+tyyahGvPnveim25CdD
         lam63/GQ/3vp0/VXdRFp6dtfix15TcFPGvmcIEkQ=
Received: by mail-ot1-f54.google.com with SMTP id 5so7518586oty.11;
        Fri, 17 Jul 2020 11:36:12 -0700 (PDT)
X-Gm-Message-State: AOAM532ccMUB4I4bDaCcANMdFqCID3aqLE4EdwqVDSHuIUfU19qaeaMx
        wOI+Ng6jQ9/cneSIIK6OwO6loVCxdhtgSQPM6g==
X-Google-Smtp-Source: ABdhPJwvWVISrMjnm+UoMBRoocoox6vjA7uZZ0i4pJ9VBySQKqf+ek0xvhn+opfsWguYonw/q0Q7Q/bIE/Tx5LV1iO8=
X-Received: by 2002:a05:6830:3104:: with SMTP id b4mr10161318ots.192.1595010971464;
 Fri, 17 Jul 2020 11:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200707102338.989660-1-yamada.masahiro@socionext.com>
 <20200716230451.GA3041278@bogus> <CAK7LNAQN04i14VwrWspTJ7+Y87rgsopv88Dyv_8+4Hk8Kx0Fdw@mail.gmail.com>
In-Reply-To: <CAK7LNAQN04i14VwrWspTJ7+Y87rgsopv88Dyv_8+4Hk8Kx0Fdw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 17 Jul 2020 12:36:00 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKahftcjgtMP9H4NE2df1LxaV+31M8KrmBWCVy05P0hHA@mail.gmail.com>
Message-ID: <CAL_JsqKahftcjgtMP9H4NE2df1LxaV+31M8KrmBWCVy05P0hHA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: uniphier-thermal: add minItems to socionext,tmod-calibration
To:     Masahiro Yamada <masahiroy@kernel.org>
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

On Thu, Jul 16, 2020 at 10:54 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Fri, Jul 17, 2020 at 8:09 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, Jul 07, 2020 at 07:23:38PM +0900, Masahiro Yamada wrote:
> > > As the description says, this property contains a pair of calibration
> > > values. The number of items must be exactly 2.
> > >
> > > Add minItems to check a too short property.
> > >
> > > While I was here, I also added this property to the example because
> > > this is the case in the real DT file,
> > > arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> > >
> > > Also, fix the interrupt type (edge -> level) to align with the
> > > real DT.
> > >
> > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > ---
> > >
> > >  .../bindings/thermal/socionext,uniphier-thermal.yaml          | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml b/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
> > > index 553c9dcdaeeb..57ffd0c4c474 100644
> > > --- a/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
> > > +++ b/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
> > > @@ -29,6 +29,7 @@ properties:
> > >
> > >    socionext,tmod-calibration:
> > >      $ref: /schemas/types.yaml#/definitions/uint32-array
> > > +    minItems: 2
> >
> > The intent was if minItems is not defined, then the default is the same
> > as maxItems. This is not the default for json-schema, so the tooling is
> > supposed to add it.
>
>
> This implication is unclear.
>
> maxItems should literally only define the max, and
> we should stick to json-schema as much as possible, IMHO.

Yes, but we already deviate a bit as the default json-schema behavior
is a bit different than DT defaults. For example, with just:

items:
  - const: a
  - const: b
  - const: c

All of these pass validation:

[]
[ a ]
[ a, b, c, 1, 2, true ]

when we really only want [ a, b, c ] to pass (by default). So we add
minItems, maxItems, and additionalItems if not specified.

> It would be nice if json-schema had something like:
>
> numItems: 2
>
> as a shorthand for
>
> minItems: 2
> maxItems: 2

Yes, I've been thinking the same thing. It wouldn't be unprecedented
as they added 'const' to shorten 'enum: [ one_entry ]'. We can add our
own keywords too, but I try to avoid that so far. The only ones we
have are internal to dtschema (typeSize and phandle).

Rob
