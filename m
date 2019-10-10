Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDFFBD3387
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2019 23:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfJJVii (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Oct 2019 17:38:38 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38017 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJVii (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Oct 2019 17:38:38 -0400
Received: by mail-ot1-f65.google.com with SMTP id e11so6221379otl.5;
        Thu, 10 Oct 2019 14:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=JrMeBCDDqMDRlV1LXtf9IBSD/gtLaIwd2AFca/FRiY0=;
        b=b61qWnZivfv0xikCD5DyfmYF8q4nGqNDcMuoSOwzdyQ7tT+qfHH+aJ02twQuAGpSXm
         3jjoD7HJzqxN7ZO3tnp6m1QWDDA1VV3eHE6FwPqyeBfNaXFKgMuNybh6moqhcw6wkBfn
         u6NxIy+826vfImpToCr+zNYLsu60IvqfZbQhKj2382iMiZW5AgmLk0uKQ2pXX+jsAB8g
         G8rFwQ3tGVTuWh3CK0gh6ApJcHU2Xokt/vETB+mC7bkS0cfdJOTwH40nIRZO34YElVaN
         yx18WF/dK3uXRWAlJHAeRCFPq1VHjJhe4P416PPizN2zrUKnmnFXDfEwsOS8X5AbSA5l
         q/ug==
X-Gm-Message-State: APjAAAUHxwXm725VibxYHOMdtwQo2SVfHQRWu0EsrN/a5KzW+9TWN9QX
        uhmJsvCFM25XY0lGupBf1w==
X-Google-Smtp-Source: APXvYqyZYaS5xDpNqavIRJUx/gyPFU7+hCzyPoviT4elP0evWutDKyCDYGE7C7bNljkDNV9TQLQh6Q==
X-Received: by 2002:a05:6830:1154:: with SMTP id x20mr9360083otq.219.1570743517234;
        Thu, 10 Oct 2019 14:38:37 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d194sm2051250oib.47.2019.10.10.14.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 14:38:36 -0700 (PDT)
Date:   Thu, 10 Oct 2019 16:38:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Simon Horman <horms+renesas@verge.net.au>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Kaneko <ykaneko0929@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: thermal: rcar-thermal: convert bindings
 to json-schema
Message-ID: <20191010213835.GA12055@bogus>
References: <20190923120348.2908-1-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190923120348.2908-1-horms+renesas@verge.net.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 23, 2019 at 02:03:48PM +0200, Simon Horman wrote:
> Convert Renesas R-Car Thermal bindings documentation to json-schema.
> Also name bindings documentation file according to the compat string
> being documented.
> 
> As a side effect of this change all currently supported/used compat
> strings are listed while no while card compat string is documented.
> This, in my opinion, is desirable as only supported hardware should
> be documented.
> 
> A possible follow-up is to deprecate renesas,rcar-thermal
> after describing thermal zones in the DT for R-Mobile APE6 and R-Car H1.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> Based on v5.3
> Tested using:
>   ARCH=arm make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/thermal/renesas,rcar-thermal.yaml
> 
> v2
> * Update compat strings to reflect that:
>   - RZ/G1M and RZ/G1N are not compatible with renesas,rcar-gen2-thermal
>   - R-Car V3M, E3 and D3, and RZ/G2E are not compatible with
>     renesas,rcar-thermal
> * Update reg property
>   - Drop uninformative comment
>   - Do not limit to a maximum of one item
> * Add SPDX tag
> ---
>  .../devicetree/bindings/thermal/rcar-thermal.txt   |  78 --------------
>  .../bindings/thermal/renesas,rcar-thermal.yaml     | 116 +++++++++++++++++++++
>  2 files changed, 116 insertions(+), 78 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/thermal/rcar-thermal.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/renesas,rcar-thermal.yaml


> diff --git a/Documentation/devicetree/bindings/thermal/renesas,rcar-thermal.yaml b/Documentation/devicetree/bindings/thermal/renesas,rcar-thermal.yaml
> new file mode 100644
> index 000000000000..a55c018a3a1f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/renesas,rcar-thermal.yaml
> @@ -0,0 +1,116 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/renesas,rcar-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas R-Car Thermal
> +
> +maintainers:
> +  - Niklas Söderlund <niklas.soderlund@ragnatech.se>
> +  - Geert Uytterhoeven <geert+renesas@glider.be>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - renesas,thermal-r8a73a4       # R-Mobile APE6
> +              - renesas,thermal-r8a7779       # R-Car H1
> +          - const: renesas,rcar-thermal       # Without thermal-zone
> +
> +      - items:
> +          - enum:
> +              - renesas,thermal-r8a7790       # R-Car H2
> +              - renesas,thermal-r8a7791       # R-Car M2-W
> +              - renesas,thermal-r8a7792       # R-Car V2H
> +              - renesas,thermal-r8a7793       # R-Car M2-N
> +          - const: renesas,rcar-gen2-thermal  # With thermal-zone
> +          - const: renesas,rcar-thermal       # Without thermal-zone
> +
> +      - items:
> +          - enum:
> +              - renesas,thermal-r8a7743       # RZ/G1M
> +              - renesas,thermal-r8a7744       # RZ/G1N
> +          - const: renesas,rcar-gen2-thermal  # With thermal-zone
> +
> +      - items:
> +          - enum:
> +              - renesas,thermal-r8a774c0      # RZ/G2E
> +              - renesas,thermal-r8a77970      # R-Car V3M
> +              - renesas,thermal-r8a77990      # R-Car E3
> +              - renesas,thermal-r8a77995      # R-Car D3
> +
> +  reg: true
> +    # The 1st reg will be recognized as common register if it has "interrupts".

reg:
  minItems: 1
  maxItems: 4 (or ?, I assume there is some known max)
  additionalItems: true
  items:
    - description: common register if it has "interrupts" or ...
    - description: ...

> +
> +  interrupts:
> +    # If present should contain 3 interrupts for R-Car V3M/E3/D3 and RZ/G2E,
> +    # otherwise 1 interrupt.
> +    minItems: 1
> +    maxItems: 3
> +
> +  clocks:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples :
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/r8a7790-clock.h>
> +
> + # Example (non interrupt support):
> +  - |
> +    thermal@ffc48000 {
> +        compatible = "renesas,thermal-r8a7779", "renesas,rcar-thermal";
> +        reg = <0xffc48000 0x38>;
> +    };
> +
> +  # Example (interrupt support):
> +  - |
> +    thermal@e61f0000 {
> +        compatible = "renesas,thermal-r8a73a4", "renesas,rcar-thermal";
> +        reg = <0xe61f0000 0x14
> +               0xe61f0100 0x38
> +               0xe61f0200 0x38
> +               0xe61f0300 0x38>;

This should be bracketed for each item or the schema thinks this is 1 
item instead of 4.

> +        interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
> +    };
> +
> +  # Example (with thermal-zone):
> +  - |
> +    thermal-zones {
> +        cpu_thermal: cpu-thermal {
> +            polling-delay-passive = <1000>;
> +            polling-delay = <5000>;
> +
> +            thermal-sensors = <&thermal>;
> +
> +            trips {
> +                cpu-crit {
> +                    temperature = <115000>;
> +                    hysteresis = <0>;
> +                    type = "critical";
> +                };
> +            };
> +            cooling-maps {
> +            };
> +        };
> +    };
> +
> +    thermal: thermal@e61f0000 {
> +        compatible = "renesas,thermal-r8a7790",
> +                     "renesas,rcar-gen2-thermal",
> +                     "renesas,rcar-thermal";
> +        reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
> +        interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&mstp5_clks R8A7790_CLK_THERMAL>;
> +        power-domains = <&cpg_clocks>;
> +        #thermal-sensor-cells = <0>;
> +    };
> -- 
> 2.11.0
> 
