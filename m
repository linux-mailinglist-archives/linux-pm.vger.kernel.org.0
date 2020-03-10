Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2950517F0E4
	for <lists+linux-pm@lfdr.de>; Tue, 10 Mar 2020 08:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgCJHEu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 03:04:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgCJHEu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Mar 2020 03:04:50 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 090892468A;
        Tue, 10 Mar 2020 07:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583823889;
        bh=EEzHE5+Ej4Ntn//ujeATmWKpJYLdDKimf0zxr2e+Ajw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EXymqZ1VrUNLGskZXVzQs/HQA/VJBZJ0xkP996JzXmIt7G+I/x6DrvhfVjW7S25Vz
         NQanULMljX2/3hH4IHyhrsmLLIjAJ55AL0CWASIuMmpdh30lz+IRyGlNZeesoYYBBs
         bDh2ShGU7wyW9b/prVufhTopqGjse/s0uunD5Wj0=
Date:   Tue, 10 Mar 2020 15:04:38 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, aisheng.dong@nxp.com,
        linux@roeck-us.net, srinivas.kandagatla@linaro.org,
        krzk@kernel.org, fugang.duan@nxp.com, peng.fan@nxp.com,
        daniel.baluta@nxp.com, bjorn.andersson@linaro.org, olof@lixom.net,
        dinguyen@kernel.org, leonard.crestez@nxp.com,
        marcin.juszkiewicz@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V16 5/5] arm64: dts: imx: add i.MX8QXP thermal support
Message-ID: <20200310070437.GC17772@dragon>
References: <1582330132-13461-1-git-send-email-Anson.Huang@nxp.com>
 <1582330132-13461-5-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582330132-13461-5-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Feb 22, 2020 at 08:08:52AM +0800, Anson Huang wrote:
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

newline

> +			trips {
> +				cpu_alert0: trip0 {
> +					temperature = <107000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};

newline

> +				cpu_crit0: trip1 {
> +					temperature = <127000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};

newline

I fixed them up and applied the patch.

Shawn

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
