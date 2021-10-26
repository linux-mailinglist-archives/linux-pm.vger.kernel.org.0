Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7879F43B97F
	for <lists+linux-pm@lfdr.de>; Tue, 26 Oct 2021 20:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbhJZS2Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Oct 2021 14:28:24 -0400
Received: from mail-oo1-f50.google.com ([209.85.161.50]:44030 "EHLO
        mail-oo1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbhJZS2W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Oct 2021 14:28:22 -0400
Received: by mail-oo1-f50.google.com with SMTP id w9-20020a4adec9000000b002b696945457so25912oou.10;
        Tue, 26 Oct 2021 11:25:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WSZr1Cmv5ob/1Jiww/LXg4dCpeepOagUPfg8Il8gYuM=;
        b=EePtaPGOB3J6o8dj0UURnEuTcInpq2bXJ87761mwopUBKcFb0t2zqwohMmih/Ybr2q
         YtgZkletKUWQqTH6q6ZPm/rUuVpDUmvtZVEMXkFXeQvJn1uE4pijYxWwPyBgvw8CXIPz
         6HPZg63JaJVBP5Si2b7JSNGfgijRA1skphW1Fl0dbq/ctO1G18izmKYMI+WSRAAaFVbq
         qOaN3kkqgl61zqzJcOT+y6AuubIPYj/SwkK9uhifJdT8TnOdu930/DZojGWgBIgD15iS
         YzTxzI5bF04dZf8bqCP05cGKn9U0op+ep4wQwur+3ztD51pGhmpadX0AQPnNUCJ59smW
         QwLQ==
X-Gm-Message-State: AOAM5327H2C0YkZySlkZ0sCeurc98DdkKtF0xpZacKZ0/a0mHNEigGoM
        Yz7WOHxXm2+HVLKpCoA4ODnv1PbUow==
X-Google-Smtp-Source: ABdhPJyNyn/Hk6PjVvlo5IisYehjIBhdvSvZfsFty86k1Vn1vTJ5hS3CpO+0wtZQ56jT9ipU94EjHQ==
X-Received: by 2002:a4a:d1c8:: with SMTP id a8mr2579386oos.12.1635272758233;
        Tue, 26 Oct 2021 11:25:58 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x12sm4045585oot.6.2021.10.26.11.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 11:25:57 -0700 (PDT)
Received: (nullmailer pid 2976480 invoked by uid 1000);
        Tue, 26 Oct 2021 18:25:56 -0000
Date:   Tue, 26 Oct 2021 13:25:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>
Subject: Re: [PATCH v2 2/8] dt-bindings: arm: apple: Add apple,pmgr binding
Message-ID: <YXhINE00HG6hbQI4@robh.at.kernel.org>
References: <20211025144718.157794-1-marcan@marcan.st>
 <20211025144718.157794-3-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025144718.157794-3-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 25, 2021 at 11:47:12PM +0900, Hector Martin wrote:
> The PMGR block in Apple Silicon SoCs is responsible for SoC power
> management. There are two PMGRs in T8103, with different register
> layouts but compatible registers. In order to support this as well
> as future SoC generations with backwards-compatible registers, we
> declare these blocks as syscons and bind to individual registers
> in child nodes. Each register controls one SoC device.
> 
> The respective apple compatibles are defined in case device-specific
> quirks are necessary in the future, but currently these nodes are
> expected to be bound by the generic syscon driver.
> 
> Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  .../bindings/arm/apple/apple,pmgr.yaml        | 149 ++++++++++++++++++
>  1 file changed, 149 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
> new file mode 100644
> index 000000000000..e8b7776163fc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
> @@ -0,0 +1,149 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/apple/apple,pmgr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple SoC Power Manager (PMGR)
> +
> +maintainers:
> +  - Hector Martin <marcan@marcan.st>
> +
> +description: |
> +  Apple SoCs include a PMGR block responsible for power management,
> +  which can control various clocks, resets, power states, and
> +  performance features. This node represents the PMGR as a syscon,
> +  with sub-nodes representing individual features.
> +
> +  Apple SoCs may have a secondary "mini-PMGR"; it is represented
> +  separately in the device tree, but works the same way.
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - apple,t8103-pmgr
> +          - apple,t8103-minipmgr
> +          - apple,pmgr

You shouldn't need this. The default select will filter out syscon and 
simple-mfd.

> +
> +  required:
> +    - compatible
> +
> +properties:
> +  $nodename:
> +    pattern: "^power-management@[0-9a-f]+$"
> +
> +  compatible:
> +    items:
> +      - enum:
> +          - apple,t8103-pmgr
> +          - apple,t8103-minipmgr
> +      - const: apple,pmgr
> +      - const: syscon
> +      - const: simple-mfd


'simple-mfd' means 'there's nothing in this node that any of the child 
nodes depend on'. You should be somewhat certain as dropping it later 
creates compatibility issues.

> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +patternProperties:
> +  "power-controller@[0-9a-f]+$":
> +    description: |

Don't need '|' if no formatting to preserve.

> +      The individual power management domains within this controller
> +    type: object
> +    $ref: /power/apple,pmgr-pwrstate.yaml#
> +
> +required:
> +  - compatible
> +  - reg
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
> +            #size-cells = <1>;
> +            reg = <0x2 0x3b700000 0x0 0x14000>;
> +
> +            ps_sio: power-controller@1c0 {
> +                compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
> +                reg = <0x1c0 8>;
> +                #power-domain-cells = <0>;
> +                #reset-cells = <0>;
> +                label = "sio";
> +                apple,always-on;
> +            };
> +
> +            ps_uart_p: power-controller@220 {
> +                compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
> +                reg = <0x220 8>;
> +                #power-domain-cells = <0>;
> +                #reset-cells = <0>;
> +                label = "uart_p";
> +                power-domains = <&ps_sio>;
> +            };
> +
> +            ps_uart0: power-controller@270 {
> +                compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
> +                reg = <0x270 8>;
> +                #power-domain-cells = <0>;
> +                #reset-cells = <0>;
> +                label = "uart0";
> +                power-domains = <&ps_uart_p>;
> +            };
> +        };
> +
> +        power-management@23d280000 {
> +            compatible = "apple,t8103-minipmgr", "apple,pmgr", "syscon", "simple-mfd";
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +            reg = <0x2 0x3d280000 0x0 0xc000>;
> +
> +            ps_aop_filter: power-controller@4000 {
> +                compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
> +                reg = <0x4000 8>;
> +                #power-domain-cells = <0>;
> +                #reset-cells = <0>;
> +                label = "aop_filter";
> +            };
> +
> +            ps_aop_base: power-controller@4010 {
> +                compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
> +                reg = <0x4010 8>;
> +                #power-domain-cells = <0>;
> +                #reset-cells = <0>;
> +                label = "aop_base";
> +                power-domains = <&ps_aop_filter>;
> +            };
> +
> +            ps_aop_shim: power-controller@4038 {
> +                compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
> +                reg = <0x4038 8>;
> +                #power-domain-cells = <0>;
> +                #reset-cells = <0>;
> +                label = "aop_shim";
> +                power-domains = <&ps_aop_base>;
> +            };
> +
> +            ps_aop_uart0: power-controller@4048 {
> +                compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
> +                reg = <0x4048 8>;
> +                #power-domain-cells = <0>;
> +                #reset-cells = <0>;
> +                label = "aop_uart0";
> +                power-domains = <&ps_aop_shim>;
> +            };
> +        };
> +    };
> -- 
> 2.33.0
> 
> 
