Return-Path: <linux-pm+bounces-28721-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7DDADA15C
	for <lists+linux-pm@lfdr.de>; Sun, 15 Jun 2025 10:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EEF2189147E
	for <lists+linux-pm@lfdr.de>; Sun, 15 Jun 2025 08:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2070E264634;
	Sun, 15 Jun 2025 08:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="J2N/hRmp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5437946C;
	Sun, 15 Jun 2025 08:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749977731; cv=none; b=PV/URX9zGtxLW1+7/YHhIlApt6Ki74UeHrCB/qrO9/0UcqGF/VQe7bkCd5IpBg56rJis2zDr/5jUBPNOte/gwyEb0nVZmvSdYKkKfo3JSJYI2O5RGIsGTIKl5tiU4MqcDIEE5CSl7B9Z6pKIlqLRdX4RvmFcE2EEgoycrGqaf2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749977731; c=relaxed/simple;
	bh=O6y6iVLmqIOeTcvLpPTqCZp8/AYMfZ8rZt6ML9OXv10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WYjL1wxzwKHQMCzIaY1J+PhLjvLRuCTtJssfQv99OTX/Ek+xPWKkL225brGrpLBbMjy+ijOLp1xXsFt95doDKHW1nQmxtqvzSwFe1lSdvDm42wT5Swdio9x4IdzMLBdjF+lbD+GtrBv4HzJv26JotdB9bwf0EkNqr9EXSCjW6f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=J2N/hRmp; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1749977716; x=1750582516; i=wahrenst@gmx.net;
	bh=k6V9zVkWMR51AZrF9mEnKnYj49GOPwzou2alXkMUR2Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=J2N/hRmp/Fi+h/0T4nUC5h6JBVpxX2SKDiC0YLAeifN5sriInrqxvzRFKhH4omnl
	 lHKBxHDqQk1g83sW5JBDOv+TrVIEGQZ65dftQ3yAonfBJwl0cBEbt++0WgEf+MuJR
	 udD6P51qiv4yT+sjZXJyn8PPdRXAhwMSDMGg5wHFnPBKCEnWYXhLm7z55kLBJulnl
	 +MOCm/m1c6deneAwo4XJN4bJdHSDO+NV8oEE86FqKsyV6ncw/BQ2bgWWVGtkDgQsD
	 doig6XtFFGTqAP7WKDEz5vwBzcbrtVLSQicNLIAOh0+skp4byjQRbTPrD2IiV6yV7
	 51zCp57tY8qIfYxqRg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.103] ([91.41.216.208]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiacR-1v2piG3OUB-00nHlK; Sun, 15
 Jun 2025 10:55:15 +0200
Message-ID: <26da3ac5-84be-4d87-8c62-48dc54c6fa7c@gmx.net>
Date: Sun, 15 Jun 2025 10:55:10 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/9] arm64: dts: freescale: add i.MX91 11x11 EVK basic
 support
To: Joy Zou <joy.zou@nxp.com>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
 catalin.marinas@arm.com, will@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 ulf.hansson@linaro.org, richardcochran@gmail.com, kernel@pengutronix.de,
 festevam@gmail.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-pm@vger.kernel.org, frank.li@nxp.com, ye.li@nxp.com, ping.bai@nxp.com,
 peng.fan@nxp.com, aisheng.dong@nxp.com, xiaoning.wang@nxp.com
References: <20250613100255.2131800-1-joy.zou@nxp.com>
 <20250613100255.2131800-7-joy.zou@nxp.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <20250613100255.2131800-7-joy.zou@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nAtymyjjgLK2r9/032MceqsCwW2XMHDkwHoK5YWjBiYlYIWgey8
 ekS1ceIJhbbMmHd1sdYo60XWW8gz8Rg4WURdfn+xL7QaQqzkBs+gAUa2gFqWrVAK1xIOtGj
 wpbJZOTzJ9CHeaYbbITvWX5Pqr45AVlc74WZbW6p9SCmb7LxDwPJr4M08Ukmsxa8j7qpwg7
 H7rNGOG9XGTweUA6y8Uvw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iotn0wU1SiM=;7Ru5ANpQE6F1USLJ9a6mNi3i5VM
 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
 UwdO8Tyb7aEv04VY+0xbDOqDysDws8fObJTtxg==

