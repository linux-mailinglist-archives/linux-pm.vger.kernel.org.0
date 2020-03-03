Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A76101784BC
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 22:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732447AbgCCVR4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 16:17:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:48428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732075AbgCCVR4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Mar 2020 16:17:56 -0500
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79354208C3;
        Tue,  3 Mar 2020 21:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583270274;
        bh=u+IJrtkDmmILKrB777JfXIiXu/1W6oLqMP+I5yJnh2M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n7g6PctrjHyalDBnUVzVVtTQjjls7cc/u2J+8JdC+r3e1d5flgOXBXR4FZ7tLvpMA
         7b6gwv5T1fiWDXqgIKGMuRwTHLdGVZ3flfrT6tvxBWzb4Z7zLJ2u8aar3WcPRYv3Rh
         3GQsCWIQ0Zl4mpqcqP4EnNO2W3gTAEZjygyMVAfo=
Received: by mail-qk1-f170.google.com with SMTP id m9so4984697qke.4;
        Tue, 03 Mar 2020 13:17:54 -0800 (PST)
X-Gm-Message-State: ANhLgQ0ybcFzbMYYXxVHeFOokuvsBorvorNaWGJdp+Qxzp7FW0xibqCM
        qXpNFPwqRGhiLfanDzXO4REnes+83MchjvN8pQ==
X-Google-Smtp-Source: ADFU+vtMU23sEGul4xIS3cOxg5HrzR9E2uToGkQ9bXIiwRYCwLzdQ482f+A1Bjc2x/VSMmCDsUDzaUn2JS5rGNey7YY=
X-Received: by 2002:a05:620a:12a3:: with SMTP id x3mr31904qki.254.1583270273440;
 Tue, 03 Mar 2020 13:17:53 -0800 (PST)
MIME-Version: 1.0
References: <20200303150749.30566-1-ulf.hansson@linaro.org>
 <20200303150749.30566-4-ulf.hansson@linaro.org> <20200303170232.GA26191@bogus>
 <CAPDyKFrgbnDR2q2Aw7HPhosBprgR43ohXmNMLya_bRry4GqtoQ@mail.gmail.com>
