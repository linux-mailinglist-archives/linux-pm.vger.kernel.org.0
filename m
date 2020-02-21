Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84E51167DED
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 14:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgBUNE4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 08:04:56 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39893 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbgBUNEz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 08:04:55 -0500
Received: by mail-wm1-f65.google.com with SMTP id c84so1764306wme.4
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2020 05:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bJNVzMRkFtXXYPsTt3SQwSqc9RpddqkHKGG4HJkeN0I=;
        b=jkgvwEvxyvKjU2Titynfam24eXLGYSEaz4oiQM93hFTl4Jb4XLMaJcbX31PBGNr7S4
         MfS43Igd6k6jCuZzDeWQ/4h204Y84NqG/NxkRws+7Vd1aqGx+rLpsIDijDI9YZUblMYQ
         SAhRpyFYdkWEG2Radn/TtiRKHmfjcVcALIu5A0NbeLfuKvQWyhigGDbvzYoutsWfwMcW
         r3DnA9sqddt7ur7yiPziRvAZlcGuEEFx782y7WHjH2JrzEww9hKjB4lncsJUbOT3ZF2F
         hYNMVWHJRqeUEhM/fSIOyrGp3p5D3BlJFn3jbvtc1r/h2UPfXCW9p1KdWT+TUByJfH1O
         4pxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bJNVzMRkFtXXYPsTt3SQwSqc9RpddqkHKGG4HJkeN0I=;
        b=RPi0TtBL/TnbORLf9/d7JRozreMK691SOf8meyLXnzv4eNi6vLJxtFlaCLwcTDIB0G
         Lb97rXM4O/86nG5bBYSWtQ3QmjEEmmSAzUudEOuNpwdcAza+EOrdV2Uz9+hVNwzmwqRp
         sw6DoahWmJiKm0/CGiAPVeGt6Ivra/lna3bjJXu/3UygwCSfx6lxl5yUKJo/3bz2m0LA
         /Znu+hyXVb/ufit4MnwVma+NQ1V+oa5E+Im7DT1dWQc3sq6CZvuG6TlZw7JGGEA6nlE1
         BFSBlaUuQng6GFOM3Wa0no2E1pxcmZVMclb/8t8j/mXwvaQtzeCqhyPuFJRRCXwJoKrh
         8ojA==
X-Gm-Message-State: APjAAAXBzhapdUlG29V/PKOy/oggAiTY2ATh3QadmkoPNrFPYDq7Kge7
        QySD9OF/HBLAI8lfCkjQvooZoA==
X-Google-Smtp-Source: APXvYqwrCwOw/nJYCU07QgEOQnMfnFDja/YSvf9ktRaNNnMixM8MO9y/tOJAK/QRxV9OsIfVPeM/zw==
X-Received: by 2002:a1c:20d6:: with SMTP id g205mr3942457wmg.38.1582290292313;
        Fri, 21 Feb 2020 05:04:52 -0800 (PST)
Received: from linaro.org ([2a01:e34:ed2f:f020:2dfb:b5ce:9043:4adb])
        by smtp.gmail.com with ESMTPSA id z10sm3561868wmk.31.2020.02.21.05.04.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Feb 2020 05:04:51 -0800 (PST)
Date:   Fri, 21 Feb 2020 14:04:48 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, aisheng.dong@nxp.com,
        linux@roeck-us.net, srinivas.kandagatla@linaro.org,
        krzk@kernel.org, fugang.duan@nxp.com, peng.fan@nxp.com,
        daniel.baluta@nxp.com, bjorn.andersson@linaro.org, olof@lixom.net,
        dinguyen@kernel.org, leonard.crestez@nxp.com,
        marcin.juszkiewicz@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V15 RESEND 5/5] arm64: dts: imx: add i.MX8QXP thermal
 support
Message-ID: <20200221130448.GC10516@linaro.org>
References: <1582161028-2844-1-git-send-email-Anson.Huang@nxp.com>
 <1582161028-2844-5-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1582161028-2844-5-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 20, 2020 at 09:10:28AM +0800, Anson Huang wrote:
> Add i.MX8QXP CPU thermal zone support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No change.
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 36 ++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> index fb5f752..0a14fe4 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -11,6 +11,7 @@
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/pinctrl/pads-imx8qxp.h>
> +#include <dt-bindings/thermal/thermal.h>
>  
>  / {
>  	interrupt-parent = <&gic>;
> @@ -189,6 +190,11 @@
>  			compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
>  			timeout-sec = <60>;
>  		};
> +
> +		tsens: thermal-sensor {
> +			compatible = "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-thermal";
> +			#thermal-sensor-cells = <1>;
> +		};
>  	};
>  
>  	timer {
> @@ -586,4 +592,34 @@
>  			#clock-cells = <1>;
>  		};
>  	};
> +
> +	thermal_zones: thermal-zones {
> +		cpu-thermal0 {
> +			polling-delay-passive = <250>;
> +			polling-delay = <2000>;
> +			thermal-sensors = <&tsens IMX_SC_R_SYSTEM>;
> +			trips {
> +				cpu_alert0: trip0 {
> +					temperature = <107000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};

May be you can add a 'hot' trip point before 'critical' for future use before
reaching the emergency shutdown.

> +				cpu_crit0: trip1 {
> +					temperature = <127000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu_alert0>;
> +					cooling-device =
> +						<&A35_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&A35_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&A35_2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&A35_3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +	};
>  };
> -- 
> 2.7.4
> 

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
