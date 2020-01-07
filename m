Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D392131F8A
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 06:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbgAGFsg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 00:48:36 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:33797 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbgAGFsf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2020 00:48:35 -0500
Received: by mail-pj1-f67.google.com with SMTP id s94so4958920pjc.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Jan 2020 21:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/Jx6rA+36XfIfQu+MZydrb1BTdiVKLgWOsWD4CYvZ/s=;
        b=m+aVEC+1ABis6TISHiquAMVXHS9kBp2CYA6CLbdCZk2JqdIHf+xu5+LJFQh6y883uh
         9Dr0viyooRJ+pnKFITJGcRJu831ZE8fsWGPmZcT7nQx0bq/zhRT1VwFm4dBgwg9wdMIN
         kgNkpyzTJcbwgZStKvd3zAtXGHZspEHvwibfDUywbAaspMvZLRRwwHHTX6N2QEq3Cqly
         5++V18Nq87HlZ/IXsCeveYEjFm/lj5I/nyC48HAK41x/zXjtD6NMsHb2eRpVlC3GC1jQ
         /hJBJ0TWG+ryJJREQQ3n1ld4sRR/n1FPU4WowDBBnxXISygTuw4jkyMPkTKjBz8j0JVD
         NkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/Jx6rA+36XfIfQu+MZydrb1BTdiVKLgWOsWD4CYvZ/s=;
        b=CfdAwldnny8Zejtj7wjDXfY9SOtbW3K3O+y/kASxH2CBgiAOUwyn1eTx+jU4SjiETW
         DPzryZx8hO9LTcYLZr5o/zhREQuCeCzpd+Jq7APN1A4yEls3gB0KGMhvxiOG2iB7GKlt
         OHS83kbeDKxMK4aJKc82cOdmOS9GWXaVWXSaKMPH4jI4tzzzGbdS3Xyl7pFs0zobc+ok
         WfhFg+LWPY4pBflzN4fV3ucsdFtKbYjbUrUB6bhVhDiOXewPF9unyC6sADLgNyjIkxDf
         MVOnZ0cjiQilf2aT37C2+7yGhpmtlivet4brk3G82XfK5jeBj2b00VFCDYYdIOr73CQF
         8Otw==
X-Gm-Message-State: APjAAAUCtDZ8ae4y8E2NMmg+DFbxd6UDgieK+V9s/yTl/RLVlcFyOTJI
        VbTHc9aaqDRa9s2lDVOB1Ur6Xw==
X-Google-Smtp-Source: APXvYqwgoEZX2ztUZ+pSpCQgR4QtYMRGaaTqBjshN7fsHcQpc9mmRVxyR1n5Pf2WB/kPQIh8GvW03w==
X-Received: by 2002:a17:902:d705:: with SMTP id w5mr101440520ply.68.1578376113546;
        Mon, 06 Jan 2020 21:48:33 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id o10sm74370634pgq.68.2020.01.06.21.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 21:48:32 -0800 (PST)
Date:   Mon, 6 Jan 2020 21:48:30 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rajeshwari <rkambl@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        sanm@codeaurora.org, sivaa@codeaurora.org, manaf@codeaurora.org
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: sc7180: Add critical interrupt
 and cooling maps for TSENS in SC7180
Message-ID: <20200107054830.GA4023550@builder>
References: <1578317369-16045-1-git-send-email-rkambl@codeaurora.org>
 <1578317369-16045-2-git-send-email-rkambl@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578317369-16045-2-git-send-email-rkambl@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon 06 Jan 05:29 PST 2020, Rajeshwari wrote:

> Added critical interrupt support in TSENS node and cooling maps in Thermal-zones node.
> 
> Signed-off-by: Rajeshwari <rkambl@codeaurora.org>

Patch applied, with Amit's tag.

