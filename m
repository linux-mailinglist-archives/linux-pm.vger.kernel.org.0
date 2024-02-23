Return-Path: <linux-pm+bounces-4355-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B443861D14
	for <lists+linux-pm@lfdr.de>; Fri, 23 Feb 2024 20:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E2321C24B9C
	for <lists+linux-pm@lfdr.de>; Fri, 23 Feb 2024 19:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9085013DBA8;
	Fri, 23 Feb 2024 19:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ms6R6aRT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DC31448FF;
	Fri, 23 Feb 2024 19:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708718353; cv=none; b=YleSf2Dj+gBpn/J+Pe3JfqBh+fr4/tvSyRckAMPn9eek/dcD61OaGYd6DfrB9uf1Bd5ZT9iXPVETgLJZ+OY+SlpqKY/SSm61ksgA1H4vC3XssHvAf+KOhGm0GYbj/DTj2QF1PGwdO7sZiCUDKkGVGxLONIsaxwkPY6t9w8XwGbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708718353; c=relaxed/simple;
	bh=0RfNMB8U2OJeZoXfNYmx+4+5DBHIL//3DzUbkh54gbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M3OzvxaMmUAwzteIOgtuj6hqAIOITPeXxs2OsK3hsx61rJ4us0UnxvuHBspLvjm0Z+0f0zX/4du1ByUanirC1mkytjoZJBG1aXdmieNOpr61HrWAU6LlwKOWfkraLaNiDRrLUjNA7GIRrP0ev7y8FwH1UK2z8QxKXQj/li4Dpno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ms6R6aRT; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3f5808b0dfso168428066b.1;
        Fri, 23 Feb 2024 11:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708718350; x=1709323150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z894Zg2CSZbZzbMtWOcHDsDVjOprmfGRO35Ki4YUhH0=;
        b=ms6R6aRTHcFhNrpE7dl2x+EIvxtUq3Dp7UO/ZJS2ZBPtIIJu52lcwoAtKslXXdm1fW
         CZuPyaBEgBx7muEa1OqnhFzwyGkhuqFs2/TD1bXBKgCdFWnztccecmBdN+d3Gc/yfq/H
         3s16BbNSSaHxDoNsI5zF85LTiMr99GSbsQdVJEJpqcfkagHUjkYEnZiE9RvviGk5rXXL
         08A8wAx2ixgsSKWwMeqK+fZqiRc+RIfhPv/zJfNbWQbcaK2EtnOsdax90uvdvk6/0AVm
         tNZAo85ctWjF2hqySb5M62tCmNG77l95FwpzSlFne61wOMJCuZVcFoNC2ugswukaurAH
         TS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708718350; x=1709323150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z894Zg2CSZbZzbMtWOcHDsDVjOprmfGRO35Ki4YUhH0=;
        b=paHlmQz+am90kFQ5lIe4M+6eZ0bx/2DFkdMC7khsk4VwGZ93wyfVgjJEieIxnqn3ou
         7+RecdDW1BTy7PGMQGfV5cASnh+XD51VES6YMOdsHtY3LZr1cCUCbEaLldtwrVJL3nIN
         AJtRp4ArETgdNRFbVvVtuWIzq1ed2S2TKny2fHqLVqfhhP8k5kgwju6OAubd5fZlH1ZA
         cq4Uth6mSAsnyDUlHLFRCIG8RKA7DpOQ1eQdyAi2qc2TJSt5zC0XJaP3gX4xw5xzjHn+
         Vmq9JRHvULw1zqyXXjBvL4a/CPXEmbXQFrPC0uVvMTix83H26sGTd1hDY2H9VdSsZ/+8
         dw5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJbp1kojTBC12PYm//4YAy8vF1jwC4+2tLNGwVGqF0lg+/RvzqFf6q4m2iN3aimaN42/yYps+l5WxwLMJGCUfz+caTOHkHc6n2BG6YiXHofi8xKDrnFDRcVLOfVSgW9vDkuCv1
X-Gm-Message-State: AOJu0YyiO9EezMF8BrCHlG2dz9+vOzuMIAFzaj0CmOtXiO9OrvOjxoXY
	JVVdtO3mzWHl6OaXdpesGSNLEyudXnFHsmY66ua545jypd2SkfuB
X-Google-Smtp-Source: AGHT+IHa3BodFIBcxDRDYeqP+u89pkUBXtdIKmif9raMa9dTkft1TZXDVm+m+J5uzAoci0my3baSQw==
X-Received: by 2002:a17:906:4bd4:b0:a3e:7a8f:27dc with SMTP id x20-20020a1709064bd400b00a3e7a8f27dcmr485556ejv.49.1708718350027;
        Fri, 23 Feb 2024 11:59:10 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id vw15-20020a170907a70f00b00a3f3a5d6752sm2811107ejc.51.2024.02.23.11.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 11:59:09 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>,
 Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Andre Przywara <andre.przywara@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Martin Botka <martin.botka@somainline.org>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Bob McChesney <bob@electricworry.net>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
