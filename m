Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF782F3333
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jan 2021 15:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbhALOsK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jan 2021 09:48:10 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:37409 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbhALOsK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2021 09:48:10 -0500
Received: by mail-oi1-f170.google.com with SMTP id l207so2570712oib.4;
        Tue, 12 Jan 2021 06:47:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fM7xQp3erzKr1NA4fTfzZcmXzvgc/peYjgAUUn7uWyw=;
        b=dO+eLV64q95puXhnJW8gF5hx386tbnZCSRKfsDQ7OAUt+cvWk/+EBIrS3/9kKTtOoq
         fS+kPN01DEtMaQqd57jAtKxGph4zrkHEGe23O+3zIgcENIuNGwdjEUx69m0NhHww2XJE
         +BBSa0OcwTz9Eb/F8wty20/AL+O5QB0G15tOe86Be1S39yAmgbc5F/SBzNzWryX349jk
         zeYDCtO8eGE4soLcKQPSpKiPGR2qZs/yZ7MCChonZuCCUcoA1MUV7zYf4Qqf0vib5X2U
         FIgtTSvdEUN/3OEH1jxKiY8TS4gCa4uM/1nPDrOYsVEsCCeboiuAwsAmxcb6tfM/HT/G
         ed4w==
X-Gm-Message-State: AOAM533x+shEmvf5QuAvgFrMQ+XUmOz/wIMJ/j1wAsjI0fIQgx5SBw8J
        O4BrEBB/XZF2g4lPBO7N6Q==
X-Google-Smtp-Source: ABdhPJwcZgbwzeRahJPpZSMpiaWcIjlcHI6CPeiAiAqPyp/VNO1VZhfwn95148OOQWTPVBTGqP0F0Q==
X-Received: by 2002:aca:af8b:: with SMTP id y133mr2510768oie.87.1610462849269;
        Tue, 12 Jan 2021 06:47:29 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y12sm403965oti.0.2021.01.12.06.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 06:47:28 -0800 (PST)
Received: (nullmailer pid 327562 invoked by uid 1000);
        Tue, 12 Jan 2021 14:47:27 -0000
Date:   Tue, 12 Jan 2021 08:47:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Roger Lu <roger.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v11 1/7] dt-bindings: soc: mediatek: add mtk svs
 dt-bindings
Message-ID: <20210112144727.GA321805@robh.at.kernel.org>
References: <20210107024356.583-1-roger.lu@mediatek.com>
 <20210107024356.583-2-roger.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107024356.583-2-roger.lu@mediatek.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 07, 2021 at 10:43:50AM +0800, Roger Lu wrote:
> Document the binding for enabling mtk svs on MediaTek SoC.
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> ---
>  .../bindings/soc/mediatek/mtk-svs.yaml        | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml b/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
> new file mode 100644
> index 000000000000..bb8c345a0c0a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/mediatek/mtk-svs.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Introduce MTK SVS engine

Introduce? That's what this commit does, not what this binding is.

> +
> +maintainers:
> +  - Matthias Brugger <matthias.bgg@gmail.com>
> +  - Kevin Hilman <khilman@kernel.org>
> +  - Nishanth Menon <nm@ti.com>

This should be someone that knows the h/w. Not who applies patches. 
Perhaps you.

> +
> +description: |+
> +  The Smart Voltage Scaling(SVS) engine is a piece of hardware
> +  which has several controllers(banks) for calculating suitable
> +  voltage to different power domains(CPU/GPU/CCI) according to
> +  chip process corner, temperatures and other factors. Then DVFS
> +  driver could apply SVS bank voltage to PMIC/Buck.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt8183-svs
> +
> +  reg:
> +    description: Address range of the MTK SVS controller.
> +    maxItems: 1
> +
> +  interrupts:
> +    description: IRQ for the MTK SVS controller.

Drop. That's kind of obvious with only 1 interrupt.

> +    maxItems: 1
> +
> +  clocks:
> +    description: Main clock for MTK SVS controller to work.

How many clocks (maxItems)?

> +
> +  clock-names:
> +    const: main
> +
> +  nvmem-cells:
> +    maxItems: 2
> +    description:
> +      Phandle to the calibration data provided by a nvmem device.

Need to define what each entry is.

items:
  - description: ...
  - description: ...

> +
> +  nvmem-cell-names:
> +    items:
> +      - const: svs-calibration-data
> +      - const: t-calibration-data
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - nvmem-cells
> +  - nvmem-cell-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8183-clk.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        svs@1100b000 {
> +            compatible = "mediatek,mt8183-svs";
> +            reg = <0 0x1100b000 0 0x1000>;
> +            interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_LOW>;
> +            clocks = <&infracfg CLK_INFRA_THERM>;
> +            clock-names = "main";
> +            nvmem-cells = <&svs_calibration>, <&thermal_calibration>;
> +            nvmem-cell-names = "svs-calibration-data", "t-calibration-data";
> +        };
> +    };
> -- 
> 2.18.0
> 
