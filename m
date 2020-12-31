Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3942E818B
	for <lists+linux-pm@lfdr.de>; Thu, 31 Dec 2020 19:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgLaSNA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Dec 2020 13:13:00 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:39586 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgLaSNA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Dec 2020 13:13:00 -0500
Received: by mail-ot1-f43.google.com with SMTP id d8so18570881otq.6;
        Thu, 31 Dec 2020 10:12:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/baDFZ04WPKFvnGfg9yUbKzRdx2bFG5qizeKUagnLfM=;
        b=qmuSBmZFIIqoII7uW/dGOZZGdPJqzDKiY6B9VB4+QpkJm16X+JWd3Oak2ulzDu19RD
         OwhQV4A65gxQvr1WMdhmQcdmb6gQj8i4AtQ6vN+uEuM2Esw/ev9D0rOB5OH9o45182q8
         IzYvZX6mo4emXyc5UEw3roDEbarj3CZh47+iK0k3HWNIqoHoriWvdUtFQYjZJNRbcfjV
         RdYs4pXe9dvNc/lR0qglwyh/mCSxcecyANb5lUCrlCyiXJDdRWOGMhJY9k+0TiBOd7Cb
         id4dMXzpY5Zka+cAuJW0dAxImyt65GtSn+B6LQpiOii8i4XbFrvj7L0Q2ovGqMh5KyNX
         wgeg==
X-Gm-Message-State: AOAM530otzYDU9DxqFQIjts/80g/kOn4dWbFBQTiZJwBoy29pgtBrfGn
        mb0TR0xuA8LAqwIvsqx3KQ==
X-Google-Smtp-Source: ABdhPJyDkXZbrOTrCWfEFNlpNchpSRar2P16KYigEufXLX1WTb+p4jeWGh4MH2z99j4KVmakj2IaGA==
X-Received: by 2002:a05:6830:1c3d:: with SMTP id f29mr42876645ote.47.1609438338832;
        Thu, 31 Dec 2020 10:12:18 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id f25sm11147568oou.39.2020.12.31.10.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 10:12:17 -0800 (PST)
Received: (nullmailer pid 2074202 invoked by uid 1000);
        Thu, 31 Dec 2020 18:12:15 -0000
Date:   Thu, 31 Dec 2020 11:12:15 -0700
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
Subject: Re: [PATCH v10 1/7] [v10,1/7]: dt-bindings: soc: mediatek: add mtk
 svs dt-bindings
Message-ID: <20201231181215.GA1874134@robh.at.kernel.org>
References: <20201227105449.11452-1-roger.lu@mediatek.com>
 <20201227105449.11452-2-roger.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201227105449.11452-2-roger.lu@mediatek.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Dec 27, 2020 at 06:54:43PM +0800, Roger Lu wrote:
> Document the binding for enabling mtk svs on MediaTek SoC.
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> ---
>  .../bindings/soc/mediatek/mtk-svs.yaml        | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml b/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
> new file mode 100644
> index 000000000000..9c7da0acd82f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/mediatek/mtk-svs.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Introduce MTK SVS engine
> +
> +maintainers:
> +  - Matthias Brugger <matthias.bgg@gmail.com>
> +  - Kevin Hilman <khilman@kernel.org>
> +  - Nishanth Menon <nm@ti.com>
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

Drop. That doesn't really add anything.

> +    maxItems: 1
> +
> +  interrupts:
> +    description: IRQ for the MTK SVS controller.

Drop.

> +    maxItems: 1
> +
> +  clocks:
> +    description: Main clock for MTK SVS controller to work.

Drop, but you need:

maxItems: 1

> +
> +  clock-names:
> +    const: main
> +
> +  nvmem-cells:
> +    maxItems: 2
> +    description:
> +      Phandle to the calibration data provided by a nvmem device.

Drop.

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
> +    svs: svs@1100b000 {
> +        compatible = "mediatek,mt8183-svs";
> +        reg = <0 0x1100b000 0 0x1000>;
> +        interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_LOW>;
> +        clocks = <&infracfg CLK_INFRA_THERM>;
> +        clock-names = "main";
> +        nvmem-cells = <&svs_calibration>, <&thermal_calibration>;
> +        nvmem-cell-names = "svs-calibration-data", "t-calibration-data";
> +    };
> -- 
> 2.18.0
> 
