Return-Path: <linux-pm+bounces-31538-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A06B14860
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 08:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6707216D5A3
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 06:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282FE25D218;
	Tue, 29 Jul 2025 06:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ExJEV+8h";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="bZyLoi0E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC7019ADBF;
	Tue, 29 Jul 2025 06:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753771440; cv=none; b=mGvnwzxbZmcSTxaYQ2oHnvH/XDgdciqRJjQUjPV5552mgKdSTYO2KcMD9ursV7vXNRTTjXNIWxLaAFkSZRnSBrgKNdwXP4I6E+4pMjZtXdzshqzpu73d7C4txlBu9vLsP9Q47qfPzTUj9x6n93IwlZ0jht5T2CglwoGhpI4HNnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753771440; c=relaxed/simple;
	bh=sM+1f1W3wxhedtvqVe4380UbBLWTaVwTmCwcVtH8AE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EO+yKUGDC8dON5E1ZmQdsxCyDTHVeqcHYJ/w+zn4fH6iTEhpCvFFAzJL7LqOAb2+w2DUqZ5/lQXR3qcFHNBYzTajQdtwySPZACmRzBRbJ6L9hm1SVYMKPvIypqM+qa3CrOxYNijbeHLrIB/ott03a12dxKuUcSIfoDCbGf0Lk6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=ExJEV+8h; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=bZyLoi0E reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1753771436; x=1785307436;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QDyrCeBw4rnnn/DNJ6kkjkhexz49Zb8SKSCeM7mOOEo=;
  b=ExJEV+8hYWI1COF3gUVu1IcG6kvwacGExlnM3n00rUwx2C7nRTnQKmcb
   LvKT0rlV7YkxVpdL+9Gak8qN0dEpMOKLhrUKwL32jIX4s0HwebfTtI0kO
   BSnMRDjubQl2BQX9cVX7mL4xnCk2/c7cEEWMFGaj8B0JcW1wWF0JhLOQH
   O/1aB/m6w/RFVnc7zSG3fn9tA9Li091MeU3UUCDDFlIgFi68X1USovMXM
   iAgzz9OoIHPMCo8dtndmEXv+ka+jLuCt+Nr5Mh9YI7OviQqFXLlPEWBCY
   KkzGGqstu7Kg3MY8KEgrlIzmQmdQqETc6zOmB/Fn6DTT1dJ9m/+fso3Uv
   A==;
X-CSE-ConnectionGUID: ooo67CxaTUe86N+KC2c5Lw==
X-CSE-MsgGUID: ulODftRJSdiGzpOUpPuoeg==
X-IronPort-AV: E=Sophos;i="6.16,348,1744063200"; 
   d="scan'208";a="45463951"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 29 Jul 2025 08:43:47 +0200
X-CheckPoint: {68886DA3-7-4FC15ADB-CD71293B}
X-MAIL-CPID: A6887ACEAF6F7F183E6628380BA7739F_0
X-Control-Analysis: str=0001.0A00210D.68886D5A.0060,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F0DB2160D38;
	Tue, 29 Jul 2025 08:43:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1753771422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QDyrCeBw4rnnn/DNJ6kkjkhexz49Zb8SKSCeM7mOOEo=;
	b=bZyLoi0Emda9peu1R7oYqcIIYhCXKygc1ha0D8MDLHWbMaQ2X9NX0B5lZnN4rXN/6EXdPA
	axJE2b9Ky8jCf43N16KTgvE71Z4b9Xm9P+ZFyoLpZAjED5dxzEOL0tHJkFODwljhH33rjC
	VA1WcAxVSIeS9i4Hg4k2iGK9I42dqhVk6WgMbWwUe0dq+VvIbDh2P+rMC+nU+fbnmC4kuX
	VyM4QHgBmT6LUOLDpi1RGciSg1Vx6HyoIwZ2lv5QvwwtCmljviwpuSeV2N2D0MWCZFvsLb
	wRUjn9NNYr82vAavZV/NxPyMc1owCCa6+95l5zBVHp8HPwF2FyTqrOmG8WcIEg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, peng.fan@nxp.com, richardcochran@gmail.com,
 catalin.marinas@arm.com, will@kernel.org, ulf.hansson@linaro.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, frieder.schrempf@kontron.de,
 primoz.fiser@norik.com, othacehe@gnu.org, Markus.Niebel@ew.tq-group.com,
 Joy Zou <joy.zou@nxp.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux@ew.tq-group.com, netdev@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, Frank.Li@nxp.com
Subject:
 Re: [PATCH v7 06/11] arm64: dts: freescale: add i.MX91 11x11 EVK basic
 support
