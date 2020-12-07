Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F5C2D1723
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 18:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgLGRIq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 12:08:46 -0500
Received: from mail-oo1-f65.google.com ([209.85.161.65]:40904 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgLGRIp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 12:08:45 -0500
Received: by mail-oo1-f65.google.com with SMTP id 9so678784ooy.7;
        Mon, 07 Dec 2020 09:08:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SogwgdPzZLs7UQaCL9uSzW/XvOBxKSbmidKt0mKHBqM=;
        b=aJx5WW/j4od1ZI/UXgIQFLm2qASM/Zs+X/uY5MhumaD91MFNDqkvd9MiesjSNeEj5I
         Er2DBOTLVDQFtoC36B9IoK4T8E36XK8GGhpLAAOq//BwwysjF+1D0JqBhwc/uk8/STb+
         EEJUP2CwqOjmG5k4qPBlK0RMUCmWMbQqUocW9FVZg2qEvBliE7TorbiLeNb6U1rH5Tos
         3EU7+o5LuZFwroRVHLAQeo9z8ris+/bD0yjALGk+v6YcZ8kB/8PRPFMfmj9/bNtupvEO
         y+CQdxduM94PgLednxPbYnQWEOxFYPtCMZRUXfavaSpp/RIEWnNGSfdHAF7s0ACNq7et
         dmDQ==
X-Gm-Message-State: AOAM530Y9xFUfMaI9LVU0z/oICLsfxZwpLme+2w/5dK/RZ8ft77zAjEr
        Yo8E1vCjagBPbTxA0Igl7A==
X-Google-Smtp-Source: ABdhPJzmdnrsrHxYVXf/qeAQGbpnlZ7/zYKbrxltqs4VunJ1rWtUE6YSlqOlmfjWhHbswR7eYMS+4w==
X-Received: by 2002:a4a:3e42:: with SMTP id t63mr1568149oot.32.1607360878900;
        Mon, 07 Dec 2020 09:07:58 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k13sm2929820otl.72.2020.12.07.09.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 09:07:58 -0800 (PST)
Received: (nullmailer pid 445307 invoked by uid 1000);
        Mon, 07 Dec 2020 17:07:56 -0000
Date:   Mon, 7 Dec 2020 11:07:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Kao <michael.kao@mediatek.com>
Cc:     ethan.chang@mediatek.com, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, srv_heupstream@mediatek.com,
        Eduardo Valentin <edubezval@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, hsinyi@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 3/3] dt-bindings: thermal: Add binding document for
 mt6873 thermal controller
Message-ID: <20201207170756.GB439416@robh.at.kernel.org>
References: <20201207063127.28051-1-michael.kao@mediatek.com>
 <20201207063127.28051-4-michael.kao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207063127.28051-4-michael.kao@mediatek.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 07, 2020 at 02:31:27PM +0800, Michael Kao wrote:
> This patch adds binding document for mt6873 thermal controller.
> 
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> ---
>  .../thermal/mediatek-thermal-lvts.yaml        | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml b/Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml
> new file mode 100644
> index 000000000000..745611718c0a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/mediatek-thermal-lvts.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek SoC LVTS thermal controller (DTS) binding
> +
> +maintainers:
> +  - Yu-Chia Chang <ethan.chang@mediatek.com>, Michael Kao <michael.kao@mediatek.com>

Not the right format. 1 email per entry.

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
