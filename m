Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC55429AD2
	for <lists+linux-pm@lfdr.de>; Tue, 12 Oct 2021 03:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbhJLBMG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Oct 2021 21:12:06 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:34539 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbhJLBMG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Oct 2021 21:12:06 -0400
Received: by mail-ot1-f53.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so23943787otb.1;
        Mon, 11 Oct 2021 18:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BHu3CTNJcW0DF5BNGHVDrnCULEBWgL3rBnbu71YErj0=;
        b=oP8+Vnuy2Qql5QtEAnwCBTqHXzM4YxL+KbETs+yHU/I9j202seqGxVY2AaxgSSNpeX
         gG0ppHpOffYjYtLVwQ5gogrXBpxXUfd7l2ZCD9iqbHCacKtvXvX1HvfeCcPxURNBF22q
         bu3JGkALhXd1Cjn8n5r0PZEd3ExqKdiKc+sbFx4MVV8Lz0iTHkC0wZPQRa6JjDo6fKqQ
         r2bsU/TR8dQA0+/TKoPlXjV3RE2EIhTrLzcvDpe6lhYwlAkhDLt6RQ11VU/bp3PnM+oV
         sGhZvR/7CC92sOyCFSAqhHMgsDNpKkOINIb6PoBtqi6W6sUo9FydvuQCgjWVY6Xm2UaA
         /lwA==
X-Gm-Message-State: AOAM532jtWgBhZoPyroXmvXykhkrcFlp8fslMm1951X9w3/EkzT4lsYe
        1ZSgwkT6MEQWsmxD19mbYQ==
X-Google-Smtp-Source: ABdhPJxO2NBWb5MDE8WhIKRdZ0dLfwhGnsFavfLIfI3dUuhOiwT1yihMphEvXIvtJSRbEL1vlHbnyQ==
X-Received: by 2002:a05:6830:351:: with SMTP id h17mr2967815ote.31.1634001005002;
        Mon, 11 Oct 2021 18:10:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e7sm1031364otq.4.2021.10.11.18.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 18:10:04 -0700 (PDT)
Received: (nullmailer pid 1519116 invoked by uid 1000);
        Tue, 12 Oct 2021 01:10:03 -0000
Date:   Mon, 11 Oct 2021 20:10:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] dt-bindings: arm: sunxi: Expand MBUS binding
Message-ID: <YWTga7XwvWAXoluU@robh.at.kernel.org>
References: <20211004012739.39053-1-samuel@sholland.org>
 <20211004012739.39053-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004012739.39053-3-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Oct 03, 2021 at 08:27:35PM -0500, Samuel Holland wrote:
> The MBUS provides more than address translation and bandwidth control.
> It also provides a PMU to measure bandwidth usage by certain masters,
> and it provides notification via IRQ when they are active or idle.
> 
> The MBUS is also tightly integrated with the DRAM controller to provide
> a Memory Dynamic Frequency Scaling (MDFS) feature. In view of this, the
> MBUS binding needs to represent the hardware resources needed for MDFS,
> which include the clocks and MMIO range of the adjacent DRAM controller.
> 
> Add the additional resources for the H3 and A64 compatibles, and a new
> example showing how they are used.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  .../arm/sunxi/allwinner,sun4i-a10-mbus.yaml   | 75 ++++++++++++++++++-
>  1 file changed, 72 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml b/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
> index e713a6fe4cf7..c1fb404d2fb3 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
> +++ b/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
> @@ -33,10 +33,33 @@ properties:
>        - allwinner,sun50i-a64-mbus
>  
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    items:
> +      - description: MBUS interconnect/bandwidth/PMU registers
> +      - description: DRAM controller/PHY registers
> +
> +  reg-names:
> +    items:
> +      - const: "mbus"
> +      - const: "dram"

Don't need quotes.

Is it your intention that reg-names has to have 2 entries. Usually we 
aren't that strict and 1 would be allowed (when reg has 1).

>  
>    clocks:
> +    minItems: 1
> +    items:
> +      - description: MBUS interconnect module clock
> +      - description: DRAM controller/PHY module clock
> +      - description: Register bus clock, shared by MBUS and DRAM
> +
> +  clock-names:
> +    items:
> +      - const: "mbus"
> +      - const: "dram"
> +      - const: "bus"
> +
> +  interrupts:
>      maxItems: 1
> +    description:
> +      MBUS PMU activity interrupt.
>  
>    dma-ranges:
>      description:
> @@ -53,13 +76,42 @@ required:
>    - clocks
>    - dma-ranges
>  
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - allwinner,sun8i-h3-mbus
> +          - allwinner,sun50i-a64-mbus
> +
> +then:
> +  properties:
> +    reg:
> +      minItems: 2
> +
> +    clocks:
> +      minItems: 3
> +
> +  required:
> +    - reg-names
> +    - clock-names
> +
> +else:
> +  properties:
> +    reg:
> +      maxItems: 1
> +
> +    clocks:
> +      maxItems: 1
> +
>  additionalProperties: false
>  
>  examples:
>    - |
> -    #include <dt-bindings/clock/sun5i-ccu.h>
> +    #include <dt-bindings/clock/sun50i-a64-ccu.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>  
> -    mbus: dram-controller@1c01000 {
> +    dram-controller@1c01000 {
>          compatible = "allwinner,sun5i-a13-mbus";
>          reg = <0x01c01000 0x1000>;
>          clocks = <&ccu CLK_MBUS>;
> @@ -69,4 +121,21 @@ examples:
>          #interconnect-cells = <1>;
>      };
>  
> +  - |
> +    dram-controller@1c62000 {
> +        compatible = "allwinner,sun50i-a64-mbus";
> +        reg = <0x01c62000 0x1000>,
> +              <0x01c63000 0x1000>;
> +        reg-names = "mbus", "dram";
> +        clocks = <&ccu CLK_MBUS>,
> +                 <&ccu CLK_DRAM>,
> +                 <&ccu CLK_BUS_DRAM>;
> +        clock-names = "mbus", "dram", "bus";
> +        interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        dma-ranges = <0x00000000 0x40000000 0xc0000000>;
> +        #interconnect-cells = <1>;
> +    };
> +
>  ...
> -- 
> 2.32.0
> 
> 
