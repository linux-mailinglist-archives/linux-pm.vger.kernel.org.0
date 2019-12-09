Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4014B1164CC
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 02:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfLIBej (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Dec 2019 20:34:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:56504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbfLIBej (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 8 Dec 2019 20:34:39 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02F8E206D5;
        Mon,  9 Dec 2019 01:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575855278;
        bh=sKsbh4vc/QZhOZJyY/0BORyBPkmadVe3B7hraBzztg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lKf1mIb2SqAWACNuPVUY1ktnLHHEmFexV8r6ikBgQIuFtdn0SNNzCCqj6jkas90CX
         GceHqWOLg67Irl0jmT4GhWgGhqOiSHc9t1muWFtnYo0Rf4yHTdDybmN8Urdm5Y6iFl
         SGFvVYsBo5WUNzVge1giUq/uPuwG8BUzIOnuN2Z0=
Date:   Mon, 9 Dec 2019 09:34:15 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Silvano di Ninno <silvano.dininno@nxp.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 5/5] arm64: dts: imx8m: Add ddr controller nodes
Message-ID: <20191209013414.GS3365@dragon>
References: <cover.1574458460.git.leonard.crestez@nxp.com>
 <23e46c12c98947315229c20dea6784ad40d294c4.1574458460.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23e46c12c98947315229c20dea6784ad40d294c4.1574458460.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 22, 2019 at 11:45:04PM +0200, Leonard Crestez wrote:
> This is used by the imx-ddrc devfreq driver to implement dynamic
> frequency scaling of DRAM.
> 
> Support for proactive scaling via interconnect will come later. The
> high-performance bus masters which need that (display, vpu, gpu) are
> mostly not yet enabled in upstream anyway.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-evk.dts  | 18 ++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi     | 10 ++++++++
>  .../boot/dts/freescale/imx8mn-ddr4-evk.dts    | 18 ++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi     | 10 ++++++++
>  arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 24 +++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 10 ++++++++
>  6 files changed, 90 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> index 28ab17a277bb..ecf0d385c164 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> @@ -75,10 +75,28 @@
>  
>  &A53_0 {
>  	cpu-supply = <&buck2_reg>;
>  };
>  
> +&ddrc {
> +	operating-points-v2 = <&ddrc_opp_table>;
> +
> +	ddrc_opp_table: opp-table {
> +		compatible = "operating-points-v2";
> +
> +		opp-25M {
> +			opp-hz = /bits/ 64 <25000000>;
> +		};

As an idiomatic practice, we have newline between nodes.

I fixed it up and applied the patch.

Shawn

> +		opp-100M {
> +			opp-hz = /bits/ 64 <100000000>;
> +		};
> +		opp-750M {
> +			opp-hz = /bits/ 64 <750000000>;
> +		};
> +	};
> +};
> +
>  &fec1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_fec1>;
>  	phy-mode = "rgmii-id";
>  	phy-handle = <&ethphy0>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index 6edbdfe2d0d7..3d4802375715 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -856,10 +856,20 @@
>  			#interrupt-cells = <3>;
>  			interrupt-controller;
>  			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
> +		ddrc: memory-controller@3d400000 {
> +			compatible = "fsl,imx8mm-ddrc", "fsl,imx8m-ddrc";
> +			reg = <0x3d400000 0x400000>;
> +			clock-names = "core", "pll", "alt", "apb";
> +			clocks = <&clk IMX8MM_CLK_DRAM_CORE>,
> +				 <&clk IMX8MM_DRAM_PLL>,
> +				 <&clk IMX8MM_CLK_DRAM_ALT>,
> +				 <&clk IMX8MM_CLK_DRAM_APB>;
> +		};
> +
>  		ddr-pmu@3d800000 {
>  			compatible = "fsl,imx8mm-ddr-pmu", "fsl,imx8m-ddr-pmu";
>  			reg = <0x3d800000 0x400000>;
>  			interrupt-parent = <&gic>;
>  			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> index 071949412caf..b051c927c11e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> @@ -15,10 +15,28 @@
>  
>  &A53_0 {
>  	cpu-supply = <&buck2_reg>;
>  };
>  
> +&ddrc {
> +	operating-points-v2 = <&ddrc_opp_table>;
> +
> +	ddrc_opp_table: opp-table {
> +		compatible = "operating-points-v2";
> +
> +		opp-25M {
> +			opp-hz = /bits/ 64 <25000000>;
> +		};
> +		opp-100M {
> +			opp-hz = /bits/ 64 <100000000>;
> +		};
> +		opp-600M {
> +			opp-hz = /bits/ 64 <600000000>;
> +		};
> +	};
> +};
> +
>  &i2c1 {
>  	pmic@4b {
>  		compatible = "rohm,bd71847";
>  		reg = <0x4b>;
>  		pinctrl-0 = <&pinctrl_pmic>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> index e91625063f8e..3a79fdddc72b 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> @@ -757,10 +757,20 @@
>  			#interrupt-cells = <3>;
>  			interrupt-controller;
>  			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
> +		ddrc: memory-controller@3d400000 {
> +			compatible = "fsl,imx8mn-ddrc", "fsl,imx8m-ddrc";
> +			reg = <0x3d400000 0x400000>;
> +			clock-names = "core", "pll", "alt", "apb";
> +			clocks = <&clk IMX8MN_CLK_DRAM_CORE>,
> +				 <&clk IMX8MN_DRAM_PLL>,
> +				 <&clk IMX8MN_CLK_DRAM_ALT>,
> +				 <&clk IMX8MN_CLK_DRAM_APB>;
> +		};
> +
>  		ddr-pmu@3d800000 {
>  			compatible = "fsl,imx8mn-ddr-pmu", "fsl,imx8m-ddr-pmu";
>  			reg = <0x3d800000 0x400000>;
>  			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
>  		};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> index c36685916683..ee6dc5f07622 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> @@ -103,10 +103,34 @@
>  
>  &A53_3 {
>  	cpu-supply = <&buck2_reg>;
>  };
>  
> +&ddrc {
> +	operating-points-v2 = <&ddrc_opp_table>;
> +
> +	ddrc_opp_table: opp-table {
> +		compatible = "operating-points-v2";
> +
> +		opp-25M {
> +			opp-hz = /bits/ 64 <25000000>;
> +		};
> +		opp-100M {
> +			opp-hz = /bits/ 64 <100000000>;
> +		};
> +		/*
> +		 * On imx8mq B0 PLL can't be bypassed so low bus is 166M
> +		 */
> +		opp-166M {
> +			opp-hz = /bits/ 64 <166935483>;
> +		};
> +		opp-800M {
> +			opp-hz = /bits/ 64 <800000000>;
> +		};
> +	};
> +};
> +
>  &fec1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_fec1>;
>  	phy-mode = "rgmii-id";
>  	phy-handle = <&ethphy0>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 7f9319452b58..d1fcf9887f8b 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -1111,10 +1111,20 @@
>  			interrupt-controller;
>  			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-parent = <&gic>;
>  		};
>  
> +		ddrc: memory-controller@3d400000 {
> +			compatible = "fsl,imx8mq-ddrc", "fsl,imx8m-ddrc";
> +			reg = <0x3d400000 0x400000>;
> +			clock-names = "core", "pll", "alt", "apb";
> +			clocks = <&clk IMX8MQ_CLK_DRAM_CORE>,
> +				 <&clk IMX8MQ_DRAM_PLL_OUT>,
> +				 <&clk IMX8MQ_CLK_DRAM_ALT>,
> +				 <&clk IMX8MQ_CLK_DRAM_APB>;
> +		};
> +
>  		ddr-pmu@3d800000 {
>  			compatible = "fsl,imx8mq-ddr-pmu", "fsl,imx8m-ddr-pmu";
>  			reg = <0x3d800000 0x400000>;
>  			interrupt-parent = <&gic>;
>  			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> -- 
> 2.17.1
> 
