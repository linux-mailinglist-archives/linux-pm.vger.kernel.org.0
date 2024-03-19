Return-Path: <linux-pm+bounces-5111-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 434E087FD2F
	for <lists+linux-pm@lfdr.de>; Tue, 19 Mar 2024 12:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E932F283B19
	for <lists+linux-pm@lfdr.de>; Tue, 19 Mar 2024 11:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BAF7F470;
	Tue, 19 Mar 2024 11:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ezTBku7R"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861251CD13;
	Tue, 19 Mar 2024 11:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710849109; cv=none; b=dV1tD2PivFol0JKA30j4wG0wRi8XDwGxdkRrFiPtCIWCFQHX++0x5TSOsoTcSacYpepuBqPv4wlZqbhCkaY/B411ClUowc9RGEQwSibCYbEiVwIztHgBpoCIG2x3GHQP73U3dCQ+DjpeoBJz5NSfsZko65ze6fFXq168A9h/rh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710849109; c=relaxed/simple;
	bh=Df4vHxdh+4U1Qaa3doL7VH2D+wCYvn+z/z5WgDx5Mxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SunfMeV9Lbl+wH1/esIQZLUuZLpRgfo6KJ763SZTwQhzQu1lPpVcQlFWSxzlauJaAzK3Zm9qdRoqEQN+asVDTgmk28aVOg/coWqTADFqMveVkB/EAxGmQ3EeuMirgOQ96Us4blmoXSB3gkUmIkOB42Y4GMLitAGWFpwZwv/iH3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ezTBku7R; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710849105;
	bh=Df4vHxdh+4U1Qaa3doL7VH2D+wCYvn+z/z5WgDx5Mxg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ezTBku7RM0wYyNfhIG/FwOjUHX+6RTtQDvga3J5wxpV6T9gGOwaubkIUaQuxBdt5d
	 m9bnqGm0A4KXLwgblKYWhR4LocvTkXOvrzVKHHQcVpBwMBdL4YTgqRDLKcPwoRVbPV
	 uv0/XJB/bFf2NlGPbmE2zQIByViTYYKo4ON03JPYH3I1CV0g6/cJriA80ynb9LbgIZ
	 PfxFB17vJ/nLdpq1tfvdPT2YwkdGt/PgnOjlWVF3SPQYHR63z9k1Y0dKgWD/Eui20f
	 rEiSxjjqA7e7IK45ahf8BV3out9O/JgoIjlWy8fEEWi1b7Jm/6Ml9KVKvpLpdgYzsr
	 V0WgK8mzTC3qQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6E532378203E;
	Tue, 19 Mar 2024 11:51:45 +0000 (UTC)
Message-ID: <b5ef97d6-083d-41ac-8781-662e4c862a15@collabora.com>
Date: Tue, 19 Mar 2024 12:51:44 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/13] thermal/drivers/mediatek/lvts_thermal: add
 MT8188 support
Content-Language: en-US
To: Nicolas Pitre <nico@fluxnic.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
Cc: Nicolas Pitre <npitre@baylibre.com>
References: <20240318212428.3843952-1-nico@fluxnic.net>
 <20240318212428.3843952-13-nico@fluxnic.net>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240318212428.3843952-13-nico@fluxnic.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 18/03/24 22:22, Nicolas Pitre ha scritto:
