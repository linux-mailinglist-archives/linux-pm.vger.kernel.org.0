Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F74D1FE684
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jun 2020 04:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbgFRCeU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jun 2020 22:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728749AbgFRCeN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jun 2020 22:34:13 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5027CC061755
        for <linux-pm@vger.kernel.org>; Wed, 17 Jun 2020 19:34:12 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y18so1810333plr.4
        for <linux-pm@vger.kernel.org>; Wed, 17 Jun 2020 19:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XUDDulpmIz8RBD0tLJMdlU0cVAglW52rxByxq23Cwpo=;
        b=qdd/ytw8p/D3JyYktShXHrtQeq20s/LwbZuT/zVeREvp8ZMeiGnFKw6KZY9NG6gHpx
         dRq6wqyLUvpVivBNiQNsP6KHpzqr2jvXkAtbFQ5Qwnr8+WW5kELpEl/iqaAm7hjJR+v2
         6Jx8sHC7njwrBoIiZTLtquNi7QOf355dWg5Uc/IaoiiEhyhveaY62vqD+Tk1KmRDcRx5
         NnKYOPx2W7pFKV0AYpdjTzNlM0+5cHXJT1uCIUEoAV80PJDK4ht3CxnBJhQqNzIYsds7
         yrIw1lL2rORzqOmhaGb2yz4qfQi+MtcqyONo47dfyEq7K3pX88s3Me6GQ5DXNVaj6zS/
         7kow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XUDDulpmIz8RBD0tLJMdlU0cVAglW52rxByxq23Cwpo=;
        b=gKDZ6gusCQkxhUspMOPj77vE78t68x8S895y7rhhXw8yVo4YeMilBC7NKQHmvjDwk7
         hZxRzS5hj2VDEOZiBtCHuWzEaEMfffzKo6EveNSZ8NLeEMNwr2B0P6NZYjBmZn/LDsBK
         rUvYmRYoEzX3AKiSZPFUC5OCu2DPwY5r8tjKrlegd5pkL5LANt5enfictF11eFRH47rP
         rbrod0+Z7odLJp6UE+kGUGAgFf1/lB9M+inOY7quVjnpk74euwo8sqfMSohgUTN4ZbwN
         mN0bYevPoAyS8LYxXH54QQKUhDfZ9Jy3LJONaZAOBn36jqkfJYk/Yl2XyoCmoTf+BaeU
         pWqQ==
X-Gm-Message-State: AOAM533jV6Dy987aohjYV9KGWc2CdgjyG+gb0wCfgxGg17/8eLTt5xV0
        fen+bMDJEPnmM8lBydOS6jgz
X-Google-Smtp-Source: ABdhPJzV5s1vxC0fdzzsWicTuF0DucrrRzheF8QQdBPCH2yGOLtggxmg6Xrt4Y5Wa42pHSPGftGB1A==
X-Received: by 2002:a17:90b:e89:: with SMTP id fv9mr1942389pjb.131.1592447651510;
        Wed, 17 Jun 2020 19:34:11 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:610d:119b:3010:a26c:c414:e0a4])
        by smtp.gmail.com with ESMTPSA id r9sm1113640pfq.31.2020.06.17.19.34.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jun 2020 19:34:10 -0700 (PDT)
Date:   Thu, 18 Jun 2020 08:04:02 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, sibis@codeaurora.org,
        dmitry.baryshkov@linaro.org, Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm8250: Add thermal zones and
 throttling support
Message-ID: <20200618023402.GA3817@Mani-XPS-13-9360>
References: <cover.1591684754.git.amit.kucheria@linaro.org>
 <bf5ca7777fbb6f5e2d374a9a72d1e17d485bd8ea.1591684754.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf5ca7777fbb6f5e2d374a9a72d1e17d485bd8ea.1591684754.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 09, 2020 at 12:14:56PM +0530, Amit Kucheria wrote:
