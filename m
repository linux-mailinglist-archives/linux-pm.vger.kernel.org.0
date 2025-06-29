Return-Path: <linux-pm+bounces-29798-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6FAAECE0B
	for <lists+linux-pm@lfdr.de>; Sun, 29 Jun 2025 16:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842881896BC1
	for <lists+linux-pm@lfdr.de>; Sun, 29 Jun 2025 14:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A572248B4;
	Sun, 29 Jun 2025 14:47:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206694437A;
	Sun, 29 Jun 2025 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751208434; cv=none; b=RFeH/9IlAJA0Ccgu07xZxWVxUogjo2XLM/pvgX04U1wSMaM7jr1nKQfUFtAIV5WltM3WdIGll9j6BnF6Gifjcp88OH4lmKmMgcuq88dc5XdDfqsoWAZmIV4CKjCCn2SvD/LksZ8QpY+lRz+4x1G2CxQ2DB4NDn2KDwKMXyj89V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751208434; c=relaxed/simple;
	bh=KClsNYwfxeyKw0Nv6uUMfVDKlblzETmDZmLERrHHVgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OB2ioMZBvbXpuOBi+zzWKXs+P4MZc/LTjYKyl8b6oueQJSMrdzpCaU5/mkLql/2mrPUggDeRK9EqcemtS2fGEi3xCgu35xkgQTcR2LJ82LHPS0hQK5j0Aes/ftWsUFJiBiQqlNOjk7hgzX06o7LcIJRj6GgmiQO8/xy7iy4w8jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uVtJ6-000000001Bw-12Mh;
	Sun, 29 Jun 2025 14:47:00 +0000
Date: Sun, 29 Jun 2025 15:46:56 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Johnson Wang <johnson.wang@mediatek.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v7 07/14] arm64: dts: mediatek: mt7988: add basic
 ethernet-nodes
Message-ID: <aGFR4PJv0pdKdD94@makrotopia.org>
References: <20250628165451.85884-1-linux@fw-web.de>
 <20250628165451.85884-8-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250628165451.85884-8-linux@fw-web.de>

On Sat, Jun 28, 2025 at 06:54:42PM +0200, Frank Wunderlich wrote:
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
> v6:
> - fix whitespace-errors for pdma irqs (spaces vs. tabs)
> - move sram from eth reg to own sram node (needs CONFIG_SRAM)
> 
> v5:
> - add reserved irqs and change names to fe0..fe3
> - change rx-ringX to pdmaX to be closer to documentation
> 
> v4:
> - comment for fixed-link on gmac0
> - update 2g5 phy node
>   - unit-name dec instead of hex to match reg property
>   - move compatible before reg
>   - drop phy-mode
> - add interrupts for RSS
> - add interrupt-names and drop reserved irqs for ethernet
> - some reordering
> - eth-reg and clock whitespace-fix based on angelos review
> ---
>  arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 137 +++++++++++++++++++++-
>  1 file changed, 134 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> index 560ec86dbec0..cf765a6b1fa8 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> @@ -680,7 +680,28 @@ xphyu3port0: usb-phy@11e13000 {
>  			};
>  		};
>  
> -		clock-controller@11f40000 {
> +		xfi_tphy0: phy@11f20000 {
> +			compatible = "mediatek,mt7988-xfi-tphy";
> +			reg = <0 0x11f20000 0 0x10000>;
> +			clocks = <&xfi_pll CLK_XFIPLL_PLL_EN>,
> +				 <&topckgen CLK_TOP_XFI_PHY_0_XTAL_SEL>;
> +			clock-names = "xfipll", "topxtal";
> +			resets = <&watchdog 14>;
> +			mediatek,usxgmii-performance-errata;
> +			#phy-cells = <0>;
> +		};
> +
> +		xfi_tphy1: phy@11f30000 {
> +			compatible = "mediatek,mt7988-xfi-tphy";
> +			reg = <0 0x11f30000 0 0x10000>;
> +			clocks = <&xfi_pll CLK_XFIPLL_PLL_EN>,
> +				 <&topckgen CLK_TOP_XFI_PHY_1_XTAL_SEL>;
> +			clock-names = "xfipll", "topxtal";
> +			resets = <&watchdog 15>;
> +			#phy-cells = <0>;
> +		};
> +
> +		xfi_pll: clock-controller@11f40000 {
>  			compatible = "mediatek,mt7988-xfi-pll";
>  			reg = <0 0x11f40000 0 0x1000>;
>  			resets = <&watchdog 16>;
> @@ -714,19 +735,129 @@ phy_calibration_p3: calib@97c {
>  			};
>  		};
>  
> -		clock-controller@15000000 {
> +		ethsys: clock-controller@15000000 {
>  			compatible = "mediatek,mt7988-ethsys", "syscon";
>  			reg = <0 0x15000000 0 0x1000>;
>  			#clock-cells = <1>;
>  			#reset-cells = <1>;
>  		};
>  
> -		clock-controller@15031000 {
> +		ethwarp: clock-controller@15031000 {
>  			compatible = "mediatek,mt7988-ethwarp";
>  			reg = <0 0x15031000 0 0x1000>;
>  			#clock-cells = <1>;
>  			#reset-cells = <1>;
>  		};
> +
> +		eth: ethernet@15100000 {
> +			compatible = "mediatek,mt7988-eth";
> +			reg = <0 0x15100000 0 0x80000>;

I think this should be

reg = <0 0x15100000 0 0x40000>;

as the range from 15140000 ~ 1517ffff is used as SRAM on MT7981/MT7986 and
doesn't seem to be used at all on MT7988.

root@OpenWrt:~# devmem 0x15140000 32
0xDEADBEEF
...
root@OpenWrt:~# devmem 0x1517fffc 32
0xDEADBEEF
(with 0xDEADBEEF all that range)

