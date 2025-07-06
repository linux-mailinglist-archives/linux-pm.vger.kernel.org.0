Return-Path: <linux-pm+bounces-30234-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C7BAFA873
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 01:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CE7E173CA3
	for <lists+linux-pm@lfdr.de>; Sun,  6 Jul 2025 23:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5907A2877DD;
	Sun,  6 Jul 2025 23:38:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90842155C88;
	Sun,  6 Jul 2025 23:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751845133; cv=none; b=H4gyqO6EkfPrrnJASHzcNF8eQa6yTnTi/X12aRU+qrrjs7JvCKjdA5w4rcMA58bX403UGthtlSTudH1lhSnPKm9I1xTfxo7utd6tQ9aVuO8sqUukLcqhmWRZoJAbuKiOHEZTZG1XihLhPOwkQ35dfsSlQhO5DPm7P3rmrwXqdrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751845133; c=relaxed/simple;
	bh=T5BRD9FAcEcLMux46w89iS9a0vl+S93dslNk6xYMWU0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AaNxm0Y1FqGKcflyf21hg6YVB861MkYexdoXPBez1kXG/ee14z4MsL515TztLzNA1+bNa0K6UO+VGQjFS2oWwb2w9W2+Sh09WyPYY+QKvSBdhjzkjLIEAiIoDrLv9E4LcYGOGq5LFDhn/C356sorG+xxC3zoS7Pf7kwyCYEB988=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 687E71E8D;
	Sun,  6 Jul 2025 16:38:38 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84A623F694;
	Sun,  6 Jul 2025 16:38:49 -0700 (PDT)
Date: Mon, 7 Jul 2025 00:37:10 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej@kernel.org>, Samuel
 Holland <samuel@sholland.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, linux-sunxi@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: dts: allwinner: a523: Add power controller
 device nodes
Message-ID: <20250707003710.1d4a3ed0@minigeek.lan>
In-Reply-To: <20250627152918.2606728-5-wens@kernel.org>
References: <20250627152918.2606728-1-wens@kernel.org>
	<20250627152918.2606728-5-wens@kernel.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Jun 2025 23:29:18 +0800
Chen-Yu Tsai <wens@kernel.org> wrote:

> From: Chen-Yu Tsai <wens@csie.org>
> 
> The A523 SoC family has two power controllers, one based on the existing
> PPU, and one newer one based on ARM's PCK-600.
> 
> Add device nodes for both of them.

Compared against the manual, that matches up. Might be worth to mention
the reliance on your RST_BUS_R_PPU0 patch, otherwise some bots might
scream.

> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> index 6f62201fd739..255e0ef98219 100644
> --- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> @@ -7,6 +7,8 @@
>  #include <dt-bindings/clock/sun55i-a523-r-ccu.h>
>  #include <dt-bindings/reset/sun55i-a523-ccu.h>
>  #include <dt-bindings/reset/sun55i-a523-r-ccu.h>
> +#include <dt-bindings/power/allwinner,sun55i-a523-ppu.h>
> +#include <dt-bindings/power/allwinner,sun55i-a523-pck600.h>
>  
>  / {
>  	interrupt-parent = <&gic>;
> @@ -576,6 +578,14 @@ mdio0: mdio {
>  			};
>  		};
>  
> +		ppu: power-controller@7001400 {
> +			compatible = "allwinner,sun55i-a523-ppu";
> +			reg = <0x07001400 0x400>;
> +			clocks = <&r_ccu CLK_BUS_R_PPU1>;
> +			resets = <&r_ccu RST_BUS_R_PPU1>;
> +			#power-domain-cells = <1>;
> +		};
> +
>  		r_ccu: clock-controller@7010000 {
>  			compatible = "allwinner,sun55i-a523-r-ccu";
>  			reg = <0x7010000 0x250>;
> @@ -622,6 +632,14 @@ r_i2c_pins: r-i2c-pins {
>  			};
>  		};
>  
> +		pck600: power-controller@7060000 {
> +			compatible = "allwinner,sun55i-a523-pck-600";
> +			reg = <0x07060000 0x8000>;
> +			clocks = <&r_ccu CLK_BUS_R_PPU0>;
> +			resets = <&r_ccu RST_BUS_R_PPU0>;
> +			#power-domain-cells = <1>;
> +		};
> +
>  		r_i2c0: i2c@7081400 {
>  			compatible = "allwinner,sun55i-a523-i2c",
>  				     "allwinner,sun8i-v536-i2c",


