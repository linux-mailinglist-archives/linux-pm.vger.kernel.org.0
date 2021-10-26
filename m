Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5484B43B98C
	for <lists+linux-pm@lfdr.de>; Tue, 26 Oct 2021 20:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238278AbhJZSaM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Oct 2021 14:30:12 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:41723 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbhJZSaI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Oct 2021 14:30:08 -0400
Received: by mail-ot1-f49.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so18550570ote.8;
        Tue, 26 Oct 2021 11:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eFp4CK/cIp2DpF9Nk6vMYc4k/uaKBP5Bf1YLZsAxfy8=;
        b=00NkxEJKPSGLo7KVpbXcVHThJAGIjZf0j6sV2wvSbse8/G3VehtBvhTC1fV/PTpFn5
         SzNQTElO05kGwFWbIbj88upTYdqdJDr3+bYVRsHBfq/9rfNIdYtaG8kcqoaFpmKLwc+d
         O4In8eDkTlFHYZ7gKHfw6p5nO8bhextz0F/ZHpnWQBNN/b8JUWJw+AfrFX8X+2lQ8C8l
         tehufxoh1vZ2XIBUzeXUg6m/O2GkN48j/0yzv0XNzUDcn8xqej5jroWVSyGh2uwwIBPZ
         GFcjs8RxW6nmsc+NmaWr2icTIKCZfqB6c6BK8koY93jA14aqFOk/U+julh4rh+EIVjYa
         H+Qw==
X-Gm-Message-State: AOAM531wBYYC+S8gKtAGXxfcMukTsAsA9OBVLovnIPxhRzeIC3FBrDla
        36UGqVIrLc/ePuZYGE6RCYsjdX5GtA==
X-Google-Smtp-Source: ABdhPJwAI3IRkPjjJ3d2IqWje3ojRvX5pfch4KRIpOaHwTTrfF7i8XPhD1CUStoVg+jiE/yJp6STeA==
X-Received: by 2002:a9d:6c8b:: with SMTP id c11mr4829768otr.50.1635272863827;
        Tue, 26 Oct 2021 11:27:43 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w9sm4701797otp.64.2021.10.26.11.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 11:27:43 -0700 (PDT)
Received: (nullmailer pid 2979460 invoked by uid 1000);
        Tue, 26 Oct 2021 18:27:41 -0000
Date:   Tue, 26 Oct 2021 13:27:41 -0500
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
Subject: Re: [PATCH v2 3/8] dt-bindings: power: Add apple,pmgr-pwrstate
 binding
Message-ID: <YXhInb5kWO15YL7W@robh.at.kernel.org>
References: <20211025144718.157794-1-marcan@marcan.st>
 <20211025144718.157794-4-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025144718.157794-4-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 25, 2021 at 11:47:13PM +0900, Hector Martin wrote:
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
> 
> Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  .../bindings/power/apple,pmgr-pwrstate.yaml   | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
> new file mode 100644
> index 000000000000..010f8b641304
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
> @@ -0,0 +1,69 @@
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
> +properties:
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
> +    minItems: 1
> +
> +  label:
> +    description: |
> +      Specifies the name of the SoC domain being controlled. This is used to
> +      name the power/reset domains.
> +
> +  apple,always-on:
> +    description: |

Can drop '|' on these too. Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> +      Forces this power domain to always be powered up.
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#power-domain-cells"
> +  - "#reset-cells"
> +  - label
> +
> +additionalProperties: false
> -- 
> 2.33.0
> 
> 
