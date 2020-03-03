Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7453A178440
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 21:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731845AbgCCUqN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 15:46:13 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38650 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbgCCUqN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2020 15:46:13 -0500
Received: by mail-vs1-f68.google.com with SMTP id r18so3352921vso.5
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2020 12:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7L4eJdYzEWt9OU7Eb6955CnoA1Bc4Uk+/BMUtBI5Efw=;
        b=EajGJc2UriF5GG1JUfXsGdRCrJrlHHOSrWyfJ88FE1mCrdqfTUHe44b+g5uDWOWE1P
         OHAPcvPTYYVHavrAPdMA7YfBas8pD2G6Q0qt/RVqbzRGZ/+crz3s2RFuJKtOVgHGIgFs
         uE6ekqsvvRTNIRqD1vs+x/nVKEsgbiJ+y9HXufoGQ7ETMPTCYXe8q+GPsGpv0QO+kgzi
         k0oUKOf9qRGCy2ND98qTJssy8yVPIbe07vuHwwdIU2bMY/6pDKyJNXq4YFQgdPwiJAEt
         Tr3yNrqTGMta2JPQtHizVe+3rjTu5CW+Orf+2vU8yELfXOQdomU9M5ukneMjkg70HfQC
         GlFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7L4eJdYzEWt9OU7Eb6955CnoA1Bc4Uk+/BMUtBI5Efw=;
        b=KNxW3fFCUm7FCGUOKXk77fq18kmMZUF7n/6TMEAHix+yfA4C/fwhEOVw2rW0GVwBMY
         bEXMZgJXrdoFy6H6XwVfqR/lI05eo7Nt4fihjQixIytextMYWkuHOHlbesMZmjbL34dk
         iqzqraHD/Ff8KaQ6qY5NXuLGXej4RM/LeAjJ/mwkLuYslrYygzoItf774VX3Q7iuOuUk
         AP0F/L5RV7P1JPSbZGjyF22wv1Zs7RUW5JJhdjXEm4ocPXu6Wztp+2IxWmJj4mTPC1V4
         0W1Wiv5hLr7MAhReVohatptUA2tX+GojCn449/CPErhzla8sTfYq7aKWdjoAM+Qz0REK
         g55Q==
X-Gm-Message-State: ANhLgQ0BEp1eTanEE49JjVngOmFd9GwC4Qrel/WTPwk3IK1mjrgxaNAl
        qY3ZDI8zxa+IDFdhiB1cpcxKMO9Nd1dlmCxtWoFPNw==
X-Google-Smtp-Source: ADFU+vs5Geo/nfXYUy3+nQ5/6sjz1pvP6CtSd2BjNvOeDErJnDZvTjqTBd0O+W+/8FOZxGqhfYYRBraBqmjwiLn2eTA=
X-Received: by 2002:a67:800e:: with SMTP id b14mr2363089vsd.191.1583268371719;
 Tue, 03 Mar 2020 12:46:11 -0800 (PST)
MIME-Version: 1.0
References: <20200303150749.30566-1-ulf.hansson@linaro.org>
 <20200303150749.30566-4-ulf.hansson@linaro.org> <20200303170232.GA26191@bogus>
In-Reply-To: <20200303170232.GA26191@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 3 Mar 2020 21:45:35 +0100
Message-ID: <CAPDyKFrgbnDR2q2Aw7HPhosBprgR43ohXmNMLya_bRry4GqtoQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] dt-bindings: power: Convert domain-idle-states
 bindings to json-schema
To:     Rob Herring <robh@kernel.org>
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

