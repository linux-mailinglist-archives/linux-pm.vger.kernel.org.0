Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A264F26348B
	for <lists+linux-pm@lfdr.de>; Wed,  9 Sep 2020 19:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgIIRXE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Sep 2020 13:23:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbgIIRXC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 9 Sep 2020 13:23:02 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C0452166E;
        Wed,  9 Sep 2020 17:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599672181;
        bh=ojYXfjO2DurN2C/opB53TRYM7STqyjyLj7tArEbYnYU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W40okwbvhzb3YNdQWWE61AnHf+7XtiOdb6MNYys5tClUSQqHRyUMpvh3j0fpRj3NS
         33B56q0jVNPBQ3AsfsIRkXkarAFSMhPU2JsKSxRbZo06tvNmgrXsWwK3ewSbwGSrxC
         B3BdieaaNhVMHkaDJiSZWYP+jSTalp6OSB3k8Ud8=
Received: by mail-ot1-f42.google.com with SMTP id g10so2954608otq.9;
        Wed, 09 Sep 2020 10:23:01 -0700 (PDT)
X-Gm-Message-State: AOAM532QNqalj6R3eFLxyi/WKh/V+wpgcVI5mHOwFIhUjqcJfy/ZkstH
        Yg8ez7sZHgduM4r4zDXprgUh9ezNBpfhIC0Ihg==
X-Google-Smtp-Source: ABdhPJwF/BBwg1karh3OP6yS1l/x+0g03zifHTvvij6uGN/zcwIb/C59SHbjSoa84vatAmS8zyZQIW9jDnoPNpIu7AQ=
X-Received: by 2002:a9d:411:: with SMTP id 17mr1405892otc.192.1599672180697;
 Wed, 09 Sep 2020 10:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1598043782.git.cristian.ciocaltea@gmail.com>
 <863c9c1e44cfbe6184bf0bd4893ff456af0e7bb8.1598043782.git.cristian.ciocaltea@gmail.com>
 <20200908214724.GA959481@bogus> <20200909160334.GA385382@BV030612LT>
In-Reply-To: <20200909160334.GA385382@BV030612LT>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 9 Sep 2020 11:22:48 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL+21YH+_w3e6PnW0GqPyEAD6uU-hqHZercKK0xQwCOjg@mail.gmail.com>
Message-ID: <CAL_JsqL+21YH+_w3e6PnW0GqPyEAD6uU-hqHZercKK0xQwCOjg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: mfd: Add Actions Semi ATC260x PMIC binding
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 9, 2020 at 10:03 AM Cristian Ciocaltea
<cristian.ciocaltea@gmail.com> wrote:
>
> Hi Rob,
>
> Thanks for reviewing!
>
> On Tue, Sep 08, 2020 at 03:47:24PM -0600, Rob Herring wrote:
> > On Sat, Aug 22, 2020 at 01:19:47AM +0300, Cristian Ciocaltea wrote:
> > > Add devicetree binding for Actions Semi ATC260x PMICs.
> > >
> > > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > > ---
> > >  .../bindings/mfd/actions,atc260x.yaml         | 221 ++++++++++++++++++
> > >  1 file changed, 221 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/mfd/actions,atc260x.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/mfd/actions,atc260x.yaml b/Documentation/devicetree/bindings/mfd/actions,atc260x.yaml
> > > new file mode 100644
> > > index 000000000000..4a55bbe1306e
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mfd/actions,atc260x.yaml
> > > @@ -0,0 +1,221 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/mfd/actions,atc260x.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Actions Semi ATC260x Power Management IC bindings
> > > +
> > > +maintainers:
> > > +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > +  - Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > > +
> > > +description: |
> > > +  ATC260x series PMICs integrates Audio Codec, Power Management, RTC, IR
> > > +  and GPIO controller blocks. Currently only the PM related functionalities
> > > +  (i.e. regulators and system power-off/reboot) for the ATC2603C and ATC2609A
> > > +  chip variants are supported.
> > > +  ATC2603C includes 3 programmable DC-DC converters and 9 LDO regulators.
> > > +  ATC2609A includes 5 programmable DC-DC converters and 10 LDO regulators.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - actions,atc2603c
> > > +      - actions,atc2609a
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  pwrc:
> > > +    type: object
> > > +    description: |
> > > +      The power controller integrated in ATC260x provides system power-off
> > > +      and reboot operations.
> >
> > No need for this node as there are no properties, just instantiate
> > what's needed in the MFD driver.
>
> My intention was to allow the user specify what functionality in the MFD
> shall be enabled. For this particular case, if the 'pwrc' node is not
> provided, the power-off/reboot functions will be disabled.

IIRC, there's a flag property for this already.

>
> > > +
> > > +    properties:
> > > +      compatible:
> > > +        enum:
> > > +          - actions,atc2603c-pwrc
> > > +          - actions,atc2609a-pwrc
> > > +
> > > +    required:
> > > +      - compatible
> > > +
> > > +    additionalProperties: false
> > > +
> > > +  onkey:
> > > +    type: object
> > > +    description: |
> > > +      Use the ONKEY built into ATC260x PMICs as an input device reporting
> > > +      power button status. ONKEY can be used to wakeup from low power
> > > +      modes and force a reset on long press.
> > > +
> > > +    properties:
> > > +      compatible:
> > > +        enum:
> > > +          - actions,atc2603c-onkey
> > > +          - actions,atc2609a-onkey
> > > +
> > > +      actions,reset-time-sec:
> > > +        description: |
> > > +          Duration in seconds which the key should be kept pressed for device
> > > +          to reset automatically. The hardware default is 8. Use 0 to disable
> > > +          this functionality.
> > > +        enum: [0, 6, 8, 10, 12]
> >
> > We already have 'power-off-time-sec' in input.yaml. How about adding
> > 'reset-time-sec' there.
>
> Thanks for the suggestion, I was actually looking for this before
> choosing the custom property and just assumed this was not added for
> a particular reason.

Probably just because the usual behavior of holding the power button
is to power off rather than reset.

> So I'm going to handle it. Would you like me to send a separate patch
> (not part of this series)?

Separate patch yes, but it can be part of the series.

> > This could really just be a property in the parent node.
>
> This is similar with 'pwrc': if 'onkey' node is not present, the ONKEY
> functionality will not be enabled.

Would you really want/need to support wakeup, but disable long press
feature? Seems like a single property would be sufficient.

> Is there a better/recommended approach to manage this MFD feature
> selection?

But we have child nodes for this in other cases, so I guess it is fine.

Rob
