Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C50FA12B1BB
	for <lists+linux-pm@lfdr.de>; Fri, 27 Dec 2019 07:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfL0GWl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Dec 2019 01:22:41 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39303 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfL0GWk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Dec 2019 01:22:40 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so8403492plp.6
        for <linux-pm@vger.kernel.org>; Thu, 26 Dec 2019 22:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kSr9mOsoSEnmbzL9sPT40m2QkkfYAnlyHFJj5NZPWNU=;
        b=Ds3MWX7K5VZ17E0RrNX8tRbeEyCEgSWJ4t7WfmNhE1CUEIDnQsmPKJvFp08frN9neN
         WihaVs0+SolAZRZQmuLgOflrjqtSi3LDnA7l8vfXVPOHl9hNLyZjCCkF6k72yi9ebibP
         tNb+D8p4SaVyZjWpHQ5MMOuNnIOt/IagCWsfdsSBkesRLPxDphVM/fMs7wMXg6ssiQ3W
         NXjASXM0J9YfN8ja0cmqEoMSWyTMkL6K5E3MS7hwhu0eW4dkjIrMYVWotzuqkaLcKNMc
         f+aPKLySIU3Hsuz4qGwLnh8yTALZucvtc7Y0gsxAerTnLOMysM3GY8FvH9hjMDQml8DQ
         FZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kSr9mOsoSEnmbzL9sPT40m2QkkfYAnlyHFJj5NZPWNU=;
        b=XFSw1VDp1U1palmyAcj0p1v/GQYjhhVhS4iS6WvikwnHyBeaH5K6QNOMD8uju16IPB
         gHz7UHSgL+rTewg/IOUYKDHL/JQsJXhCNnj9de4E33ISvrbtcZnY3Qm4tmyRLKEfnPrh
         7r/vvjAUEdQHM18FYWRmK8VRUkqUYmL9cif9sIDwYHtc3oIC791npoXn5zEkBih9DtJf
         sWJq/R+CSGICSzfYNlMBTXK2UUJBP9TDBYkapnynX9DsP+4Jukj2fByrDCQEW7Lfm2In
         k18wmW+M/7NKjbbLU9G4nh92codeu6sWFqmwxwHhEeH6AOWnRBT4gffXlXZbdC1HWde1
         DCnw==
X-Gm-Message-State: APjAAAUJNZQMvTIS5vpuZZ++V5G0xLk+iPNKMnqA7uXcgGVsUtKHBhON
        H7xXoZ606fhviGX9Yy5Sdrpnhw==
X-Google-Smtp-Source: APXvYqy5NmPkkw2TYwp4DZVgwdJToq40tZNIT3DUjWj4HOafdx8i2VZLXcb55SeUdddApCbH68Wqug==
X-Received: by 2002:a17:90b:438e:: with SMTP id in14mr23541131pjb.83.1577427758920;
        Thu, 26 Dec 2019 22:22:38 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g67sm35825321pfb.66.2019.12.26.22.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 22:22:38 -0800 (PST)
Date:   Thu, 26 Dec 2019 22:22:35 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rajeshwari <rkambl@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        sanm@codeaurora.org, sivaa@codeaurora.org, manafm@codeaurora.org
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sc7180:  Add critical interrupt
 and cooling maps for TSENS in SC7180.
Message-ID: <20191227062235.GM549437@yoga>
References: <1577106871-19863-1-git-send-email-rkambl@codeaurora.org>
 <1577106871-19863-2-git-send-email-rkambl@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577106871-19863-2-git-send-email-rkambl@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon 23 Dec 05:14 PST 2019, Rajeshwari wrote:

This patch adds critical interrupt to tsens nodes, add cooling maps,
renames nodes and renames labels.

While the end result looks reasonable I would like to see this split in
a few different patches - and perhaps a line or two in the commit
message describing the new naming scheme for the renames.

Thanks,
Bjorn