On Tue, 3 Mar 2020 at 18:02, Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Mar 03, 2020 at 04:07:45PM +0100, Ulf Hansson wrote:
> > While converting to the json-schema, let's also take the opportunity to
> > further specify/clarify some more details about the DT binding.
> >
> > For example, let's define the label where to put the states nodes, set a
> > pattern for nodename of the state nodes and finally add an example.
> >
> > Fixes: a3f048b5424e ("dt: psci: Update DT bindings to support hierarchical PSCI states")
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  .../devicetree/bindings/arm/psci.yaml         |  2 +-
> >  .../bindings/power/domain-idle-state.txt      | 33 ---------
> >  .../bindings/power/domain-idle-state.yaml     | 67 +++++++++++++++++++
> >  .../bindings/power/power-domain.yaml          | 22 +++---
> >  .../bindings/power/power_domain.txt           |  2 +-
> >  5 files changed, 79 insertions(+), 47 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/power/domain-idle-state.txt
> >  create mode 100644 Documentation/devicetree/bindings/power/domain-idle-state.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
> > index 540211a080d4..0bc3c43a525a 100644
> > --- a/Documentation/devicetree/bindings/arm/psci.yaml
> > +++ b/Documentation/devicetree/bindings/arm/psci.yaml
> > @@ -123,7 +123,7 @@ properties:
> >        to mandate it.
> >
> >        [3] Documentation/devicetree/bindings/power/power_domain.txt
> > -      [4] Documentation/devicetree/bindings/power/domain-idle-state.txt
> > +      [4] Documentation/devicetree/bindings/power/domain-idle-state.yaml
> >
> >    power-domains:
> >      $ref: '/schemas/types.yaml#/definitions/phandle-array'
> > diff --git a/Documentation/devicetree/bindings/power/domain-idle-state.txt b/Documentation/devicetree/bindings/power/domain-idle-state.txt
> > deleted file mode 100644
> > index eefc7ed22ca2..000000000000
> > --- a/Documentation/devicetree/bindings/power/domain-idle-state.txt
> > +++ /dev/null
> > @@ -1,33 +0,0 @@
> > -PM Domain Idle State Node:
> > -
> > -A domain idle state node represents the state parameters that will be used to
> > -select the state when there are no active components in the domain.
> > -
> > -The state node has the following parameters -
> > -
> > -- compatible:
> > -     Usage: Required
> > -     Value type: <string>
> > -     Definition: Must be "domain-idle-state".
> > -
> > -- entry-latency-us
> > -     Usage: Required
> > -     Value type: <prop-encoded-array>
> > -     Definition: u32 value representing worst case latency in
> > -                 microseconds required to enter the idle state.
> > -                 The exit-latency-us duration may be guaranteed
> > -                 only after entry-latency-us has passed.
> > -
> > -- exit-latency-us
> > -     Usage: Required
> > -     Value type: <prop-encoded-array>
> > -     Definition: u32 value representing worst case latency
> > -                 in microseconds required to exit the idle state.
> > -
> > -- min-residency-us
> > -     Usage: Required
> > -     Value type: <prop-encoded-array>
> > -     Definition: u32 value representing minimum residency duration
> > -                 in microseconds after which the idle state will yield
> > -                 power benefits after overcoming the overhead in entering
> > -i                the idle state.
> > diff --git a/Documentation/devicetree/bindings/power/domain-idle-state.yaml b/Documentation/devicetree/bindings/power/domain-idle-state.yaml
> > new file mode 100644
> > index 000000000000..27da43076b85
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/domain-idle-state.yaml
> > @@ -0,0 +1,67 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/power/domain-idle-state.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: PM Domain Idle States binding description
> > +
> > +maintainers:
> > +  - Ulf Hansson <ulf.hansson@linaro.org>
> > +
> > +description:
> > +  A domain idle state node represents the state parameters that will be used to
> > +  select the state when there are no active components in the PM domain.
> > +
> > +properties:
> > +  $nodename:
> > +    const: domain-idle-states
> > +
> > +patternProperties:
> > +  "^(cpu|cluster|domain)-":
> > +    type: object
> > +    description:
> > +      Each state node represents a domain idle state description.
> > +
> > +    properties:
> > +      compatible:
> > +        const: domain-idle-state
> > +
> > +      entry-latency-us:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
>
> You don't need a type because the core schema defines it for all
> standard units.

Okay, I noticed some skips this, but wanted rather to clear and fuzzy.

In any case, yes, let's remove it.

>
> > +        description:
> > +          The worst case latency in microseconds required to enter the idle
> > +          state. Note that, the exit-latency-us duration may be guaranteed only
> > +          after the entry-latency-us has passed.
> > +
> > +      exit-latency-us:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description:
> > +          The worst case latency in microseconds required to exit the idle
> > +          state.
> > +
> > +      min-residency-us:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description:
> > +          The minimum residency duration in microseconds after which the idle
> > +          state will yield power benefits, after overcoming the overhead while
> > +          entering the idle state.
> > +
> > +    required:
> > +      - compatible
> > +      - entry-latency-us
> > +      - exit-latency-us
> > +      - min-residency-us
>
>        additionalProperties: false
>
> Do we have cases of adding additional properties?

I might, but I am not sure what's the correct way to deal with that.

What I am wondering about is the "arm,psci-suspend-param" property,
currently defined as part of the PSCI bindings (psci.yaml).

I am not sure that's correct to define it as a PSCI binding. Shouldn't
it rather be a part of the idle state bindings (idle-states.yaml) and
the domain idle states binding ($subject patch)?

What do you think?

In any case, we probably want to fix this on top, if we should care.

>
> I can fix these up when applying.

Thanks a lot!

Kind regards
Uffe