Hello Joy,

Am 13.06.25 um 12:02 schrieb Joy Zou:
> Add i.MX91 11x11 EVK board support.
> - Enable ADC1.
> - Enable lpuart1 and lpuart5.
> - Enable network eqos and fec.
> - Enable I2C bus and children nodes under I2C bus.
> - Enable USB and related nodes.
> - Enable uSDHC1 and uSDHC2.
> - Enable Watchdog3.
>
> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
>   arch/arm64/boot/dts/freescale/Makefile        |   1 +
>   .../boot/dts/freescale/imx91-11x11-evk.dts    | 878 ++++++++++++++++++
>   2 files changed, 879 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dt=
s/freescale/Makefile
> index 0b473a23d120..fbedb3493c09 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -315,6 +315,7 @@ dtb-$(CONFIG_ARCH_MXC) +=3D imx8qxp-tqma8xqp-mba8xx.=
dtb
>   dtb-$(CONFIG_ARCH_MXC) +=3D imx8qxp-tqma8xqps-mb-smarc-2.dtb
>   dtb-$(CONFIG_ARCH_MXC) +=3D imx8ulp-evk.dtb
>   dtb-$(CONFIG_ARCH_MXC) +=3D imx93-9x9-qsb.dtb
> +dtb-$(CONFIG_ARCH_MXC) +=3D imx91-11x11-evk.dtb
>  =20
>   imx93-9x9-qsb-i3c-dtbs +=3D imx93-9x9-qsb.dtb imx93-9x9-qsb-i3c.dtbo
>   dtb-$(CONFIG_ARCH_MXC) +=3D imx93-9x9-qsb-i3c.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts b/arch/ar=
m64/boot/dts/freescale/imx91-11x11-evk.dts
> new file mode 100644
> index 000000000000..7ce76b207eae
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
> @@ -0,0 +1,878 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/usb/pd.h>
> +#include "imx91.dtsi"
> +
> +/ {
> +	compatible =3D "fsl,imx91-11x11-evk", "fsl,imx91";
> +	model =3D "NXP i.MX91 11X11 EVK board";
> +
> +	aliases {
> +		ethernet0 =3D &fec;
> +		ethernet1 =3D &eqos;
> +		rtc0 =3D &bbnsm_rtc;
> +	};
> +
> +	chosen {
> +		stdout-path =3D &lpuart1;
> +	};
> +
> +	reg_vref_1v8: regulator-adc-vref {
> +		compatible =3D "regulator-fixed";
> +		regulator-max-microvolt =3D <1800000>;
> +		regulator-min-microvolt =3D <1800000>;
> +		regulator-name =3D "vref_1v8";
> +	};
> +
> +	reg_audio_pwr: regulator-audio-pwr {
> +		compatible =3D "regulator-fixed";
> +		regulator-always-on;
> +		regulator-max-microvolt =3D <3300000>;
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-name =3D "audio-pwr";
> +		gpio =3D <&adp5585 1 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reg_usdhc2_vmmc: regulator-usdhc2 {
> +		compatible =3D "regulator-fixed";
> +		off-on-delay-us =3D <12000>;
> +		pinctrl-0 =3D <&pinctrl_reg_usdhc2_vmmc>;
> +		pinctrl-names =3D "default";
> +		regulator-max-microvolt =3D <3300000>;
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-name =3D "VSD_3V3";
> +		gpio =3D <&gpio3 7 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reg_usdhc3_vmmc: regulator-usdhc3 {
> +		compatible =3D "regulator-fixed";
> +		regulator-max-microvolt =3D <3300000>;
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-name =3D "WLAN_EN";
> +		gpio =3D <&pcal6524 20 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		/*
> +		 * IW612 wifi chip needs more delay than other wifi chips to complete
> +		 * the host interface initialization after power up, otherwise the
> +		 * internal state of IW612 may be unstable, resulting in the failure =
of
> +		 * the SDIO3.0 switch voltage.
> +		 */
> +		startup-delay-us =3D <20000>;
> +	};
There is a regulator and pinctrl settings for usdhc3, but it's never=20
used. Why?
> +
> +	reg_vdd_12v: regulator-vdd-12v {
> +		compatible =3D "regulator-fixed";
> +		regulator-max-microvolt =3D <12000000>;
> +		regulator-min-microvolt =3D <12000000>;
> +		regulator-name =3D "reg_vdd_12v";
> +		gpio =3D <&pcal6524 14 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reg_vrpi_3v3: regulator-vrpi-3v3 {
> +		compatible =3D "regulator-fixed";
> +		regulator-max-microvolt =3D <3300000>;
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-name =3D "VRPI_3V3";
> +		vin-supply =3D <&buck4>;
> +		gpio =3D <&pcal6524 2 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reg_vrpi_5v: regulator-vrpi-5v {
> +		compatible =3D "regulator-fixed";
> +		regulator-max-microvolt =3D <5000000>;
> +		regulator-min-microvolt =3D <5000000>;
> +		regulator-name =3D "VRPI_5V";
> +		gpio =3D <&pcal6524 8 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
These regulators doesn't seem to be used. Are they intended for overlays?
> +
> +	reserved-memory {
> +		ranges;
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +
> +		linux,cma {
> +			compatible =3D "shared-dma-pool";
> +			alloc-ranges =3D <0 0x80000000 0 0x40000000>;
> +			reusable;
> +			size =3D <0 0x10000000>;
> +			linux,cma-default;
> +		};
> +	};
> +};
> +
> +&adc1 {
> +	vref-supply =3D <&reg_vref_1v8>;
> +	status =3D "okay";
> +};
> +
> +&eqos {
> +	phy-handle =3D <&ethphy1>;
> +	phy-mode =3D "rgmii-id";
> +	pinctrl-0 =3D <&pinctrl_eqos>;
> +	pinctrl-1 =3D <&pinctrl_eqos_sleep>;
> +	pinctrl-names =3D "default", "sleep";
> +	status =3D "okay";
> +
> +	mdio {
> +		compatible =3D "snps,dwmac-mdio";
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		clock-frequency =3D <5000000>;
> +
> +		ethphy1: ethernet-phy@1 {
> +			reg =3D <1>;
> +			realtek,clkout-disable;
> +		};
> +	};
> +};
> +
> +&fec {
> +	phy-handle =3D <&ethphy2>;
> +	phy-mode =3D "rgmii-id";
> +	pinctrl-0 =3D <&pinctrl_fec>;
> +	pinctrl-1 =3D <&pinctrl_fec_sleep>;
> +	pinctrl-names =3D "default", "sleep";
> +	fsl,magic-packet;
> +	status =3D "okay";
> +
> +	mdio {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		clock-frequency =3D <5000000>;
> +
> +		ethphy2: ethernet-phy@2 {
> +			reg =3D <2>;
> +			eee-broken-1000t;
> +			realtek,clkout-disable;
> +		};
> +	};
> +};
> +
> +/*
> + * When add, delete or change any target device setting in &lpi2c1,
> + * please synchronize the changes to the &i3c1 bus in imx91-11x11-evk-i=
3c.dts.
> + */
> +&lpi2c1 {
> +	clock-frequency =3D <400000>;
> +	pinctrl-0 =3D <&pinctrl_lpi2c1>;
> +	pinctrl-names =3D "default";
> +	status =3D "okay";
> +
> +	audio_codec: wm8962@1a {
> +		compatible =3D "wlf,wm8962";
> +		reg =3D <0x1a>;
> +		clocks =3D <&clk IMX93_CLK_SAI3_GATE>;
> +		AVDD-supply =3D <&reg_audio_pwr>;
> +		CPVDD-supply =3D <&reg_audio_pwr>;
> +		DBVDD-supply =3D <&reg_audio_pwr>;
> +		DCVDD-supply =3D <&reg_audio_pwr>;
> +		MICVDD-supply =3D <&reg_audio_pwr>;
> +		PLLVDD-supply =3D <&reg_audio_pwr>;
> +		SPKVDD1-supply =3D <&reg_audio_pwr>;
> +		SPKVDD2-supply =3D <&reg_audio_pwr>;
> +		gpio-cfg =3D <
> +			0x0000 /* 0:Default */
> +			0x0000 /* 1:Default */
> +			0x0000 /* 2:FN_DMICCLK */
> +			0x0000 /* 3:Default */
> +			0x0000 /* 4:FN_DMICCDAT */
> +			0x0000 /* 5:Default */
> +		>;
> +	};
> +
> +	inertial-meter@6a {
> +		compatible =3D "st,lsm6dso";
> +		reg =3D <0x6a>;
> +	};
> +};
> +
> +&lpi2c2 {
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;
> +	clock-frequency =3D <400000>;
> +	pinctrl-0 =3D <&pinctrl_lpi2c2>;
> +	pinctrl-names =3D "default";
> +	status =3D "okay";
> +
> +	pcal6524: gpio@22 {
> +		compatible =3D "nxp,pcal6524";
> +		reg =3D <0x22>;
> +		#interrupt-cells =3D <2>;
> +		interrupt-controller;
> +		interrupts =3D <27 IRQ_TYPE_LEVEL_LOW>;
> +		#gpio-cells =3D <2>;
> +		gpio-controller;
> +		interrupt-parent =3D <&gpio3>;
> +		pinctrl-0 =3D <&pinctrl_pcal6524>;
> +		pinctrl-names =3D "default";
> +	};
> +
> +	pmic@25 {
> +		compatible =3D "nxp,pca9451a";
> +		reg =3D <0x25>;
> +		interrupts =3D <11 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-parent =3D <&pcal6524>;
> +
> +		regulators {
> +			buck1: BUCK1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt =3D <2237500>;
> +				regulator-min-microvolt =3D <650000>;
> +				regulator-name =3D "BUCK1";
> +				regulator-ramp-delay =3D <3125>;
> +			};
> +
> +			buck2: BUCK2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt =3D <2187500>;
> +				regulator-min-microvolt =3D <600000>;
> +				regulator-name =3D "BUCK2";
> +				regulator-ramp-delay =3D <3125>;
> +			};
> +
> +			buck4: BUCK4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt =3D <3400000>;
> +				regulator-min-microvolt =3D <600000>;
> +				regulator-name =3D "BUCK4";
> +			};
> +
> +			buck5: BUCK5 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt =3D <3400000>;
> +				regulator-min-microvolt =3D <600000>;
> +				regulator-name =3D "BUCK5";
> +			};
> +
> +			buck6: BUCK6 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt =3D <3400000>;
> +				regulator-min-microvolt =3D <600000>;
> +				regulator-name =3D "BUCK6";
> +			};
> +
> +			ldo1: LDO1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt =3D <3300000>;
> +				regulator-min-microvolt =3D <1600000>;
> +				regulator-name =3D "LDO1";
> +			};
> +
> +			ldo4: LDO4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt =3D <3300000>;
> +				regulator-min-microvolt =3D <800000>;
> +				regulator-name =3D "LDO4";
> +			};
> +
> +			ldo5: LDO5 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt =3D <3300000>;
> +				regulator-min-microvolt =3D <1800000>;
> +				regulator-name =3D "LDO5";
> +			};
> +		};
> +	};
> +
> +	adp5585: io-expander@34 {
> +		compatible =3D "adi,adp5585-00", "adi,adp5585";
> +		reg =3D <0x34>;
> +		#gpio-cells =3D <2>;
> +		gpio-controller;
> +		#pwm-cells =3D <3>;
> +		gpio-reserved-ranges =3D <5 1>;
> +
> +		exp-sel-hog {
> +			gpio-hog;
> +			gpios =3D <4 GPIO_ACTIVE_HIGH>;
> +			output-low;
> +		};
> +	};
> +};
> +
> +&lpi2c3 {
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;
> +	clock-frequency =3D <400000>;
> +	pinctrl-0 =3D <&pinctrl_lpi2c3>;
> +	pinctrl-names =3D "default";
> +	status =3D "okay";
> +
> +	ptn5110: tcpc@50 {
> +		compatible =3D "nxp,ptn5110", "tcpci";
> +		reg =3D <0x50>;
> +		interrupts =3D <27 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-parent =3D <&gpio3>;
> +
> +		typec1_con: connector {
> +			compatible =3D "usb-c-connector";
> +			data-role =3D "dual";
> +			label =3D "USB-C";
> +			op-sink-microwatt =3D <15000000>;
> +			power-role =3D "dual";
> +			self-powered;
> +			sink-pdos =3D <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
> +				     PDO_VAR(5000, 20000, 3000)>;
> +			source-pdos =3D <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
> +			try-power-role =3D "sink";
> +
> +			ports {
> +				#address-cells =3D <1>;
> +				#size-cells =3D <0>;
> +
> +				port@0 {
> +					reg =3D <0>;
> +
> +					typec1_dr_sw: endpoint {
> +						remote-endpoint =3D <&usb1_drd_sw>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +
> +	ptn5110_2: tcpc@51 {
> +		compatible =3D "nxp,ptn5110", "tcpci";
> +		reg =3D <0x51>;
> +		interrupts =3D <27 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-parent =3D <&gpio3>;
> +		status =3D "okay";
> +
> +		typec2_con: connector {
> +			compatible =3D "usb-c-connector";
> +			data-role =3D "dual";
> +			label =3D "USB-C";
> +			op-sink-microwatt =3D <15000000>;
> +			power-role =3D "dual";
> +			self-powered;
> +			sink-pdos =3D <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
> +				     PDO_VAR(5000, 20000, 3000)>;
> +			source-pdos =3D <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
> +			try-power-role =3D "sink";
> +
> +			ports {
> +				#address-cells =3D <1>;
> +				#size-cells =3D <0>;
> +
> +				port@0 {
> +					reg =3D <0>;
> +
> +					typec2_dr_sw: endpoint {
> +						remote-endpoint =3D <&usb2_drd_sw>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +
> +	pcf2131: rtc@53 {
> +		compatible =3D "nxp,pcf2131";
> +		reg =3D <0x53>;
> +		interrupts =3D <1 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-parent =3D <&pcal6524>;
> +		status =3D "okay";
> +	};
> +};
> +
> +&lpuart1 {
> +	pinctrl-0 =3D <&pinctrl_uart1>;
> +	pinctrl-names =3D "default";
> +	status =3D "okay";
> +};
> +
> +&lpuart5 {
> +	pinctrl-0 =3D <&pinctrl_uart5>;
> +	pinctrl-names =3D "default";
> +	status =3D "okay";
> +
> +	bluetooth {
> +		compatible =3D "nxp,88w8987-bt";
> +	};
> +};
> +
> +&usbotg1 {
> +	adp-disable;
> +	disable-over-current;
> +	dr_mode =3D "otg";
> +	hnp-disable;
> +	srp-disable;
> +	usb-role-switch;
> +	samsung,picophy-dc-vol-level-adjust =3D <7>;
> +	samsung,picophy-pre-emp-curr-control =3D <3>;
> +	status =3D "okay";
> +
> +	port {
> +		usb1_drd_sw: endpoint {
> +			remote-endpoint =3D <&typec1_dr_sw>;
> +		};
> +	};
> +};
> +
> +&usbotg2 {
> +	adp-disable;
> +	disable-over-current;
> +	dr_mode =3D "otg";
> +	hnp-disable;
> +	srp-disable;
> +	usb-role-switch;
> +	samsung,picophy-dc-vol-level-adjust =3D <7>;
> +	samsung,picophy-pre-emp-curr-control =3D <3>;
> +	status =3D "okay";
> +
> +	port {
> +		usb2_drd_sw: endpoint {
> +			remote-endpoint =3D <&typec2_dr_sw>;
> +		};
> +	};
> +};
> +
> +&usdhc1 {
> +	bus-width =3D <8>;
> +	non-removable;
> +	pinctrl-0 =3D <&pinctrl_usdhc1>;
> +	pinctrl-1 =3D <&pinctrl_usdhc1_100mhz>;
> +	pinctrl-2 =3D <&pinctrl_usdhc1_200mhz>;
> +	pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
> +	status =3D "okay";
> +};
> +
> +&usdhc2 {
> +	bus-width =3D <4>;
> +	cd-gpios =3D <&gpio3 00 GPIO_ACTIVE_LOW>;
> +	no-mmc;
> +	no-sdio;
> +	pinctrl-0 =3D <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-1 =3D <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-2 =3D <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-3 =3D <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_gpio_sleep>;
> +	pinctrl-names =3D "default", "state_100mhz", "state_200mhz", "sleep";
> +	vmmc-supply =3D <&reg_usdhc2_vmmc>;
> +	status =3D "okay";
> +};
> +
> +&wdog3 {
> +	fsl,ext-reset-output;
> +	status =3D "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_eqos: eqosgrp {
> +		fsl,pins =3D <
> +			MX91_PAD_ENET1_MDC__ENET1_MDC                           0x57e
> +			MX91_PAD_ENET1_MDIO__ENET_QOS_MDIO                      0x57e
> +			MX91_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0                  0x57e
> +			MX91_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1                  0x57e
> +			MX91_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2                  0x57e
> +			MX91_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3                  0x57e
> +			MX91_PAD_ENET1_RXC__ENET_QOS_RGMII_RXC                  0x5fe
> +			MX91_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL            0x57e
> +			MX91_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0                  0x57e
> +			MX91_PAD_ENET1_TD1__ENET1_RGMII_TD1                     0x57e
> +			MX91_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2                  0x57e
> +			MX91_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3                  0x57e
> +			MX91_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK  0x5fe
> +			MX91_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL            0x57e
> +		>;
> +	};
> +
> +	pinctrl_eqos_sleep: eqossleepgrp {
> +		fsl,pins =3D <
> +			MX91_PAD_ENET1_MDC__GPIO4_IO0                           0x31e
> +			MX91_PAD_ENET1_MDIO__GPIO4_IO1                          0x31e
> +			MX91_PAD_ENET1_RD0__GPIO4_IO10                          0x31e
> +			MX91_PAD_ENET1_RD1__GPIO4_IO11                          0x31e
> +			MX91_PAD_ENET1_RD2__GPIO4_IO12                          0x31e
> +			MX91_PAD_ENET1_RD3__GPIO4_IO13                          0x31e
> +			MX91_PAD_ENET1_RXC__GPIO4_IO9                           0x31e
> +			MX91_PAD_ENET1_RX_CTL__GPIO4_IO8                        0x31e
> +			MX91_PAD_ENET1_TD0__GPIO4_IO5                           0x31e
> +			MX91_PAD_ENET1_TD1__GPIO4_IO4                           0x31e
> +			MX91_PAD_ENET1_TD2__GPIO4_IO3                           0x31e
> +			MX91_PAD_ENET1_TD3__GPIO4_IO2                           0x31e
> +			MX91_PAD_ENET1_TXC__GPIO4_IO7                           0x31e
> +			MX91_PAD_ENET1_TX_CTL__GPIO4_IO6                        0x31e
> +		>;
> +	};
> +
> +	pinctrl_fec: fecgrp {
> +		fsl,pins =3D <
> +			MX91_PAD_ENET2_MDC__ENET2_MDC			0x57e
> +			MX91_PAD_ENET2_MDIO__ENET2_MDIO			0x57e
> +			MX91_PAD_ENET2_RD0__ENET2_RGMII_RD0		0x57e
> +			MX91_PAD_ENET2_RD1__ENET2_RGMII_RD1		0x57e
> +			MX91_PAD_ENET2_RD2__ENET2_RGMII_RD2		0x57e
> +			MX91_PAD_ENET2_RD3__ENET2_RGMII_RD3		0x57e
> +			MX91_PAD_ENET2_RXC__ENET2_RGMII_RXC		0x5fe
> +			MX91_PAD_ENET2_RX_CTL__ENET2_RGMII_RX_CTL	0x57e
> +			MX91_PAD_ENET2_TD0__ENET2_RGMII_TD0		0x57e
> +			MX91_PAD_ENET2_TD1__ENET2_RGMII_TD1		0x57e
> +			MX91_PAD_ENET2_TD2__ENET2_RGMII_TD2		0x57e
> +			MX91_PAD_ENET2_TD3__ENET2_RGMII_TD3		0x57e
> +			MX91_PAD_ENET2_TXC__ENET2_RGMII_TXC		0x5fe
> +			MX91_PAD_ENET2_TX_CTL__ENET2_RGMII_TX_CTL	0x57e
> +		>;
> +	};
> +
> +	pinctrl_fec_sleep: fecsleepgrp {
> +		fsl,pins =3D <
> +			MX91_PAD_ENET2_MDC__GPIO4_IO14			0x51e
> +			MX91_PAD_ENET2_MDIO__GPIO4_IO15			0x51e
> +			MX91_PAD_ENET2_RD0__GPIO4_IO24			0x51e
> +			MX91_PAD_ENET2_RD1__GPIO4_IO25			0x51e
> +			MX91_PAD_ENET2_RD2__GPIO4_IO26			0x51e
> +			MX91_PAD_ENET2_RD3__GPIO4_IO27			0x51e
> +			MX91_PAD_ENET2_RXC__GPIO4_IO23			0x51e
> +			MX91_PAD_ENET2_RX_CTL__GPIO4_IO22		0x51e
> +			MX91_PAD_ENET2_TD0__GPIO4_IO19			0x51e
> +			MX91_PAD_ENET2_TD1__GPIO4_IO18			0x51e
> +			MX91_PAD_ENET2_TD2__GPIO4_IO17			0x51e
> +			MX91_PAD_ENET2_TD3__GPIO4_IO16			0x51e
> +			MX91_PAD_ENET2_TXC__GPIO4_IO21			0x51e
> +			MX91_PAD_ENET2_TX_CTL__GPIO4_IO20		0x51e
> +		>;
> +	};
> +
> +	pinctrl_flexcan2: flexcan2grp {
> +		fsl,pins =3D <
> +			MX91_PAD_GPIO_IO25__CAN2_TX	0x139e
> +			MX91_PAD_GPIO_IO27__CAN2_RX	0x139e
> +		>;
> +	};
> +
> +	pinctrl_flexcan2_sleep: flexcan2sleepgrp {
> +		fsl,pins =3D <
> +			MX91_PAD_GPIO_IO25__GPIO2_IO25  0x31e
> +			MX91_PAD_GPIO_IO27__GPIO2_IO27	0x31e
> +		>;
> +	};
Is CAN used somewhere?

Best regards

