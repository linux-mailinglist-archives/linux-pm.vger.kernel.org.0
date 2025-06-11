Return-Path: <linux-pm+bounces-28461-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D45AD5006
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 11:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A50153A9BA9
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 09:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B42269818;
	Wed, 11 Jun 2025 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jSSIRrP0"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150D52690D6;
	Wed, 11 Jun 2025 09:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634431; cv=none; b=jqA6EFi30onViffYAtkq30xVHui1aqJJP9Z1ukPosHWVeHpW3oNI7kL/xxza723UAfQaFprTLuK2MKpcPmy3crUJx154VPr3ukhJIjLbR8tcH7XO1DdOf8iuEd4CL4x5jDduJ1PsBOE5uZ/sDtwra851WbWEM8j6m7FvZ7NkgOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634431; c=relaxed/simple;
	bh=2Bx5pk/4PGvxDMaVO9PDV3VXGwo3Kr1fdGR9qhTJyQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tT/Cy/WxbKqKuxWasz0KbZpuSX050zCBcd3/nc/Pb/tHr4aAHX0QWfBu6TKqi7v8atknZB68S/FqFmHXSIoywxixaT4OxgliWbF9Wpa30SiKCjty4Ews8x39DaYZBBgWiKysyZKlJcsimqIBnOE2gPeEAmUI58g2r0ULyGRm/eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jSSIRrP0; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1749634427;
	bh=2Bx5pk/4PGvxDMaVO9PDV3VXGwo3Kr1fdGR9qhTJyQ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jSSIRrP0dym3SIK5fuDSfb41jRmXzwWKM+lizNdp7xWoOSy1Xpawhx6nISRH9wXnO
	 0lqGn+oK03kY93KRWG3t7cE8mqF5UjpyGlxzGagxF4/neBnPqbs2QBdD9DwVIieBFs
	 J/ftFm1FhzP/WqmI60Zf8Cxapq4PFD9/msJmdaeyU9bShmQu+661uU5UFv7VrsX4/t
	 ZljcFtRk3qtl/TRhpl5SXj7Ac0GU9/oWcDLtOEQeMOw9kc/Ml4dKZTuzkqfIrkckFS
	 zw6PSJ6FfyIwOJKNVoh1feH8eycsUGUwGUiNH6dHWOTYPP8gJdqZbpE9Yb0yJoPOdc
	 kmiH9ucGZbDwA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1B55F17E36B3;
	Wed, 11 Jun 2025 11:33:46 +0200 (CEST)
Message-ID: <10d6fe88-75ff-4c02-8fdd-e1101aaa565c@collabora.com>
Date: Wed, 11 Jun 2025 11:33:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/13] arm64: dts: mediatek: mt7988: add basic
 ethernet-nodes
To: Frank Wunderlich <linux@fw-web.de>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Georgi Djakov <djakov@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
 Jia-Wei Chang <jia-wei.chang@mediatek.com>,
 Johnson Wang <johnson.wang@mediatek.com>, =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?=
 <arinc.unal@arinc9.com>, Landen Chao <Landen.Chao@mediatek.com>,
 DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Felix Fietkau <nbd@nbd.name>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250608211452.72920-1-linux@fw-web.de>
 <20250608211452.72920-7-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250608211452.72920-7-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 08/06/25 23:14, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add basic ethernet related nodes.
