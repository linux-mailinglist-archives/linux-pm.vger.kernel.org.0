Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 979F4177CB2
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 18:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbgCCRCi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 12:02:38 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40061 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729148AbgCCRCi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2020 12:02:38 -0500
Received: by mail-oi1-f195.google.com with SMTP id j80so3735497oih.7;
        Tue, 03 Mar 2020 09:02:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8kKpSbpaA0ng8YEkQSINQ3r4/4jqo4CKQTEPdV6/BRw=;
        b=JXiXVNW5qQ3FaQ9ItmH7R/TehO0y75Nb2RAWMGHqIGXnN4hJQUQOhjcja5mJxCLAnp
         Un9xG9LIjTkyR1s5v4z1Y+F8LCtoLjewZul7BQ2p1JqnJraVTdX6zPdBGQoVM7XPPvab
         pSf3QmubwyTM4VjTyr4RuVqxy7M6BjRor3+nXxD89RqZ3WPIUodNl9lAb8qXp9X1SlPW
         QGn4TR2pTaX3vN4/Yja8eCZgtTpI952+2jWyydx2RXIEwEnjuzDoIMdlYmM2hM4pg2L8
         8h9+/jygFWLm2qnXTTcCfuZmdXvMRmDm42GgdA9Gg2ns2ecmR0hAuN1xOljpjMdSP6cq
         fd6A==
X-Gm-Message-State: ANhLgQ1ueUxLaxg8yR2PKVvlq3PsXdl/zQhuY68nBb+QE4w81bAXW8Tl
        geIGETa/sHpO6r52gzH3Qw==
X-Google-Smtp-Source: ADFU+vvEQfPygs1sXv3/t9WnuW0flPvlY/t1wIiM5OQ2yzNmdPGlR0ZW8uthJFyAM3EtuYBRj4z0cg==
X-Received: by 2002:aca:1c01:: with SMTP id c1mr3164809oic.18.1583254957380;
        Tue, 03 Mar 2020 09:02:37 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a14sm8080946otr.54.2020.03.03.09.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 09:02:35 -0800 (PST)
Received: (nullmailer pid 6336 invoked by uid 1000);
        Tue, 03 Mar 2020 17:02:32 -0000
Date:   Tue, 3 Mar 2020 11:02:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        devicetree@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/7] dt-bindings: power: Convert domain-idle-states
 bindings to json-schema
Message-ID: <20200303170232.GA26191@bogus>
References: <20200303150749.30566-1-ulf.hansson@linaro.org>
 <20200303150749.30566-4-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303150749.30566-4-ulf.hansson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 03, 2020 at 04:07:45PM +0100, Ulf Hansson wrote:
> While converting to the json-schema, let's also take the opportunity to
> further specify/clarify some more details about the DT binding.
> 
> For example, let's define the label where to put the states nodes, set a
> pattern for nodename of the state nodes and finally add an example.
> 
> Fixes: a3f048b5424e ("dt: psci: Update DT bindings to support hierarchical PSCI states")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  .../devicetree/bindings/arm/psci.yaml         |  2 +-
>  .../bindings/power/domain-idle-state.txt      | 33 ---------
>  .../bindings/power/domain-idle-state.yaml     | 67 +++++++++++++++++++
>  .../bindings/power/power-domain.yaml          | 22 +++---
>  .../bindings/power/power_domain.txt           |  2 +-
>  5 files changed, 79 insertions(+), 47 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/domain-idle-state.txt
>  create mode 100644 Documentation/devicetree/bindings/power/domain-idle-state.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
> index 540211a080d4..0bc3c43a525a 100644
> --- a/Documentation/devicetree/bindings/arm/psci.yaml
> +++ b/Documentation/devicetree/bindings/arm/psci.yaml
> @@ -123,7 +123,7 @@ properties:
>        to mandate it.
>  
>        [3] Documentation/devicetree/bindings/power/power_domain.txt
> -      [4] Documentation/devicetree/bindings/power/domain-idle-state.txt
> +      [4] Documentation/devicetree/bindings/power/domain-idle-state.yaml
>  
>    power-domains:
>      $ref: '/schemas/types.yaml#/definitions/phandle-array'
> diff --git a/Documentation/devicetree/bindings/power/domain-idle-state.txt b/Documentation/devicetree/bindings/power/domain-idle-state.txt
> deleted file mode 100644
> index eefc7ed22ca2..000000000000
> --- a/Documentation/devicetree/bindings/power/domain-idle-state.txt
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -PM Domain Idle State Node:
> -
> -A domain idle state node represents the state parameters that will be used to
> -select the state when there are no active components in the domain.
> -
> -The state node has the following parameters -
> -
> -- compatible:
> -	Usage: Required
> -	Value type: <string>
> -	Definition: Must be "domain-idle-state".
> -
> -- entry-latency-us
> -	Usage: Required
> -	Value type: <prop-encoded-array>
> -	Definition: u32 value representing worst case latency in
> -		    microseconds required to enter the idle state.
> -		    The exit-latency-us duration may be guaranteed
> -		    only after entry-latency-us has passed.
> -
> -- exit-latency-us
> -	Usage: Required
> -	Value type: <prop-encoded-array>
> -	Definition: u32 value representing worst case latency
> -		    in microseconds required to exit the idle state.
> -
> -- min-residency-us
> -	Usage: Required
> -	Value type: <prop-encoded-array>
> -	Definition: u32 value representing minimum residency duration
> -		    in microseconds after which the idle state will yield
> -		    power benefits after overcoming the overhead in entering
> -i		    the idle state.
> diff --git a/Documentation/devicetree/bindings/power/domain-idle-state.yaml b/Documentation/devicetree/bindings/power/domain-idle-state.yaml
> new file mode 100644
> index 000000000000..27da43076b85
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/domain-idle-state.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/domain-idle-state.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PM Domain Idle States binding description
> +
> +maintainers:
> +  - Ulf Hansson <ulf.hansson@linaro.org>
> +
> +description:
> +  A domain idle state node represents the state parameters that will be used to
> +  select the state when there are no active components in the PM domain.
> +
> +properties:
> +  $nodename:
> +    const: domain-idle-states
> +
> +patternProperties:
> +  "^(cpu|cluster|domain)-":
> +    type: object
> +    description:
> +      Each state node represents a domain idle state description.
> +
> +    properties:
> +      compatible:
> +        const: domain-idle-state
> +
> +      entry-latency-us:
> +        $ref: /schemas/types.yaml#/definitions/uint32

You don't need a type because the core schema defines it for all 
standard units.

> +        description:
> +          The worst case latency in microseconds required to enter the idle
> +          state. Note that, the exit-latency-us duration may be guaranteed only
> +          after the entry-latency-us has passed.
> +
> +      exit-latency-us:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          The worst case latency in microseconds required to exit the idle
> +          state.
> +
> +      min-residency-us:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          The minimum residency duration in microseconds after which the idle
> +          state will yield power benefits, after overcoming the overhead while
> +          entering the idle state.
> +
> +    required:
> +      - compatible
> +      - entry-latency-us
> +      - exit-latency-us
> +      - min-residency-us

       additionalProperties: false 

Do we have cases of adding additional properties?

I can fix these up when applying.

Rob