Thanks,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 197 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 193 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 3676bfd..c414ce0 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -10,6 +10,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/phy/phy-qcom-qusb2.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +#include <dt-bindings/thermal/thermal.h>
>  
>  / {
>  	interrupt-parent = <&intc>;
> @@ -78,6 +79,7 @@
>  			reg = <0x0 0x0>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
> +			#cooling-cells = <2>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
>  			L2_0: l2-cache {
>  				compatible = "cache";
> @@ -94,6 +96,7 @@
>  			reg = <0x0 0x100>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_100>;
> +			#cooling-cells = <2>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
>  			L2_100: l2-cache {
>  				compatible = "cache";
> @@ -107,6 +110,7 @@
>  			reg = <0x0 0x200>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_200>;
> +			#cooling-cells = <2>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
>  			L2_200: l2-cache {
>  				compatible = "cache";
> @@ -120,6 +124,7 @@
>  			reg = <0x0 0x300>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_300>;
> +			#cooling-cells = <2>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
>  			L2_300: l2-cache {
>  				compatible = "cache";
> @@ -133,6 +138,7 @@
>  			reg = <0x0 0x400>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_400>;
> +			#cooling-cells = <2>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
>  			L2_400: l2-cache {
>  				compatible = "cache";
> @@ -146,6 +152,7 @@
>  			reg = <0x0 0x500>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_500>;
> +			#cooling-cells = <2>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
>  			L2_500: l2-cache {
>  				compatible = "cache";
> @@ -159,6 +166,7 @@
>  			reg = <0x0 0x600>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_600>;
> +			#cooling-cells = <2>;
>  			qcom,freq-domain = <&cpufreq_hw 1>;
>  			L2_600: l2-cache {
>  				compatible = "cache";
> @@ -172,6 +180,7 @@
>  			reg = <0x0 0x700>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_700>;
> +			#cooling-cells = <2>;
>  			qcom,freq-domain = <&cpufreq_hw 1>;
>  			L2_700: l2-cache {
>  				compatible = "cache";
> @@ -1058,8 +1067,9 @@
>  			reg = <0 0x0c263000 0 0x1ff>, /* TM */
>  				<0 0x0c222000 0 0x1ff>; /* SROT */
>  			#qcom,sensors = <15>;
> -			interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names = "uplow";
> +			interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "uplow","critical";
>  			#thermal-sensor-cells = <1>;
>  		};
>  
> @@ -1068,8 +1078,9 @@
>  			reg = <0 0x0c265000 0 0x1ff>, /* TM */
>  				<0 0x0c223000 0 0x1ff>; /* SROT */
>  			#qcom,sensors = <10>;
> -			interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names = "uplow";
> +			interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 509 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "uplow","critical";
>  			#thermal-sensor-cells = <1>;
>  		};
>  
> @@ -1326,6 +1337,27 @@
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu0_alert0>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +				map1 {
> +					trip = <&cpu0_alert1>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
>  
>  		cpu1-thermal {
> @@ -1353,6 +1385,27 @@
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu1_alert0>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +				map1 {
> +					trip = <&cpu1_alert1>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
>  
>  		cpu2-thermal {
> @@ -1380,6 +1433,27 @@
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu2_alert0>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +				map1 {
> +					trip = <&cpu2_alert1>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
>  
>  		cpu3-thermal {
> @@ -1407,6 +1481,27 @@
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu3_alert0>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +				map1 {
> +					trip = <&cpu3_alert1>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
>  
>  		cpu4-thermal {
> @@ -1434,6 +1529,27 @@
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu4_alert0>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +				map1 {
> +					trip = <&cpu4_alert1>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
>  
>  		cpu5-thermal {
> @@ -1461,6 +1577,27 @@
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu5_alert0>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +				map1 {
> +					trip = <&cpu5_alert1>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
>  
>  		cpu6-thermal {
> @@ -1488,6 +1625,19 @@
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu6_alert0>;
> +					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +				map1 {
> +					trip = <&cpu6_alert1>;
> +					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
>  
>  		cpu7-thermal {
> @@ -1515,6 +1665,19 @@
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu7_alert0>;
> +					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +				map1 {
> +					trip = <&cpu7_alert1>;
> +					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
>  
>  		cpu8-thermal {
> @@ -1542,6 +1705,19 @@
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu8_alert0>;
> +					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +				map1 {
> +					trip = <&cpu8_alert1>;
> +					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
>  
>  		cpu9-thermal {
> @@ -1569,6 +1745,19 @@
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu9_alert0>;
> +					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +				map1 {
> +					trip = <&cpu9_alert1>;
> +					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
>  
>  		aoss0-thermal {
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
> of Code Aurora Forum, hosted by The Linux Foundation
> 
