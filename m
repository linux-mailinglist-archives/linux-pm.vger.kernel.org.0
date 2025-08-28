Return-Path: <linux-pm+bounces-33224-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DEAB39606
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 09:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC8F3685EB8
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 07:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647792C236C;
	Thu, 28 Aug 2025 07:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="LrSwYwe0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="b+JJBEoE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5432773D5;
	Thu, 28 Aug 2025 07:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756367743; cv=none; b=IRTzw+SZy9/7lFl+xAKfh8Xo7amPch2Nfm4oGEsiGeAlw4MicmkathdYjBMDh8D63/uPUf8HNM3eINzoxdcVn3KTqnG1DlESywHSzeUeNm5Xu8Ju6+RsiHh7ws/juYcwjTPcXzA/Et2gncOQ4ecwAioJlCq8D2YtxEF3IkZr2tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756367743; c=relaxed/simple;
	bh=dB21VovnO+BqnjAuPsDy6yMgRCa5sL1/EBBYFLHvMBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aHqvkRiHFpUoTc6sbiC7ZYltaaE47EtatrVW4CWxss4XxfWMgQUMudCdOFVL0H0HGNW2CnqHYdXC0gMI5iMCvfIxBy+nnd0sCjP7mxVxI/CppJFqk2qow+YXAr7iSKwJDK+fesEQeGmgyVuzJqlaB1FB7vH7iNwlANviWlG6q0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=LrSwYwe0; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=b+JJBEoE reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1756367739; x=1787903739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5HwiAk4UaJ/0RnREoKOoLiBWJI8eHPDmXvmgOzLgPWo=;
  b=LrSwYwe0yL6FYd9XaX81GXaL8eA/88ukxXxQxbWzyg812ZcISsoOd/v7
   FrlLp+2S6skVVUgIqIguOtojNKQUAczMokOS1Qyz0moqYkbrF7nbJtudj
   1FlxYH7DsBTMN8IZUDsyq0DWKvdQ+0xL1hAbVu3k/pARWAPW911fzAKHb
   DDyBwAVmygjWnQmxibbW7kxxuTX9VzPSJhPylL4H1meiMBoDoVjtmXiTz
   4nccTcFLOJCIsmD6qyXsUiYbr3qhz63u9n+9yDpzNzw6lkzqs4b+pUf77
   ybBf4Sjfhx2GXXNmtmtWeLSeN/wkpxrKIdZxNcB39MIwQTWmOKJjoxIIq
   Q==;
X-CSE-ConnectionGUID: DT7/qzjVS322pF82mqZonQ==
X-CSE-MsgGUID: Nme356ZFScCFBcwqXo/rFQ==
X-IronPort-AV: E=Sophos;i="6.18,217,1751234400"; 
   d="scan'208";a="45949455"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 28 Aug 2025 09:55:28 +0200
X-CheckPoint: {68B00B70-28-820F521C-C7779E56}
X-MAIL-CPID: F4DDEA0D02B3B61D9A99DB4722F13A30_4
X-Control-Analysis: str=0001.0A002109.68B00B0B.0011,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 565541609FD;
	Thu, 28 Aug 2025 09:55:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1756367724;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5HwiAk4UaJ/0RnREoKOoLiBWJI8eHPDmXvmgOzLgPWo=;
	b=b+JJBEoE5ceAFZwdG8+H/uZU0uJwXkaIxAEoC/nSuaJ+H2jKgPXXwb/8HWJ9tYpaBZdvvZ
	NV7i4LwG/avXFqtYV6NYxfsbzz18M3kdGrSK9KV3j2pPqyJWzKWcFMgYFJ6SKuLCVQ6Q73
	00t2CwkBomDcZR0xlOC5UueJobU2N+66yVFdZUqLM0Sr02kk3whP3+woc9laFeKQmcGVGM
	/YPLcWHyOIhn5sN9SMwsUU8fLFCDXSWbo4JdUYa2IPBWaVmh27QJy95gjhIqxVVPbkLpu5
	u7d57S7O+Ts6eKFwkvmQPiqs/nt/RxCi49vvt80PQX4oL1nBCHNXdaYE0S9Mvg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, richardcochran@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 frieder.schrempf@kontron.de, primoz.fiser@norik.com, othacehe@gnu.org,
 Markus.Niebel@ew.tq-group.com, linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux@ew.tq-group.com, netdev@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, Frank.Li@nxp.com,
 Joy Zou <joy.zou@nxp.com>
Subject:
 Re: [PATCH v9 1/6] arm64: dts: freescale: move aliases from imx93.dtsi to
 board dts
Date: Thu, 28 Aug 2025 09:55:18 +0200
Message-ID: <7849995.EvYhyI6sBW@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20250825091223.1378137-2-joy.zou@nxp.com>
References:
 <20250825091223.1378137-1-joy.zou@nxp.com>
 <20250825091223.1378137-2-joy.zou@nxp.com>
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

