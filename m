Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 953131812EF
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 09:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgCKIbA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 04:31:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:55944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbgCKIbA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Mar 2020 04:31:00 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C91AC20848;
        Wed, 11 Mar 2020 08:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583915459;
        bh=rIWT9c23MTBVlaTh1Eb6lpf59lA1osIAXiNlIrkeg/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PmrV3SBmAO/5xRR+ybHP68yc0R7xxRl/oaiqY1r4hJ8wa9wRJUgPn1CQKEA9GHKVi
         UA9LjjCVNtrwB+IJCS7PWZOgeeI5Br2yGlnux0CRVoPfmpPJkdPRvYXPkXeCwcZI1s
         /cxWTtSI/ddBabdOgeSrp1Hzg7Vwmg6IJtKTd9Fk=
Date:   Wed, 11 Mar 2020 16:30:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     viresh.kumar@linaro.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] ARM: dts: imx: add nvmem property for cpu0
Message-ID: <20200311083052.GD29269@dragon>
References: <1583201690-16068-1-git-send-email-peng.fan@nxp.com>
 <1583201690-16068-2-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583201690-16068-2-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 03, 2020 at 10:14:48AM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add nvmem related property for cpu0, then nvmem API could be used
> to read cpu speed grading to avoid directly read OCOTP registers
> mapped which could not handle defer probe.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm/boot/dts/imx6dl.dtsi  | 2 ++
>  arch/arm/boot/dts/imx6q.dtsi   | 2 ++
>  arch/arm/boot/dts/imx6qdl.dtsi | 7 +++++++
>  arch/arm/boot/dts/imx6sl.dtsi  | 9 +++++++++
>  arch/arm/boot/dts/imx6sll.dtsi | 6 ++++++
>  arch/arm/boot/dts/imx6sx.dtsi  | 6 ++++++
>  6 files changed, 32 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
> index 4b3a128d9260..055f1d875bac 100644
> --- a/arch/arm/boot/dts/imx6dl.dtsi
> +++ b/arch/arm/boot/dts/imx6dl.dtsi
> @@ -44,6 +44,8 @@
>  			arm-supply = <&reg_arm>;
>  			pu-supply = <&reg_pu>;
>  			soc-supply = <&reg_soc>;
> +			nvmem-cells = <&cpu_speed_grade>;
> +			nvmem-cell-names = "speed_grade";
>  		};
>  
>  		cpu@1 {
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index 0fad13f9d336..d3ba9d4a1290 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -49,6 +49,8 @@
>  			arm-supply = <&reg_arm>;
>  			pu-supply = <&reg_pu>;
>  			soc-supply = <&reg_soc>;
> +			nvmem-cells = <&cpu_speed_grade>;
> +			nvmem-cell-names = "speed_grade";
>  		};
>  
>  		cpu1: cpu@1 {
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 70fb8b56b1d7..982f546b0b89 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -1165,6 +1165,13 @@
>  				compatible = "fsl,imx6q-ocotp", "syscon";
>  				reg = <0x021bc000 0x4000>;
>  				clocks = <&clks IMX6QDL_CLK_IIM>;
> +

Please drop such newline.  Do not really think they are necessary.

Shawn

> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +
> +				cpu_speed_grade: speed-grade@10 {
> +					reg = <0x10 4>;
> +				};
>  			};
>  
>  			tzasc@21d0000 { /* TZASC1 */
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index c8ec46fe8302..de943341e4f2 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -74,6 +74,8 @@
>  			arm-supply = <&reg_arm>;
>  			pu-supply = <&reg_pu>;
>  			soc-supply = <&reg_soc>;
> +			nvmem-cells = <&cpu_speed_grade>;
> +			nvmem-cell-names = "speed_grade";
>  		};
>  	};
>  
> @@ -953,6 +955,13 @@
>  				compatible = "fsl,imx6sl-ocotp", "syscon";
>  				reg = <0x021bc000 0x4000>;
>  				clocks = <&clks IMX6SL_CLK_OCOTP>;
> +
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +
> +				cpu_speed_grade: speed-grade@10 {
> +					reg = <0x10 4>;
> +				};
>  			};
>  
>  			audmux: audmux@21d8000 {
> diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
> index 797f850492fe..6b7fb3cec9f6 100644
> --- a/arch/arm/boot/dts/imx6sll.dtsi
> +++ b/arch/arm/boot/dts/imx6sll.dtsi
> @@ -72,6 +72,8 @@
>  				 <&clks IMX6SLL_CLK_PLL1_SYS>;
>  			clock-names = "arm", "pll2_pfd2_396m", "step",
>  				      "pll1_sw", "pll1_sys";
> +			nvmem-cells = <&cpu_speed_grade>;
> +			nvmem-cell-names = "speed_grade";
>  		};
>  	};
>  
> @@ -791,6 +793,10 @@
>  				reg = <0x021bc000 0x4000>;
>  				clocks = <&clks IMX6SLL_CLK_OCOTP>;
>  
> +				cpu_speed_grade: speed-grade@10 {
> +					reg = <0x10 4>;
> +				};
> +
>  				tempmon_calib: calib@38 {
>  					reg = <0x38 4>;
>  				};
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
> index e47d346a3543..63aa19d81b42 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -87,6 +87,8 @@
>  				      "pll1_sw", "pll1_sys";
>  			arm-supply = <&reg_arm>;
>  			soc-supply = <&reg_soc>;
> +			nvmem-cells = <&cpu_speed_grade>;
> +			nvmem-cell-names = "speed_grade";
>  		};
>  	};
>  
> @@ -1058,6 +1060,10 @@
>  				reg = <0x021bc000 0x4000>;
>  				clocks = <&clks IMX6SX_CLK_OCOTP>;
>  
> +				cpu_speed_grade: speed-grade@10 {
> +					reg = <0x10 4>;
> +				};
> +
>  				tempmon_calib: calib@38 {
>  					reg = <0x38 4>;
>  				};
> -- 
> 2.16.4
> 