> sm8250 has 24 thermal sensors split across two tsens controllers. Add
> the thermal zones to expose them and wireup the cpus to throttle on
> crossing passive temperature thresholds.
> 
> Update the comment in the drivers to list the SoCs it supports.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Tested this patch on an interesting SM8250 based board. Hence,

Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 766 +++++++++++++++++++++++++++
>  drivers/thermal/qcom/tsens-v2.c      |   2 +-
>  2 files changed, 767 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index deaa8415c7b72..5cd18cd8a675b 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -8,6 +8,7 @@
>  #include <dt-bindings/clock/qcom,rpmh.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +#include <dt-bindings/thermal/thermal.h>
>  
>  / {
>  	interrupt-parent = <&intc>;
> @@ -86,6 +87,7 @@ CPU0: cpu@0 {
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
> +			#cooling-cells = <2>;
>  			L2_0: l2-cache {
>  			      compatible = "cache";
>  			      next-level-cache = <&L3_0>;
> @@ -102,6 +104,7 @@ CPU1: cpu@100 {
>  			enable-method = "psci";
>  			next-level-cache = <&L2_100>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
> +			#cooling-cells = <2>;
>  			L2_100: l2-cache {
>  			      compatible = "cache";
>  			      next-level-cache = <&L3_0>;
> @@ -115,6 +118,7 @@ CPU2: cpu@200 {
>  			enable-method = "psci";
>  			next-level-cache = <&L2_200>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
> +			#cooling-cells = <2>;
>  			L2_200: l2-cache {
>  			      compatible = "cache";
>  			      next-level-cache = <&L3_0>;
> @@ -128,6 +132,7 @@ CPU3: cpu@300 {
>  			enable-method = "psci";
>  			next-level-cache = <&L2_300>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
> +			#cooling-cells = <2>;
>  			L2_300: l2-cache {
>  			      compatible = "cache";
>  			      next-level-cache = <&L3_0>;
> @@ -141,6 +146,7 @@ CPU4: cpu@400 {
>  			enable-method = "psci";
>  			next-level-cache = <&L2_400>;
>  			qcom,freq-domain = <&cpufreq_hw 1>;
> +			#cooling-cells = <2>;
>  			L2_400: l2-cache {
>  			      compatible = "cache";
>  			      next-level-cache = <&L3_0>;
> @@ -154,6 +160,7 @@ CPU5: cpu@500 {
>  			enable-method = "psci";
>  			next-level-cache = <&L2_500>;
>  			qcom,freq-domain = <&cpufreq_hw 1>;
> +			#cooling-cells = <2>;
>  			L2_500: l2-cache {
>  			      compatible = "cache";
>  			      next-level-cache = <&L3_0>;
> @@ -168,6 +175,7 @@ CPU6: cpu@600 {
>  			enable-method = "psci";
>  			next-level-cache = <&L2_600>;
>  			qcom,freq-domain = <&cpufreq_hw 1>;
> +			#cooling-cells = <2>;
>  			L2_600: l2-cache {
>  			      compatible = "cache";
>  			      next-level-cache = <&L3_0>;
> @@ -181,6 +189,7 @@ CPU7: cpu@700 {
>  			enable-method = "psci";
>  			next-level-cache = <&L2_700>;
>  			qcom,freq-domain = <&cpufreq_hw 2>;
> +			#cooling-cells = <2>;
>  			L2_700: l2-cache {
>  			      compatible = "cache";
>  			      next-level-cache = <&L3_0>;
> @@ -991,6 +1000,28 @@ pdc: interrupt-controller@b220000 {
>  			interrupt-controller;
>  		};
>  
> +		tsens0: thermal-sensor@c263000 {
> +			compatible = "qcom,sm8250-tsens", "qcom,tsens-v2";
> +			reg = <0 0x0c263000 0 0x1ff>, /* TM */
> +			      <0 0x0c222000 0 0x1ff>; /* SROT */
> +			#qcom,sensors = <16>;
> +			interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "uplow", "critical";
> +			#thermal-sensor-cells = <1>;
> +		};
> +
> +		tsens1: thermal-sensor@c265000 {
> +			compatible = "qcom,sm8250-tsens", "qcom,tsens-v2";
> +			reg = <0 0x0c265000 0 0x1ff>, /* TM */
> +			      <0 0x0c223000 0 0x1ff>; /* SROT */
> +			#qcom,sensors = <9>;
> +			interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 509 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "uplow", "critical";
> +			#thermal-sensor-cells = <1>;
> +		};
> +
>  		spmi_bus: qcom,spmi@c440000 {
>  			compatible = "qcom,spmi-pmic-arb";
>  			reg = <0x0 0x0c440000 0x0 0x0001100>,
> @@ -1753,4 +1784,739 @@ timer {
>  			     <GIC_PPI 12
>  				(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
>  	};
> +
> +	thermal-zones {
> +		cpu0-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 1>;
> +
> +			trips {
> +				cpu0_alert0: trip-point0 {
> +					temperature = <90000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu0_alert1: trip-point1 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu0_crit: cpu_crit {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu0_alert0>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +				map1 {
> +					trip = <&cpu0_alert1>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		cpu1-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 2>;
> +
> +			trips {
> +				cpu1_alert0: trip-point0 {
> +					temperature = <90000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu1_alert1: trip-point1 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu1_crit: cpu_crit {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu1_alert0>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +				map1 {
> +					trip = <&cpu1_alert1>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		cpu2-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 3>;
> +
> +			trips {
> +				cpu2_alert0: trip-point0 {
> +					temperature = <90000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu2_alert1: trip-point1 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu2_crit: cpu_crit {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu2_alert0>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +				map1 {
> +					trip = <&cpu2_alert1>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		cpu3-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 4>;
> +
> +			trips {
> +				cpu3_alert0: trip-point0 {
> +					temperature = <90000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu3_alert1: trip-point1 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu3_crit: cpu_crit {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu3_alert0>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +				map1 {
> +					trip = <&cpu3_alert1>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		cpu4-top-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 7>;
> +
> +			trips {
> +				cpu4_top_alert0: trip-point0 {
> +					temperature = <90000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu4_top_alert1: trip-point1 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu4_top_crit: cpu_crit {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu4_top_alert0>;
> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +				map1 {
> +					trip = <&cpu4_top_alert1>;
> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		cpu5-top-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 8>;
> +
> +			trips {
> +				cpu5_top_alert0: trip-point0 {
> +					temperature = <90000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu5_top_alert1: trip-point1 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu5_top_crit: cpu_crit {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu5_top_alert0>;
> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +				map1 {
> +					trip = <&cpu5_top_alert1>;
> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		cpu6-top-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 9>;
> +
> +			trips {
> +				cpu6_top_alert0: trip-point0 {
> +					temperature = <90000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu6_top_alert1: trip-point1 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu6_top_crit: cpu_crit {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu6_top_alert0>;
> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +				map1 {
> +					trip = <&cpu6_top_alert1>;
> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		cpu7-top-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 10>;
> +
> +			trips {
> +				cpu7_top_alert0: trip-point0 {
> +					temperature = <90000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu7_top_alert1: trip-point1 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu7_top_crit: cpu_crit {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu7_top_alert0>;
> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +				map1 {
> +					trip = <&cpu7_top_alert1>;
> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		cpu4-bottom-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 11>;
> +
> +			trips {
> +				cpu4_bottom_alert0: trip-point0 {
> +					temperature = <90000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu4_bottom_alert1: trip-point1 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu4_bottom_crit: cpu_crit {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu4_bottom_alert0>;
> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +				map1 {
> +					trip = <&cpu4_bottom_alert1>;
> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		cpu5-bottom-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 12>;
> +
> +			trips {
> +				cpu5_bottom_alert0: trip-point0 {
> +					temperature = <90000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu5_bottom_alert1: trip-point1 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu5_bottom_crit: cpu_crit {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu5_bottom_alert0>;
> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +				map1 {
> +					trip = <&cpu5_bottom_alert1>;
> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		cpu6-bottom-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 13>;
> +
> +			trips {
> +				cpu6_bottom_alert0: trip-point0 {
> +					temperature = <90000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu6_bottom_alert1: trip-point1 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu6_bottom_crit: cpu_crit {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu6_bottom_alert0>;
> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +				map1 {
> +					trip = <&cpu6_bottom_alert1>;
> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		cpu7-bottom-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 14>;
> +
> +			trips {
> +				cpu7_bottom_alert0: trip-point0 {
> +					temperature = <90000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu7_bottom_alert1: trip-point1 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu7_bottom_crit: cpu_crit {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu7_bottom_alert0>;
> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +				map1 {
> +					trip = <&cpu7_bottom_alert1>;
> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		aoss0-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 0>;
> +
> +			trips {
> +				aoss0_alert0: trip-point0 {
> +					temperature = <90000>;
> +					hysteresis = <2000>;
> +					type = "hot";
> +				};
> +			};
> +		};
> +
> +		cluster0-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 5>;
> +
> +			trips {
> +				cluster0_alert0: trip-point0 {
> +					temperature = <90000>;
> +					hysteresis = <2000>;
> +					type = "hot";
> +				};
> +				cluster0_crit: cluster0_crit {
> +					temperature = <110000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cluster1-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 6>;
> +
> +			trips {
> +				cluster1_alert0: trip-point0 {
> +					temperature = <90000>;
> +					hysteresis = <2000>;
> +					type = "hot";
> +				};
> +				cluster1_crit: cluster1_crit {
> +					temperature = <110000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		gpu-thermal-top {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 15>;
> +
> +			trips {
> +				gpu1_alert0: trip-point0 {
> +					temperature = <90000>;
> +					hysteresis = <2000>;
> +					type = "hot";
> +				};
> +			};
> +		};
> +
> +		aoss1-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens1 0>;
> +
> +			trips {
> +				aoss1_alert0: trip-point0 {
> +					temperature = <90000>;
> +					hysteresis = <2000>;
> +					type = "hot";
> +				};
> +			};
> +		};
> +
> +		wlan-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens1 1>;
> +
> +			trips {
> +				wlan_alert0: trip-point0 {
> +					temperature = <90000>;
> +					hysteresis = <2000>;
> +					type = "hot";
> +				};
> +			};
> +		};
> +
> +		video-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens1 2>;
> +
> +			trips {
> +				video_alert0: trip-point0 {
> +					temperature = <90000>;
> +					hysteresis = <2000>;
> +					type = "hot";
> +				};
> +			};
> +		};
> +
> +		mem-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens1 3>;
> +
> +			trips {
> +				mem_alert0: trip-point0 {
> +					temperature = <90000>;
> +					hysteresis = <2000>;
> +					type = "hot";
> +				};
> +			};
> +		};
> +
> +		q6-hvx-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens1 4>;
> +
> +			trips {
> +				q6_hvx_alert0: trip-point0 {
> +					temperature = <90000>;
> +					hysteresis = <2000>;
> +					type = "hot";
> +				};
> +			};
> +		};
> +
> +		camera-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens1 5>;
> +
> +			trips {
> +				camera_alert0: trip-point0 {
> +					temperature = <90000>;
> +					hysteresis = <2000>;
> +					type = "hot";
> +				};
> +			};
> +		};
> +
> +		compute-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens1 6>;
> +
> +			trips {
> +				compute_alert0: trip-point0 {
> +					temperature = <90000>;
> +					hysteresis = <2000>;
> +					type = "hot";
> +				};
> +			};
> +		};
> +
> +		npu-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens1 7>;
> +
> +			trips {
> +				npu_alert0: trip-point0 {
> +					temperature = <90000>;
> +					hysteresis = <2000>;
> +					type = "hot";
> +				};
> +			};
> +		};
> +
> +		gpu-thermal-bottom {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens1 8>;
> +
> +			trips {
> +				gpu2_alert0: trip-point0 {
> +					temperature = <90000>;
> +					hysteresis = <2000>;
> +					type = "hot";
> +				};
> +			};
> +		};
> +	};
>  };
> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
> index b293ed32174b5..58cac8f2a358c 100644
> --- a/drivers/thermal/qcom/tsens-v2.c
> +++ b/drivers/thermal/qcom/tsens-v2.c
> @@ -26,7 +26,7 @@
>  #define TM_TRDY_OFF			0x00e4
>  #define TM_WDOG_LOG_OFF		0x013c
>  
> -/* v2.x: 8996, 8998, sdm845 */
> +/* v2.x: 8996, 8998, sc7180, sdm845, sm8150, sm8250 */
>  
>  static struct tsens_features tsens_v2_feat = {
>  	.ver_major	= VER_2_X,
> -- 
> 2.25.1
> 