Date: Tue, 29 Jul 2025 08:43:37 +0200
Message-ID: <2793248.mvXUDI8C0e@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20250728071438.2332382-7-joy.zou@nxp.com>
References:
 <20250728071438.2332382-1-joy.zou@nxp.com>
 <20250728071438.2332382-7-joy.zou@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Am Montag, 28. Juli 2025, 09:14:33 CEST schrieb Joy Zou:
> Add i.MX91 11x11 EVK board support.
> - Enable ADC1.
> - Enable lpuart1 and lpuart5.
> - Enable network eqos and fec.
> - Enable I2C bus and children nodes under I2C bus.
> - Enable USB and related nodes.
> - Enable uSDHC1 and uSDHC2.
> - Enable Watchdog3.
>=20
> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
> Changes for v7:
> 1. remove this unused comments, there are not imx91-11x11-evk-i3c.dts.
> 2. align all pinctrl value to the same column.
> 3. add aliases because remove aliases from common dtsi.
> 4. The 'eee-broken-1000t' flag disables Energy-Efficient Ethernet (EEE) o=
n 1G
>    links as a workaround for PTP sync issues on older i.MX6 platforms.
>    Remove it since the i.MX91 have not such issue.
>=20
> Changes for v6:
> 1. remove unused regulators and pinctrl settings.
>=20
> Changes for v5:
> 1. change node name codec and lsm6dsm into common name audio-codec and
>    inertial-meter, and add BT compatible string.
>=20
> Changes for v4:
> 1. remove pmic node unused newline.
> 2. delete the tcpc@50 status property.
> 3. align pad hex values.
>=20
> Changes for v3:
> 1. format imx91-11x11-evk.dts with the dt-format tool.
> 2. add lpi2c1 node.
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../boot/dts/freescale/imx91-11x11-evk.dts    | 674 ++++++++++++++++++
>  2 files changed, 675 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
>=20
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts=
/freescale/Makefile
> index 0b473a23d120..fbedb3493c09 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -315,6 +315,7 @@ dtb-$(CONFIG_ARCH_MXC) +=3D imx8qxp-tqma8xqp-mba8xx.d=
tb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx8qxp-tqma8xqps-mb-smarc-2.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx8ulp-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx93-9x9-qsb.dtb
> +dtb-$(CONFIG_ARCH_MXC) +=3D imx91-11x11-evk.dtb

Please add imx91 before imx93, otherwise inserting will be a pain.

Best regards,
Alexander

