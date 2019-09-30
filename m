Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98F24C2223
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 15:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbfI3Nfv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 09:35:51 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41209 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbfI3Nfv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2019 09:35:51 -0400
Received: by mail-oi1-f196.google.com with SMTP id w17so11092680oiw.8;
        Mon, 30 Sep 2019 06:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a9jR1BNKDDZGZvIL5lhodG0XnQTe5HRm6UzcjXJdIrE=;
        b=ZD7c2trCFm35L1fJ3YCTdHFNIz4hNjr0XpWFhv6sMWPJmeW9jUypB8uY1phogYFYYR
         Yxao9vB+AzeCkrlrUWru6uTI0LLRcdF3OKffHhxQi5WVwnLNlOZhFk8WDFdsgqKaXL2Q
         vQ+j2McWcD6KEnzru760G6bj0fbu/RXrw1pgO5BpiX0xpuybyo+TMEvwQdoT3bMLdstk
         0QkNVpc2kDTDRkrGdUsi80FiLA8YWtINJFWLGhJlYL550XcBWnDPHkvk7nAL9pexQ4+D
         wKg+Nqk2+7u8gYKUuVTSFtMKEwm9DfCYi6l6lswnlUfQ5crYKOgGzJDYOZRTdl9WjloI
         yqtw==
X-Gm-Message-State: APjAAAU3P2tCiM+zB4jDTS3uk+++9DXQF4GSCugrSf4ev3rqUDI7Ywq+
        8VGfvuO2nOnSh1+FhKVZVw==
X-Google-Smtp-Source: APXvYqz7v38Yb3gdAuwcC3Pdow5jowdh8vbv74h20x1h3izlQLTP8SfiZeKSqNctH5OMmF/elaB/Rg==
X-Received: by 2002:aca:cf13:: with SMTP id f19mr17629022oig.154.1569850549773;
        Mon, 30 Sep 2019 06:35:49 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 11sm3864751otg.62.2019.09.30.06.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 06:35:49 -0700 (PDT)
Date:   Mon, 30 Sep 2019 08:35:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Roger Lu <roger.lu@mediatek.com>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>, yt.lee@mediatek.com,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: soc: add mtk svs dt-bindings
Message-ID: <20190930133548.GA24574@bogus>
References: <20190906100514.30803-1-roger.lu@mediatek.com>
 <20190906100514.30803-2-roger.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906100514.30803-2-roger.lu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 06, 2019 at 06:05:13PM +0800, Roger Lu wrote:
> Document the binding for enabling mtk svs on MediaTek SoC.
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> ---
>  .../devicetree/bindings/power/mtk-svs.txt     | 88 +++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/mtk-svs.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/mtk-svs.txt b/Documentation/devicetree/bindings/power/mtk-svs.txt
> new file mode 100644
> index 000000000000..6a71992ef162
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/mtk-svs.txt
> @@ -0,0 +1,88 @@
> +* Mediatek Smart Voltage Scaling (MTK SVS)
> +
> +This describes the device tree binding for the MTK SVS controller (bank)
> +which helps provide the optimized CPU/GPU/CCI voltages. This device also
> +needs thermal data to calculate thermal slope for accurately compensate
> +the voltages when temperature change.
> +
> +Required properties:
> +- compatible:
> +  - "mediatek,mt8183-svs" : For MT8183 family of SoCs
> +- reg: Address range of the MTK SVS controller.
> +- interrupts: IRQ for the MTK SVS controller.
> +- clocks, clock-names: Clocks needed for the svs controller. required
> +                       clocks are:
> +		       "main_clk": Main clock needed for register access

'_clk' is redundant.

> +- nvmem-cells: Phandle to the calibration data provided by a nvmem device.
> +- nvmem-cell-names: Should be "svs-calibration-data" and "calibration-data"
> +
> +Subnodes:
> +- svs_cpu_little: SVS bank device node of little CPU
> +  compatible: "mediatek,mt8183-svs-cpu-little"
> +  operating-points-v2: OPP table hooked by SVS little CPU bank.
> +		       SVS will optimze this OPP table voltage part.
> +  vcpu-little-supply: PMIC buck of little CPU
> +- svs_cpu_big: SVS bank device node of big CPU
> +  compatible: "mediatek,mt8183-svs-cpu-big"
> +  operating-points-v2: OPP table hooked by SVS big CPU bank.
> +		       SVS will optimze this OPP table voltage part.
> +  vcpu-big-supply: PMIC buck of big CPU
> +- svs_cci: SVS bank device node of CCI
> +  compatible: "mediatek,mt8183-svs-cci"
> +  operating-points-v2: OPP table hooked by SVS CCI bank.
> +		       SVS will optimze this OPP table voltage part.
> +  vcci-supply: PMIC buck of CCI
> +- svs_gpu: SVS bank device node of GPU
> +  compatible: "mediatek,mt8183-svs-gpu"
> +  operating-points-v2: OPP table hooked by SVS GPU bank.
> +		       SVS will optimze this OPP table voltage part.
> +  vgpu-spply: PMIC buck of GPU
> +
> +Example:
> +
> +	svs: svs@1100b000 {
> +		compatible = "mediatek,mt8183-svs";
> +		reg = <0 0x1100b000 0 0x1000>;
> +		interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_LOW 0>;

GIC interrupts are 3 cells, you have 4.

> +		clocks = <&infracfg CLK_INFRA_THERM>;
> +		clock-names = "main_clk";
> +		nvmem-cells = <&svs_calibration>, <&thermal_calibration>;
> +		nvmem-cell-names = "svs-calibration-data", "calibration-data";
> +
> +		svs_cpu_little: svs_cpu_little {

Don't use '_' in node names.

> +			compatible = "mediatek,mt8183-svs-cpu-little";
> +			operating-points-v2 = <&cluster0_opp>;
> +		};
> +
> +		svs_cpu_big: svs_cpu_big {
> +			compatible = "mediatek,mt8183-svs-cpu-big";
> +			operating-points-v2 = <&cluster1_opp>;
> +		};
> +
> +		svs_cci: svs_cci {
> +			compatible = "mediatek,mt8183-svs-cci";
> +			operating-points-v2 = <&cci_opp>;
> +		};
> +
> +		svs_gpu: svs_gpu {
> +			compatible = "mediatek,mt8183-svs-gpu";
> +			power-domains = <&scpsys MT8183_POWER_DOMAIN_MFG_2D>;
> +			operating-points-v2 = <&gpu_opp_table>;
> +		};
> +	};
> +
> +	&svs_cpu_little {
> +		vcpu-little-supply = <&mt6358_vproc12_reg>;

It's already defined to have OPP and supply in the cpu nodes. Parse them
to get this information rather than duplicating it here.

The same should apply to the CCI and GPU.

Rob
