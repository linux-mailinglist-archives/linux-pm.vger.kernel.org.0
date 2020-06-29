Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1143420DD6D
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jun 2020 23:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbgF2Svr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jun 2020 14:51:47 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:35733 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726831AbgF2Sva (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2020 14:51:30 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 14CE6580597;
        Mon, 29 Jun 2020 11:21:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 29 Jun 2020 11:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=krUOveEdR6vT0SBK3qtfa5n706o
        ryNuDtBLGwOel0Fo=; b=VEtU5b+EqJvRVoGcecDwOgK9INc1igaqGpNTrbyWjp7
        t4GknrXv7tKctUi5JWrH2p6O6uYYIDpxpq2pM/8mTaxmakYjDGs2EQutbHreQYwd
        fJv+kZaW3ewSRuY8FVsI1HEbFNUwl4erX42gfLwEeTg1ns00ICau45mAoNseOhbC
        8kD0h8BGjs8fPp3YjhpxkYlwLEC/2n2D77Szii/1UwuSkmfTTqEGQnnsoyY3GpIl
        EHBhoY9KmtyUnCsveKv0MW5JG2xy2qCB6TaqQxf0mcFwx0IB64WHhkgiQN6O0lpn
        DT8q0Ta5pesXagJSN5DYMMpMFpbUCjfwZIr1JA4Z/0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=krUOve
        EdR6vT0SBK3qtfa5n706oryNuDtBLGwOel0Fo=; b=L6DQtBRbaLn4l3ffIzF0Bw
        bJfxa6fVOnQh9qO0p0mJrmSfuq9FDhIP89CuSO4gemX0ANlp8rukEIP6+d25PuP6
        a3QSGPxF/k+Xcx7uqFlMQ2P4OF4kTh9ELsXnA5re3hD2MOlpZgMYXre6ehH5kS4a
        cCxOeIagn8x5pSEn1VwUNGpbyjjxxHPsAy6Hdca09MtGrRJpAf6loosOhXjVBlR3
        Ny+o5D6hqOsFi534Rc4VwRjOE/iQBXI0yjAY/wmsvZwTjr3/tXfURRfYZhIh+Mk8
        hd14z5Ml3RtHtEw0mRB/nAAy5xb04b4c9LOIvEKkmyqZj/VrfLGJuhd6ky+jhXhA
        ==
X-ME-Sender: <xms:6Qb6Xs5A65jiVMk-TBJ7E6MWYyS4QOEbvSnIUioCEO_-3JMTBBRYfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudelledgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:6Qb6Xt7HQSIAah0eJg07s37QLKiq_njkDArZ0GZNou-AaxfXfxeVWA>
    <xmx:6Qb6Xrflm2twAlFg4vyHYS5sN91S-uNRTR0cQNey4cTSqfSaVfk9JA>
    <xmx:6Qb6XhKlWp2txSt5ptrbZvHChxtJtnYggh9FY3iKjY9qUnbEHvLN1w>
    <xmx:7Qb6Xg7aRoYgPeksuOqXA0bw-zrOHrTGsRA0vVtbBGtdnNedV-Vj5g>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 83B73328005E;
        Mon, 29 Jun 2020 11:21:13 -0400 (EDT)
Date:   Mon, 29 Jun 2020 17:21:12 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     robh+dt@kernel.org, wens@csie.org, mturquette@baylibre.com,
        sboyd@kernel.org, srinivas.kandagatla@linaro.org,
        linus.walleij@linaro.org, anarsoul@gmail.com,
        tiny.windzz@gmail.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        p.zabel@pengutronix.de, clabbe@baylibre.com, icenowy@aosc.io,
        megous@megous.com, karlp@tweak.net.au, bage@linutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        huangshuosheng@allwinnertech.com, liyong@allwinnertech.com
Subject: Re: [PATCH v2 09/11] arm64: allwinner: A100: add the basical
 Allwinner A100 DTSI file
Message-ID: <20200629152112.fo3kgcztlutj66hc@gilmour.lan>
References: <20200622025907.32574-1-frank@allwinnertech.com>
 <20200622025907.32574-10-frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lbejoaecuizw4km4"
Content-Disposition: inline
In-Reply-To: <20200622025907.32574-10-frank@allwinnertech.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--lbejoaecuizw4km4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 22, 2020 at 10:59:05AM +0800, Frank Lee wrote:
> Allwinner A100 is a new SoC with Cortex-A53 cores, this commit adds
> the basical DTSI file of it, including the clock, i2c, pins, sid, ths,
> and UART support.
>=20
> Signed-off-by: Frank Lee <frank@allwinnertech.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi | 337 +++++++++++++++++++=
++++++
>  1 file changed, 337 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/=
boot/dts/allwinner/sun50i-a100.dtsi
> new file mode 100644
> index 0000000..5133897
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> @@ -0,0 +1,337 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (c) 2020 Frank Lee <frank@allwinnertech.com>
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/sun50i-a100-ccu.h>
> +#include <dt-bindings/clock/sun50i-a100-r-ccu.h>
> +#include <dt-bindings/reset/sun50i-a100-ccu.h>
> +#include <dt-bindings/reset/sun50i-a100-r-ccu.h>
> +
> +/ {
> +	interrupt-parent =3D <&gic>;
> +	#address-cells =3D <2>;
> +	#size-cells =3D <2>;
> +
> +	cpus {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		cpu0: cpu@0 {
> +			compatible =3D "arm,armv8";
> +			device_type =3D "cpu";
> +			reg =3D <0x0>;
> +			enable-method =3D "psci";
> +		};
> +
> +		cpu@1 {
> +			compatible =3D "arm,armv8";
> +			device_type =3D "cpu";
> +			reg =3D <0x1>;
> +			enable-method =3D "psci";
> +		};
> +
> +		cpu@2 {
> +			compatible =3D "arm,armv8";
> +			device_type =3D "cpu";
> +			reg =3D <0x2>;
> +			enable-method =3D "psci";
> +		};
> +
> +		cpu@3 {
> +			compatible =3D "arm,armv8";
> +			device_type =3D "cpu";
> +			reg =3D <0x3>;
> +			enable-method =3D "psci";
> +		};
> +	};
> +
> +	psci {
> +		compatible =3D "arm,psci-1.0";
> +		method =3D "smc";
> +	};
> +
> +	iosc: internal-osc-clk {
> +		compatible =3D "fixed-clock";
> +		clock-frequency =3D <16000000>;
> +		clock-accuracy =3D <300000000>;
> +		clock-output-names =3D "iosc";
> +		#clock-cells =3D <0>;
> +	};
> +
> +	dcxo24M: dcxo24M_clk {

You shouldn't have underscores in the node names.

> +		compatible =3D "fixed-clock";
> +		clock-frequency =3D <24000000>;
> +		clock-output-names =3D "dcxo24M";
> +		#clock-cells =3D <0>;
> +	};
> +
> +	osc32k: osc32k_clk {

Same thing here

Also, ordering by node name here would be nice

> +		compatible =3D "fixed-clock";
> +		clock-frequency =3D <32768>;
> +		clock-output-names =3D "osc32k";
> +		#clock-cells =3D <0>;
> +	};
> +
> +	timer {
> +		compatible =3D "arm,armv8-timer";
> +		interrupts =3D <GIC_PPI 13
> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +			     <GIC_PPI 14
> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +			     <GIC_PPI 11
> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +			     <GIC_PPI 10
> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +	};

Does it suffer from the same time instability than the one in the A64?
If so, you probably want to enable the workaround too.

> +	soc: soc {

Do you really need a label for that node?

> +		compatible =3D "simple-bus";
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;

Why do you need cells with 2 items here? You don't seem to be using
them.

> +		r_i2c0: i2c@7081400 {
> +			compatible =3D "allwinner,sun6i-a31-i2c";
> +			reg =3D <0x0 0x07081400 0x0 0x400>;
> +			interrupts =3D <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&ccu CLK_BUS_I2C0>;
> +			resets =3D <&ccu RST_BUS_I2C0>;
> +			pinctrl-names =3D "default";
> +			pinctrl-0 =3D <&r_i2c0_pins>;
> +			status =3D "disabled";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +		};
> +
> +		r_i2c1: i2c@7081800 {
> +			compatible =3D "allwinner,sun6i-a31-i2c";
> +			reg =3D <0x0 0x07081800 0x0 0x400>;
> +			interrupts =3D <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&ccu CLK_BUS_I2C1>;
> +			resets =3D <&ccu RST_BUS_I2C1>;
> +			pinctrl-names =3D "default";
> +			pinctrl-0 =3D <&r_i2c1_pins>;
> +			status =3D "disabled";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +		};
> +	};

The clocks and resets phandles and IDs don't look right

> +	thermal-zones {
> +		cpu_thermal_zone {
> +			polling-delay-passive =3D <0>;
> +			polling-delay =3D <0>;
> +			thermal-sensors =3D <&ths 0>;
> +		};

Please add a new line here

> +		gpu_thermal_zone{

You should have a space here    ^=20

> +			polling-delay-passive =3D <0>;
> +			polling-delay =3D <0>;
> +			thermal-sensors =3D <&ths 1>;
> +		};

newline

> +		ddr_thermal_zone{

space                           ^=20

Thanks!
Maxime

--lbejoaecuizw4km4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXvoG6AAKCRDj7w1vZxhR
xRRCAQCSyQ9nHql6TEykxi9l3Cj8dRiNVK0CnZJ3fTQSc1l2AAD/fJV1R7VkbxZi
OFU2QxjJ1CZU81YE8OkmeFr/wMlCsw8=
=kgim
-----END PGP SIGNATURE-----

--lbejoaecuizw4km4--
