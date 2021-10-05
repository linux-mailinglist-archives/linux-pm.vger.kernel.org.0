Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACADF423172
	for <lists+linux-pm@lfdr.de>; Tue,  5 Oct 2021 22:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhJEUSV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 16:18:21 -0400
Received: from sibelius.xs4all.nl ([83.163.83.176]:50367 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhJEUSV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Oct 2021 16:18:21 -0400
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id 3b738dd1;
        Tue, 5 Oct 2021 22:16:28 +0200 (CEST)
Date:   Tue, 5 Oct 2021 22:16:28 +0200 (CEST)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-arm-kernel@lists.infradead.org, marcan@marcan.st,
        maz@kernel.org, robh+dt@kernel.org, arnd@kernel.org,
        linus.walleij@linaro.org, alyssa@rosenzweig.io, krzk@kernel.org,
        gregkh@linuxfoundation.org, p.zabel@pengutronix.de,
        rafael@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20211005155923.173399-3-marcan@marcan.st> (message from Hector
        Martin on Wed, 6 Oct 2021 00:59:18 +0900)
Subject: Re: [PATCH 2/7] dt-bindings: power: Add apple,pmgr-pwrstate binding
References: <20211005155923.173399-1-marcan@marcan.st> <20211005155923.173399-3-marcan@marcan.st>
Message-ID: <d3ca3bcc44156f32@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> From: Hector Martin <marcan@marcan.st>
> Date: Wed,  6 Oct 2021 00:59:18 +0900
> 
> This syscon child node represents a single SoC device controlled by the
> PMGR block. This layout allows us to declare all device power state
> controls (power/clock gating and reset) in the device tree, including
> dependencies, instead of hardcoding it into the driver. The register
> layout is uniform.
> 
> Each pmgr-pwrstate node provides genpd and reset features, to be
> consumed by downstream device nodes.
> 
> Future SoCs are expected to use backwards compatible registers, and the
> "apple,pmgr-pwrstate" represents any such interfaces (possibly with
> additional features gated by the more specific compatible), allowing
> them to be bound without driver updates. If a backwards incompatible
> change is introduced in future SoCs, it will require a new compatible,
> such as "apple,pmgr-pwrstate-v2".

Or we drop the apple,mpgr-pwrstate and go with only SoC-specific
compatibles from that point onwards.

> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  .../bindings/power/apple,pmgr-pwrstate.yaml   | 117 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 118 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml

This works for U-Boot.  Didn't write an OpenBSD driver yet but it
should work there as well.

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>


> diff --git a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
> new file mode 100644
> index 000000000000..a14bf5f30ff0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
> @@ -0,0 +1,117 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/apple,pmgr-pwrstate.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple SoC PMGR Power States
> +
> +maintainers:
> +  - Hector Martin <marcan@marcan.st>
> +
> +allOf:
> +  - $ref: "power-domain.yaml#"
> +
> +description: |
> +  Apple SoCs include a PMGR block responsible for power management,
> +  which can control various clocks, resets, power states, and
> +  performance features. This binding describes the device power
> +  state registers, which control power states and resets.
> +
> +  Each instance of a power controller within the PMGR syscon node
> +  represents a generic power domain provider, as documented in
> +  Documentation/devicetree/bindings/power/power-domain.yaml.
> +  The provider controls a single SoC block. The power hierarchy is
> +  represented via power-domains relationships between these nodes.
> +
> +  See Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
> +  for the top-level PMGR node documentation.
> +
> +  IP cores belonging to a power domain should contain a
> +  "power-domains" property that is a phandle for the
> +  power domain node representing the domain.
> +
> +properties:
> +  $nodename:
> +    pattern: "^power-controller@[0-9a-f]+$"
> +
> +  compatible:
> +    items:
> +      - enum:
> +          - apple,t8103-pmgr-pwrstate
> +      - const: apple,pmgr-pwrstate
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#power-domain-cells":
> +    const: 0
> +
> +  "#reset-cells":
> +    const: 0
> +
> +  power-domains:
> +    description:
> +      Reference to parent power domains. A domain may have multiple parents,
> +      and all will be powered up when it is powered.
> +
> +  apple,domain-name:
> +    description: |
> +      Specifies the name of the SoC device being controlled. This is used to
> +      name the power/reset domains.
> +    $ref: /schemas/types.yaml#/definitions/string
> +
> +  apple,always-on:
> +    description: |
> +      Forces this power domain to always be powered up.
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#power-domain-cells"
> +  - "#reset-cells"
> +  - "apple,domain-name"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        power-management@23b700000 {
> +            compatible = "apple,t8103-pmgr", "apple,pmgr", "syscon", "simple-mfd";
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            reg = <0x2 0x3b700000 0x0 0x14000>;
> +
> +            ps_sio: power-controller@1c0 {
> +                compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
> +                reg = <0x1c0>;
> +                #power-domain-cells = <0>;
> +                #reset-cells = <0>;
> +                apple,domain-name = "sio";
> +                apple,always-on;
> +            };
> +
> +            ps_uart_p: power-controller@220 {
> +                compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
> +                reg = <0x220>;
> +                #power-domain-cells = <0>;
> +                #reset-cells = <0>;
> +                apple,domain-name = "uart_p";
> +                power-domains = <&ps_sio>;
> +            };
> +
> +            ps_uart0: power-controller@270 {
> +                compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
> +                reg = <0x270>;
> +                #power-domain-cells = <0>;
> +                #reset-cells = <0>;
> +                apple,domain-name = "uart0";
> +                power-domains = <&ps_uart_p>;
> +            };
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d25598842d15..5fe53d9a2956 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1722,6 +1722,7 @@ F:	Documentation/devicetree/bindings/arm/apple.yaml
>  F:	Documentation/devicetree/bindings/arm/apple/*
>  F:	Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
>  F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
> +F:	Documentation/devicetree/bindings/power/apple*
>  F:	arch/arm64/boot/dts/apple/
>  F:	drivers/irqchip/irq-apple-aic.c
>  F:	include/dt-bindings/interrupt-controller/apple-aic.h
> -- 
> 2.33.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
