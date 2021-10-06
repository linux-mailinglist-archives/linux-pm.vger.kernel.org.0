Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADFA42354B
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 02:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237056AbhJFBAw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 21:00:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231582AbhJFBAv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 5 Oct 2021 21:00:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85D5A6126A;
        Wed,  6 Oct 2021 00:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633481940;
        bh=4KxeoPX5kMqjbGIp6gHdEzoQ6BewWpSdOHHIbtMjaWY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fbBdYJPgp/9F6i/OT7PKm6vBl3pkk1EIHpu90jK//CIN2rOaMl88bqFNAO3OjYSGd
         TRcs57/llWVRoZT+hNBf9vjje7r0wjt5WOjW7oV7Y5B4CCn7bzhYtQ34+wrXlxX7nG
         ZGHuZlBye13kA2vKEmSB8QE7fK/kD8XxpXOZDFIPELDilfztvNd4mRFzItKzu+wmHg
         b9pUtcecDQp/biI6ZZcsYZbHSQCh260UsIO6G6WPKB6M4y3RmLVKR4QFKHlUqn4kqV
         vgTiGDP9hjPpKC8L/vTHdBBjkiZPTorsg3PmPyxse8SiTBrubdqKGZUY3iaasgGnMp
         UwesYMZC8lzcw==
Received: by mail-qv1-f42.google.com with SMTP id k3so833371qve.10;
        Tue, 05 Oct 2021 17:59:00 -0700 (PDT)
X-Gm-Message-State: AOAM531b8xWFJJDWAgKOTkj4vO+B/DKipVGOuBqWLBki5GEv65RJcvbD
        ad+ejfPFZ4tsYZGHyXggiNvKz7vAiKQMHl+r5Q==
X-Google-Smtp-Source: ABdhPJxjQlA/cp+FzqvM3EyDTi6JQ+slebysicqoFFjo2B8R23fH2Q6TTZ4610qSLDb8glKceWIDWpOKx454V2zvMS8=
X-Received: by 2002:a0c:f383:: with SMTP id i3mr9895650qvk.0.1633481939670;
 Tue, 05 Oct 2021 17:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211005155923.173399-1-marcan@marcan.st> <20211005155923.173399-3-marcan@marcan.st>
In-Reply-To: <20211005155923.173399-3-marcan@marcan.st>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 5 Oct 2021 19:58:24 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJenHAOw4gApzGpuj-8nZjkYhmBg0qBj-DV+CEJ7zXuVw@mail.gmail.com>
Message-ID: <CAL_JsqJenHAOw4gApzGpuj-8nZjkYhmBg0qBj-DV+CEJ7zXuVw@mail.gmail.com>
Subject: Re: [PATCH 2/7] dt-bindings: power: Add apple,pmgr-pwrstate binding
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 5, 2021 at 10:59 AM Hector Martin <marcan@marcan.st> wrote:
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

Is that because past SoCs used the same registers? I don't see how
else you have any insight to what future SoCs will do.

Normally we don't do 1 node per register type bindings, so I'm a bit
leery about doing 1 node per domain.

>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  .../bindings/power/apple,pmgr-pwrstate.yaml   | 117 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 118 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
>
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

Drop this and define this node in the syscon schema with a $ref to this schema.

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

No other power domain binding needs this, why do you?

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

I prefer 1 complete example in the MFD schema rather than piecemeal examples.

> +  - |
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        power-management@23b700000 {
> +            compatible = "apple,t8103-pmgr", "apple,pmgr", "syscon", "simple-mfd";
> +            #address-cells = <1>;
> +            #size-cells = <0>;

As the child nodes are memory mapped devices, size should be 1. Then
address translation works (though Linux doesn't care (currently)).

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
> @@ -1722,6 +1722,7 @@ F:        Documentation/devicetree/bindings/arm/apple.yaml
>  F:     Documentation/devicetree/bindings/arm/apple/*
>  F:     Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
>  F:     Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
> +F:     Documentation/devicetree/bindings/power/apple*
>  F:     arch/arm64/boot/dts/apple/
>  F:     drivers/irqchip/irq-apple-aic.c
>  F:     include/dt-bindings/interrupt-controller/apple-aic.h
> --
> 2.33.0
>