In-Reply-To: <CAPDyKFrgbnDR2q2Aw7HPhosBprgR43ohXmNMLya_bRry4GqtoQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 3 Mar 2020 15:17:42 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+T0VxPMRAvmEOnKi14eQiciRqOEQAo1GT8EG9jp=BNng@mail.gmail.com>
Message-ID: <CAL_Jsq+T0VxPMRAvmEOnKi14eQiciRqOEQAo1GT8EG9jp=BNng@mail.gmail.com>
Subject: Re: [PATCH 3/7] dt-bindings: power: Convert domain-idle-states
 bindings to json-schema
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 3, 2020 at 2:46 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 3 Mar 2020 at 18:02, Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, Mar 03, 2020 at 04:07:45PM +0100, Ulf Hansson wrote:
> > > While converting to the json-schema, let's also take the opportunity to
> > > further specify/clarify some more details about the DT binding.
> > >
> > > For example, let's define the label where to put the states nodes, set a
> > > pattern for nodename of the state nodes and finally add an example.
> > >
> > > Fixes: a3f048b5424e ("dt: psci: Update DT bindings to support hierarchical PSCI states")
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >  .../devicetree/bindings/arm/psci.yaml         |  2 +-
> > >  .../bindings/power/domain-idle-state.txt      | 33 ---------
> > >  .../bindings/power/domain-idle-state.yaml     | 67 +++++++++++++++++++
> > >  .../bindings/power/power-domain.yaml          | 22 +++---
> > >  .../bindings/power/power_domain.txt           |  2 +-
> > >  5 files changed, 79 insertions(+), 47 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/power/domain-idle-state.txt
> > >  create mode 100644 Documentation/devicetree/bindings/power/domain-idle-state.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
> > > index 540211a080d4..0bc3c43a525a 100644
> > > --- a/Documentation/devicetree/bindings/arm/psci.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/psci.yaml
> > > @@ -123,7 +123,7 @@ properties:
> > >        to mandate it.
> > >
> > >        [3] Documentation/devicetree/bindings/power/power_domain.txt
> > > -      [4] Documentation/devicetree/bindings/power/domain-idle-state.txt
> > > +      [4] Documentation/devicetree/bindings/power/domain-idle-state.yaml
> > >
> > >    power-domains:
> > >      $ref: '/schemas/types.yaml#/definitions/phandle-array'
> > > diff --git a/Documentation/devicetree/bindings/power/domain-idle-state.txt b/Documentation/devicetree/bindings/power/domain-idle-state.txt
> > > deleted file mode 100644
> > > index eefc7ed22ca2..000000000000
> > > --- a/Documentation/devicetree/bindings/power/domain-idle-state.txt
> > > +++ /dev/null
> > > @@ -1,33 +0,0 @@
> > > -PM Domain Idle State Node:
> > > -
> > > -A domain idle state node represents the state parameters that will be used to
> > > -select the state when there are no active components in the domain.
> > > -
> > > -The state node has the following parameters -
> > > -
> > > -- compatible:
> > > -     Usage: Required
> > > -     Value type: <string>
> > > -     Definition: Must be "domain-idle-state".
> > > -
> > > -- entry-latency-us
> > > -     Usage: Required
> > > -     Value type: <prop-encoded-array>
> > > -     Definition: u32 value representing worst case latency in
> > > -                 microseconds required to enter the idle state.
> > > -                 The exit-latency-us duration may be guaranteed
> > > -                 only after entry-latency-us has passed.
> > > -
> > > -- exit-latency-us
> > > -     Usage: Required
> > > -     Value type: <prop-encoded-array>
> > > -     Definition: u32 value representing worst case latency
> > > -                 in microseconds required to exit the idle state.
> > > -
> > > -- min-residency-us
> > > -     Usage: Required
> > > -     Value type: <prop-encoded-array>
> > > -     Definition: u32 value representing minimum residency duration
> > > -                 in microseconds after which the idle state will yield
> > > -                 power benefits after overcoming the overhead in entering
> > > -i                the idle state.
> > > diff --git a/Documentation/devicetree/bindings/power/domain-idle-state.yaml b/Documentation/devicetree/bindings/power/domain-idle-state.yaml
> > > new file mode 100644
> > > index 000000000000..27da43076b85
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/power/domain-idle-state.yaml
> > > @@ -0,0 +1,67 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/power/domain-idle-state.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: PM Domain Idle States binding description
> > > +
> > > +maintainers:
> > > +  - Ulf Hansson <ulf.hansson@linaro.org>
> > > +
> > > +description:
> > > +  A domain idle state node represents the state parameters that will be used to
> > > +  select the state when there are no active components in the PM domain.
> > > +
> > > +properties:
> > > +  $nodename:
> > > +    const: domain-idle-states
> > > +
> > > +patternProperties:
> > > +  "^(cpu|cluster|domain)-":
> > > +    type: object
> > > +    description:
> > > +      Each state node represents a domain idle state description.
> > > +
> > > +    properties:
> > > +      compatible:
> > > +        const: domain-idle-state
> > > +
> > > +      entry-latency-us:
> > > +        $ref: /schemas/types.yaml#/definitions/uint32
> >
> > You don't need a type because the core schema defines it for all
> > standard units.
>
> Okay, I noticed some skips this, but wanted rather to clear and fuzzy.
>
> In any case, yes, let's remove it.
>
> >
> > > +        description:
> > > +          The worst case latency in microseconds required to enter the idle
> > > +          state. Note that, the exit-latency-us duration may be guaranteed only
> > > +          after the entry-latency-us has passed.
> > > +
> > > +      exit-latency-us:
> > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > +        description:
> > > +          The worst case latency in microseconds required to exit the idle
> > > +          state.
> > > +
> > > +      min-residency-us:
> > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > +        description:
> > > +          The minimum residency duration in microseconds after which the idle
> > > +          state will yield power benefits, after overcoming the overhead while
> > > +          entering the idle state.
> > > +
> > > +    required:
> > > +      - compatible
> > > +      - entry-latency-us
> > > +      - exit-latency-us
> > > +      - min-residency-us
> >
> >        additionalProperties: false
> >
> > Do we have cases of adding additional properties?
>
> I might, but I am not sure what's the correct way to deal with that.

I was thinking more like a vendor adding properties. Is this a base
class that can be extended or every possible property is defined here.
Actually, with the matching on $nodename, we have to put any additions
in here or do a custom 'select'. In any case, I think we can cross
than when/if we get there.

> What I am wondering about is the "arm,psci-suspend-param" property,
> currently defined as part of the PSCI bindings (psci.yaml).
>
> I am not sure that's correct to define it as a PSCI binding. Shouldn't
> it rather be a part of the idle state bindings (idle-states.yaml) and
> the domain idle states binding ($subject patch)?

Indeed it should be moved here.

>
> What do you think?
>
> In any case, we probably want to fix this on top, if we should care.

Yes, that's fine.

Rob