> 
> Mac1+2 needs pcs (sgmii+usxgmii) to work correctly which will be linked
> later when driver is merged.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>   arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 124 +++++++++++++++++++++-
>   1 file changed, 121 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> index 560ec86dbec0..ee1e01d720fe 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> @@ -680,7 +680,28 @@ xphyu3port0: usb-phy@11e13000 {
>   			};
>   		};
>   
> -		clock-controller@11f40000 {
> +		xfi_tphy0: phy@11f20000 {
> +			compatible = "mediatek,mt7988-xfi-tphy";
> +			reg = <0 0x11f20000 0 0x10000>;
> +			resets = <&watchdog 14>;
> +			clocks = <&xfi_pll CLK_XFIPLL_PLL_EN>,
> +				 <&topckgen CLK_TOP_XFI_PHY_0_XTAL_SEL>;
> +			clock-names = "xfipll", "topxtal";

resets here please, not after reg.

> +			mediatek,usxgmii-performance-errata;
> +			#phy-cells = <0>;
> +		};
> +
> +		xfi_tphy1: phy@11f30000 {
> +			compatible = "mediatek,mt7988-xfi-tphy";
> +			reg = <0 0x11f30000 0 0x10000>;
> +			resets = <&watchdog 15>;
> +			clocks = <&xfi_pll CLK_XFIPLL_PLL_EN>,
> +				 <&topckgen CLK_TOP_XFI_PHY_1_XTAL_SEL>;
> +			clock-names = "xfipll", "topxtal";

ditto

> +			#phy-cells = <0>;
> +		};
> +
> +		xfi_pll: clock-controller@11f40000 {
>   			compatible = "mediatek,mt7988-xfi-pll";
>   			reg = <0 0x11f40000 0 0x1000>;
>   			resets = <&watchdog 16>;
> @@ -714,19 +735,116 @@ phy_calibration_p3: calib@97c {
>   			};
>   		};
>   
> -		clock-controller@15000000 {
> +		ethsys: clock-controller@15000000 {
>   			compatible = "mediatek,mt7988-ethsys", "syscon";
>   			reg = <0 0x15000000 0 0x1000>;
>   			#clock-cells = <1>;
>   			#reset-cells = <1>;
>   		};
>   
> -		clock-controller@15031000 {
> +		ethwarp: clock-controller@15031000 {
>   			compatible = "mediatek,mt7988-ethwarp";
>   			reg = <0 0x15031000 0 0x1000>;
>   			#clock-cells = <1>;
>   			#reset-cells = <1>;
>   		};
> +
> +		eth: ethernet@15100000 {
> +			compatible = "mediatek,mt7988-eth";
> +			reg = <0 0x15100000 0 0x80000>,
> +			      <0 0x15400000 0 0x200000>;

reg = <0 0x15100000 0 0x80000>, <0 0x15400000 0 0x200000>;

it's 83 columns - it's fine.

> +			interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ethsys CLK_ETHDMA_CRYPT0_EN>,
> +				 <&ethsys CLK_ETHDMA_FE_EN>,
> +				 <&ethsys CLK_ETHDMA_GP2_EN>,
> +				 <&ethsys CLK_ETHDMA_GP1_EN>,
> +				 <&ethsys CLK_ETHDMA_GP3_EN>,
> +				 <&ethwarp CLK_ETHWARP_WOCPU2_EN>,
> +				 <&ethwarp CLK_ETHWARP_WOCPU1_EN>,
> +				 <&ethwarp CLK_ETHWARP_WOCPU0_EN>,
> +				 <&ethsys CLK_ETHDMA_ESW_EN>,
> +				 <&topckgen CLK_TOP_ETH_GMII_SEL>,
> +				 <&topckgen CLK_TOP_ETH_REFCK_50M_SEL>,
> +				 <&topckgen CLK_TOP_ETH_SYS_200M_SEL>,
> +				 <&topckgen CLK_TOP_ETH_SYS_SEL>,
> +				 <&topckgen CLK_TOP_ETH_XGMII_SEL>,
> +				 <&topckgen CLK_TOP_ETH_MII_SEL>,
> +				 <&topckgen CLK_TOP_NETSYS_SEL>,
> +				 <&topckgen CLK_TOP_NETSYS_500M_SEL>,
> +				 <&topckgen CLK_TOP_NETSYS_PAO_2X_SEL>,
> +				 <&topckgen CLK_TOP_NETSYS_SYNC_250M_SEL>,
> +				 <&topckgen CLK_TOP_NETSYS_PPEFB_250M_SEL>,
> +				 <&topckgen CLK_TOP_NETSYS_WARP_SEL>,
> +				 <&ethsys CLK_ETHDMA_XGP1_EN>,
> +				 <&ethsys CLK_ETHDMA_XGP2_EN>,
> +				 <&ethsys CLK_ETHDMA_XGP3_EN>;
> +			clock-names = "crypto", "fe", "gp2", "gp1",
> +				      "gp3",

clock-names = "crypto", "fe", "gp2", "gp1", "gp3",

:-)

> +				      "ethwarp_wocpu2", "ethwarp_wocpu1",
> +				      "ethwarp_wocpu0", "esw", "top_eth_gmii_sel",
> +				      "top_eth_refck_50m_sel", "top_eth_sys_200m_sel",
> +				      "top_eth_sys_sel", "top_eth_xgmii_sel",
> +				      "top_eth_mii_sel", "top_netsys_sel",
> +				      "top_netsys_500m_sel", "top_netsys_pao_2x_sel",
> +				      "top_netsys_sync_250m_sel",
> +				      "top_netsys_ppefb_250m_sel",
> +				      "top_netsys_warp_sel","xgp1", "xgp2", "xgp3";
> +			assigned-clocks = <&topckgen CLK_TOP_NETSYS_2X_SEL>,
> +					  <&topckgen CLK_TOP_NETSYS_GSW_SEL>,
> +					  <&topckgen CLK_TOP_USXGMII_SBUS_0_SEL>,
> +					  <&topckgen CLK_TOP_USXGMII_SBUS_1_SEL>,
> +					  <&topckgen CLK_TOP_SGM_0_SEL>,
> +					  <&topckgen CLK_TOP_SGM_1_SEL>;
> +			assigned-clock-parents = <&apmixedsys CLK_APMIXED_NET2PLL>,
> +						 <&topckgen CLK_TOP_NET1PLL_D4>,
> +						 <&topckgen CLK_TOP_NET1PLL_D8_D4>,
> +						 <&topckgen CLK_TOP_NET1PLL_D8_D4>,
> +						 <&apmixedsys CLK_APMIXED_SGMPLL>,
> +						 <&apmixedsys CLK_APMIXED_SGMPLL>;

Address and size cells must go *before* vendor-specific properties

> +			mediatek,ethsys = <&ethsys>;
> +			mediatek,infracfg = <&topmisc>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +

Cheers!
Angelo

