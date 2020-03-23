Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90F75190037
	for <lists+linux-pm@lfdr.de>; Mon, 23 Mar 2020 22:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgCWVYe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Mar 2020 17:24:34 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39839 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgCWVYe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Mar 2020 17:24:34 -0400
Received: by mail-io1-f66.google.com with SMTP id c19so15956034ioo.6;
        Mon, 23 Mar 2020 14:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IRECHsQOOrgQyWV/3xEmgvKFUSzN/LifFmNxePf9bz8=;
        b=uKGm7zPcnM4WWCnrobKZwG9jWkyW0BDdPZt2WZqlcTjJ41g2Uho8Sk64ffeS1h6qLX
         LMCR98J4zMiOcdrTpKnLZeBhX6JDnXgBMDjTOQHVpLZUpj4TF7rwFBLMtL+IhY9LqRUn
         Kmh8NVarXsG1egtZw9chvst3ldCpUIJBkjtV9r4+1zPO4GxJEEc1gPU9xMkLO0qRckNx
         qSIeQgAAJ9Hs5+DbCs7EXvnhRkoYfj7N0IhPIii1Q5SJsLcgJbODRlL3cRWd9zx2spcM
         R0wmLX9RA93E6DZhimxiuBfoe6uMC3Rw6mC08VzpC6+5Fcel9yHOXtb4ogotFS6o6/3l
         QcMQ==
X-Gm-Message-State: ANhLgQ3QqOIO7gccniE1gnZtUhFodNzw+wzp2mQYH9nEwdWvleWJuG99
        /veI+xWS4wAWzCpFaVPcAA==
X-Google-Smtp-Source: ADFU+vvmF4CWObCriC4Olv0j6Sf6BBLPzdfMZD6B8Y4E7nrkdF7M2+1ItVHAuvZeWVlMi2eKDAPNoA==
X-Received: by 2002:a05:6638:24c:: with SMTP id w12mr8177512jaq.42.1584998672760;
        Mon, 23 Mar 2020 14:24:32 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id u77sm5662926ili.35.2020.03.23.14.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 14:24:32 -0700 (PDT)
Received: (nullmailer pid 6554 invoked by uid 1000);
        Mon, 23 Mar 2020 21:24:30 -0000
Date:   Mon, 23 Mar 2020 15:24:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: thermal: rcar-gen3-thermal: Convert
 bindings to json-schema
Message-ID: <20200323212430.GA11881@bogus>
References: <20200310001255.1425662-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200310001255.1425662-1-niklas.soderlund+renesas@ragnatech.se>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 10, 2020 at 01:12:55AM +0100, Niklas Söderlund wrote:
> Convert Renesas R-Car Gen3 Thermal bindings documentation to
> json-schema.

Mostly looks fine, but I'd like to make sure this works with the common 
binding Amit is converting. I see one issue with that.

> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> ---
>  .../bindings/thermal/rcar-gen3-thermal.txt    | 59 ------------
>  .../bindings/thermal/rcar-gen3-thermal.yaml   | 96 +++++++++++++++++++
>  2 files changed, 96 insertions(+), 59 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
> deleted file mode 100644
> index 12c740b975f78690..0000000000000000
> --- a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
> +++ /dev/null
> @@ -1,59 +0,0 @@
> -* DT bindings for Renesas R-Car Gen3 Thermal Sensor driver
> -
> -On R-Car Gen3 SoCs, the thermal sensor controllers (TSC) control the thermal
> -sensors (THS) which are the analog circuits for measuring temperature (Tj)
> -inside the LSI.
> -
> -Required properties:
> -- compatible		: "renesas,<soctype>-thermal",
> -			  Examples with soctypes are:
> -			    - "renesas,r8a774a1-thermal" (RZ/G2M)
> -			    - "renesas,r8a774b1-thermal" (RZ/G2N)
> -			    - "renesas,r8a7795-thermal" (R-Car H3)
> -			    - "renesas,r8a7796-thermal" (R-Car M3-W)
> -			    - "renesas,r8a77965-thermal" (R-Car M3-N)
> -			    - "renesas,r8a77980-thermal" (R-Car V3H)
> -- reg			: Address ranges of the thermal registers. Each sensor
> -			  needs one address range. Sorting must be done in
> -			  increasing order according to datasheet, i.e.
> -			  TSC1, TSC2, ...
> -- clocks		: Must contain a reference to the functional clock.
> -- #thermal-sensor-cells : must be <1>.
> -
> -Optional properties:
> -
> -- interrupts		: interrupts routed to the TSC (must be 3).
> -- power-domain		: Must contain a reference to the power domain. This
> -			  property is mandatory if the thermal sensor instance
> -			  is part of a controllable power domain.
> -
> -Example:
> -
> -	tsc: thermal@e6198000 {
> -		compatible = "renesas,r8a7795-thermal";
> -		reg = <0 0xe6198000 0 0x100>,
> -		      <0 0xe61a0000 0 0x100>,
> -		      <0 0xe61a8000 0 0x100>;
> -		interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&cpg CPG_MOD 522>;
> -		power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
> -		#thermal-sensor-cells = <1>;
> -	};
> -
> -	thermal-zones {
> -		sensor_thermal1: sensor-thermal1 {
> -			polling-delay-passive = <250>;
> -			polling-delay = <1000>;
> -			thermal-sensors = <&tsc 0>;
> -
> -			trips {
> -				sensor1_crit: sensor1-crit {
> -					temperature = <90000>;
> -					hysteresis = <2000>;
> -					type = "critical";
> -				};
> -			};
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
> new file mode 100644
> index 0000000000000000..4b605482f3e38735
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# Copyright (C) 2020 Renesas Electronics Corp.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/rcar-gen3-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas R-Car Gen3 Thermal Sensor
> +
> +description:
> +  On R-Car Gen3 SoCs, the thermal sensor controllers (TSC) control the thermal
> +  sensors (THS) which are the analog circuits for measuring temperature (Tj)
> +  inside the LSI.
> +
> +maintainers:
> +  - Niklas Söderlund <niklas.soderlund@ragnatech.se>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - renesas,r8a774a1-thermal # RZ/G2M
> +      - renesas,r8a774b1-thermal # RZ/G2N
> +      - renesas,r8a7795-thermal  # R-Car H3
> +      - renesas,r8a7796-thermal  # R-Car M3-W
> +      - renesas,r8a77965-thermal # R-Car M3-N
> +      - renesas,r8a77980-thermal # R-Car V3H
> +  reg:
> +    description:
> +      Address ranges of the thermal registers. Each sensor needs one address
> +      range. Sorting must be done in increasing order according to datasheet,

Generally, the order should be by function. I guess if each entry has 
the same set of registers (i.e. is homogeneous), then it doesn't matter.

> +      i.e. TSC1, TSC2, ...
> +    minItems: 1
> +    maxItems: 4
> +
> +  interrupts:
> +    minItems: 3
> +    maxItems: 3

Need to define what each one is.

> +
> +  clocks:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  "#thermal-sensor-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - power-domains
> +  - resets
> +  - "#thermal-sensor-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/r8a7795-cpg-mssr.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/power/r8a7795-sysc.h>
> +
> +    tsc: thermal@e6198000 {
> +            compatible = "renesas,r8a7795-thermal";
> +            reg = <0 0xe6198000 0 0x100>,
> +                  <0 0xe61a0000 0 0x100>,
> +                  <0 0xe61a8000 0 0x100>;
> +            interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&cpg CPG_MOD 522>;
> +            power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
> +            resets = <&cpg 522>;
> +            #thermal-sensor-cells = <1>;
> +    };
> +
> +    thermal-zones {
> +            sensor_thermal1: sensor-thermal1 {

Node names should end in '-thermal'.

> +                    polling-delay-passive = <250>;
> +                    polling-delay = <1000>;
> +                    thermal-sensors = <&tsc 0>;
> +
> +                    trips {
> +                            sensor1_crit: sensor1-crit {
> +                                    temperature = <90000>;
> +                                    hysteresis = <2000>;
> +                                    type = "critical";
> +                            };
> +                    };
> +            };
> +    };
> -- 
> 2.25.1
> 
