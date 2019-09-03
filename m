Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8575A6491
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2019 11:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfICJA0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Sep 2019 05:00:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbfICJA0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Sep 2019 05:00:26 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C43E21883;
        Tue,  3 Sep 2019 09:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567501225;
        bh=mVnvcxp+G9Lg09PKVia7IRCacGhHCMYuQLC/geqOJ/4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qAKAWwZEd/yvtlIIDRkP8+OQaZqVZulzqnHj2cQBPUTH2pf3gFRAOlWqqJERYclcg
         KK9JAzB4eSsgZLU1CVX4TQcLi+BEsciUkTj0Nkw3F4kdhXXFv8LYIC7I96SykPW7p0
         DCJMjCQbD7+46O1I3nONz923kX6yissO0EN+FPao=
Received: by mail-qt1-f175.google.com with SMTP id k10so8579311qth.2;
        Tue, 03 Sep 2019 02:00:25 -0700 (PDT)
X-Gm-Message-State: APjAAAXOMkvMSvR1xDEiwo7tGUJNJhZQLVBOE0hKuq1+5rlsHoxCcn2V
        ers9BrEH4VHqnUYD2tgGq5IM046o/hW8I1WNUw==
X-Google-Smtp-Source: APXvYqxINc1z5+kUGayW8tQqoY1hH7ZohnenT2DMo0cxL15BrooAJ51z08nZ2stlFiJ8pZ/eaBW9rKX+cE1M9Hly+Ug=
X-Received: by 2002:ac8:44c4:: with SMTP id b4mr32496188qto.224.1567501224313;
 Tue, 03 Sep 2019 02:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190902150336.3600-1-krzk@kernel.org> <CAL_JsqK_O+7zQDGxAhAHDW=AkMy+RtyijTXUuRStOgu8CYXe0g@mail.gmail.com>
 <CAJKOXPfO0yBzGFPvF_WwsGGJBZSBGMLsFi2CQ2Eg5RVfyfW3nA@mail.gmail.com>
In-Reply-To: <CAJKOXPfO0yBzGFPvF_WwsGGJBZSBGMLsFi2CQ2Eg5RVfyfW3nA@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 3 Sep 2019 10:00:12 +0100
X-Gmail-Original-Message-ID: <CAL_JsqJUfGBRAv=StPyavQU1DiHnFwUseNCvP6Ce_ZMohJXTXQ@mail.gmail.com>
Message-ID: <CAL_JsqJUfGBRAv=StPyavQU1DiHnFwUseNCvP6Ce_ZMohJXTXQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: power: syscon-reboot: Convert bindings
 to json-schema
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 3, 2019 at 8:47 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Tue, 3 Sep 2019 at 09:14, Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Mon, Sep 2, 2019 at 4:03 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > Convert the Syscon reboot bindings to DT schema format using
> > > json-schema.
> > >
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > ---
> > >  .../bindings/power/reset/syscon-reboot.txt    | 30 --------
> > >  .../bindings/power/reset/syscon-reboot.yaml   | 68 +++++++++++++++++++
> > >  2 files changed, 68 insertions(+), 30 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot.txt
> > >  create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
> >
> > > diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml b/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
> > > new file mode 100644
> > > index 000000000000..a583f3dc8ef4
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
> > > @@ -0,0 +1,68 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/power/reset/syscon-reboot.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Generic SYSCON mapped register reset driver
> > > +
> > > +maintainers:
> > > +  - Sebastian Reichel <sre@kernel.org>
> > > +
> > > +description: |+
> > > +  This is a generic reset driver using syscon to map the reset register.
> > > +  The reset is generally performed with a write to the reset register
> > > +  defined by the register map pointed by syscon reference plus the offset
> > > +  with the value and mask defined in the reboot node.
> > > +  Default will be little endian mode, 32 bit access only.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: syscon-reboot
> > > +
> > > +  mask:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: Update only the register bits defined by the mask (32 bit).
> > > +    maxItems: 1
> >
> > Drop this as that is already defined for uint32.
> >
> > It also doesn't actually work. The $ref has to be under an 'allOf' if
> > you have additional schemas. A quirk of json-schema...
> >
> > > +
> > > +  offset:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: Offset in the register map for the reboot register (in bytes).
> > > +    maxItems: 1
> > > +
> > > +  regmap:
> > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > +    description: Phandle to the register map node.
> > > +    maxItems: 1
> > > +
> > > +  value:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: The reset value written to the reboot register (32 bit access).
> > > +    maxItems: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - regmap
> > > +  - offset
> > > +
> > > +allOf:
> > > +  - if:
> > > +      properties:
> > > +        value:
> > > +          not:
> > > +            type: array
> >
> > I think you could make this a bit more readable with:
> >
> > if:
> >   not:
> >     required:
> >       - value
>
> I do not understand how does it work (value is not mentioned in the
> required fields so why checking of it?)... but it works fine.

What's under required doesn't have to be listed as a property.

> > However, if the tree is free of legacy usage, then you could just drop all this.
>
> One of them - mask or value - has to be provided.

Or both, right?

Actually, a better way to express it is probably this:

oneOf:
  - required: [ value ]
  - required: [ mask ]
  - required: [ value, mask ]

Rob