> From: Nicolas Pitre <npitre@baylibre.com>
> 
> Various values extracted from the vendor's kernel driver.
> 
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8188.dtsi |  35 ++++++++
>   drivers/thermal/mediatek/lvts_thermal.c  | 102 +++++++++++++++++++++++
>   2 files changed, 137 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> index b4315c9214..5a3c58a77c 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> @@ -11,6 +11,7 @@
>   #include <dt-bindings/phy/phy.h>
>   #include <dt-bindings/pinctrl/mediatek,mt8188-pinfunc.h>
>   #include <dt-bindings/power/mediatek,mt8188-power.h>
> +#include <dt-bindings/reset/mt8188-resets.h>
>   
>   / {
>   	compatible = "mediatek,mt8188";
> @@ -357,6 +358,7 @@ infracfg_ao: syscon@10001000 {
>   			compatible = "mediatek,mt8188-infracfg-ao", "syscon";
>   			reg = <0 0x10001000 0 0x1000>;
>   			#clock-cells = <1>;
> +			#reset-cells = <1>;
>   		};
>   
>   		pericfg: syscon@10003000 {
> @@ -491,6 +493,17 @@ spi0: spi@1100a000 {
>   			status = "disabled";
>   		};
>   
> +		lvts_ap: thermal-sensor@1100b000 {
> +			compatible = "mediatek,mt8188-lvts-ap";
> +			reg = <0 0x1100b000 0 0x1000>;

iospace clashing with SVS. NAK.

> +			interrupts = <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&infracfg_ao CLK_INFRA_AO_THERM>;
> +			resets = <&infracfg_ao MT8188_INFRA_RST1_THERMAL_CTRL_RST>;
> +			nvmem-cells = <&lvts_efuse_data1>;
> +			nvmem-cell-names = "lvts_calib_data1";
> +			#thermal-sensor-cells = <1>;
> +		};
> +
>   		spi1: spi@11010000 {
>   			compatible = "mediatek,mt8188-spi-ipm", "mediatek,spi-ipm";
>   			#address-cells = <1>;
> @@ -604,6 +617,17 @@ mmc1: mmc@11240000 {
>   			status = "disabled";
>   		};
>   
> +		lvts_mcu: thermal-sensor@11278000 {
> +			compatible = "mediatek,mt8188-lvts-mcu";
> +			reg = <0 0x11278000 0 0x1000>;
> +			interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&infracfg_ao CLK_INFRA_AO_THERM>;
> +			resets = <&infracfg_ao MT8188_INFRA_RST1_THERMAL_MCU_RST>;
> +			nvmem-cells = <&lvts_efuse_data1>;
> +			nvmem-cell-names = "lvts_calib_data1";
> +			#thermal-sensor-cells = <1>;
> +		};
> +
>   		i2c0: i2c@11280000 {
>   			compatible = "mediatek,mt8188-i2c";
>   			reg = <0 0x11280000 0 0x1000>,
> @@ -827,6 +851,17 @@ imp_iic_wrap_en: clock-controller@11ec2000 {
>   			#clock-cells = <1>;
>   		};
>   
> +		efuse: efuse@11f20000 {
> +			compatible = "mediatek,mt8188-efuse", "mediatek,efuse";
> +			reg = <0 0x11f20000 0 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			lvts_efuse_data1: lvts1-calib@1ac {
> +				reg = <0x1ac 0x40>;
> +			};
> +		};
> +
>   		mfgcfg: clock-controller@13fbf000 {
>   			compatible = "mediatek,mt8188-mfgcfg";
>   			reg = <0 0x13fbf000 0 0x1000>;
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index a23a93fc82..46882df640 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -1448,6 +1448,90 @@ static const struct lvts_ctrl_data mt8186_lvts_data_ctrl[] = {
>   	}
>   };
>   
> +static const struct lvts_ctrl_data mt8188_lvts_mcu_data_ctrl[] = {
> +	{
> +		.lvts_sensor = {
> +			{ .dt_id = MT8188_MCU_TS1_0,
> +			  .cal_offsets = { 22, 23, 24 } },
> +			{ .dt_id = MT8188_MCU_TS1_1,
> +			  .cal_offsets = { 25, 26, 27 } },
> +			{ .dt_id = MT8188_MCU_TS1_2,
> +			  .cal_offsets = { 28, 29, 30 } },
> +			{ .dt_id = MT8188_MCU_TS1_3,
> +			  .cal_offsets = { 31, 32, 33 } },
> +		},
> +		VALID_SENSOR_MAP(1, 1, 1, 1),
> +		.offset = 0x0,
> +		.hw_tshut_temp = 117000,
> +		.mode = LVTS_MSR_FILTERED_MODE,
> +	},
> +	{
> +		.lvts_sensor = {
> +			{ .dt_id = MT8188_MCU_TS2_0,
> +			  .cal_offsets = { 34, 35, 36 } },
> +			{ .dt_id = MT8188_MCU_TS2_1,
> +			  .cal_offsets = { 37, 38, 39 } },
> +		},
> +		VALID_SENSOR_MAP(1, 1, 0, 0),
> +		.offset = 0x100,
> +		.hw_tshut_temp = 117000,
> +		.mode = LVTS_MSR_FILTERED_MODE,
> +	}
> +};
> +
> +static const struct lvts_ctrl_data mt8188_lvts_ap_data_ctrl[] = {
> +	{
> +		.lvts_sensor = {
> +
> +			{ /* unused */ },
> +			{ .dt_id = MT8188_AP_TS3_1,
> +			  .cal_offsets = { 40, 41, 42 } },
> +		},
> +		VALID_SENSOR_MAP(0, 1, 0, 0),
> +		.offset = 0x0,
> +		.hw_tshut_temp = 117000,
> +		.mode = LVTS_MSR_FILTERED_MODE,
> +	},
> +	{
> +		.lvts_sensor = {
> +			{ .dt_id = MT8188_AP_TS4_0,
> +			  .cal_offsets = { 43, 44, 45 } },
> +			{ .dt_id = MT8188_AP_TS4_1,
> +			  .cal_offsets = { 46, 47, 48 } },
> +			{ .dt_id = MT8188_AP_TS4_2,
> +			  .cal_offsets = { 49, 50, 51 } },
> +		},
> +		VALID_SENSOR_MAP(1, 1, 1, 0),
> +		.offset = 0x100,
> +		.hw_tshut_temp = 117000,
> +		.mode = LVTS_MSR_FILTERED_MODE,
> +	},
> +	{
> +		.lvts_sensor = {
> +			{ .dt_id = MT8188_AP_TS5_0,
> +			  .cal_offsets = { 52, 53, 54 } },
> +			{ .dt_id = MT8188_AP_TS5_1,
> +			  .cal_offsets = { 55, 56, 57 } },
> +		},
> +		VALID_SENSOR_MAP(1, 1, 0, 0),
> +		.offset = 0x200,
> +		.hw_tshut_temp = 117000,
> +		.mode = LVTS_MSR_FILTERED_MODE,
> +	},
> +	{
> +		.lvts_sensor = {
> +			{ .dt_id = MT8188_AP_TS6_0,
> +			  .cal_offsets = { 58, 59, 60 } },
> +			{ .dt_id = MT8188_AP_TS6_1,
> +			  .cal_offsets = { 61, 62, 63 } },
> +		},
> +		VALID_SENSOR_MAP(1, 1, 0, 0),
> +		.offset = 0x300,
> +		.hw_tshut_temp = 117000,
> +		.mode = LVTS_MSR_FILTERED_MODE,
> +	}
> +};
> +
>   static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] = {
>   	{
>   		.lvts_sensor = {
> @@ -1645,6 +1729,22 @@ static const struct lvts_data mt8186_lvts_data = {
>   	.gt_calib_bit_offset = 24,
>   };
>   
> +static const struct lvts_data mt8188_lvts_mcu_data = {
> +	.lvts_ctrl	= mt8188_lvts_mcu_data_ctrl,
> +	.num_lvts_ctrl	= ARRAY_SIZE(mt8188_lvts_mcu_data_ctrl),
> +	.temp_factor	= -250460,
> +	.temp_offset	= 250460,

This is LVTS_COEFF_{A,B}_MT8195: please use the definitions that are already there.

Regards,
Angelo

> +	.gt_calib_bit_offset = 20,
> +};
> +
> +static const struct lvts_data mt8188_lvts_ap_data = {
> +	.lvts_ctrl	= mt8188_lvts_ap_data_ctrl,
> +	.num_lvts_ctrl	= ARRAY_SIZE(mt8188_lvts_ap_data_ctrl),
> +	.temp_factor	= -250460,
> +	.temp_offset	= 250460,
> +	.gt_calib_bit_offset = 20,
> +};
> +
>   static const struct lvts_data mt8192_lvts_mcu_data = {
>   	.lvts_ctrl	= mt8192_lvts_mcu_data_ctrl,
>   	.num_lvts_ctrl	= ARRAY_SIZE(mt8192_lvts_mcu_data_ctrl),
> @@ -1676,6 +1776,8 @@ static const struct lvts_data mt8195_lvts_ap_data = {
>   static const struct of_device_id lvts_of_match[] = {
>   	{ .compatible = "mediatek,mt7988-lvts-ap", .data = &mt7988_lvts_ap_data },
>   	{ .compatible = "mediatek,mt8186-lvts", .data = &mt8186_lvts_data },
> +	{ .compatible = "mediatek,mt8188-lvts-mcu", .data = &mt8188_lvts_mcu_data },
> +	{ .compatible = "mediatek,mt8188-lvts-ap", .data = &mt8188_lvts_ap_data },
>   	{ .compatible = "mediatek,mt8192-lvts-mcu", .data = &mt8192_lvts_mcu_data },
>   	{ .compatible = "mediatek,mt8192-lvts-ap", .data = &mt8192_lvts_ap_data },
>   	{ .compatible = "mediatek,mt8195-lvts-mcu", .data = &mt8195_lvts_mcu_data },