> =20
>  imx93-9x9-qsb-i3c-dtbs +=3D imx93-9x9-qsb.dtb imx93-9x9-qsb-i3c.dtbo
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx93-9x9-qsb-i3c.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts b/arch/arm=
64/boot/dts/freescale/imx91-11x11-evk.dts
> new file mode 100644
> index 000000000000..aca78768dbd4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
> @@ -0,0 +1,674 @@
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
> +		gpio0 =3D &gpio1;
> +		gpio1 =3D &gpio2;
> +		gpio2 =3D &gpio3;
> +		i2c0 =3D &lpi2c1;
> +		i2c1 =3D &lpi2c2;
> +		i2c2 =3D &lpi2c3;
> +		mmc0 =3D &usdhc1;
> +		mmc1 =3D &usdhc2;
> +		rtc0 =3D &bbnsm_rtc;
> +		serial0 =3D &lpuart1;
> +		serial1 =3D &lpuart2;
> +		serial2 =3D &lpuart3;
> +		serial3 =3D &lpuart4;
> +		serial4 =3D &lpuart5;
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
> +			realtek,clkout-disable;
> +		};
> +	};
> +};
> +
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
> +			MX91_PAD_ENET2_MDC__ENET2_MDC                           0x57e
> +			MX91_PAD_ENET2_MDIO__ENET2_MDIO                         0x57e
> +			MX91_PAD_ENET2_RD0__ENET2_RGMII_RD0                     0x57e
> +			MX91_PAD_ENET2_RD1__ENET2_RGMII_RD1                     0x57e
> +			MX91_PAD_ENET2_RD2__ENET2_RGMII_RD2                     0x57e
> +			MX91_PAD_ENET2_RD3__ENET2_RGMII_RD3                     0x57e
> +			MX91_PAD_ENET2_RXC__ENET2_RGMII_RXC                     0x5fe
> +			MX91_PAD_ENET2_RX_CTL__ENET2_RGMII_RX_CTL               0x57e
> +			MX91_PAD_ENET2_TD0__ENET2_RGMII_TD0                     0x57e
> +			MX91_PAD_ENET2_TD1__ENET2_RGMII_TD1                     0x57e
> +			MX91_PAD_ENET2_TD2__ENET2_RGMII_TD2                     0x57e
> +			MX91_PAD_ENET2_TD3__ENET2_RGMII_TD3                     0x57e
> +			MX91_PAD_ENET2_TXC__ENET2_RGMII_TXC                     0x5fe
> +			MX91_PAD_ENET2_TX_CTL__ENET2_RGMII_TX_CTL               0x57e
> +		>;
> +	};
> +
> +	pinctrl_fec_sleep: fecsleepgrp {
> +		fsl,pins =3D <
> +			MX91_PAD_ENET2_MDC__GPIO4_IO14                          0x51e
> +			MX91_PAD_ENET2_MDIO__GPIO4_IO15                         0x51e
> +			MX91_PAD_ENET2_RD0__GPIO4_IO24                          0x51e
> +			MX91_PAD_ENET2_RD1__GPIO4_IO25                          0x51e
> +			MX91_PAD_ENET2_RD2__GPIO4_IO26                          0x51e
> +			MX91_PAD_ENET2_RD3__GPIO4_IO27                          0x51e
> +			MX91_PAD_ENET2_RXC__GPIO4_IO23                          0x51e
> +			MX91_PAD_ENET2_RX_CTL__GPIO4_IO22                       0x51e
> +			MX91_PAD_ENET2_TD0__GPIO4_IO19                          0x51e
> +			MX91_PAD_ENET2_TD1__GPIO4_IO18                          0x51e
> +			MX91_PAD_ENET2_TD2__GPIO4_IO17                          0x51e
> +			MX91_PAD_ENET2_TD3__GPIO4_IO16                          0x51e
> +			MX91_PAD_ENET2_TXC__GPIO4_IO21                          0x51e
> +			MX91_PAD_ENET2_TX_CTL__GPIO4_IO20                       0x51e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c1: lpi2c1grp {
> +		fsl,pins =3D <
> +			MX91_PAD_I2C1_SCL__LPI2C1_SCL                           0x40000b9e
> +			MX91_PAD_I2C1_SDA__LPI2C1_SDA                           0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c2: lpi2c2grp {
> +		fsl,pins =3D <
> +			MX91_PAD_I2C2_SCL__LPI2C2_SCL                           0x40000b9e
> +			MX91_PAD_I2C2_SDA__LPI2C2_SDA                           0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c3: lpi2c3grp {
> +		fsl,pins =3D <
> +			MX91_PAD_GPIO_IO28__LPI2C3_SDA                          0x40000b9e
> +			MX91_PAD_GPIO_IO29__LPI2C3_SCL                          0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_pcal6524: pcal6524grp {
> +		fsl,pins =3D <
> +			MX91_PAD_CCM_CLKO2__GPIO3_IO27                          0x31e
> +		>;
> +	};
> +
> +	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
> +		fsl,pins =3D <
> +			MX91_PAD_SD2_RESET_B__GPIO3_IO7                         0x31e
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins =3D <
> +			MX91_PAD_UART1_RXD__LPUART1_RX                          0x31e
> +			MX91_PAD_UART1_TXD__LPUART1_TX                          0x31e
> +		>;
> +	};
> +
> +	pinctrl_uart5: uart5grp {
> +		fsl,pins =3D <
> +			MX91_PAD_DAP_TDO_TRACESWO__LPUART5_TX                   0x31e
> +			MX91_PAD_DAP_TDI__LPUART5_RX                            0x31e
> +			MX91_PAD_DAP_TMS_SWDIO__LPUART5_RTS_B                   0x31e
> +			MX91_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B                  0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
> +		fsl,pins =3D <
> +			MX91_PAD_SD1_CLK__USDHC1_CLK                            0x158e
> +			MX91_PAD_SD1_CMD__USDHC1_CMD                            0x138e
> +			MX91_PAD_SD1_DATA0__USDHC1_DATA0                        0x138e
> +			MX91_PAD_SD1_DATA1__USDHC1_DATA1                        0x138e
> +			MX91_PAD_SD1_DATA2__USDHC1_DATA2                        0x138e
> +			MX91_PAD_SD1_DATA3__USDHC1_DATA3                        0x138e
> +			MX91_PAD_SD1_DATA4__USDHC1_DATA4                        0x138e
> +			MX91_PAD_SD1_DATA5__USDHC1_DATA5                        0x138e
> +			MX91_PAD_SD1_DATA6__USDHC1_DATA6                        0x138e
> +			MX91_PAD_SD1_DATA7__USDHC1_DATA7                        0x138e
> +			MX91_PAD_SD1_STROBE__USDHC1_STROBE                      0x158e
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
> +		fsl,pins =3D <
> +			MX91_PAD_SD1_CLK__USDHC1_CLK                            0x15fe
> +			MX91_PAD_SD1_CMD__USDHC1_CMD                            0x13fe
> +			MX91_PAD_SD1_DATA0__USDHC1_DATA0                        0x13fe
> +			MX91_PAD_SD1_DATA1__USDHC1_DATA1                        0x13fe
> +			MX91_PAD_SD1_DATA2__USDHC1_DATA2                        0x13fe
> +			MX91_PAD_SD1_DATA3__USDHC1_DATA3                        0x13fe
> +			MX91_PAD_SD1_DATA4__USDHC1_DATA4                        0x13fe
> +			MX91_PAD_SD1_DATA5__USDHC1_DATA5                        0x13fe
> +			MX91_PAD_SD1_DATA6__USDHC1_DATA6                        0x13fe
> +			MX91_PAD_SD1_DATA7__USDHC1_DATA7                        0x13fe
> +			MX91_PAD_SD1_STROBE__USDHC1_STROBE                      0x15fe
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins =3D <
> +			MX91_PAD_SD1_CLK__USDHC1_CLK                            0x1582
> +			MX91_PAD_SD1_CMD__USDHC1_CMD                            0x1382
> +			MX91_PAD_SD1_DATA0__USDHC1_DATA0                        0x1382
> +			MX91_PAD_SD1_DATA1__USDHC1_DATA1                        0x1382
> +			MX91_PAD_SD1_DATA2__USDHC1_DATA2                        0x1382
> +			MX91_PAD_SD1_DATA3__USDHC1_DATA3                        0x1382
> +			MX91_PAD_SD1_DATA4__USDHC1_DATA4                        0x1382
> +			MX91_PAD_SD1_DATA5__USDHC1_DATA5                        0x1382
> +			MX91_PAD_SD1_DATA6__USDHC1_DATA6                        0x1382
> +			MX91_PAD_SD1_DATA7__USDHC1_DATA7                        0x1382
> +			MX91_PAD_SD1_STROBE__USDHC1_STROBE                      0x1582
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
> +		fsl,pins =3D <
> +			MX91_PAD_SD2_CLK__USDHC2_CLK                            0x158e
> +			MX91_PAD_SD2_CMD__USDHC2_CMD                            0x138e
> +			MX91_PAD_SD2_DATA0__USDHC2_DATA0                        0x138e
> +			MX91_PAD_SD2_DATA1__USDHC2_DATA1                        0x138e
> +			MX91_PAD_SD2_DATA2__USDHC2_DATA2                        0x138e
> +			MX91_PAD_SD2_DATA3__USDHC2_DATA3                        0x138e
> +			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT                    0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
> +		fsl,pins =3D <
> +			MX91_PAD_SD2_CLK__USDHC2_CLK                            0x15fe
> +			MX91_PAD_SD2_CMD__USDHC2_CMD                            0x13fe
> +			MX91_PAD_SD2_DATA0__USDHC2_DATA0                        0x13fe
> +			MX91_PAD_SD2_DATA1__USDHC2_DATA1                        0x13fe
> +			MX91_PAD_SD2_DATA2__USDHC2_DATA2                        0x13fe
> +			MX91_PAD_SD2_DATA3__USDHC2_DATA3                        0x13fe
> +			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT                    0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
> +		fsl,pins =3D <
> +			MX91_PAD_SD2_CD_B__GPIO3_IO0                            0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_gpio_sleep: usdhc2gpiosleepgrp {
> +		fsl,pins =3D <
> +			MX91_PAD_SD2_CD_B__GPIO3_IO0                            0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins =3D <
> +			MX91_PAD_SD2_CLK__USDHC2_CLK                            0x1582
> +			MX91_PAD_SD2_CMD__USDHC2_CMD                            0x1382
> +			MX91_PAD_SD2_DATA0__USDHC2_DATA0                        0x1382
> +			MX91_PAD_SD2_DATA1__USDHC2_DATA1                        0x1382
> +			MX91_PAD_SD2_DATA2__USDHC2_DATA2                        0x1382
> +			MX91_PAD_SD2_DATA3__USDHC2_DATA3                        0x1382
> +			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT                    0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_sleep: usdhc2sleepgrp {
> +		fsl,pins =3D <
> +			MX91_PAD_SD2_CLK__GPIO3_IO1                             0x51e
> +			MX91_PAD_SD2_CMD__GPIO3_IO2                             0x51e
> +			MX91_PAD_SD2_DATA0__GPIO3_IO3                           0x51e
> +			MX91_PAD_SD2_DATA1__GPIO3_IO4                           0x51e
> +			MX91_PAD_SD2_DATA2__GPIO3_IO5                           0x51e
> +			MX91_PAD_SD2_DATA3__GPIO3_IO6                           0x51e
> +			MX91_PAD_SD2_VSELECT__GPIO3_IO19                        0x51e
> +		>;
> +	};
> +
> +};
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



