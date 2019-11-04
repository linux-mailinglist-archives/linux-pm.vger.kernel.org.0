Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 858A8EEEF4
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 23:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389176AbfKDWBr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 17:01:47 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35107 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387848AbfKDWBr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 17:01:47 -0500
Received: by mail-oi1-f195.google.com with SMTP id n16so15635532oig.2;
        Mon, 04 Nov 2019 14:01:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gICVn3u8ASpKk8yKpGUgqNBScOIqpiBNd4WtMocjQ8o=;
        b=ZtUPH5Qj2aqv3R3NqXMaRNsfHwvHn24ZWw1nnfpkAGTq0xe+Z6YTgAL+4ov4+XUEb/
         nRPL8VtRGiHfAAX2MFPO16A+rocPoSAKDx7MwljvHsBNs5xKe9gJG9VqlnkwReNpVmB+
         kDzX4zdTJ026GWuSU3zhKoTp+kbSc0cbzCLtLiuk2bmJIbd++gK8VK+dZ2LEmID3SVWY
         0xS5YAEHCkzpUvGY2E1aGgHAkC4gD0KmHaZTpq/L8DOc9ZVrqs9L1Nhhbu5hLnzpiHIv
         14sqDDtEfDST2ULOa49SHCnp3+cXGZlok2pkc0mwf0DeyLtuAn8bVidplL1Rx2FygEzn
         Vc7g==
X-Gm-Message-State: APjAAAXxy+rY1QWas9zOozaUlKIeTQX64JJS3BtwzMJybY+DJe1uI1oI
        NXgcT9YCkRu2hLI8ycFbgw==
X-Google-Smtp-Source: APXvYqwLHKhqTibA1uW3XY9c8wtsWQIYuDLFvJINilMATw8yBBYyhOv5hhkQXaGX5VRglnSSyVHobw==
X-Received: by 2002:a54:4484:: with SMTP id v4mr1058881oiv.49.1572904905923;
        Mon, 04 Nov 2019 14:01:45 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 68sm5857904otw.56.2019.11.04.14.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 14:01:45 -0800 (PST)
Date:   Mon, 4 Nov 2019 16:01:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
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
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 6/6] arm64: dts: imx8m: Add ddr controller nodes
Message-ID: <20191104220144.GA5218@bogus>
References: <cover.1572558427.git.leonard.crestez@nxp.com>
 <44dcab5a136f5b046092e6ed456d8e206413059f.1572558427.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44dcab5a136f5b046092e6ed456d8e206413059f.1572558427.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 31, 2019 at 11:50:27PM +0200, Leonard Crestez wrote:
> This is used by the imx-ddrc devfreq driver to implement dynamic
> frequency scaling of DRAM.
> 
> Add a devfreq-event link to the dram PMU in order to support on-demand
> scaling of ddrc based on measured dram bandwidth usage.
> 
> Support for proactive scaling via interconnect will come later. The
> high-performance bus masters which need that (display, vpu, gpu) are not
> yet enabled in upstream anyway.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-evk.dts  | 18 ++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi     | 17 ++++++++++++-
>  .../boot/dts/freescale/imx8mn-ddr4-evk.dts    | 18 ++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi     | 16 ++++++++++++-
>  arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 24 +++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 16 ++++++++++++-
>  6 files changed, 106 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> index 4f5e408d6e6a..be9abd8e4478 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> @@ -69,16 +69,34 @@
>  		simple-audio-card,codec {
>  			sound-dai = <&wm8524>;
>  			clocks = <&clk IMX8MM_CLK_SAI3_ROOT>;
>  		};
>  	};
> +
> +	ddrc_opp_table: ddrc-opp-table {
> +		compatible = "operating-points-v2";
> +
> +		opp-25M {
> +			opp-hz = /bits/ 64 <25000000>;
> +		};
> +		opp-100M {
> +			opp-hz = /bits/ 64 <100000000>;
> +		};
> +		opp-750M {
> +			opp-hz = /bits/ 64 <750000000>;
> +		};
> +	};
>  };
>  
>  &A53_0 {
>  	cpu-supply = <&buck2_reg>;
>  };
>  
> +&ddrc {
> +	operating-points-v2 = <&ddrc_opp_table>;
> +};
> +
>  &fec1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_fec1>;
>  	phy-mode = "rgmii-id";
>  	phy-handle = <&ethphy0>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index 6edbdfe2d0d7..5404870d80d5 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -856,11 +856,26 @@
>  			#interrupt-cells = <3>;
>  			interrupt-controller;
>  			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
> -		ddr-pmu@3d800000 {
> +		ddrc: dram-controller@3d400000 {
> +			compatible = "fsl,imx8mm-ddrc", "fsl,imx8m-ddrc";
> +			reg = <0x3d400000 0x400000>;

Do you really need the OS to map 4MB of register space? Virtual 
space on 64-bit doesn't matter, but it's still wasting 2KB of memory 
just to map all that if only a few pages are needed. Adds up if the 
whole DT is done this way.

> +			clock-names = "dram_core",
> +				      "dram_pll",
> +				      "dram_alt",
> +				      "dram_apb";
> +			clocks = <&clk IMX8MM_CLK_DRAM_CORE>,
> +				 <&clk IMX8MM_DRAM_PLL>,
> +				 <&clk IMX8MM_CLK_DRAM_ALT>,
> +				 <&clk IMX8MM_CLK_DRAM_APB>;
> +			devfreq-events = <&ddr_pmu>;
> +			operating-points-v2 = <&ddrc_opp_table>;
> +		};
> +
> +		ddr_pmu: ddr-pmu@3d800000 {
>  			compatible = "fsl,imx8mm-ddr-pmu", "fsl,imx8m-ddr-pmu";
>  			reg = <0x3d800000 0x400000>;
>  			interrupt-parent = <&gic>;
>  			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
>  		};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> index 071949412caf..ab2060667671 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> @@ -9,16 +9,34 @@
>  #include "imx8mn-evk.dtsi"
>  
>  / {
>  	model = "NXP i.MX8MNano DDR4 EVK board";
>  	compatible = "fsl,imx8mn-ddr4-evk", "fsl,imx8mn";
> +
> +	ddrc_opp_table: ddrc-opp-table {

I think it would be better to put this under the ddrc node (and named 
'opp-table'). Yes, it's kind of silly to have a phandle to a child node, 
but that still works.

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
>  };
>  
>  &A53_0 {
>  	cpu-supply = <&buck2_reg>;
>  };
>  
> +&ddrc {
> +	operating-points-v2 = <&ddrc_opp_table>;
> +};
> +
>  &i2c1 {
>  	pmic@4b {
>  		compatible = "rohm,bd71847";
>  		reg = <0x4b>;
>  		pinctrl-0 = <&pinctrl_pmic>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> index e91625063f8e..344dd777635f 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> @@ -757,11 +757,25 @@
>  			#interrupt-cells = <3>;
>  			interrupt-controller;
>  			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
> -		ddr-pmu@3d800000 {
> +		ddrc: dram-controller@3d400000 {
> +			compatible = "fsl,imx8mn-ddrc", "fsl,imx8m-ddrc";
> +			reg = <0x3d400000 0x400000>;
> +			clock-names = "dram_core",
> +				      "dram_pll",
> +				      "dram_alt",
> +				      "dram_apb";
> +			clocks = <&clk IMX8MN_CLK_DRAM_CORE>,
> +				 <&clk IMX8MN_DRAM_PLL>,
> +				 <&clk IMX8MN_CLK_DRAM_ALT>,
> +				 <&clk IMX8MN_CLK_DRAM_APB>;
> +			devfreq-events = <&ddr_pmu>;
> +		};
> +
> +		ddr_pmu: ddr-pmu@3d800000 {
>  			compatible = "fsl,imx8mn-ddr-pmu", "fsl,imx8m-ddr-pmu";
>  			reg = <0x3d800000 0x400000>;
>  			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  	};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> index c36685916683..fc4c12ab8991 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> @@ -85,10 +85,30 @@
>  		link_codec: simple-audio-card,codec {
>  			sound-dai = <&wm8524>;
>  			clocks = <&clk IMX8MQ_CLK_SAI2_ROOT>;
>  		};
>  	};
> +
> +	ddrc_opp_table: ddrc-opp-table {
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
>  };
>  
>  &A53_0 {
>  	cpu-supply = <&buck2_reg>;
>  };
> @@ -103,10 +123,14 @@
>  
>  &A53_3 {
>  	cpu-supply = <&buck2_reg>;
>  };
>  
> +&ddrc {
> +	operating-points-v2 = <&ddrc_opp_table>;
> +};
> +
>  &fec1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_fec1>;
>  	phy-mode = "rgmii-id";
>  	phy-handle = <&ethphy0>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 7f9319452b58..6ef1af41ef68 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -1111,11 +1111,25 @@
>  			interrupt-controller;
>  			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-parent = <&gic>;
>  		};
>  
> -		ddr-pmu@3d800000 {
> +		ddrc: dram-controller@3d400000 {
> +			compatible = "fsl,imx8mq-ddrc", "fsl,imx8m-ddrc";
> +			reg = <0x3d400000 0x400000>;
> +			clock-names = "dram_core",
> +				      "dram_pll",
> +				      "dram_alt",
> +				      "dram_apb";
> +			clocks = <&clk IMX8MQ_CLK_DRAM_CORE>,
> +				 <&clk IMX8MQ_DRAM_PLL_OUT>,
> +				 <&clk IMX8MQ_CLK_DRAM_ALT>,
> +				 <&clk IMX8MQ_CLK_DRAM_APB>;
> +			devfreq-events = <&ddr_pmu>;
> +		};
> +
> +		ddr_pmu: ddr-pmu@3d800000 {
>  			compatible = "fsl,imx8mq-ddr-pmu", "fsl,imx8m-ddr-pmu";
>  			reg = <0x3d800000 0x400000>;
>  			interrupt-parent = <&gic>;
>  			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
>  		};
> -- 
> 2.17.1
> 