Subject:
 Re: [PATCH v5 7/7] arm64: dts: allwinner: h616: Add thermal sensor and zones
Date: Fri, 23 Feb 2024 20:59:08 +0100
Message-ID: <6017645.lOV4Wx5bFT@jernej-laptop>
In-Reply-To: <20240219153639.179814-8-andre.przywara@arm.com>
References:
 <20240219153639.179814-1-andre.przywara@arm.com>
 <20240219153639.179814-8-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne ponedeljek, 19. februar 2024 ob 16:36:39 CET je Andre Przywara napisal(a):
> From: Martin Botka <martin.botka@somainline.org>
> 
> There are four thermal sensors:
> - CPU
> - GPU
> - VE
> - DRAM
> 
> Add the thermal sensor configuration and the thermal zones.
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

I can't cleanly apply patch on top of sunxi/dt-for-6.9. Can you please rebase?

Best regards,
Jernej

> ---
>  .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 88 +++++++++++++++++++
>  1 file changed, 88 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> index 12ffabc79bcde..7c7d7c285505c 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> @@ -9,6 +9,7 @@
>  #include <dt-bindings/clock/sun6i-rtc.h>
>  #include <dt-bindings/reset/sun50i-h616-ccu.h>
>  #include <dt-bindings/reset/sun50i-h6-r-ccu.h>
> +#include <dt-bindings/thermal/thermal.h>
>  
>  / {
>  	interrupt-parent = <&gic>;
> @@ -138,6 +139,10 @@ sid: efuse@3006000 {
>  			reg = <0x03006000 0x1000>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> +
> +			ths_calibration: thermal-sensor-calibration@14 {
> +				reg = <0x14 0x8>;
> +			};
>  		};
>  
>  		watchdog: watchdog@30090a0 {
> @@ -517,6 +522,19 @@ mdio0: mdio {
>  			};
>  		};
>  
> +		ths: thermal-sensor@5070400 {
> +			compatible = "allwinner,sun50i-h616-ths";
> +			reg = <0x05070400 0x400>;
> +			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_THS>;
> +			clock-names = "bus";
> +			resets = <&ccu RST_BUS_THS>;
> +			nvmem-cells = <&ths_calibration>;
> +			nvmem-cell-names = "calibration";
> +			allwinner,sram = <&syscon>;
> +			#thermal-sensor-cells = <1>;
> +		};
> +
>  		usbotg: usb@5100000 {
>  			compatible = "allwinner,sun50i-h616-musb",
>  				     "allwinner,sun8i-h3-musb";
> @@ -761,4 +779,74 @@ r_rsb: rsb@7083000 {
>  			#size-cells = <0>;
>  		};
>  	};
> +
> +	thermal-zones {
> +		cpu-thermal {
> +			polling-delay-passive = <500>;
> +			polling-delay = <1000>;
> +			thermal-sensors = <&ths 2>;
> +			sustainable-power = <1000>;
> +
> +			trips {
> +				cpu_threshold: cpu-trip-0 {
> +					temperature = <60000>;
> +					type = "passive";
> +					hysteresis = <0>;
> +				};
> +				cpu_target: cpu-trip-1 {
> +					temperature = <70000>;
> +					type = "passive";
> +					hysteresis = <0>;
> +				};
> +				cpu_critical: cpu-trip-2 {
> +					temperature = <110000>;
> +					type = "critical";
> +					hysteresis = <0>;
> +				};
> +			};
> +		};
> +
> +		gpu-thermal {
> +			polling-delay-passive = <500>;
> +			polling-delay = <1000>;
> +			thermal-sensors = <&ths 0>;
> +			sustainable-power = <1100>;
> +
> +			trips {
> +				gpu_temp_critical: gpu-trip-0 {
> +					temperature = <110000>;
> +					type = "critical";
> +					hysteresis = <0>;
> +				};
> +			};
> +		};
> +
> +		ve-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&ths 1>;
> +
> +			trips {
> +				ve_temp_critical: ve-trip-0 {
> +					temperature = <110000>;
> +					type = "critical";
> +					hysteresis = <0>;
> +				};
> +			};
> +		};
> +
> +		ddr-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&ths 3>;
> +
> +			trips {
> +				ddr_temp_critical: ddr-trip-0 {
> +					temperature = <110000>;
> +					type = "critical";
> +					hysteresis = <0>;
> +				};
> +			};
> +		};
> +	};
>  };
> 





