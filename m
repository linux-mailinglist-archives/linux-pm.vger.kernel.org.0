Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C5B3AD291
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jun 2021 21:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbhFRTMZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Jun 2021 15:12:25 -0400
Received: from mail-oo1-f48.google.com ([209.85.161.48]:44604 "EHLO
        mail-oo1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235429AbhFRTMX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jun 2021 15:12:23 -0400
Received: by mail-oo1-f48.google.com with SMTP id o5-20020a4a2c050000b0290245d6c7b555so2687766ooo.11;
        Fri, 18 Jun 2021 12:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=daEJxXx4kGgQjf5gbnT7Q2a5f94zl/Y1PbDu72pCGuA=;
        b=C3cZdbiyOaUGxJdTspHFL+eBZNDpznXVJQS9UT919UQIbgfaWmo7SDpS+QPsed84l4
         KHciIjf42j4MFE9aHycHcidh8vwSE21EE0QjYDbKp0r60016t6cTAKpct8JHBTtt3bOe
         o+TGHKdHkZBsvH6sHy3sU/Gr22G3ZnwNbw4TFXnPrbQWe3TaSgRuNW15qsBhxlnBa0yj
         M4bb+l1sVJsmZJ5EIW1cKHBkRDz+N9otzJ9gTH+wLPwRKJ/pjHjIvDMAh5JDvmEuJZxJ
         YIQ8VZCznoc06nZi90WuKpL4VGFo3BcViFzgbN5mjHnkcqomGz8YMwU0/2MobN3r69IJ
         36qA==
X-Gm-Message-State: AOAM533DO3JeAsjy+8mQmujfZACra39pUv1y1Gc8z8RpwmYngZLkFfyj
        HAkzOncAa2h24l81PSQiUnYJwTHT+A==
X-Google-Smtp-Source: ABdhPJzYycg7M/u2vTWyigX0DR29r/E95lU8Z7lGuBbGyiTV0doykatrXGVzFhx4S8iGthmRHLvppQ==
X-Received: by 2002:a4a:d781:: with SMTP id c1mr10281257oou.23.1624043412611;
        Fri, 18 Jun 2021 12:10:12 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id v203sm1970825oie.52.2021.06.18.12.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 12:10:11 -0700 (PDT)
Received: (nullmailer pid 2636260 invoked by uid 1000);
        Fri, 18 Jun 2021 19:10:07 -0000
Date:   Fri, 18 Jun 2021 13:10:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ben Tseng <ben.tseng@mediatek.com>
Cc:     Fan Chen <fan.chen@mediatek.com>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, srv_heupstream@mediatek.com,
        Eduardo Valentin <edubezval@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, hsinyi@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Michael Kao <michael.kao@mediatek.com>
Subject: Re: [PATCH v5 3/3] dt-bindings: thermal: Add binding document for
 mt6873 thermal controller
Message-ID: <20210618191007.GA2633228@robh.at.kernel.org>
References: <20210617114707.10618-1-ben.tseng@mediatek.com>
 <20210617114707.10618-4-ben.tseng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617114707.10618-4-ben.tseng@mediatek.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 17, 2021 at 07:47:07PM +0800, Ben Tseng wrote:
> From: Michael Kao <michael.kao@mediatek.com>
> 
> This patch adds binding document for mt6873 thermal controller.
> 
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
> ---
> This patch depends on [1].
> 
> [1] https://patchwork.kernel.org/project/linux-mediatek/patch/20210524122053.17155-7-chun-jie.chen@mediatek.com/
> ---
> Feature: Thermal Management
> 
> Change-Id: Ibe06c699c6edc870aaee95170c3f182d1889472d
> ---
>  .../thermal/mediatek-thermal-lvts.yaml        | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml b/Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml
> new file mode 100644
> index 000000000000..69ffe7b14c21
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/mediatek-thermal-lvts.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek SoC LVTS thermal controller (DTS) binding
> +
> +maintainers:
> +  - Yu-Chia Chang <ethan.chang@mediatek.com>
> +  - Ben Tseng <ben.tseng@mediatek.com>
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt6873-lvts
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: lvts_clk

Not really a useful name. I'd just drop 'clock-names'.

> +
> +  "#thermal-sensor-cells":
> +    const: 0
> +
> +required:
> +  - "#thermal-sensor-cells"
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/thermal/thermal.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/mt8192-clk.h>
> +    dts: lvts@1100b000 {

thermal-sensor@...

> +        compatible = "mediatek,mt6873-lvts";
> +        reg = <0x1100b000 0x1000>;
> +        clocks = <&infracfg CLK_INFRA_THERM>;
> +        clock-names = "lvts_clk";
> +        #thermal-sensor-cells = <0>;
> +        interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
> +    };
> +
> +    thermal-zones {
> +        cpu_thermal: cpu-thermal {
> +            polling-delay-passive = <0>;
> +            polling-delay = <0>;
> +
> +            thermal-sensors = <&dts>;
> +            trips {
> +                cpu_alert1: cpu-alert1 {
> +                    temperature = <85000>;
> +                    hysteresis = <0>;
> +                    type = "passive";
> +                };
> +
> +                cpu_crit: cpu-crit {
> +                    temperature = <120000>;
> +                    hysteresis = <0>;
> +                    type = "critical";
> +                };
> +            };
> +
> +            cooling-maps {
> +            };
> +        };
> +    };
> +...
> -- 
> 2.18.0
> 
> 
