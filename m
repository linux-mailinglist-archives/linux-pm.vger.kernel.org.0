Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96BDA3C3296
	for <lists+linux-pm@lfdr.de>; Sat, 10 Jul 2021 06:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhGJEUh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Jul 2021 00:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhGJEUf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Jul 2021 00:20:35 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103DDC0613E5
        for <linux-pm@vger.kernel.org>; Fri,  9 Jul 2021 21:17:51 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 53-20020a9d0eb80000b02904b6c4d33e84so2954221otj.13
        for <linux-pm@vger.kernel.org>; Fri, 09 Jul 2021 21:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oi8mwijOAs1Ydojiq5XE5MdHF4Z1BJedwWBPbyqDAxw=;
        b=XB5SXDz4lbZaKOdpulr5KWaM9g79T2jil2Q9d/oSjhBvFHraqBtD9xR94xWH4mER1j
         lSDnE7mkQagbahpEvq04AXGnS+YkoEyNY5Pf5v8FIjUsQ0X4PhS5z4EFMzGfpnj7muat
         qn8B6VbIXkEgy8lrQhGLfY/yn8+VxdXYUYWLSurn/OWFUdkxGV3X9rk+VF3c771vvWpV
         EozU6B4h/gdhP4LHcuggY5uGtfRSUGe7tr/eedfLn/gn9/ga0eSr1ygNNpX1AcTBaDOY
         3eQErx6J5gTqwA4Xfdwq8PxFQB5Nl5pG8VDae/p6+MJY1ayJiq40/WqpAqOwCa9tpTF9
         +G9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oi8mwijOAs1Ydojiq5XE5MdHF4Z1BJedwWBPbyqDAxw=;
        b=Co3f49rKqBVCEf+SYs3C0UhmC8sK11uBK3LW0D1TjfF8rQXd5kctGkr//JHNBnGx+G
         NR+1+lZdDRs8lZ+9Pj1Mk5ucuCt80LLQvNPxWizIlpfNcF2p0011y0+fe/1a1WNOs2eY
         JgUkMWJt84d0UgUJ6wk+WMEIIP7SEABT9nydi56fxn2AdFycKV7LVBFpB5wbKLhfxSNM
         5yXecYU5Kbv2X5uTliftVkRh2XUMs3JOyZLOSfKDWyw+pLziYEc7v9JFkdsnjjnLJPnu
         mU3TPuqHavwyPIFhNmxAPFZ2HR3s4EIxA1DG+4JuaTasnofR6mKIisn+9kMktkPxBzE5
         AasQ==
X-Gm-Message-State: AOAM5329twBHNnUMQfXvfm+LZtpY5zoTB0HUJs3rsg8vYHwqL1hcHLq4
        k619AngNGYtrxzLXWXZ7X2TaoQ==
X-Google-Smtp-Source: ABdhPJzpMy95PehIM2NViXPvm5va98uz9V2cozsr+ASH1vW5r3mj7LgNYStYf+aFZpGa59zExwFKJg==
X-Received: by 2002:a9d:262:: with SMTP id 89mr19021125otb.31.1625890670445;
        Fri, 09 Jul 2021 21:17:50 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id k14sm1416783oon.5.2021.07.09.21.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 21:17:50 -0700 (PDT)
Date:   Fri, 9 Jul 2021 23:17:47 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     agross@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rjw@rjwysocki.net, robh+dt@kernel.org,
        tdas@codeaurora.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [Patch v3 5/6] arm64: boot: dts: qcom: sdm845: Remove cpufreq
 cooling devices for CPU thermal zones
Message-ID: <YOkfa3nG3l5djiYD@yoga>
References: <20210708120656.663851-1-thara.gopinath@linaro.org>
 <20210708120656.663851-6-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708120656.663851-6-thara.gopinath@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu 08 Jul 07:06 CDT 2021, Thara Gopinath wrote:

> Now that Limits h/w is enabled to monitor thermal events around cpus and
> throttle the cpu frequencies, remove cpufreq cooling device for the CPU
> thermal zones which does software throttling of cpu frequencies.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
> 
> v2->v3:
> 	- Improved the subject header and descrption to better reflect the
> 	  patch as per Matthias's review comments.
> 
> v1->v2:
> 	Removing only cooling maps for cpu specific thermal zones keeping the
> 	trip point definitions intact as per Daniel's suggestion. This is to
> 	ensure that thermal zone temparature and trip violation information is
> 	available to any userspace daemon monitoring these zones.
> 
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 136 ---------------------------
>  1 file changed, 136 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 4da6b8f3dd7b..6185fff8859a 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -4994,23 +4994,6 @@ cpu0_crit: cpu_crit {
>  					type = "critical";
>  				};
>  			};
> -
> -			cooling-maps {
> -				map0 {
> -					trip = <&cpu0_alert0>;
> -					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> -				};
> -				map1 {
> -					trip = <&cpu0_alert1>;
> -					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> -				};
> -			};
>  		};
>  
>  		cpu1-thermal {
> @@ -5038,23 +5021,6 @@ cpu1_crit: cpu_crit {
>  					type = "critical";
>  				};
>  			};
> -
> -			cooling-maps {
> -				map0 {
> -					trip = <&cpu1_alert0>;
> -					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> -				};
> -				map1 {
> -					trip = <&cpu1_alert1>;
> -					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> -				};
> -			};
>  		};
>  
>  		cpu2-thermal {
> @@ -5082,23 +5048,6 @@ cpu2_crit: cpu_crit {
>  					type = "critical";
>  				};
>  			};
> -
> -			cooling-maps {
> -				map0 {
> -					trip = <&cpu2_alert0>;
> -					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> -				};
> -				map1 {
> -					trip = <&cpu2_alert1>;
> -					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> -				};
> -			};
>  		};
>  
>  		cpu3-thermal {
> @@ -5126,23 +5075,6 @@ cpu3_crit: cpu_crit {
>  					type = "critical";
>  				};
>  			};
> -
> -			cooling-maps {
> -				map0 {
> -					trip = <&cpu3_alert0>;
> -					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> -				};
> -				map1 {
> -					trip = <&cpu3_alert1>;
> -					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> -				};
> -			};
>  		};
>  
>  		cpu4-thermal {
> @@ -5170,23 +5102,6 @@ cpu4_crit: cpu_crit {
>  					type = "critical";
>  				};
>  			};
> -
> -			cooling-maps {
> -				map0 {
> -					trip = <&cpu4_alert0>;
> -					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> -				};
> -				map1 {
> -					trip = <&cpu4_alert1>;
> -					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> -				};
> -			};
>  		};
>  
>  		cpu5-thermal {
> @@ -5214,23 +5129,6 @@ cpu5_crit: cpu_crit {
>  					type = "critical";
>  				};
>  			};
> -
> -			cooling-maps {
> -				map0 {
> -					trip = <&cpu5_alert0>;
> -					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> -				};
> -				map1 {
> -					trip = <&cpu5_alert1>;
> -					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> -				};
> -			};
>  		};
>  
>  		cpu6-thermal {
> @@ -5258,23 +5156,6 @@ cpu6_crit: cpu_crit {
>  					type = "critical";
>  				};
>  			};
> -
> -			cooling-maps {
> -				map0 {
> -					trip = <&cpu6_alert0>;
> -					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> -				};
> -				map1 {
> -					trip = <&cpu6_alert1>;
> -					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> -				};
> -			};
>  		};
>  
>  		cpu7-thermal {
> @@ -5302,23 +5183,6 @@ cpu7_crit: cpu_crit {
>  					type = "critical";
>  				};
>  			};
> -
> -			cooling-maps {
> -				map0 {
> -					trip = <&cpu7_alert0>;
> -					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> -				};
> -				map1 {
> -					trip = <&cpu7_alert1>;
> -					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> -				};
> -			};
>  		};
>  
>  		aoss0-thermal {
> -- 
> 2.25.1
> 
