Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9019B42E704
	for <lists+linux-pm@lfdr.de>; Fri, 15 Oct 2021 04:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbhJODBv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 23:01:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235274AbhJODBh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 Oct 2021 23:01:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCF8261151;
        Fri, 15 Oct 2021 02:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634266772;
        bh=KfjD2rCyH2HclCsiLQsNo252pJdf5DBVJQQPUNIyJMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X4O+yjylSXm3zsoDdbKT62HmSvuErqoiqFce2NbpOSDBeayumOqPhi1RZ8N+BPWBC
         xajRjB/ccSW8vEOmpCgx62jC+6ZQWogjwvBOxYJ6tpVvlOEmUsENrERZXpOENCTeSh
         cbCoq4nXKtU7lMiiT81bSxc9n62hxY/8rHplENhIhrPZejl5GHKX0TKjJhOU0QMRB/
         LYvxNN8MB4e4da024qdfX/KAoNGoAZ077+4jmEGczW9venFscZgsPhYA5rEGpiLayL
         X98pe+QssaZcOU6VKQu/HSGTBN/CECh/1aNof7LjL8ouFjjSvGbw8m8dhOdLGTUqoZ
         CyQepUaKGNkIg==
Date:   Fri, 15 Oct 2021 10:59:24 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, kernel@pengutronix.de, s.hauer@pengutronix.de,
        linux-imx@nxp.com, amitk@kernel.org, rui.zhang@intel.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v12 10/10] ARM: dts: imx7d: remarkable2: Enable lcdif
Message-ID: <20211015025923.GA22881@dragon>
References: <20211009115732.19102-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211009115732.19102-1-alistair@alistair23.me>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Oct 09, 2021 at 09:57:32PM +1000, Alistair Francis wrote:
> Connect the dispaly on the reMarkable2.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>

Maybe there are some patches missing.  It doesn't apply to my branch.

Shawn 

> ---
>  arch/arm/boot/dts/imx7d-remarkable2.dts | 74 +++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
> index 1b49c26816cd..5f32c216c3fd 100644
> --- a/arch/arm/boot/dts/imx7d-remarkable2.dts
> +++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
> @@ -47,6 +47,16 @@ reg_digitizer: regulator-digitizer {
>  		startup-delay-us = <100000>; /* 100 ms */
>  	};
>  
> +	reg_sdoe: regulator-sdoe {
> +		compatible = "regulator-fixed";
> +		regulator-name = "SDOE";
> +		pinctrl-names = "default", "sleep";
> +		pinctrl-0 = <&pinctrl_sdoe_reg>;
> +		pinctrl-1 = <&pinctrl_sdoe_reg>;
> +		gpio = <&gpio3 27 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
>  	wifi_pwrseq: wifi_pwrseq {
>  		compatible = "mmc-pwrseq-simple";
>  		pinctrl-names = "default";
> @@ -55,6 +65,16 @@ wifi_pwrseq: wifi_pwrseq {
>  		clocks = <&clks IMX7D_CLKO2_ROOT_DIV>;
>  		clock-names = "ext_clock";
>  	};
> +
> +	panel {
> +		compatible = "eink,vb3300-kca";
> +
> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint = <&display_out>;
> +			};
> +		};
> +	};
>  };
>  
>  &clks {
> @@ -114,6 +134,20 @@ reg_epdpmic: vcom {
>  	};
>  };
>  
> +&lcdif {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_lcdif>;
> +	lcd-supply = <&reg_epdpmic>;
> +	lcd2-supply = <&reg_sdoe>;
> +	status = "okay";
> +
> +	port {
> +		display_out: endpoint {
> +			remote-endpoint = <&panel_in>;
> +		};
> +	};
> +};
> +
>  &snvs_pwrkey {
>  	status = "okay";
>  };
> @@ -228,6 +262,46 @@ MX7D_PAD_I2C4_SCL__I2C4_SCL		0x4000007f
>  		>;
>  	};
>  
> +	pinctrl_lcdif: lcdifgrp {
> +		fsl,pins = <
> +			MX7D_PAD_LCD_DATA00__LCD_DATA0		0x79
> +			MX7D_PAD_LCD_DATA01__LCD_DATA1		0x79
> +			MX7D_PAD_LCD_DATA02__LCD_DATA2		0x79
> +			MX7D_PAD_LCD_DATA03__LCD_DATA3		0x79
> +			MX7D_PAD_LCD_DATA04__LCD_DATA4		0x79
> +			MX7D_PAD_LCD_DATA05__LCD_DATA5		0x79
> +			MX7D_PAD_LCD_DATA06__LCD_DATA6		0x79
> +			MX7D_PAD_LCD_DATA07__LCD_DATA7		0x79
> +			MX7D_PAD_LCD_DATA08__LCD_DATA8		0x79
> +			MX7D_PAD_LCD_DATA09__LCD_DATA9		0x79
> +			MX7D_PAD_LCD_DATA10__LCD_DATA10		0x79
> +			MX7D_PAD_LCD_DATA11__LCD_DATA11		0x79
> +			MX7D_PAD_LCD_DATA12__LCD_DATA12		0x79
> +			MX7D_PAD_LCD_DATA13__LCD_DATA13		0x79
> +			MX7D_PAD_LCD_DATA14__LCD_DATA14		0x79
> +			MX7D_PAD_LCD_DATA15__LCD_DATA15		0x79
> +
> +			MX7D_PAD_LCD_DATA17__LCD_DATA17		0x79
> +			MX7D_PAD_LCD_DATA18__LCD_DATA18		0x79
> +			MX7D_PAD_LCD_DATA19__LCD_DATA19		0x79
> +			MX7D_PAD_LCD_DATA20__LCD_DATA20		0x79
> +			MX7D_PAD_LCD_DATA21__LCD_DATA21		0x79
> +
> +			MX7D_PAD_LCD_DATA23__LCD_DATA23		0x79
> +			MX7D_PAD_LCD_CLK__LCD_CLK		0x79
> +			MX7D_PAD_LCD_ENABLE__LCD_ENABLE		0x79
> +			MX7D_PAD_LCD_VSYNC__LCD_VSYNC		0x79
> +			MX7D_PAD_LCD_HSYNC__LCD_HSYNC		0x79
> +			MX7D_PAD_LCD_RESET__LCD_RESET		0x79
> +		>;
> +	};
> +
> +	pinctrl_sdoe_reg: sdoereggrp {
> +		fsl,pins = <
> +			MX7D_PAD_LCD_DATA22__GPIO3_IO27		0x74
> +		>;
> +	};
> +
>  	pinctrl_uart1: uart1grp {
>  		fsl,pins = <
>  			MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
> -- 
> 2.31.1
> 