> Signed-off-by: Rajeshwari <rkambl@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 289 +++++++++++++++++++++++++++++------
>  1 file changed, 239 insertions(+), 50 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 3676bfd..e419ca0 100644
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
> @@ -1301,277 +1312,455 @@
>  	};
>  
>  	thermal-zones {
> -		cpu0-thermal {
> +		cpu_0_0-thermal {
>  			polling-delay-passive = <250>;
>  			polling-delay = <1000>;
>  
>  			thermal-sensors = <&tsens0 1>;
>  
>  			trips {
> -				cpu0_alert0: trip-point0 {
> +				cpu_0_0_alert0: trip-point0 {
>  					temperature = <90000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
>  
> -				cpu0_alert1: trip-point1 {
> +				cpu_0_0_alert1: trip-point1 {
>  					temperature = <95000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
>  
> -				cpu0_crit: cpu_crit {
> +				cpu_0_0_crit: cpu_crit {
>  					temperature = <110000>;
>  					hysteresis = <1000>;
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu_0_0_alert0>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +				map1 {
> +					trip = <&cpu_0_0_alert1>;
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
> -		cpu1-thermal {
> +		cpu_0_1-thermal {
>  			polling-delay-passive = <250>;
>  			polling-delay = <1000>;
>  
>  			thermal-sensors = <&tsens0 2>;
>  
>  			trips {
> -				cpu1_alert0: trip-point0 {
> +				cpu_0_1_alert0: trip-point0 {
>  					temperature = <90000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
>  
> -				cpu1_alert1: trip-point1 {
> +				cpu_0_1_alert1: trip-point1 {
>  					temperature = <95000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
>  
> -				cpu1_crit: cpu_crit {
> +				cpu_0_1_crit: cpu_crit {
>  					temperature = <110000>;
>  					hysteresis = <1000>;
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu_0_1_alert0>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +				map1 {
> +					trip = <&cpu_0_1_alert1>;
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
> -		cpu2-thermal {
> +		cpu_0_2-thermal {
>  			polling-delay-passive = <250>;
>  			polling-delay = <1000>;
>  
>  			thermal-sensors = <&tsens0 3>;
>  
>  			trips {
> -				cpu2_alert0: trip-point0 {
> +				cpu_0_2_alert0: trip-point0 {
>  					temperature = <90000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
>  
> -				cpu2_alert1: trip-point1 {
> +				cpu_0_2_alert1: trip-point1 {
>  					temperature = <95000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
>  
> -				cpu2_crit: cpu_crit {
> +				cpu_0_2_crit: cpu_crit {
>  					temperature = <110000>;
>  					hysteresis = <1000>;
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu_0_2_alert0>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +				map1 {
> +					trip = <&cpu_0_2_alert1>;
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
> -		cpu3-thermal {
> +		cpu_0_3-thermal {
>  			polling-delay-passive = <250>;
>  			polling-delay = <1000>;
>  
>  			thermal-sensors = <&tsens0 4>;
>  
>  			trips {
> -				cpu3_alert0: trip-point0 {
> +				cpu_0_3_alert0: trip-point0 {
>  					temperature = <90000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
>  
> -				cpu3_alert1: trip-point1 {
> +				cpu_0_3_alert1: trip-point1 {
>  					temperature = <95000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
>  
> -				cpu3_crit: cpu_crit {
> +				cpu_0_3_crit: cpu_crit {
>  					temperature = <110000>;
>  					hysteresis = <1000>;
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu_0_3_alert0>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +				map1 {
> +					trip = <&cpu_0_3_alert1>;
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
> -		cpu4-thermal {
> +		cpu_0_4-thermal {
>  			polling-delay-passive = <250>;
>  			polling-delay = <1000>;
>  
>  			thermal-sensors = <&tsens0 5>;
>  
>  			trips {
> -				cpu4_alert0: trip-point0 {
> +				cpu_0_4_alert0: trip-point0 {
>  					temperature = <90000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
>  
> -				cpu4_alert1: trip-point1 {
> +				cpu_0_4_alert1: trip-point1 {
>  					temperature = <95000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
>  
> -				cpu4_crit: cpu_crit {
> +				cpu_0_4_crit: cpu_crit {
>  					temperature = <110000>;
>  					hysteresis = <1000>;
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu_0_4_alert0>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +				map1 {
> +					trip = <&cpu_0_4_alert1>;
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
> -		cpu5-thermal {
> +		cpu_0_5-thermal {
>  			polling-delay-passive = <250>;
>  			polling-delay = <1000>;
>  
>  			thermal-sensors = <&tsens0 6>;
>  
>  			trips {
> -				cpu5_alert0: trip-point0 {
> +				cpu_0_5_alert0: trip-point0 {
>  					temperature = <90000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
>  
> -				cpu5_alert1: trip-point1 {
> +				cpu_0_5_alert1: trip-point1 {
>  					temperature = <95000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
>  
> -				cpu5_crit: cpu_crit {
> +				cpu_0_5_crit: cpu_crit {
>  					temperature = <110000>;
>  					hysteresis = <1000>;
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu_0_5_alert0>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +				map1 {
> +					trip = <&cpu_0_5_alert1>;
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
> -		cpu6-thermal {
> +		cpu_1_0-thermal {
>  			polling-delay-passive = <250>;
>  			polling-delay = <1000>;
>  
>  			thermal-sensors = <&tsens0 9>;
>  
>  			trips {
> -				cpu6_alert0: trip-point0 {
> +				cpu_1_0_alert0: trip-point0 {
>  					temperature = <90000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
>  
> -				cpu6_alert1: trip-point1 {
> +				cpu_1_0_alert1: trip-point1 {
>  					temperature = <95000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
>  
> -				cpu6_crit: cpu_crit {
> +				cpu_1_0_crit: cpu_crit {
>  					temperature = <110000>;
>  					hysteresis = <1000>;
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu_1_0_alert0>;
> +					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +				map1 {
> +					trip = <&cpu_1_0_alert1>;
> +					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
>  
> -		cpu7-thermal {
> +		cpu_1_1-thermal {
>  			polling-delay-passive = <250>;
>  			polling-delay = <1000>;
>  
>  			thermal-sensors = <&tsens0 10>;
>  
>  			trips {
> -				cpu7_alert0: trip-point0 {
> +				cpu_1_1_alert0: trip-point0 {
>  					temperature = <90000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
>  
> -				cpu7_alert1: trip-point1 {
> +				cpu_1_1_alert1: trip-point1 {
>  					temperature = <95000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
>  
> -				cpu7_crit: cpu_crit {
> +				cpu_1_1_crit: cpu_crit {
>  					temperature = <110000>;
>  					hysteresis = <1000>;
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu_1_1_alert0>;
> +					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +				map1 {
> +					trip = <&cpu_1_1_alert1>;
> +					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
>  
> -		cpu8-thermal {
> +		cpu_1_2-thermal {
>  			polling-delay-passive = <250>;
>  			polling-delay = <1000>;
>  
>  			thermal-sensors = <&tsens0 11>;
>  
>  			trips {
> -				cpu8_alert0: trip-point0 {
> +				cpu_1_2_alert0: trip-point0 {
>  					temperature = <90000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
>  
> -				cpu8_alert1: trip-point1 {
> +				cpu_1_2_alert1: trip-point1 {
>  					temperature = <95000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
>  
> -				cpu8_crit: cpu_crit {
> +				cpu_1_2_crit: cpu_crit {
>  					temperature = <110000>;
>  					hysteresis = <1000>;
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu_1_2_alert0>;
> +					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +				map1 {
> +					trip = <&cpu_1_2_alert1>;
> +					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
>  
> -		cpu9-thermal {
> +		cpu_1_3-thermal {
>  			polling-delay-passive = <250>;
>  			polling-delay = <1000>;
>  
>  			thermal-sensors = <&tsens0 12>;
>  
>  			trips {
> -				cpu9_alert0: trip-point0 {
> +				cpu_1_3_alert0: trip-point0 {
>  					temperature = <90000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
>  
> -				cpu9_alert1: trip-point1 {
> +				cpu_1_3_alert1: trip-point1 {
>  					temperature = <95000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
>  
> -				cpu9_crit: cpu_crit {
> +				cpu_1_3_crit: cpu_crit {
>  					temperature = <110000>;
>  					hysteresis = <1000>;
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu_1_3_alert0>;
> +					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +				map1 {
> +					trip = <&cpu_1_3_alert1>;
> +					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
>  
> -		aoss0-thermal {
> +		aoss_0-thermal {
>  			polling-delay-passive = <250>;
>  			polling-delay = <1000>;
>  
> @@ -1586,7 +1775,7 @@
>  			};
>  		};
>  
> -		cpuss0-thermal {
> +		cpuss_0-thermal {
>  			polling-delay-passive = <250>;
>  			polling-delay = <1000>;
>  
> @@ -1606,7 +1795,7 @@
>  			};
>  		};
>  
> -		cpuss1-thermal {
> +		cpuss_1-thermal {
>  			polling-delay-passive = <250>;
>  			polling-delay = <1000>;
>  
> @@ -1626,7 +1815,7 @@
>  			};
>  		};
>  
> -		gpuss0-thermal {
> +		gpuss_0-thermal {
>  			polling-delay-passive = <250>;
>  			polling-delay = <1000>;
>  
> @@ -1641,7 +1830,7 @@
>  			};
>  		};
>  
> -		gpuss1-thermal {
> +		gpuss_1-thermal {
>  			polling-delay-passive = <250>;
>  			polling-delay = <1000>;
>  
> @@ -1656,7 +1845,7 @@
>  			};
>  		};
>  
> -		aoss1-thermal {
> +		aoss_1-thermal {
>  			polling-delay-passive = <250>;
>  			polling-delay = <1000>;
>  
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
> of Code Aurora Forum, hosted by The Linux Foundation
> 
