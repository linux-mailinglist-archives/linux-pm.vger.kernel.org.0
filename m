Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A886A434186
	for <lists+linux-pm@lfdr.de>; Wed, 20 Oct 2021 00:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbhJSWqP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 18:46:15 -0400
Received: from mail-oo1-f43.google.com ([209.85.161.43]:34768 "EHLO
        mail-oo1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhJSWqP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Oct 2021 18:46:15 -0400
Received: by mail-oo1-f43.google.com with SMTP id n15-20020a4ad12f000000b002b6e3e5fd5dso1464079oor.1;
        Tue, 19 Oct 2021 15:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1m9OX/Iwd5yq38UvhnkkIadmZsRZNS3qdx4ir1kcVNw=;
        b=anuvoZEU7YMdWBOMb/WE7JDUxHfH6jnHqpggCAJogjkbH7AA3cTLb2NGxxHS3re1fE
         s7jWHFo9rAJ8yaQXlah4amIAZmqAAmsIdwoq2LfFLkt6jrlvcP8MGHT9LlcsEsy7ZvXR
         mGQSN09u/lh5jY3HKFMqvJRjM5wifCBDcKkUBL3j6Nwv9WW+DsVSXubJER4fasPcWhER
         LsfWPtWINHzZvVFQ4cjUHC3z1WJMtd/RShb3m68/A5C5w/KoDmjhgWWedgKdRyYQ73l2
         y47jDco66+UmW+k2M+imqWALiNrnUWgU1L94Dv2o3Y6vKoOod+r6Un10G0JowlFfwQ3J
         mOEg==
X-Gm-Message-State: AOAM530LCOCYrfqO6cH7qVDrLmNLmg1BqPVuS0A7Sr1usvMHjyUi1why
        Zw+gQogiaWmznk/CaMn8wA==
X-Google-Smtp-Source: ABdhPJzUU3VUWI682S2KU0DU1+1kmv1QzDke4dNPNWl7FQZwt9qn1gRrdnqxwwN0MoQjOcDzG6b8xw==
X-Received: by 2002:a4a:a38d:: with SMTP id s13mr6755243ool.60.1634683441388;
        Tue, 19 Oct 2021 15:44:01 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k2sm99873oot.37.2021.10.19.15.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 15:44:00 -0700 (PDT)
Received: (nullmailer pid 962499 invoked by uid 1000);
        Tue, 19 Oct 2021 22:43:59 -0000
Date:   Tue, 19 Oct 2021 17:43:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Hector Martin <marcan@marcan.st>,
        linux-arm-kernel@lists.infradead.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/9] dt-bindings: memory-controller: Add apple,mcc
 binding
Message-ID: <YW9KL+3MgD8NYxF5@robh.at.kernel.org>
References: <20211011165707.138157-1-marcan@marcan.st>
 <20211011165707.138157-3-marcan@marcan.st>
 <6999f3f4-338c-f1ba-2360-40fa50ecd45d@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6999f3f4-338c-f1ba-2360-40fa50ecd45d@canonical.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 12, 2021 at 10:48:12AM +0200, Krzysztof Kozlowski wrote:
> On 11/10/2021 18:57, Hector Martin wrote:
> > This device represents the memory controller in Apple SoCs, and is
> > chiefly in charge of adjusting performance characteristics according to
> > system demand.
> > 
> > Signed-off-by: Hector Martin <marcan@marcan.st>
> > ---
> >  .../memory-controllers/apple,mcc.yaml         | 80 +++++++++++++++++++
> >  .../opp/apple,mcc-operating-points.yaml       | 62 ++++++++++++++
> >  2 files changed, 142 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/memory-controllers/apple,mcc.yaml
> >  create mode 100644 Documentation/devicetree/bindings/opp/apple,mcc-operating-points.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/memory-controllers/apple,mcc.yaml b/Documentation/devicetree/bindings/memory-controllers/apple,mcc.yaml
> > new file mode 100644
> > index 000000000000..0774f10e65ed
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/memory-controllers/apple,mcc.yaml
> > @@ -0,0 +1,80 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/memory-controllers/apple,mcc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Apple SoC MCC memory controller performance controls
> > +
> > +maintainers:
> > +  - Hector Martin <marcan@marcan.st>
> > +
> > +description: |
> > +  Apple SoCs contain a multichannel memory controller that can have its
> > +  configuration changed to adjust to changing performance requirements from
> > +  the rest of the SoC. This node represents the controller and provides a
> > +  power domain provider that downstream devices can use to adjust the memory
> > +  controller performance level.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - apple,t8103-mcc
> > +      - const: apple,mcc
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#power-domain-cells":
> > +    const: 0
> > +
> > +  operating-points-v2:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description:
> > +      A reference to the OPP table describing the memory controller performance
> > +      levels. Each OPP node should contain an `apple,memory-perf-config`
> > +      property that contains the configuration values for that performance
> > +      level.
> > +
> > +  apple,num-channels:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      The number of memory channels in use.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#power-domain-cells"
> > +  - operating-points-v2
> > +  - apple,num-channels
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  # See clock/apple,cluster-clock.yaml for an example of downstream usage.
> > +  - |
> > +    mcc_opp: opp-table-2 {
> > +        compatible = "operating-points-v2";
> 
> apple,mcc-operating-points?

+1


> > +
> > +        mcc_lowperf: opp0 {
> > +            opp-level = <0>;
> > +            apple,memory-perf-config = <0x813057f 0x1800180>;
> > +        };
> > +        mcc_highperf: opp1 {
> > +            opp-level = <1>;
> > +            apple,memory-perf-config = <0x133 0x55555340>;
> > +        };
> > +    };
> > +    soc {
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +
> > +        mcc: memory-controller@200200000 {
> > +            compatible = "apple,t8103-mcc", "apple,mcc";
> > +            #power-domain-cells = <0>;
> > +            reg = <0x2 0x200000 0x0 0x200000>;
> > +            operating-points-v2 = <&mcc_opp>;
> > +            apple,num-channels = <8>;
> > +        };
> > +    };
> > diff --git a/Documentation/devicetree/bindings/opp/apple,mcc-operating-points.yaml b/Documentation/devicetree/bindings/opp/apple,mcc-operating-points.yaml
> > new file mode 100644
> > index 000000000000..babf27841bb7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/opp/apple,mcc-operating-points.yaml
> > @@ -0,0 +1,62 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/opp/apple,mcc-operating-points.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Apple SoC memory controller OPP bindings
> > +
> > +maintainers:
> > +  - Hector Martin <marcan@marcan.st>
> > +
> > +description: |
> > +  Apple SoCs can have their memory controller performance adjusted depending on
> > +  system requirements. These performance states are represented by specific
> > +  memory controller register values. The apple-mcc driver uses these values
> > +  to change the MCC performance.
> > +
> > +allOf:
> > +  - $ref: opp-v2-base.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: apple,mcc-operating-points
> > +
> > +required:
> > +  - compatible
> > +
> > +patternProperties:
> > +  "opp[0-9]+":
> > +    type: object
> > +
> > +    properties:
> > +      opp-level: true
> 
> You don't need to mention it.

Actually, you do.

You are thinking unevaluatedProperties takes care of it, but it doesn't 
here. The problem is if you have 2 schemas (this one and 
opp-v2-base.yaml) with child nodes, the child nodes in each schema are 
evaluated separately.

So anywhere we have child nodes, we need the child node schema to be a 
separate file or able to be directly referenced (i.e. under $defs). I 
only realized this when testing out unevaluatedProperties support.

Rob
