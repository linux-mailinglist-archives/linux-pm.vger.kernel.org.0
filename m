Return-Path: <linux-pm+bounces-16450-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B12D69B0258
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 14:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4D901C2203F
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 12:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D53A203711;
	Fri, 25 Oct 2024 12:27:51 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661E6203712;
	Fri, 25 Oct 2024 12:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729859270; cv=none; b=Rs7aIg80VZZkE4ADuHHt3novkd9r9MqwFcL4fpnKRsRgmaKztKfwEwvo0OzoV3k0SblAjmuXf/NzV2XBVU7pqzxBjtFF0bLrX48mudfVqoktPdjjv365CSGtcOlZJkEI+O/sFxntM48WuvsjegYG3LP99lzthA/nvfBD1u5YmAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729859270; c=relaxed/simple;
	bh=hAhBOBQcAfSsqFw9V4igY225+CSJsKalgPicXLm49CA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AAovWbmE4x90ZrW3UiuHVSz/htJq8n7CKC3cZ+SGcnWtVke2pjGQUHtZ9FVnrrMxfcIdjjMn3L0R+d6mHktGxGjGI/UddMM0/GMHQK7QgFPrJT4nkNOS6ogKO9PAyGmZ+vBBJJEAmT6jhvHEVAR3hu7vUxdzs+hW1TColaheK1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AF6C339;
	Fri, 25 Oct 2024 05:28:17 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADC9A3F71E;
	Fri, 25 Oct 2024 05:27:42 -0700 (PDT)
Date: Fri, 25 Oct 2024 13:27:39 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Cody Eksal <masterr3c0rd@epochal.quest>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-usb@vger.kernel.org, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu
 Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel
 Holland <samuel@sholland.org>, Parthiban <parthiban@linumiz.com>, Yangtao
 Li <frank@allwinnertech.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Vinod Koul <vkoul@kernel.org>, Linus
 Walleij <linus.walleij@linaro.org>, Thierry Reding <treding@nvidia.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Maxime Ripard
 <mripard@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yangtao Li <tiny.windzz@gmail.com>, Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Kishon Vijay
 Abraham I <kishon@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Shuosheng Huang <huangshuosheng@allwinnertech.com>
Subject: Re: [PATCH 13/13] arm64: dts: allwinner: a100: Add CPU Operating
 Performance Points table
Message-ID: <20241025132739.3d0f116d@donnerap.manchester.arm.com>
In-Reply-To: <20241024170540.2721307-14-masterr3c0rd@epochal.quest>
References: <20241024170540.2721307-1-masterr3c0rd@epochal.quest>
	<20241024170540.2721307-14-masterr3c0rd@epochal.quest>
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

On Thu, 24 Oct 2024 14:05:31 -0300
Cody Eksal <masterr3c0rd@epochal.quest> wrote:

> From: Shuosheng Huang <huangshuosheng@allwinnertech.com>
> 
> Add an Operating Performance Points table for the CPU cores to
> enable Dynamic Voltage & Frequency Scaling on the A100.
> 
> Signed-off-by: Shuosheng Huang <huangshuosheng@allwinnertech.com>
> [masterr3c0rd@epochal.quest: fix typos in -cpu-opp, use compatible]
> Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
> ---
>  .../allwinner/sun50i-a100-allwinner-perf1.dts |  5 ++
>  .../dts/allwinner/sun50i-a100-cpu-opp.dtsi    | 90 +++++++++++++++++++
>  .../arm64/boot/dts/allwinner/sun50i-a100.dtsi |  8 ++
>  3 files changed, 103 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a100-cpu-opp.dtsi
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts b/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
> index 29e9d24da8b6..99b1b2f7b92a 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
> @@ -6,6 +6,7 @@
>  /dts-v1/;
>  
>  #include "sun50i-a100.dtsi"
> +#include "sun50i-a100-cpu-opp.dtsi"
>  
>  #include <dt-bindings/gpio/gpio.h>
>  
> @@ -67,6 +68,10 @@ &usb_otg {
>  	status = "okay";
>  };
>  
> +&cpu0 {
> +	cpu-supply = <&reg_dcdc2>;
> +};
> +
>  &pio {
>  	vcc-pb-supply = <&reg_dcdc1>;
>  	vcc-pc-supply = <&reg_eldo1>;
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100-cpu-opp.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a100-cpu-opp.dtsi
> new file mode 100644
> index 000000000000..eeb8d20f3fb4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a100-cpu-opp.dtsi
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +// Copyright (c) 2020 Yangtao Li <frank@allwinnertech.com>
> +// Copyright (c) 2020 ShuoSheng Huang <huangshuosheng@allwinnertech.com>
> +
> +/ {
> +	cpu_opp_table: cpu-opp-table {
> +		compatible = "allwinner,sun50i-a100-operating-points";
> +		nvmem-cells = <&cpu_speed_grade>;
> +		opp-shared;
> +
> +		opp@408000000 {
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +			opp-hz = /bits/ 64 <408000000>;
> +
> +			opp-microvolt-speed0 = <900000 900000 1200000>;
> +			opp-microvolt-speed1 = <900000 900000 1200000>;
> +			opp-microvolt-speed2 = <900000 900000 1200000>;

Is there actually an advantage when using the three cells version?
I wonder if we should go with just the target voltage (the first cell
here), as done for the H616.

Apart from that it looks fine to me.

Cheers,
Andre.

> +		};
> +
> +		opp@600000000 {
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +			opp-hz = /bits/ 64 <600000000>;
> +
> +			opp-microvolt-speed0 = <900000 900000 1200000>;
> +			opp-microvolt-speed1 = <900000 900000 1200000>;
> +			opp-microvolt-speed2 = <900000 900000 1200000>;
> +		};
> +
> +		opp@816000000 {
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +			opp-hz = /bits/ 64 <816000000>;
> +
> +			opp-microvolt-speed0 = <940000 940000 1200000>;
> +			opp-microvolt-speed1 = <900000 900000 1200000>;
> +			opp-microvolt-speed2 = <900000 900000 1200000>;
> +		};
> +
> +		opp@1080000000 {
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +			opp-hz = /bits/ 64 <1080000000>;
> +
> +			opp-microvolt-speed0 = <1020000 1020000 1200000>;
> +			opp-microvolt-speed1 = <980000 980000 1200000>;
> +			opp-microvolt-speed2 = <950000 950000 1200000>;
> +		};
> +
> +		opp@1200000000 {
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +			opp-hz = /bits/ 64 <1200000000>;
> +
> +			opp-microvolt-speed0 = <1100000 1100000 1200000>;
> +			opp-microvolt-speed1 = <1020000 1020000 1200000>;
> +			opp-microvolt-speed2 = <1000000 1000000 1200000>;
> +		};
> +
> +		opp@1320000000 {
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +			opp-hz = /bits/ 64 <1320000000>;
> +
> +			opp-microvolt-speed0 = <1160000 1160000 1200000>;
> +			opp-microvolt-speed1 = <1060000 1060000 1200000>;
> +			opp-microvolt-speed2 = <1030000 1030000 1200000>;
> +		};
> +
> +		opp@1464000000 {
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +			opp-hz = /bits/ 64 <1464000000>;
> +
> +			opp-microvolt-speed0 = <1180000 1180000 1200000>;
> +			opp-microvolt-speed1 = <1180000 1180000 1200000>;
> +			opp-microvolt-speed2 = <1130000 1130000 1200000>;
> +		};
> +	};
> +};
> +
> +&cpu0 {
> +	operating-points-v2 = <&cpu_opp_table>;
> +};
> +
> +&cpu1 {
> +	operating-points-v2 = <&cpu_opp_table>;
> +};
> +
> +&cpu2 {
> +	operating-points-v2 = <&cpu_opp_table>;
> +};
> +
> +&cpu3 {
> +	operating-points-v2 = <&cpu_opp_table>;
> +};
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> index 6dca766ea222..747a0292ef98 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> @@ -23,6 +23,7 @@ cpu0: cpu@0 {
>  			device_type = "cpu";
>  			reg = <0x0>;
>  			enable-method = "psci";
> +			clocks = <&ccu CLK_CPUX>;
>  		};
>  
>  		cpu1: cpu@1 {
> @@ -30,6 +31,7 @@ cpu1: cpu@1 {
>  			device_type = "cpu";
>  			reg = <0x1>;
>  			enable-method = "psci";
> +			clocks = <&ccu CLK_CPUX>;
>  		};
>  
>  		cpu2: cpu@2 {
> @@ -37,6 +39,7 @@ cpu2: cpu@2 {
>  			device_type = "cpu";
>  			reg = <0x2>;
>  			enable-method = "psci";
> +			clocks = <&ccu CLK_CPUX>;
>  		};
>  
>  		cpu3: cpu@3 {
> @@ -44,6 +47,7 @@ cpu3: cpu@3 {
>  			device_type = "cpu";
>  			reg = <0x3>;
>  			enable-method = "psci";
> +			clocks = <&ccu CLK_CPUX>;
>  		};
>  	};
>  
> @@ -142,6 +146,10 @@ efuse@3006000 {
>  			ths_calibration: calib@14 {
>  				reg = <0x14 8>;
>  			};
> +
> +			cpu_speed_grade: cpu-speed-grade@1c {
> +				reg = <0x1c 0x2>;
> +			};
>  		};
>  
>  		watchdog@30090a0 {


