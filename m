Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C99434EF9
	for <lists+linux-pm@lfdr.de>; Wed, 20 Oct 2021 17:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhJTP0z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Oct 2021 11:26:55 -0400
Received: from relay06.th.seeweb.it ([5.144.164.167]:37401 "EHLO
        relay06.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhJTP0y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Oct 2021 11:26:54 -0400
X-Greylist: delayed 514 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Oct 2021 11:26:54 EDT
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id AA9903F36D;
        Wed, 20 Oct 2021 17:16:00 +0200 (CEST)
Subject: Re: [PATCH v16 6/7] arm64: dts: mt8192: add svs device information
To:     Roger Lu <roger.lu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20210428065440.3704-1-roger.lu@mediatek.com>
 <20210428065440.3704-7-roger.lu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <855e004b-b128-70f7-b1d2-9fe957c94e08@somainline.org>
Date:   Wed, 20 Oct 2021 17:16:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210428065440.3704-7-roger.lu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 28/04/21 08:54, Roger Lu ha scritto:
> add compitable/reg/irq/clock/efuse/reset setting in svs node
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 34 ++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
> 

Hello Roger,
thanks for this series! However, there is an issue with this patch:

> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index fe24cc66ff7a..e9816a56d87b 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -270,6 +270,14 @@
>   			compatible = "mediatek,mt8192-infracfg", "syscon";
>   			reg = <0 0x10001000 0 0x1000>;
>   			#clock-cells = <1>;
> +
> +			infracfg_rst: reset-controller {
> +				compatible = "mediatek,infra-reset", "ti,syscon-reset";
> +				#reset-cells = <1>;
> +				ti,reset-bits = <
> +					0x150 5 0x154 5 0 0     (ASSERT_SET | DEASSERT_SET | STATUS_NONE) /* 0: svs */

You are using macros here, which are defined in dt-bindings/reset/ti-syscon.h
hovever, you are not including this header in this devicetree, so it's not
compiling.

Please fix it.

> +				>;
> +			};
>   		};
>   
>   		pericfg: syscon@10003000 {
> @@ -564,6 +572,20 @@
>   			status = "disabled";
>   		};
>   
> +		svs: svs@1100b000 {
> +			compatible = "mediatek,mt8192-svs";
> +			reg = <0 0x1100b000 0 0x1000>;
> +			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&infracfg CLK_INFRA_THERM>;
> +			clock-names = "main";
> +			nvmem-cells = <&svs_calibration>,
> +				      <&lvts_e_data1>;
> +			nvmem-cell-names = "svs-calibration-data",
> +					   "t-calibration-data";
> +			resets = <&infracfg_rst 0>;
> +			reset-names = "svs_rst";
> +		};
> +
>   		spi1: spi@11010000 {
>   			compatible = "mediatek,mt8192-spi",
>   				     "mediatek,mt6765-spi";
> @@ -681,6 +703,18 @@
>   			#clock-cells = <1>;
>   		};
>   
> +		efuse: efuse@11c10000 {
> +			compatible = "mediatek,efuse";
> +			reg = <0 0x11c10000 0 0x1000>;
> +

arch/arm64/boot/dts/mediatek/mt8192.dtsi:510.5-24: Warning (reg_format): 
/soc/efuse@11c10000/data1:reg: property has invalid length (8 bytes) 
(#address-cells == 2, #size-cells == 1)

arch/arm64/boot/dts/mediatek/mt8192.dtsi:513.5-24: Warning (reg_format): 
/soc/efuse@11c10000/calib@580:reg: property has invalid length (8 bytes) 
(#address-cells == 2, #size-cells == 1)


In short, you should add here:
			#address-cells = <1>;
			#size-cells = <1>;

> +			lvts_e_data1: data1 {
> +				reg = <0x1C0 0x58>;
> +			};
> +			svs_calibration: calib@580 {
> +				reg = <0x580 0x68>;
> +			};
> +		};
> +
>   		i2c3: i2c3@11cb0000 {
>   			compatible = "mediatek,mt8192-i2c";
>   			reg = <0 0x11cb0000 0 0x1000>,
> 

Regards,
- Angelo
