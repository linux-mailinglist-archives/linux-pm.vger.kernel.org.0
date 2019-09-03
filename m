Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB5B5A6300
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2019 09:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfICHrD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Sep 2019 03:47:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbfICHrD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Sep 2019 03:47:03 -0400
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 034AF2053B;
        Tue,  3 Sep 2019 07:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567496822;
        bh=RuEU75Q1POSO0w61+q41p+/7Q/GAHx2CK3Fki186RB4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mk468JDy/2IvHvOcaxJbsYuG99xwARgNgtbjcqBHSQu8ZxKWjTpRUKPZ8+6WzKy2u
         Q5UCQ70neOx98y/LB/vY+qc2WCchR5+SAPzwfTj3sH/YU4RUWfSfr3QWuuYvflnq6R
         l5VC0HgOWIkh8koGlRSR/S4AZQ9q49Pu/8pfSCa4=
Received: by mail-lf1-f45.google.com with SMTP id c12so12084783lfh.5;
        Tue, 03 Sep 2019 00:47:01 -0700 (PDT)
X-Gm-Message-State: APjAAAUHIHnRdDPtMuB9ylzCp8gLwSTGF5hnJniVGoLsq3eN9uk+v/1v
        vxqxD0V9GIvKiPf5zQMpzh4z8dphdClfC6ehqO0=
X-Google-Smtp-Source: APXvYqwWAirMV435z7XIBUx14TCjV1uPxmk+KHbqV+P+MdpQ5RtqlgUoQgdo5mlGH8SMTZRWkobUP09k0obMElzC7EA=
X-Received: by 2002:a19:c649:: with SMTP id w70mr20043799lff.33.1567496820229;
 Tue, 03 Sep 2019 00:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190902150336.3600-1-krzk@kernel.org> <CAL_JsqK_O+7zQDGxAhAHDW=AkMy+RtyijTXUuRStOgu8CYXe0g@mail.gmail.com>
In-Reply-To: <CAL_JsqK_O+7zQDGxAhAHDW=AkMy+RtyijTXUuRStOgu8CYXe0g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 3 Sep 2019 09:46:49 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfO0yBzGFPvF_WwsGGJBZSBGMLsFi2CQ2Eg5RVfyfW3nA@mail.gmail.com>
Message-ID: <CAJKOXPfO0yBzGFPvF_WwsGGJBZSBGMLsFi2CQ2Eg5RVfyfW3nA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: power: syscon-reboot: Convert bindings
 to json-schema
To:     Rob Herring <robh+dt@kernel.org>
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

On Tue, 3 Sep 2019 at 09:14, Rob Herring <robh+dt@kernel.org> wrote:
>
> On Mon, Sep 2, 2019 at 4:03 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > Convert the Syscon reboot bindings to DT schema format using
> > json-schema.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  .../bindings/power/reset/syscon-reboot.txt    | 30 --------
> >  .../bindings/power/reset/syscon-reboot.yaml   | 68 +++++++++++++++++++
> >  2 files changed, 68 insertions(+), 30 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot.txt
> >  create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
>
> > diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml b/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
> > new file mode 100644
> > index 000000000000..a583f3dc8ef4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
> > @@ -0,0 +1,68 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/power/reset/syscon-reboot.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Generic SYSCON mapped register reset driver
> > +
> > +maintainers:
> > +  - Sebastian Reichel <sre@kernel.org>
> > +
> > +description: |+
> > +  This is a generic reset driver using syscon to map the reset register.
> > +  The reset is generally performed with a write to the reset register
> > +  defined by the register map pointed by syscon reference plus the offset
> > +  with the value and mask defined in the reboot node.
> > +  Default will be little endian mode, 32 bit access only.
> > +
> > +properties:
> > +  compatible:
> > +    const: syscon-reboot
> > +
> > +  mask:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: Update only the register bits defined by the mask (32 bit).
> > +    maxItems: 1
>
> Drop this as that is already defined for uint32.
>
> It also doesn't actually work. The $ref has to be under an 'allOf' if
> you have additional schemas. A quirk of json-schema...
>
> > +
> > +  offset:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: Offset in the register map for the reboot register (in bytes).
> > +    maxItems: 1
> > +
> > +  regmap:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: Phandle to the register map node.
> > +    maxItems: 1
> > +
> > +  value:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: The reset value written to the reboot register (32 bit access).
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - regmap
> > +  - offset
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        value:
> > +          not:
> > +            type: array
>
> I think you could make this a bit more readable with:
>
> if:
>   not:
>     required:
>       - value

I do not understand how does it work (value is not mentioned in the
required fields so why checking of it?)... but it works fine.

> However, if the tree is free of legacy usage, then you could just drop all this.

One of them - mask or value - has to be provided.

Thanks for review,
Kryzsztof
