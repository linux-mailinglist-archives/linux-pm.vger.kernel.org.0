Return-Path: <linux-pm+bounces-24807-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5231A7BCD2
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 14:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63BFD189D570
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 12:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9061E1DE0;
	Fri,  4 Apr 2025 12:41:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBCA1DB363;
	Fri,  4 Apr 2025 12:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743770469; cv=none; b=po1iB3a4WTKm1jZJkxuzara899KRRNduo/D6MGAzjWeq614NUK6+oD3OiezraDHoyCxQiwdh6bhmxFP7fcozPUL6UFbH7jz5nB8lHu26fLr2OiwM+tMFMf5seMmgjeb79bwM2DFphN9oyT5USqyjYNZe/qYCw5XfRfmdOpN4h1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743770469; c=relaxed/simple;
	bh=iY1p6+npB+bD9BrO1Sg5lKvxjiUurx93mXmSO4ERzEc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t9c45BdoxF1MPfDuk6ktwePTMHImdOzEL8fVrVErXLJ2Z9O+3FMVkOU+J9QcNawKvTVcIPuY8/rKFxmK25MuRS972okxWrJRIHFhzBzWfU0/ELlGFr948mefJ+jHXbTcYn1yuB/EqC0+jk/xQFmcp19EWhTWNP8YQIS0pBMQEIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39AA31515;
	Fri,  4 Apr 2025 05:41:02 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF7A53F59E;
	Fri,  4 Apr 2025 05:40:53 -0700 (PDT)
Date: Fri, 4 Apr 2025 13:39:58 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep
 Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio
 <konradybcio@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd
 <sboyd@kernel.org>, zhouyanjie@wanyeetech.com, Conor Dooley
 <conor@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu
 Beznea <claudiu.beznea@tuxon.dev>, Steen Hegelund
 <Steen.Hegelund@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Heiko Stuebner <heiko@sntech.de>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Jerome
 Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-mips@vger.kernel.org,
 imx@lists.linux.dev, linux-rockchip@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 01/19] arm64: dts: allwinner: h5/h6: Drop spurious
 'clock-latency-ns' properties
Message-ID: <20250404133958.5361be95@donnerap.manchester.arm.com>
In-Reply-To: <20250403-dt-cpu-schema-v1-1-076be7171a85@kernel.org>
References: <20250403-dt-cpu-schema-v1-0-076be7171a85@kernel.org>
	<20250403-dt-cpu-schema-v1-1-076be7171a85@kernel.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 03 Apr 2025 21:59:22 -0500
"Rob Herring (Arm)" <robh@kernel.org> wrote:

Hi,

> 'clock-latency-ns' is not a valid property for CPU nodes. It belongs in
> OPP table (which has it). Drop them from the CPU nodes.

Looks alright, only affects H5 and H6, and they indeed have it in their
-cpu-opp.dtsi:

> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi | 4 ----
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 4 ----
>  2 files changed, 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> index d3caf27b6a55..48802bf02f3b 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> @@ -16,7 +16,6 @@ cpu0: cpu@0 {
>  			reg = <0>;
>  			enable-method = "psci";
>  			clocks = <&ccu CLK_CPUX>;
> -			clock-latency-ns = <244144>; /* 8 32k periods */
>  			#cooling-cells = <2>;
>  		};
>  
> @@ -26,7 +25,6 @@ cpu1: cpu@1 {
>  			reg = <1>;
>  			enable-method = "psci";
>  			clocks = <&ccu CLK_CPUX>;
> -			clock-latency-ns = <244144>; /* 8 32k periods */
>  			#cooling-cells = <2>;
>  		};
>  
> @@ -36,7 +34,6 @@ cpu2: cpu@2 {
>  			reg = <2>;
>  			enable-method = "psci";
>  			clocks = <&ccu CLK_CPUX>;
> -			clock-latency-ns = <244144>; /* 8 32k periods */
>  			#cooling-cells = <2>;
>  		};
>  
> @@ -46,7 +43,6 @@ cpu3: cpu@3 {
>  			reg = <3>;
>  			enable-method = "psci";
>  			clocks = <&ccu CLK_CPUX>;
> -			clock-latency-ns = <244144>; /* 8 32k periods */
>  			#cooling-cells = <2>;
>  		};
>  	};
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> index 2301c59b41b1..73e8604315c5 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -27,7 +27,6 @@ cpu0: cpu@0 {
>  			reg = <0>;
>  			enable-method = "psci";
>  			clocks = <&ccu CLK_CPUX>;
> -			clock-latency-ns = <244144>; /* 8 32k periods */
>  			#cooling-cells = <2>;
>  			i-cache-size = <0x8000>;
>  			i-cache-line-size = <64>;
> @@ -44,7 +43,6 @@ cpu1: cpu@1 {
>  			reg = <1>;
>  			enable-method = "psci";
>  			clocks = <&ccu CLK_CPUX>;
> -			clock-latency-ns = <244144>; /* 8 32k periods */
>  			#cooling-cells = <2>;
>  			i-cache-size = <0x8000>;
>  			i-cache-line-size = <64>;
> @@ -61,7 +59,6 @@ cpu2: cpu@2 {
>  			reg = <2>;
>  			enable-method = "psci";
>  			clocks = <&ccu CLK_CPUX>;
> -			clock-latency-ns = <244144>; /* 8 32k periods */
>  			#cooling-cells = <2>;
>  			i-cache-size = <0x8000>;
>  			i-cache-line-size = <64>;
> @@ -78,7 +75,6 @@ cpu3: cpu@3 {
>  			reg = <3>;
>  			enable-method = "psci";
>  			clocks = <&ccu CLK_CPUX>;
> -			clock-latency-ns = <244144>; /* 8 32k periods */
>  			#cooling-cells = <2>;
>  			i-cache-size = <0x8000>;
>  			i-cache-line-size = <64>;
> 


