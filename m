Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F293434EE9
	for <lists+linux-pm@lfdr.de>; Wed, 20 Oct 2021 17:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhJTPWi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Oct 2021 11:22:38 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:32860 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhJTPWh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Oct 2021 11:22:37 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 1C10F1F441E0
Subject: Re: [PATCH v16 2/7] arm64: dts: mt8183: add svs device information
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
 <20210428065440.3704-3-roger.lu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <70e71210-6d17-92e3-4e3f-01b83380be42@collabora.com>
Date:   Wed, 20 Oct 2021 17:20:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210428065440.3704-3-roger.lu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 28/04/21 08:54, Roger Lu ha scritto:
> add compitable/reg/irq/clock/efuse setting in svs node
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 80519a145f13..441d617ece43 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -657,6 +657,18 @@
>   			status = "disabled";
>   		};
>   
> +		svs: svs@1100b000 {
> +			compatible = "mediatek,mt8183-svs";
> +			reg = <0 0x1100b000 0 0x1000>;
> +			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&infracfg CLK_INFRA_THERM>;
> +			clock-names = "main";
> +			nvmem-cells = <&svs_calibration>,
> +				      <&thermal_calibration>;
> +			nvmem-cell-names = "svs-calibration-data",
> +					   "t-calibration-data";
> +		};
> +
>   		pwm0: pwm@1100e000 {
>   			compatible = "mediatek,mt8183-disp-pwm";
>   			reg = <0 0x1100e000 0 0x1000>;
> @@ -941,9 +953,15 @@
>   			reg = <0 0x11f10000 0 0x1000>;
>   			#address-cells = <1>;
>   			#size-cells = <1>;
> +			thermal_calibration: calib@180 {
> +				reg = <0x180 0xc>;
> +			};
>   			mipi_tx_calibration: calib@190 {
>   				reg = <0x190 0xc>;
>   			};
> +			svs_calibration: calib@580 {
> +				reg = <0x580 0x64>;
> +			};
>   		};
>   
>   		u3phy: usb-phy@11f40000 {
> 

This patch doesn't apply on the latest linux-next due to some new commits in
mt8183.dtsi, can you please rebase?

Thanks,
- Angelo