Am Montag, 25. August 2025, 11:12:18 CEST schrieb Joy Zou:
> The aliases is board level property rather than soc property, so move
> these to each boards.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>

Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com> # imx93-tqma=
9352

> ---
> Changes for v7:
> 1. Add new patch that move aliases from imx93.dtsi to board dts.
> 2. The aliases is board level property rather than soc property.
>    These changes come from comments:
>    https://lore.kernel.org/imx/4e8f2426-92a1-4c7e-b860-0e10e8dd886c@kerne=
l.org/
> 3. Only add aliases using to imx93 board dts.
> ---
>  .../boot/dts/freescale/imx93-11x11-evk.dts    | 19 +++++++++++
>  .../boot/dts/freescale/imx93-14x14-evk.dts    | 15 ++++++++
>  .../boot/dts/freescale/imx93-9x9-qsb.dts      | 18 ++++++++++
>  .../dts/freescale/imx93-kontron-bl-osm-s.dts  | 21 ++++++++++++
>  .../dts/freescale/imx93-phyboard-nash.dts     | 21 ++++++++++++
>  .../dts/freescale/imx93-phyboard-segin.dts    |  9 +++++
>  .../freescale/imx93-tqma9352-mba91xxca.dts    | 11 ++++++
>  .../freescale/imx93-tqma9352-mba93xxca.dts    | 25 ++++++++++++++
>  .../freescale/imx93-tqma9352-mba93xxla.dts    | 25 ++++++++++++++
>  .../dts/freescale/imx93-var-som-symphony.dts  | 17 ++++++++++
>  arch/arm64/boot/dts/freescale/imx93.dtsi      | 34 -------------------
>  11 files changed, 181 insertions(+), 34 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm=
64/boot/dts/freescale/imx93-11x11-evk.dts
> index e24e12f04526..44566e03be65 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> @@ -12,6 +12,25 @@ / {
>  	model =3D "NXP i.MX93 11X11 EVK board";
>  	compatible =3D "fsl,imx93-11x11-evk", "fsl,imx93";
> =20
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
>  	chosen {
>  		stdout-path =3D &lpuart1;
>  	};
> diff --git a/arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts b/arch/arm=
64/boot/dts/freescale/imx93-14x14-evk.dts
> index c5d86b54ad33..da252b7c06cb 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts
> @@ -12,6 +12,21 @@ / {
>  	model =3D "NXP i.MX93 14X14 EVK board";
>  	compatible =3D "fsl,imx93-14x14-evk", "fsl,imx93";
> =20
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
> +	};
> +
>  	chosen {
>  		stdout-path =3D &lpuart1;
>  	};
> diff --git a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts b/arch/arm64=
/boot/dts/freescale/imx93-9x9-qsb.dts
> index f6f8d105b737..0852067eab2c 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
> @@ -17,6 +17,24 @@ bt_sco_codec: bt-sco-codec {
>  		compatible =3D "linux,bt-sco";
>  	};
> =20
> +	aliases {
> +		ethernet0 =3D &fec;
> +		ethernet1 =3D &eqos;
> +		gpio0 =3D &gpio1;
> +		gpio1 =3D &gpio2;
> +		gpio2 =3D &gpio3;
> +		i2c0 =3D &lpi2c1;
> +		i2c1 =3D &lpi2c2;
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
>  	chosen {
>  		stdout-path =3D &lpuart1;
>  	};
> diff --git a/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts b/a=
rch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts
> index 89e97c604bd3..11dd23044722 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts
> @@ -14,6 +14,27 @@ / {
>  	aliases {
>  		ethernet0 =3D &fec;
>  		ethernet1 =3D &eqos;
> +		gpio0 =3D &gpio1;
> +		gpio1 =3D &gpio2;
> +		i2c0 =3D &lpi2c1;
> +		i2c1 =3D &lpi2c2;
> +		mmc0 =3D &usdhc1;
> +		mmc1 =3D &usdhc2;
> +		serial0 =3D &lpuart1;
> +		serial1 =3D &lpuart2;
> +		serial2 =3D &lpuart3;
> +		serial3 =3D &lpuart4;
> +		serial4 =3D &lpuart5;
> +		serial5 =3D &lpuart6;
> +		serial6 =3D &lpuart7;
> +		spi0 =3D &lpspi1;
> +		spi1 =3D &lpspi2;
> +		spi2 =3D &lpspi3;
> +		spi3 =3D &lpspi4;
> +		spi4 =3D &lpspi5;
> +		spi5 =3D &lpspi6;
> +		spi6 =3D &lpspi7;
> +		spi7 =3D &lpspi8;
>  	};
> =20
>  	leds {
> diff --git a/arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts b/arch=
/arm64/boot/dts/freescale/imx93-phyboard-nash.dts
> index 475913cf0cb9..fa5d83dee0a7 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts
> @@ -19,8 +19,29 @@ / {
> =20
>  	aliases {
>  		ethernet1 =3D &eqos;
> +		gpio0 =3D &gpio1;
> +		gpio1 =3D &gpio2;
> +		gpio2 =3D &gpio3;
> +		gpio3 =3D &gpio4;
> +		i2c0 =3D &lpi2c1;
> +		i2c1 =3D &lpi2c2;
> +		mmc0 =3D &usdhc1;
> +		mmc1 =3D &usdhc2;
>  		rtc0 =3D &i2c_rtc;
>  		rtc1 =3D &bbnsm_rtc;
> +		serial0 =3D &lpuart1;
> +		serial1 =3D &lpuart2;
> +		serial2 =3D &lpuart3;
> +		serial3 =3D &lpuart4;
> +		serial4 =3D &lpuart5;
> +		serial5 =3D &lpuart6;
> +		serial6 =3D &lpuart7;
> +		spi0 =3D &lpspi1;
> +		spi1 =3D &lpspi2;
> +		spi2 =3D &lpspi3;
> +		spi3 =3D &lpspi4;
> +		spi4 =3D &lpspi5;
> +		spi5 =3D &lpspi6;
>  	};
> =20
>  	chosen {
> diff --git a/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts b/arc=
h/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
> index 6f1374f5757f..802d96b19e4c 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
> @@ -19,8 +19,17 @@ /{
> =20
>  	aliases {
>  		ethernet1 =3D &eqos;
> +		gpio0 =3D &gpio1;
> +		gpio1 =3D &gpio2;
> +		gpio2 =3D &gpio3;
> +		gpio3 =3D &gpio4;
> +		i2c0 =3D &lpi2c1;
> +		i2c1 =3D &lpi2c2;
> +		mmc0 =3D &usdhc1;
> +		mmc1 =3D &usdhc2;
>  		rtc0 =3D &i2c_rtc;
>  		rtc1 =3D &bbnsm_rtc;
> +		serial0 =3D &lpuart1;
>  	};
> =20
>  	chosen {
> diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba91xxca.dts b=
/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba91xxca.dts
> index 9dbf41cf394b..2673d9dccbf4 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba91xxca.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba91xxca.dts
> @@ -27,8 +27,19 @@ aliases {
>  		eeprom0 =3D &eeprom0;
>  		ethernet0 =3D &eqos;
>  		ethernet1 =3D &fec;
> +		gpio0 =3D &gpio1;
> +		gpio1 =3D &gpio2;
> +		gpio2 =3D &gpio3;
> +		gpio3 =3D &gpio4;
> +		i2c0 =3D &lpi2c1;
> +		i2c1 =3D &lpi2c2;
> +		i2c2 =3D &lpi2c3;
> +		mmc0 =3D &usdhc1;
> +		mmc1 =3D &usdhc2;
>  		rtc0 =3D &pcf85063;
>  		rtc1 =3D &bbnsm_rtc;
> +		serial0 =3D &lpuart1;
> +		serial1 =3D &lpuart2;
>  	};
> =20
>  	backlight: backlight {
> diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts b=
/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
> index 137b8ed242a2..4760d07ea24b 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
> @@ -28,8 +28,33 @@ aliases {
>  		eeprom0 =3D &eeprom0;
>  		ethernet0 =3D &eqos;
>  		ethernet1 =3D &fec;
> +		gpio0 =3D &gpio1;
> +		gpio1 =3D &gpio2;
> +		gpio2 =3D &gpio3;
> +		gpio3 =3D &gpio4;
> +		i2c0 =3D &lpi2c1;
> +		i2c1 =3D &lpi2c2;
> +		i2c2 =3D &lpi2c3;
> +		i2c3 =3D &lpi2c4;
> +		i2c4 =3D &lpi2c5;
> +		mmc0 =3D &usdhc1;
> +		mmc1 =3D &usdhc2;
>  		rtc0 =3D &pcf85063;
>  		rtc1 =3D &bbnsm_rtc;
> +		serial0 =3D &lpuart1;
> +		serial1 =3D &lpuart2;
> +		serial2 =3D &lpuart3;
> +		serial3 =3D &lpuart4;
> +		serial4 =3D &lpuart5;
> +		serial5 =3D &lpuart6;
> +		serial6 =3D &lpuart7;
> +		serial7 =3D &lpuart8;
> +		spi0 =3D &lpspi1;
> +		spi1 =3D &lpspi2;
> +		spi2 =3D &lpspi3;
> +		spi3 =3D &lpspi4;
> +		spi4 =3D &lpspi5;
> +		spi5 =3D &lpspi6;
>  	};
> =20
>  	backlight_lvds: backlight {
> diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts b=
/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
> index 219f49a4f87f..8a88c98ac05a 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
> @@ -28,8 +28,33 @@ aliases {
>  		eeprom0 =3D &eeprom0;
>  		ethernet0 =3D &eqos;
>  		ethernet1 =3D &fec;
> +		gpio0 =3D &gpio1;
> +		gpio1 =3D &gpio2;
> +		gpio2 =3D &gpio3;
> +		gpio3 =3D &gpio4;
> +		i2c0 =3D &lpi2c1;
> +		i2c1 =3D &lpi2c2;
> +		i2c2 =3D &lpi2c3;
> +		i2c3 =3D &lpi2c4;
> +		i2c4 =3D &lpi2c5;
> +		mmc0 =3D &usdhc1;
> +		mmc1 =3D &usdhc2;
>  		rtc0 =3D &pcf85063;
>  		rtc1 =3D &bbnsm_rtc;
> +		serial0 =3D &lpuart1;
> +		serial1 =3D &lpuart2;
> +		serial2 =3D &lpuart3;
> +		serial3 =3D &lpuart4;
> +		serial4 =3D &lpuart5;
> +		serial5 =3D &lpuart6;
> +		serial6 =3D &lpuart7;
> +		serial7 =3D &lpuart8;
> +		spi0 =3D &lpspi1;
> +		spi1 =3D &lpspi2;
> +		spi2 =3D &lpspi3;
> +		spi3 =3D &lpspi4;
> +		spi4 =3D &lpspi5;
> +		spi5 =3D &lpspi6;
>  	};
> =20
>  	backlight_lvds: backlight {
> diff --git a/arch/arm64/boot/dts/freescale/imx93-var-som-symphony.dts b/a=
rch/arm64/boot/dts/freescale/imx93-var-som-symphony.dts
> index 576d6982a4a0..c789c1f24bdc 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-var-som-symphony.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-var-som-symphony.dts
> @@ -17,8 +17,25 @@ /{
>  	aliases {
>  		ethernet0 =3D &eqos;
>  		ethernet1 =3D &fec;
> +		gpio0 =3D &gpio1;
> +		gpio1 =3D &gpio2;
> +		gpio2 =3D &gpio3;
> +		i2c0 =3D &lpi2c1;
> +		i2c1 =3D &lpi2c2;
> +		i2c2 =3D &lpi2c3;
> +		i2c3 =3D &lpi2c4;
> +		i2c4 =3D &lpi2c5;
> +		mmc0 =3D &usdhc1;
> +		mmc1 =3D &usdhc2;
> +		serial0 =3D &lpuart1;
> +		serial1 =3D &lpuart2;
> +		serial2 =3D &lpuart3;
> +		serial3 =3D &lpuart4;
> +		serial4 =3D &lpuart5;
> +		serial5 =3D &lpuart6;
>  	};
> =20
> +
>  	chosen {
>  		stdout-path =3D &lpuart1;
>  	};
> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/d=
ts/freescale/imx93.dtsi
> index 8a7f1cd76c76..d505f9dfd8ee 100644
> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> @@ -18,40 +18,6 @@ / {
>  	#address-cells =3D <2>;
>  	#size-cells =3D <2>;
> =20
> -	aliases {
> -		gpio0 =3D &gpio1;
> -		gpio1 =3D &gpio2;
> -		gpio2 =3D &gpio3;
> -		gpio3 =3D &gpio4;
> -		i2c0 =3D &lpi2c1;
> -		i2c1 =3D &lpi2c2;
> -		i2c2 =3D &lpi2c3;
> -		i2c3 =3D &lpi2c4;
> -		i2c4 =3D &lpi2c5;
> -		i2c5 =3D &lpi2c6;
> -		i2c6 =3D &lpi2c7;
> -		i2c7 =3D &lpi2c8;
> -		mmc0 =3D &usdhc1;
> -		mmc1 =3D &usdhc2;
> -		mmc2 =3D &usdhc3;
> -		serial0 =3D &lpuart1;
> -		serial1 =3D &lpuart2;
> -		serial2 =3D &lpuart3;
> -		serial3 =3D &lpuart4;
> -		serial4 =3D &lpuart5;
> -		serial5 =3D &lpuart6;
> -		serial6 =3D &lpuart7;
> -		serial7 =3D &lpuart8;
> -		spi0 =3D &lpspi1;
> -		spi1 =3D &lpspi2;
> -		spi2 =3D &lpspi3;
> -		spi3 =3D &lpspi4;
> -		spi4 =3D &lpspi5;
> -		spi5 =3D &lpspi6;
> -		spi6 =3D &lpspi7;
> -		spi7 =3D &lpspi8;
> -	};
> -
>  	cpus {
>  		#address-cells =3D <1>;
>  		#size-cells =3D <0>;
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



