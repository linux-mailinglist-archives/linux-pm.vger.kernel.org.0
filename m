Return-Path: <linux-pm+bounces-33189-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D79B37DE7
	for <lists+linux-pm@lfdr.de>; Wed, 27 Aug 2025 10:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65ED8680F43
	for <lists+linux-pm@lfdr.de>; Wed, 27 Aug 2025 08:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5349133A00E;
	Wed, 27 Aug 2025 08:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="FBHyVWhq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="pzkMvWPB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02650308F37;
	Wed, 27 Aug 2025 08:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756283573; cv=none; b=ls9g83099kHjux/IBHP2IESwu7mvQ4X7v2F/XkWuC3DvyMnwFO0XKRrvPDFDZ9k8IejnHXLAUtmlt0SiBkFp5otDRM76MCyWBeqeee4QVx1HTLw1XXw5lyNfg0Fp+7nktbdKqNVw74QWtLTgBJVxn01jJt0EQ6atbed1W0ewSOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756283573; c=relaxed/simple;
	bh=MvkYX0fcmxa0uqR++gUI7FW5HpOrcx+4mhdV1n9+gb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FnwWlyKGZjJDVanwS7j+gwsR4YdXIMNAu5EjNX7iYJLd5IapsTrEgUi4AKBQg/qB8fkmba85Ctha6lQel6Cy6WwmBy7xUrIVQYRmilHlE0tPy4wTjjNPJ2QX96MRyC8V6t/vqaToperafpMWdoZIQ0qoxgwSCFMZN2TTxKHXmA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=FBHyVWhq; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=pzkMvWPB reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1756283568; x=1787819568;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ayIDx4N/D2mhtT/NhR+/h5uppbTLXv9G9g/MuIWqPeo=;
  b=FBHyVWhqBB9ZhwqHmETS3yrFsgb7Kqr3BHTxUtDGBffc8deeUBbpBj50
   WSuZbKCqCA0jRDhGdLZqCnFa/F8lsMdt/jjBpCa1N0Q2Ge/UNsu1Rfg3c
   Tz6ko6mlog+38xEAS/I46VEVDuHxjg8hNBoNwtPQNJiDX/akT87mC0ufa
   8iHzKQCrnKEBhrvuVoqAiJzothhcSFEyqS27EEoEiDffDYHybb9SoFqGP
   oPsOcYUUylLnQfJqmnjTRASVMmfN6/FxsG062F7mFLKpqPfNJQUUGUh4w
   lAXX1F2sEV8Ea8VvFtgsQ/NWRaCPqRJ3e1SZRPlPftJS0htLA9kVNt72f
   Q==;
X-CSE-ConnectionGUID: 5oWBWxrZRcaDIIgBMPrIOA==
X-CSE-MsgGUID: qoibrt+fQTaDc55BUV7UfQ==
X-IronPort-AV: E=Sophos;i="6.18,214,1751234400"; 
   d="scan'208";a="45929668"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 27 Aug 2025 10:32:42 +0200
X-CheckPoint: {68AEC2AA-57-20CAA7DA-EC9DC758}
X-MAIL-CPID: FE6E029ACFA4C8000FC429B018F5E59D_0
X-Control-Analysis: str=0001.0A00210C.68AEC268.008A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4709A1610A4;
	Wed, 27 Aug 2025 10:32:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1756283558;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ayIDx4N/D2mhtT/NhR+/h5uppbTLXv9G9g/MuIWqPeo=;
	b=pzkMvWPByjkZBCW9QBZdodSTQ4JYDdwpMjlOVNenUHBTdvzVLMV4/f1D+PeS/RXsrfaupW
	ezd/HPGYg3F/ChixXGJI25/37xn3J/o9hYlNL2qAoqoPL2hd/vJgOUvX4meDbWpUhmuv3E
	WPAsSS7TgAIq8Q3Oigsu0+foFYJmtnHLNezL8Pn88XXlfSgJ/xTnBvFsTJJihbGh2JpUmG
	Osr6GTRQMeXSMC+VffVluw5pnjWnocYNItzq3aNxQnwL/dn1E0zzyvWIsQzcxWv3wTSTht
	dYQH5jXPQD7/g24UlJtLi2YeoHo97LK+tU/aqry252si7/a+2GS3DkhtLhCmPg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, richardcochran@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 frieder.schrempf@kontron.de, primoz.fiser@norik.com, othacehe@gnu.org,
 Markus.Niebel@ew.tq-group.com, Joy Zou <joy.zou@nxp.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux@ew.tq-group.com, netdev@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, Frank.Li@nxp.com
Subject:
 Re: [PATCH v9 2/6] arm64: dts: freescale: rename imx93.dtsi to
 imx91_93_common.dtsi and modify them
Date: Wed, 27 Aug 2025 10:32:33 +0200
Message-ID: <2326064.iZASKD2KPV@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20250825091223.1378137-3-joy.zou@nxp.com>
References:
 <20250825091223.1378137-1-joy.zou@nxp.com>
 <20250825091223.1378137-3-joy.zou@nxp.com>
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

Am Montag, 25. August 2025, 11:12:19 CEST schrieb Joy Zou:
> The design of i.MX91 platform is very similar to i.MX93 and only
> some small differences.
>=20
> If the imx91.dtsi include the imx93.dtsi, each add to imx93.dtsi
> requires an remove in imx91.dtsi for this unique to i.MX93, e.g. NPU.
> The i.MX91 isn't the i.MX93 subset, if the imx93.dtsi include the
> imx91.dtsi, the same problem will occur.
>=20
> Common + delta is better than common - delta, so add imx91_93_common.dtsi
> for i.MX91 and i.MX93, then the imx93.dtsi and imx91.dtsi will include the
> imx91_93_common.dtsi.
>=20
> Rename imx93.dtsi to imx91_93_common.dtsi and move i.MX93 specific
> part from imx91_93_common.dtsi to imx93.dtsi.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
> Changes for v7:
> 1.The aliases are removed from common.dtsi because the imx93.dtsi aliases
>   are removed.
>=20
> Changes for v6:
> 1. merge rename imx93.dtsi to imx91_93_common.dtsi and move i.MX93
>    specific part from imx91_93_common.dtsi to imx93.dtsi patch.
> 2. restore copyright time and add modification time.
> 3. remove unused map0 label in imx91_93_common.dtsi.
> ---
>  .../{imx93.dtsi =3D> imx91_93_common.dtsi}      |  140 +-
>  arch/arm64/boot/dts/freescale/imx93.dtsi      | 1484 ++---------------
>  2 files changed, 163 insertions(+), 1461 deletions(-)
>  copy arch/arm64/boot/dts/freescale/{imx93.dtsi =3D> imx91_93_common.dtsi=
} (91%)
>  rewrite arch/arm64/boot/dts/freescale/imx93.dtsi (97%)

It's not shown in the diff, but can you add a 'soc' phandle for 'soc@0' nod=
e?
So it can be referenced by imx91 or imx93 individually.

Best regards
Alexander

>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/d=
ts/freescale/imx91_93_common.dtsi
> similarity index 91%
> copy from arch/arm64/boot/dts/freescale/imx93.dtsi
> copy to arch/arm64/boot/dts/freescale/imx91_93_common.dtsi
> index d505f9dfd8ee..c48f3ecb91ed 100644
> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx91_93_common.dtsi
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>  /*
> - * Copyright 2022 NXP
> + * Copyright 2022,2025 NXP
>   */
> =20
>  #include <dt-bindings/clock/imx93-clock.h>
> @@ -18,7 +18,7 @@ / {
>  	#address-cells =3D <2>;
>  	#size-cells =3D <2>;
> =20
> -	cpus {
> +	cpus: cpus {
>  		#address-cells =3D <1>;
>  		#size-cells =3D <0>;
> =20
> @@ -43,58 +43,6 @@ A55_0: cpu@0 {
>  			enable-method =3D "psci";
>  			#cooling-cells =3D <2>;
>  			cpu-idle-states =3D <&cpu_pd_wait>;
> -			i-cache-size =3D <32768>;
> -			i-cache-line-size =3D <64>;
> -			i-cache-sets =3D <128>;
> -			d-cache-size =3D <32768>;
> -			d-cache-line-size =3D <64>;
> -			d-cache-sets =3D <128>;
> -			next-level-cache =3D <&l2_cache_l0>;
> -		};
> -
> -		A55_1: cpu@100 {
> -			device_type =3D "cpu";
> -			compatible =3D "arm,cortex-a55";
> -			reg =3D <0x100>;
> -			enable-method =3D "psci";
> -			#cooling-cells =3D <2>;
> -			cpu-idle-states =3D <&cpu_pd_wait>;
> -			i-cache-size =3D <32768>;
> -			i-cache-line-size =3D <64>;
> -			i-cache-sets =3D <128>;
> -			d-cache-size =3D <32768>;
> -			d-cache-line-size =3D <64>;
> -			d-cache-sets =3D <128>;
> -			next-level-cache =3D <&l2_cache_l1>;
> -		};
> -
> -		l2_cache_l0: l2-cache-l0 {
> -			compatible =3D "cache";
> -			cache-size =3D <65536>;
> -			cache-line-size =3D <64>;
> -			cache-sets =3D <256>;
> -			cache-level =3D <2>;
> -			cache-unified;
> -			next-level-cache =3D <&l3_cache>;
> -		};
> -
> -		l2_cache_l1: l2-cache-l1 {
> -			compatible =3D "cache";
> -			cache-size =3D <65536>;
> -			cache-line-size =3D <64>;
> -			cache-sets =3D <256>;
> -			cache-level =3D <2>;
> -			cache-unified;
> -			next-level-cache =3D <&l3_cache>;
> -		};
> -
> -		l3_cache: l3-cache {
> -			compatible =3D "cache";
> -			cache-size =3D <262144>;
> -			cache-line-size =3D <64>;
> -			cache-sets =3D <256>;
> -			cache-level =3D <3>;
> -			cache-unified;
>  		};
>  	};
> =20
> @@ -150,44 +98,6 @@ gic: interrupt-controller@48000000 {
>  		interrupt-parent =3D <&gic>;
>  	};
> =20
> -	thermal-zones {
> -		cpu-thermal {
> -			polling-delay-passive =3D <250>;
> -			polling-delay =3D <2000>;
> -
> -			thermal-sensors =3D <&tmu 0>;
> -
> -			trips {
> -				cpu_alert: cpu-alert {
> -					temperature =3D <80000>;
> -					hysteresis =3D <2000>;
> -					type =3D "passive";
> -				};
> -
> -				cpu_crit: cpu-crit {
> -					temperature =3D <90000>;
> -					hysteresis =3D <2000>;
> -					type =3D "critical";
> -				};
> -			};
> -
> -			cooling-maps {
> -				map0 {
> -					trip =3D <&cpu_alert>;
> -					cooling-device =3D
> -						<&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -						<&A55_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> -				};
> -			};
> -		};
> -	};
> -
> -	cm33: remoteproc-cm33 {
> -		compatible =3D "fsl,imx93-cm33";
> -		clocks =3D <&clk IMX93_CLK_CM33_GATE>;
> -		status =3D "disabled";
> -	};
> -
>  	mqs1: mqs1 {
>  		compatible =3D "fsl,imx93-mqs";
>  		gpr =3D <&aonmix_ns_gpr>;
> @@ -274,15 +184,6 @@ aonmix_ns_gpr: syscon@44210000 {
>  				reg =3D <0x44210000 0x1000>;
>  			};
> =20
> -			mu1: mailbox@44230000 {
> -				compatible =3D "fsl,imx93-mu", "fsl,imx8ulp-mu";
> -				reg =3D <0x44230000 0x10000>;
> -				interrupts =3D <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_MU1_B_GATE>;
> -				#mbox-cells =3D <2>;
> -				status =3D "disabled";
> -			};
> -
>  			system_counter: timer@44290000 {
>  				compatible =3D "nxp,sysctr-timer";
>  				reg =3D <0x44290000 0x30000>;
> @@ -486,14 +387,6 @@ src: system-controller@44460000 {
>  				#size-cells =3D <1>;
>  				ranges;
> =20
> -				mlmix: power-domain@44461800 {
> -					compatible =3D "fsl,imx93-src-slice";
> -					reg =3D <0x44461800 0x400>, <0x44464800 0x400>;
> -					#power-domain-cells =3D <0>;
> -					clocks =3D <&clk IMX93_CLK_ML_APB>,
> -						 <&clk IMX93_CLK_ML>;
> -				};
> -
>  				mediamix: power-domain@44462400 {
>  					compatible =3D "fsl,imx93-src-slice";
>  					reg =3D <0x44462400 0x400>, <0x44465800 0x400>;
> @@ -509,26 +402,6 @@ clock-controller@44480000 {
>  				#clock-cells =3D <1>;
>  			};
> =20
> -			tmu: tmu@44482000 {
> -				compatible =3D "fsl,qoriq-tmu";
> -				reg =3D <0x44482000 0x1000>;
> -				interrupts =3D <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_TMC_GATE>;
> -				little-endian;
> -				fsl,tmu-range =3D <0x800000da 0x800000e9
> -						 0x80000102 0x8000012a
> -						 0x80000166 0x800001a7
> -						 0x800001b6>;
> -				fsl,tmu-calibration =3D <0x00000000 0x0000000e
> -						       0x00000001 0x00000029
> -						       0x00000002 0x00000056
> -						       0x00000003 0x000000a2
> -						       0x00000004 0x00000116
> -						       0x00000005 0x00000195
> -						       0x00000006 0x000001b2>;
> -				#thermal-sensor-cells =3D <1>;
> -			};
> -
>  			micfil: micfil@44520000 {
>  				compatible =3D "fsl,imx93-micfil";
>  				reg =3D <0x44520000 0x10000>;
> @@ -645,15 +518,6 @@ wakeupmix_gpr: syscon@42420000 {
>  				reg =3D <0x42420000 0x1000>;
>  			};
> =20
> -			mu2: mailbox@42440000 {
> -				compatible =3D "fsl,imx93-mu", "fsl,imx8ulp-mu";
> -				reg =3D <0x42440000 0x10000>;
> -				interrupts =3D <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_MU2_B_GATE>;
> -				#mbox-cells =3D <2>;
> -				status =3D "disabled";
> -			};
> -
>  			wdog3: watchdog@42490000 {
>  				compatible =3D "fsl,imx93-wdt";
>  				reg =3D <0x42490000 0x10000>;
> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/d=
ts/freescale/imx93.dtsi
> dissimilarity index 97%
> index d505f9dfd8ee..7b27012dfcb5 100644
> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> @@ -1,1323 +1,161 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright 2022 NXP
> - */
> -
> -#include <dt-bindings/clock/imx93-clock.h>
> -#include <dt-bindings/dma/fsl-edma.h>
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/input/input.h>
> -#include <dt-bindings/interrupt-controller/arm-gic.h>
> -#include <dt-bindings/power/fsl,imx93-power.h>
> -#include <dt-bindings/thermal/thermal.h>
> -
> -#include "imx93-pinfunc.h"
> -
> -/ {
> -	interrupt-parent =3D <&gic>;
> -	#address-cells =3D <2>;
> -	#size-cells =3D <2>;
> -
> -	cpus {
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
> -
> -		idle-states {
> -			entry-method =3D "psci";
> -
> -			cpu_pd_wait: cpu-pd-wait {
> -				compatible =3D "arm,idle-state";
> -				arm,psci-suspend-param =3D <0x0010033>;
> -				local-timer-stop;
> -				entry-latency-us =3D <10000>;
> -				exit-latency-us =3D <7000>;
> -				min-residency-us =3D <27000>;
> -				wakeup-latency-us =3D <15000>;
> -			};
> -		};
> -
> -		A55_0: cpu@0 {
> -			device_type =3D "cpu";
> -			compatible =3D "arm,cortex-a55";
> -			reg =3D <0x0>;
> -			enable-method =3D "psci";
> -			#cooling-cells =3D <2>;
> -			cpu-idle-states =3D <&cpu_pd_wait>;
> -			i-cache-size =3D <32768>;
> -			i-cache-line-size =3D <64>;
> -			i-cache-sets =3D <128>;
> -			d-cache-size =3D <32768>;
> -			d-cache-line-size =3D <64>;
> -			d-cache-sets =3D <128>;
> -			next-level-cache =3D <&l2_cache_l0>;
> -		};
> -
> -		A55_1: cpu@100 {
> -			device_type =3D "cpu";
> -			compatible =3D "arm,cortex-a55";
> -			reg =3D <0x100>;
> -			enable-method =3D "psci";
> -			#cooling-cells =3D <2>;
> -			cpu-idle-states =3D <&cpu_pd_wait>;
> -			i-cache-size =3D <32768>;
> -			i-cache-line-size =3D <64>;
> -			i-cache-sets =3D <128>;
> -			d-cache-size =3D <32768>;
> -			d-cache-line-size =3D <64>;
> -			d-cache-sets =3D <128>;
> -			next-level-cache =3D <&l2_cache_l1>;
> -		};
> -
> -		l2_cache_l0: l2-cache-l0 {
> -			compatible =3D "cache";
> -			cache-size =3D <65536>;
> -			cache-line-size =3D <64>;
> -			cache-sets =3D <256>;
> -			cache-level =3D <2>;
> -			cache-unified;
> -			next-level-cache =3D <&l3_cache>;
> -		};
> -
> -		l2_cache_l1: l2-cache-l1 {
> -			compatible =3D "cache";
> -			cache-size =3D <65536>;
> -			cache-line-size =3D <64>;
> -			cache-sets =3D <256>;
> -			cache-level =3D <2>;
> -			cache-unified;
> -			next-level-cache =3D <&l3_cache>;
> -		};
> -
> -		l3_cache: l3-cache {
> -			compatible =3D "cache";
> -			cache-size =3D <262144>;
> -			cache-line-size =3D <64>;
> -			cache-sets =3D <256>;
> -			cache-level =3D <3>;
> -			cache-unified;
> -		};
> -	};
> -
> -	osc_32k: clock-osc-32k {
> -		compatible =3D "fixed-clock";
> -		#clock-cells =3D <0>;
> -		clock-frequency =3D <32768>;
> -		clock-output-names =3D "osc_32k";
> -	};
> -
> -	osc_24m: clock-osc-24m {
> -		compatible =3D "fixed-clock";
> -		#clock-cells =3D <0>;
> -		clock-frequency =3D <24000000>;
> -		clock-output-names =3D "osc_24m";
> -	};
> -
> -	clk_ext1: clock-ext1 {
> -		compatible =3D "fixed-clock";
> -		#clock-cells =3D <0>;
> -		clock-frequency =3D <133000000>;
> -		clock-output-names =3D "clk_ext1";
> -	};
> -
> -	pmu {
> -		compatible =3D "arm,cortex-a55-pmu";
> -		interrupts =3D <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIG=
H)>;
> -	};
> -
> -	psci {
> -		compatible =3D "arm,psci-1.0";
> -		method =3D "smc";
> -	};
> -
> -	timer {
> -		compatible =3D "arm,armv8-timer";
> -		interrupts =3D <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LO=
W)>,
> -			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
> -			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
> -			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>;
> -		clock-frequency =3D <24000000>;
> -		arm,no-tick-in-suspend;
> -		interrupt-parent =3D <&gic>;
> -	};
> -
> -	gic: interrupt-controller@48000000 {
> -		compatible =3D "arm,gic-v3";
> -		reg =3D <0 0x48000000 0 0x10000>,
> -		      <0 0x48040000 0 0xc0000>;
> -		#interrupt-cells =3D <3>;
> -		interrupt-controller;
> -		interrupts =3D <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-parent =3D <&gic>;
> -	};
> -
> -	thermal-zones {
> -		cpu-thermal {
> -			polling-delay-passive =3D <250>;
> -			polling-delay =3D <2000>;
> -
> -			thermal-sensors =3D <&tmu 0>;
> -
> -			trips {
> -				cpu_alert: cpu-alert {
> -					temperature =3D <80000>;
> -					hysteresis =3D <2000>;
> -					type =3D "passive";
> -				};
> -
> -				cpu_crit: cpu-crit {
> -					temperature =3D <90000>;
> -					hysteresis =3D <2000>;
> -					type =3D "critical";
> -				};
> -			};
> -
> -			cooling-maps {
> -				map0 {
> -					trip =3D <&cpu_alert>;
> -					cooling-device =3D
> -						<&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -						<&A55_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> -				};
> -			};
> -		};
> -	};
> -
> -	cm33: remoteproc-cm33 {
> -		compatible =3D "fsl,imx93-cm33";
> -		clocks =3D <&clk IMX93_CLK_CM33_GATE>;
> -		status =3D "disabled";
> -	};
> -
> -	mqs1: mqs1 {
> -		compatible =3D "fsl,imx93-mqs";
> -		gpr =3D <&aonmix_ns_gpr>;
> -		status =3D "disabled";
> -	};
> -
> -	mqs2: mqs2 {
> -		compatible =3D "fsl,imx93-mqs";
> -		gpr =3D <&wakeupmix_gpr>;
> -		status =3D "disabled";
> -	};
> -
> -	usbphynop1: usbphynop1 {
> -		compatible =3D "usb-nop-xceiv";
> -		#phy-cells =3D <0>;
> -		clocks =3D <&clk IMX93_CLK_USB_PHY_BURUNIN>;
> -		clock-names =3D "main_clk";
> -	};
> -
> -	usbphynop2: usbphynop2 {
> -		compatible =3D "usb-nop-xceiv";
> -		#phy-cells =3D <0>;
> -		clocks =3D <&clk IMX93_CLK_USB_PHY_BURUNIN>;
> -		clock-names =3D "main_clk";
> -	};
> -
> -	soc@0 {
> -		compatible =3D "simple-bus";
> -		#address-cells =3D <1>;
> -		#size-cells =3D <1>;
> -		ranges =3D <0x0 0x0 0x0 0x80000000>,
> -			 <0x28000000 0x0 0x28000000 0x10000000>;
> -
> -		aips1: bus@44000000 {
> -			compatible =3D "fsl,aips-bus", "simple-bus";
> -			reg =3D <0x44000000 0x800000>;
> -			#address-cells =3D <1>;
> -			#size-cells =3D <1>;
> -			ranges;
> -
> -			edma1: dma-controller@44000000 {
> -				compatible =3D "fsl,imx93-edma3";
> -				reg =3D <0x44000000 0x200000>;
> -				#dma-cells =3D <3>;
> -				dma-channels =3D <31>;
> -				interrupts =3D <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,  //  0: Reserved
> -					     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,  //  1: CANFD1
> -					     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,  //  2: Reserved
> -					     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,  //  3: GPIO1 CH0
> -					     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,  //  4: GPIO1 CH1
> -					     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>, //  5: I3C1 TO Bus
> -					     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>, //  6: I3C1 From Bus
> -					     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>, //  7: LPI2C1 M TX
> -					     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>, //  8: LPI2C1 S TX
> -					     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>, //  9: LPI2C2 M RX
> -					     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>, // 10: LPI2C2 S RX
> -					     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>, // 11: LPSPI1 TX
> -					     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>, // 12: LPSPI1 RX
> -					     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, // 13: LPSPI2 TX
> -					     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>, // 14: LPSPI2 RX
> -					     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>, // 15: LPTMR1
> -					     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>, // 16: LPUART1 TX
> -					     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>, // 17: LPUART1 RX
> -					     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>, // 18: LPUART2 TX
> -					     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>, // 19: LPUART2 RX
> -					     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>, // 20: S400
> -					     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>, // 21: SAI TX
> -					     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>, // 22: SAI RX
> -					     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>, // 23: TPM1 CH0/CH2
> -					     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>, // 24: TPM1 CH1/CH3
> -					     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>, // 25: TPM1 Overflow
> -					     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>, // 26: TMP2 CH0/CH2
> -					     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>, // 27: TMP2 CH1/CH3
> -					     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, // 28: TMP2 Overflow
> -					     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>, // 29: PDM
> -					     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>, // 30: ADC1
> -					     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;  // err
> -				clocks =3D <&clk IMX93_CLK_EDMA1_GATE>;
> -				clock-names =3D "dma";
> -			};
> -
> -			aonmix_ns_gpr: syscon@44210000 {
> -				compatible =3D "fsl,imx93-aonmix-ns-syscfg", "syscon";
> -				reg =3D <0x44210000 0x1000>;
> -			};
> -
> -			mu1: mailbox@44230000 {
> -				compatible =3D "fsl,imx93-mu", "fsl,imx8ulp-mu";
> -				reg =3D <0x44230000 0x10000>;
> -				interrupts =3D <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_MU1_B_GATE>;
> -				#mbox-cells =3D <2>;
> -				status =3D "disabled";
> -			};
> -
> -			system_counter: timer@44290000 {
> -				compatible =3D "nxp,sysctr-timer";
> -				reg =3D <0x44290000 0x30000>;
> -				interrupts =3D <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&osc_24m>;
> -				clock-names =3D "per";
> -				nxp,no-divider;
> -			};
> -
> -			wdog1: watchdog@442d0000 {
> -				compatible =3D "fsl,imx93-wdt";
> -				reg =3D <0x442d0000 0x10000>;
> -				interrupts =3D <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_WDOG1_GATE>;
> -				timeout-sec =3D <40>;
> -				status =3D "disabled";
> -			};
> -
> -			wdog2: watchdog@442e0000 {
> -				compatible =3D "fsl,imx93-wdt";
> -				reg =3D <0x442e0000 0x10000>;
> -				interrupts =3D <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_WDOG2_GATE>;
> -				timeout-sec =3D <40>;
> -				status =3D "disabled";
> -			};
> -
> -			tpm1: pwm@44310000 {
> -				compatible =3D "fsl,imx7ulp-pwm";
> -				reg =3D <0x44310000 0x1000>;
> -				clocks =3D <&clk IMX93_CLK_TPM1_GATE>;
> -				#pwm-cells =3D <3>;
> -				status =3D "disabled";
> -			};
> -
> -			tpm2: pwm@44320000 {
> -				compatible =3D "fsl,imx7ulp-pwm";
> -				reg =3D <0x44320000 0x10000>;
> -				clocks =3D <&clk IMX93_CLK_TPM2_GATE>;
> -				#pwm-cells =3D <3>;
> -				status =3D "disabled";
> -			};
> -
> -			i3c1: i3c@44330000 {
> -				compatible =3D "silvaco,i3c-master-v1";
> -				reg =3D <0x44330000 0x10000>;
> -				interrupts =3D <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> -				#address-cells =3D <3>;
> -				#size-cells =3D <0>;
> -				clocks =3D <&clk IMX93_CLK_BUS_AON>,
> -					 <&clk IMX93_CLK_I3C1_GATE>,
> -					 <&clk IMX93_CLK_I3C1_SLOW>;
> -				clock-names =3D "pclk", "fast_clk", "slow_clk";
> -				status =3D "disabled";
> -			};
> -
> -			lpi2c1: i2c@44340000 {
> -				compatible =3D "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
> -				reg =3D <0x44340000 0x10000>;
> -				#address-cells =3D <1>;
> -				#size-cells =3D <0>;
> -				interrupts =3D <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_LPI2C1_GATE>,
> -					 <&clk IMX93_CLK_BUS_AON>;
> -				clock-names =3D "per", "ipg";
> -				dmas =3D <&edma1 7 0 0>, <&edma1 8 0 FSL_EDMA_RX>;
> -				dma-names =3D "tx", "rx";
> -				status =3D "disabled";
> -			};
> -
> -			lpi2c2: i2c@44350000 {
> -				compatible =3D "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
> -				reg =3D <0x44350000 0x10000>;
> -				#address-cells =3D <1>;
> -				#size-cells =3D <0>;
> -				interrupts =3D <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_LPI2C2_GATE>,
> -					 <&clk IMX93_CLK_BUS_AON>;
> -				clock-names =3D "per", "ipg";
> -				dmas =3D <&edma1 9 0 0>, <&edma1 10 0 FSL_EDMA_RX>;
> -				dma-names =3D "tx", "rx";
> -				status =3D "disabled";
> -			};
> -
> -			lpspi1: spi@44360000 {
> -				#address-cells =3D <1>;
> -				#size-cells =3D <0>;
> -				compatible =3D "fsl,imx93-spi", "fsl,imx7ulp-spi";
> -				reg =3D <0x44360000 0x10000>;
> -				interrupts =3D <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_LPSPI1_GATE>,
> -					 <&clk IMX93_CLK_BUS_AON>;
> -				clock-names =3D "per", "ipg";
> -				dmas =3D <&edma1 11 0 0>, <&edma1 12 0 FSL_EDMA_RX>;
> -				dma-names =3D "tx", "rx";
> -				status =3D "disabled";
> -			};
> -
> -			lpspi2: spi@44370000 {
> -				#address-cells =3D <1>;
> -				#size-cells =3D <0>;
> -				compatible =3D "fsl,imx93-spi", "fsl,imx7ulp-spi";
> -				reg =3D <0x44370000 0x10000>;
> -				interrupts =3D <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_LPSPI2_GATE>,
> -					 <&clk IMX93_CLK_BUS_AON>;
> -				clock-names =3D "per", "ipg";
> -				dmas =3D <&edma1 13 0 0>, <&edma1 14 0 FSL_EDMA_RX>;
> -				dma-names =3D "tx", "rx";
> -				status =3D "disabled";
> -			};
> -
> -			lpuart1: serial@44380000 {
> -				compatible =3D "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ul=
p-lpuart";
> -				reg =3D <0x44380000 0x1000>;
> -				interrupts =3D <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_LPUART1_GATE>;
> -				clock-names =3D "ipg";
> -				dmas =3D <&edma1 17 0 FSL_EDMA_RX>, <&edma1 16 0 0>;
> -				dma-names =3D "rx", "tx";
> -				status =3D "disabled";
> -			};
> -
> -			lpuart2: serial@44390000 {
> -				compatible =3D "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ul=
p-lpuart";
> -				reg =3D <0x44390000 0x1000>;
> -				interrupts =3D <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_LPUART2_GATE>;
> -				clock-names =3D "ipg";
> -				dmas =3D <&edma1 19 0 FSL_EDMA_RX>, <&edma1 18 0 0>;
> -				dma-names =3D "rx", "tx";
> -				status =3D "disabled";
> -			};
> -
> -			flexcan1: can@443a0000 {
> -				compatible =3D "fsl,imx93-flexcan";
> -				reg =3D <0x443a0000 0x10000>;
> -				interrupts =3D <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_BUS_AON>,
> -					 <&clk IMX93_CLK_CAN1_GATE>;
> -				clock-names =3D "ipg", "per";
> -				assigned-clocks =3D <&clk IMX93_CLK_CAN1>;
> -				assigned-clock-parents =3D <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
> -				assigned-clock-rates =3D <40000000>;
> -				fsl,clk-source =3D /bits/ 8 <0>;
> -				fsl,stop-mode =3D <&aonmix_ns_gpr 0x14 0>;
> -				status =3D "disabled";
> -			};
> -
> -			sai1: sai@443b0000 {
> -				compatible =3D "fsl,imx93-sai";
> -				reg =3D <0x443b0000 0x10000>;
> -				interrupts =3D <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_SAI1_IPG>, <&clk IMX93_CLK_DUMMY>,
> -					 <&clk IMX93_CLK_SAI1_GATE>, <&clk IMX93_CLK_DUMMY>,
> -					 <&clk IMX93_CLK_DUMMY>;
> -				clock-names =3D "bus", "mclk0", "mclk1", "mclk2", "mclk3";
> -				dmas =3D <&edma1 22 0 FSL_EDMA_RX>, <&edma1 21 0 0>;
> -				dma-names =3D "rx", "tx";
> -				#sound-dai-cells =3D <0>;
> -				status =3D "disabled";
> -			};
> -
> -			iomuxc: pinctrl@443c0000 {
> -				compatible =3D "fsl,imx93-iomuxc";
> -				reg =3D <0x443c0000 0x10000>;
> -				status =3D "okay";
> -			};
> -
> -			bbnsm: bbnsm@44440000 {
> -				compatible =3D "nxp,imx93-bbnsm", "syscon", "simple-mfd";
> -				reg =3D <0x44440000 0x10000>;
> -
> -				bbnsm_rtc: rtc {
> -					compatible =3D "nxp,imx93-bbnsm-rtc";
> -					interrupts =3D <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
> -				};
> -
> -				bbnsm_pwrkey: pwrkey {
> -					compatible =3D "nxp,imx93-bbnsm-pwrkey";
> -					interrupts =3D <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
> -					linux,code =3D <KEY_POWER>;
> -				};
> -			};
> -
> -			clk: clock-controller@44450000 {
> -				compatible =3D "fsl,imx93-ccm";
> -				reg =3D <0x44450000 0x10000>;
> -				#clock-cells =3D <1>;
> -				clocks =3D <&osc_32k>, <&osc_24m>, <&clk_ext1>;
> -				clock-names =3D "osc_32k", "osc_24m", "clk_ext1";
> -				assigned-clocks =3D <&clk IMX93_CLK_AUDIO_PLL>;
> -				assigned-clock-rates =3D <393216000>;
> -				status =3D "okay";
> -			};
> -
> -			src: system-controller@44460000 {
> -				compatible =3D "fsl,imx93-src", "syscon";
> -				reg =3D <0x44460000 0x10000>;
> -				#address-cells =3D <1>;
> -				#size-cells =3D <1>;
> -				ranges;
> -
> -				mlmix: power-domain@44461800 {
> -					compatible =3D "fsl,imx93-src-slice";
> -					reg =3D <0x44461800 0x400>, <0x44464800 0x400>;
> -					#power-domain-cells =3D <0>;
> -					clocks =3D <&clk IMX93_CLK_ML_APB>,
> -						 <&clk IMX93_CLK_ML>;
> -				};
> -
> -				mediamix: power-domain@44462400 {
> -					compatible =3D "fsl,imx93-src-slice";
> -					reg =3D <0x44462400 0x400>, <0x44465800 0x400>;
> -					#power-domain-cells =3D <0>;
> -					clocks =3D <&clk IMX93_CLK_NIC_MEDIA_GATE>,
> -						 <&clk IMX93_CLK_MEDIA_APB>;
> -				};
> -			};
> -
> -			clock-controller@44480000 {
> -				compatible =3D "fsl,imx93-anatop";
> -				reg =3D <0x44480000 0x2000>;
> -				#clock-cells =3D <1>;
> -			};
> -
> -			tmu: tmu@44482000 {
> -				compatible =3D "fsl,qoriq-tmu";
> -				reg =3D <0x44482000 0x1000>;
> -				interrupts =3D <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_TMC_GATE>;
> -				little-endian;
> -				fsl,tmu-range =3D <0x800000da 0x800000e9
> -						 0x80000102 0x8000012a
> -						 0x80000166 0x800001a7
> -						 0x800001b6>;
> -				fsl,tmu-calibration =3D <0x00000000 0x0000000e
> -						       0x00000001 0x00000029
> -						       0x00000002 0x00000056
> -						       0x00000003 0x000000a2
> -						       0x00000004 0x00000116
> -						       0x00000005 0x00000195
> -						       0x00000006 0x000001b2>;
> -				#thermal-sensor-cells =3D <1>;
> -			};
> -
> -			micfil: micfil@44520000 {
> -				compatible =3D "fsl,imx93-micfil";
> -				reg =3D <0x44520000 0x10000>;
> -				interrupts =3D <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_PDM_IPG>,
> -					 <&clk IMX93_CLK_PDM_GATE>,
> -					 <&clk IMX93_CLK_AUDIO_PLL>;
> -				clock-names =3D "ipg_clk", "ipg_clk_app", "pll8k";
> -				dmas =3D <&edma1 29 0 5>;
> -				dma-names =3D "rx";
> -				#sound-dai-cells =3D <0>;
> -				status =3D "disabled";
> -			};
> -
> -			adc1: adc@44530000 {
> -				compatible =3D "nxp,imx93-adc";
> -				reg =3D <0x44530000 0x10000>;
> -				interrupts =3D <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_ADC1_GATE>;
> -				clock-names =3D "ipg";
> -				#io-channel-cells =3D <1>;
> -				status =3D "disabled";
> -			};
> -		};
> -
> -		aips2: bus@42000000 {
> -			compatible =3D "fsl,aips-bus", "simple-bus";
> -			reg =3D <0x42000000 0x800000>;
> -			#address-cells =3D <1>;
> -			#size-cells =3D <1>;
> -			ranges;
> -
> -			edma2: dma-controller@42000000 {
> -				compatible =3D "fsl,imx93-edma4";
> -				reg =3D <0x42000000 0x210000>;
> -				#dma-cells =3D <3>;
> -				dma-channels =3D <64>;
> -				interrupts =3D <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_EDMA2_GATE>;
> -				clock-names =3D "dma";
> -			};
> -
> -			wakeupmix_gpr: syscon@42420000 {
> -				compatible =3D "fsl,imx93-wakeupmix-syscfg", "syscon";
> -				reg =3D <0x42420000 0x1000>;
> -			};
> -
> -			mu2: mailbox@42440000 {
> -				compatible =3D "fsl,imx93-mu", "fsl,imx8ulp-mu";
> -				reg =3D <0x42440000 0x10000>;
> -				interrupts =3D <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_MU2_B_GATE>;
> -				#mbox-cells =3D <2>;
> -				status =3D "disabled";
> -			};
> -
> -			wdog3: watchdog@42490000 {
> -				compatible =3D "fsl,imx93-wdt";
> -				reg =3D <0x42490000 0x10000>;
> -				interrupts =3D <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_WDOG3_GATE>;
> -				timeout-sec =3D <40>;
> -				status =3D "disabled";
> -			};
> -
> -			wdog4: watchdog@424a0000 {
> -				compatible =3D "fsl,imx93-wdt";
> -				reg =3D <0x424a0000 0x10000>;
> -				interrupts =3D <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_WDOG4_GATE>;
> -				timeout-sec =3D <40>;
> -				status =3D "disabled";
> -			};
> -
> -			wdog5: watchdog@424b0000 {
> -				compatible =3D "fsl,imx93-wdt";
> -				reg =3D <0x424b0000 0x10000>;
> -				interrupts =3D <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_WDOG5_GATE>;
> -				timeout-sec =3D <40>;
> -				status =3D "disabled";
> -			};
> -
> -			tpm3: pwm@424e0000 {
> -				compatible =3D "fsl,imx7ulp-pwm";
> -				reg =3D <0x424e0000 0x1000>;
> -				clocks =3D <&clk IMX93_CLK_TPM3_GATE>;
> -				#pwm-cells =3D <3>;
> -				status =3D "disabled";
> -			};
> -
> -			tpm4: pwm@424f0000 {
> -				compatible =3D "fsl,imx7ulp-pwm";
> -				reg =3D <0x424f0000 0x10000>;
> -				clocks =3D <&clk IMX93_CLK_TPM4_GATE>;
> -				#pwm-cells =3D <3>;
> -				status =3D "disabled";
> -			};
> -
> -			tpm5: pwm@42500000 {
> -				compatible =3D "fsl,imx7ulp-pwm";
> -				reg =3D <0x42500000 0x10000>;
> -				clocks =3D <&clk IMX93_CLK_TPM5_GATE>;
> -				#pwm-cells =3D <3>;
> -				status =3D "disabled";
> -			};
> -
> -			tpm6: pwm@42510000 {
> -				compatible =3D "fsl,imx7ulp-pwm";
> -				reg =3D <0x42510000 0x10000>;
> -				clocks =3D <&clk IMX93_CLK_TPM6_GATE>;
> -				#pwm-cells =3D <3>;
> -				status =3D "disabled";
> -			};
> -
> -			i3c2: i3c@42520000 {
> -				compatible =3D "silvaco,i3c-master-v1";
> -				reg =3D <0x42520000 0x10000>;
> -				interrupts =3D <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
> -				#address-cells =3D <3>;
> -				#size-cells =3D <0>;
> -				clocks =3D <&clk IMX93_CLK_BUS_WAKEUP>,
> -					 <&clk IMX93_CLK_I3C2_GATE>,
> -					 <&clk IMX93_CLK_I3C2_SLOW>;
> -				clock-names =3D "pclk", "fast_clk", "slow_clk";
> -				status =3D "disabled";
> -			};
> -
> -			lpi2c3: i2c@42530000 {
> -				compatible =3D "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
> -				reg =3D <0x42530000 0x10000>;
> -				#address-cells =3D <1>;
> -				#size-cells =3D <0>;
> -				interrupts =3D <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_LPI2C3_GATE>,
> -					 <&clk IMX93_CLK_BUS_WAKEUP>;
> -				clock-names =3D "per", "ipg";
> -				dmas =3D <&edma2 8 0 0>, <&edma2 9 0 FSL_EDMA_RX>;
> -				dma-names =3D "tx", "rx";
> -				status =3D "disabled";
> -			};
> -
> -			lpi2c4: i2c@42540000 {
> -				compatible =3D "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
> -				reg =3D <0x42540000 0x10000>;
> -				#address-cells =3D <1>;
> -				#size-cells =3D <0>;
> -				interrupts =3D <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_LPI2C4_GATE>,
> -					 <&clk IMX93_CLK_BUS_WAKEUP>;
> -				clock-names =3D "per", "ipg";
> -				dmas =3D <&edma2 10 0 0>, <&edma2 11 0 FSL_EDMA_RX>;
> -				dma-names =3D "tx", "rx";
> -				status =3D "disabled";
> -			};
> -
> -			lpspi3: spi@42550000 {
> -				#address-cells =3D <1>;
> -				#size-cells =3D <0>;
> -				compatible =3D "fsl,imx93-spi", "fsl,imx7ulp-spi";
> -				reg =3D <0x42550000 0x10000>;
> -				interrupts =3D <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_LPSPI3_GATE>,
> -					 <&clk IMX93_CLK_BUS_WAKEUP>;
> -				clock-names =3D "per", "ipg";
> -				dmas =3D <&edma2 12 0 0>, <&edma2 13 0 FSL_EDMA_RX>;
> -				dma-names =3D "tx", "rx";
> -				status =3D "disabled";
> -			};
> -
> -			lpspi4: spi@42560000 {
> -				#address-cells =3D <1>;
> -				#size-cells =3D <0>;
> -				compatible =3D "fsl,imx93-spi", "fsl,imx7ulp-spi";
> -				reg =3D <0x42560000 0x10000>;
> -				interrupts =3D <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_LPSPI4_GATE>,
> -					 <&clk IMX93_CLK_BUS_WAKEUP>;
> -				clock-names =3D "per", "ipg";
> -				dmas =3D <&edma2 14 0 0>, <&edma2 15 0 FSL_EDMA_RX>;
> -				dma-names =3D "tx", "rx";
> -				status =3D "disabled";
> -			};
> -
> -			lpuart3: serial@42570000 {
> -				compatible =3D "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ul=
p-lpuart";
> -				reg =3D <0x42570000 0x1000>;
> -				interrupts =3D <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_LPUART3_GATE>;
> -				clock-names =3D "ipg";
> -				dmas =3D <&edma2 18 0 FSL_EDMA_RX>, <&edma2 17 0 0>;
> -				dma-names =3D "rx", "tx";
> -				status =3D "disabled";
> -			};
> -
> -			lpuart4: serial@42580000 {
> -				compatible =3D "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ul=
p-lpuart";
> -				reg =3D <0x42580000 0x1000>;
> -				interrupts =3D <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_LPUART4_GATE>;
> -				clock-names =3D "ipg";
> -				dmas =3D <&edma2 20 0 FSL_EDMA_RX>, <&edma2 19 0 0>;
> -				dma-names =3D "rx", "tx";
> -				status =3D "disabled";
> -			};
> -
> -			lpuart5: serial@42590000 {
> -				compatible =3D "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ul=
p-lpuart";
> -				reg =3D <0x42590000 0x1000>;
> -				interrupts =3D <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_LPUART5_GATE>;
> -				clock-names =3D "ipg";
> -				dmas =3D <&edma2 22 0 FSL_EDMA_RX>, <&edma2 21 0 0>;
> -				dma-names =3D "rx", "tx";
> -				status =3D "disabled";
> -			};
> -
> -			lpuart6: serial@425a0000 {
> -				compatible =3D "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ul=
p-lpuart";
> -				reg =3D <0x425a0000 0x1000>;
> -				interrupts =3D <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_LPUART6_GATE>;
> -				clock-names =3D "ipg";
> -				dmas =3D <&edma2 24 0 FSL_EDMA_RX>, <&edma2 23 0 0>;
> -				dma-names =3D "rx", "tx";
> -				status =3D "disabled";
> -			};
> -
> -			flexcan2: can@425b0000 {
> -				compatible =3D "fsl,imx93-flexcan";
> -				reg =3D <0x425b0000 0x10000>;
> -				interrupts =3D <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_BUS_WAKEUP>,
> -					 <&clk IMX93_CLK_CAN2_GATE>;
> -				clock-names =3D "ipg", "per";
> -				assigned-clocks =3D <&clk IMX93_CLK_CAN2>;
> -				assigned-clock-parents =3D <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
> -				assigned-clock-rates =3D <40000000>;
> -				fsl,clk-source =3D /bits/ 8 <0>;
> -				fsl,stop-mode =3D <&wakeupmix_gpr 0x0c 2>;
> -				status =3D "disabled";
> -			};
> -
> -			flexspi1: spi@425e0000 {
> -				compatible =3D "nxp,imx8mm-fspi";
> -				reg =3D <0x425e0000 0x10000>, <0x28000000 0x10000000>;
> -				reg-names =3D "fspi_base", "fspi_mmap";
> -				#address-cells =3D <1>;
> -				#size-cells =3D <0>;
> -				interrupts =3D <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_FLEXSPI1_GATE>,
> -					 <&clk IMX93_CLK_FLEXSPI1_GATE>;
> -				clock-names =3D "fspi_en", "fspi";
> -				assigned-clocks =3D <&clk IMX93_CLK_FLEXSPI1>;
> -				assigned-clock-parents =3D <&clk IMX93_CLK_SYS_PLL_PFD1>;
> -				status =3D "disabled";
> -			};
> -
> -			sai2: sai@42650000 {
> -				compatible =3D "fsl,imx93-sai";
> -				reg =3D <0x42650000 0x10000>;
> -				interrupts =3D <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_SAI2_IPG>, <&clk IMX93_CLK_DUMMY>,
> -					 <&clk IMX93_CLK_SAI2_GATE>, <&clk IMX93_CLK_DUMMY>,
> -					 <&clk IMX93_CLK_DUMMY>;
> -				clock-names =3D "bus", "mclk0", "mclk1", "mclk2", "mclk3";
> -				dmas =3D <&edma2 59 0 FSL_EDMA_RX>, <&edma2 58 0 0>;
> -				dma-names =3D "rx", "tx";
> -				#sound-dai-cells =3D <0>;
> -				status =3D "disabled";
> -			};
> -
> -			sai3: sai@42660000 {
> -				compatible =3D "fsl,imx93-sai";
> -				reg =3D <0x42660000 0x10000>;
> -				interrupts =3D <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_SAI3_IPG>, <&clk IMX93_CLK_DUMMY>,
> -					 <&clk IMX93_CLK_SAI3_GATE>, <&clk IMX93_CLK_DUMMY>,
> -					 <&clk IMX93_CLK_DUMMY>;
> -				clock-names =3D "bus", "mclk0", "mclk1", "mclk2", "mclk3";
> -				dmas =3D <&edma2 61 0 FSL_EDMA_RX>, <&edma2 60 0 0>;
> -				dma-names =3D "rx", "tx";
> -				#sound-dai-cells =3D <0>;
> -				status =3D "disabled";
> -			};
> -
> -			xcvr: xcvr@42680000 {
> -				compatible =3D "fsl,imx93-xcvr";
> -				reg =3D <0x42680000 0x800>,
> -				      <0x42680800 0x400>,
> -				      <0x42680c00 0x080>,
> -				      <0x42680e00 0x080>;
> -				reg-names =3D "ram", "regs", "rxfifo", "txfifo";
> -				interrupts =3D <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_SPDIF_IPG>,
> -					 <&clk IMX93_CLK_SPDIF_GATE>,
> -					 <&clk IMX93_CLK_DUMMY>,
> -					 <&clk IMX93_CLK_AUD_XCVR_GATE>;
> -				clock-names =3D "ipg", "phy", "spba", "pll_ipg";
> -				dmas =3D <&edma2 65 0 FSL_EDMA_RX>, <&edma2 66 0 0>;
> -				dma-names =3D "rx", "tx";
> -				#sound-dai-cells =3D <0>;
> -				status =3D "disabled";
> -			};
> -
> -			lpuart7: serial@42690000 {
> -				compatible =3D "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ul=
p-lpuart";
> -				reg =3D <0x42690000 0x1000>;
> -				interrupts =3D <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_LPUART7_GATE>;
> -				clock-names =3D "ipg";
> -				dmas =3D <&edma2 88 0 FSL_EDMA_RX>, <&edma2 87 0 0>;
> -				dma-names =3D "rx", "tx";
> -				status =3D "disabled";
> -			};
> -
> -			lpuart8: serial@426a0000 {
> -				compatible =3D "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ul=
p-lpuart";
> -				reg =3D <0x426a0000 0x1000>;
> -				interrupts =3D <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_LPUART8_GATE>;
> -				clock-names =3D "ipg";
> -				dmas =3D <&edma2 90 0 FSL_EDMA_RX>, <&edma2 89 0 0>;
> -				dma-names =3D "rx", "tx";
> -				status =3D "disabled";
> -			};
> -
> -			lpi2c5: i2c@426b0000 {
> -				compatible =3D "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
> -				reg =3D <0x426b0000 0x10000>;
> -				#address-cells =3D <1>;
> -				#size-cells =3D <0>;
> -				interrupts =3D <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_LPI2C5_GATE>,
> -					 <&clk IMX93_CLK_BUS_WAKEUP>;
> -				clock-names =3D "per", "ipg";
> -				dmas =3D <&edma2 71 0 0>, <&edma2 72 0 FSL_EDMA_RX>;
> -				dma-names =3D "tx", "rx";
> -				status =3D "disabled";
> -			};
> -
> -			lpi2c6: i2c@426c0000 {
> -				compatible =3D "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
> -				reg =3D <0x426c0000 0x10000>;
> -				#address-cells =3D <1>;
> -				#size-cells =3D <0>;
> -				interrupts =3D <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_LPI2C6_GATE>,
> -					 <&clk IMX93_CLK_BUS_WAKEUP>;
> -				clock-names =3D "per", "ipg";
> -				dmas =3D <&edma2 73 0 0>, <&edma2 74 0 FSL_EDMA_RX>;
> -				dma-names =3D "tx", "rx";
> -				status =3D "disabled";
> -			};
> -
> -			lpi2c7: i2c@426d0000 {
> -				compatible =3D "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
> -				reg =3D <0x426d0000 0x10000>;
> -				#address-cells =3D <1>;
> -				#size-cells =3D <0>;
> -				interrupts =3D <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_LPI2C7_GATE>,
> -					 <&clk IMX93_CLK_BUS_WAKEUP>;
> -				clock-names =3D "per", "ipg";
> -				dmas =3D <&edma2 75 0 0>, <&edma2 76 0 FSL_EDMA_RX>;
> -				dma-names =3D "tx", "rx";
> -				status =3D "disabled";
> -			};
> -
> -			lpi2c8: i2c@426e0000 {
> -				compatible =3D "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
> -				reg =3D <0x426e0000 0x10000>;
> -				#address-cells =3D <1>;
> -				#size-cells =3D <0>;
> -				interrupts =3D <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_LPI2C8_GATE>,
> -					 <&clk IMX93_CLK_BUS_WAKEUP>;
> -				clock-names =3D "per", "ipg";
> -				dmas =3D <&edma2 77 0 0>, <&edma2 78 0 FSL_EDMA_RX>;
> -				dma-names =3D "tx", "rx";
> -				status =3D "disabled";
> -			};
> -
> -			lpspi5: spi@426f0000 {
> -				#address-cells =3D <1>;
> -				#size-cells =3D <0>;
> -				compatible =3D "fsl,imx93-spi", "fsl,imx7ulp-spi";
> -				reg =3D <0x426f0000 0x10000>;
> -				interrupts =3D <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_LPSPI5_GATE>,
> -					 <&clk IMX93_CLK_BUS_WAKEUP>;
> -				clock-names =3D "per", "ipg";
> -				dmas =3D <&edma2 79 0 0>, <&edma2 80 0 FSL_EDMA_RX>;
> -				dma-names =3D "tx", "rx";
> -				status =3D "disabled";
> -			};
> -
> -			lpspi6: spi@42700000 {
> -				#address-cells =3D <1>;
> -				#size-cells =3D <0>;
> -				compatible =3D "fsl,imx93-spi", "fsl,imx7ulp-spi";
> -				reg =3D <0x42700000 0x10000>;
> -				interrupts =3D <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_LPSPI6_GATE>,
> -					 <&clk IMX93_CLK_BUS_WAKEUP>;
> -				clock-names =3D "per", "ipg";
> -				dmas =3D <&edma2 81 0 0>, <&edma2 82 0 FSL_EDMA_RX>;
> -				dma-names =3D "tx", "rx";
> -				status =3D "disabled";
> -			};
> -
> -			lpspi7: spi@42710000 {
> -				#address-cells =3D <1>;
> -				#size-cells =3D <0>;
> -				compatible =3D "fsl,imx93-spi", "fsl,imx7ulp-spi";
> -				reg =3D <0x42710000 0x10000>;
> -				interrupts =3D <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_LPSPI7_GATE>,
> -					 <&clk IMX93_CLK_BUS_WAKEUP>;
> -				clock-names =3D "per", "ipg";
> -				dmas =3D <&edma2 83 0 0>, <&edma2 84 0 FSL_EDMA_RX>;
> -				dma-names =3D "tx", "rx";
> -				status =3D "disabled";
> -			};
> -
> -			lpspi8: spi@42720000 {
> -				#address-cells =3D <1>;
> -				#size-cells =3D <0>;
> -				compatible =3D "fsl,imx93-spi", "fsl,imx7ulp-spi";
> -				reg =3D <0x42720000 0x10000>;
> -				interrupts =3D <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_LPSPI8_GATE>,
> -					 <&clk IMX93_CLK_BUS_WAKEUP>;
> -				clock-names =3D "per", "ipg";
> -				dmas =3D <&edma2 85 0 0>, <&edma2 86 0 FSL_EDMA_RX>;
> -				dma-names =3D "tx", "rx";
> -				status =3D "disabled";
> -			};
> -
> -		};
> -
> -		aips3: bus@42800000 {
> -			compatible =3D "fsl,aips-bus", "simple-bus";
> -			reg =3D <0x42800000 0x800000>;
> -			#address-cells =3D <1>;
> -			#size-cells =3D <1>;
> -			ranges;
> -
> -			usdhc1: mmc@42850000 {
> -				compatible =3D "fsl,imx93-usdhc", "fsl,imx8mm-usdhc";
> -				reg =3D <0x42850000 0x10000>;
> -				interrupts =3D <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_BUS_WAKEUP>,
> -					 <&clk IMX93_CLK_WAKEUP_AXI>,
> -					 <&clk IMX93_CLK_USDHC1_GATE>;
> -				clock-names =3D "ipg", "ahb", "per";
> -				assigned-clocks =3D <&clk IMX93_CLK_USDHC1>;
> -				assigned-clock-parents =3D <&clk IMX93_CLK_SYS_PLL_PFD1>;
> -				assigned-clock-rates =3D <400000000>;
> -				bus-width =3D <8>;
> -				fsl,tuning-start-tap =3D <1>;
> -				fsl,tuning-step =3D <2>;
> -				status =3D "disabled";
> -			};
> -
> -			usdhc2: mmc@42860000 {
> -				compatible =3D "fsl,imx93-usdhc", "fsl,imx8mm-usdhc";
> -				reg =3D <0x42860000 0x10000>;
> -				interrupts =3D <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_BUS_WAKEUP>,
> -					 <&clk IMX93_CLK_WAKEUP_AXI>,
> -					 <&clk IMX93_CLK_USDHC2_GATE>;
> -				clock-names =3D "ipg", "ahb", "per";
> -				assigned-clocks =3D <&clk IMX93_CLK_USDHC2>;
> -				assigned-clock-parents =3D <&clk IMX93_CLK_SYS_PLL_PFD1>;
> -				assigned-clock-rates =3D <400000000>;
> -				bus-width =3D <4>;
> -				fsl,tuning-start-tap =3D <1>;
> -				fsl,tuning-step =3D <2>;
> -				status =3D "disabled";
> -			};
> -
> -			fec: ethernet@42890000 {
> -				compatible =3D "fsl,imx93-fec", "fsl,imx8mq-fec", "fsl,imx6sx-fec";
> -				reg =3D <0x42890000 0x10000>;
> -				interrupts =3D <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_ENET1_GATE>,
> -					 <&clk IMX93_CLK_ENET1_GATE>,
> -					 <&clk IMX93_CLK_ENET_TIMER1>,
> -					 <&clk IMX93_CLK_ENET_REF>,
> -					 <&clk IMX93_CLK_ENET_REF_PHY>;
> -				clock-names =3D "ipg", "ahb", "ptp",
> -					      "enet_clk_ref", "enet_out";
> -				assigned-clocks =3D <&clk IMX93_CLK_ENET_TIMER1>,
> -						  <&clk IMX93_CLK_ENET_REF>,
> -						  <&clk IMX93_CLK_ENET_REF_PHY>;
> -				assigned-clock-parents =3D <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
> -							 <&clk IMX93_CLK_SYS_PLL_PFD0_DIV2>,
> -							 <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
> -				assigned-clock-rates =3D <100000000>, <250000000>, <50000000>;
> -				fsl,num-tx-queues =3D <3>;
> -				fsl,num-rx-queues =3D <3>;
> -				fsl,stop-mode =3D <&wakeupmix_gpr 0x0c 1>;
> -				nvmem-cells =3D <&eth_mac1>;
> -				nvmem-cell-names =3D "mac-address";
> -				status =3D "disabled";
> -			};
> -
> -			eqos: ethernet@428a0000 {
> -				compatible =3D "nxp,imx93-dwmac-eqos", "snps,dwmac-5.10a";
> -				reg =3D <0x428a0000 0x10000>;
> -				interrupts =3D <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
> -				interrupt-names =3D "macirq", "eth_wake_irq";
> -				clocks =3D <&clk IMX93_CLK_ENET_QOS_GATE>,
> -					 <&clk IMX93_CLK_ENET_QOS_GATE>,
> -					 <&clk IMX93_CLK_ENET_TIMER2>,
> -					 <&clk IMX93_CLK_ENET>,
> -					 <&clk IMX93_CLK_ENET_QOS_GATE>;
> -				clock-names =3D "stmmaceth", "pclk", "ptp_ref", "tx", "mem";
> -				assigned-clocks =3D <&clk IMX93_CLK_ENET_TIMER2>,
> -						  <&clk IMX93_CLK_ENET>;
> -				assigned-clock-parents =3D <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
> -							 <&clk IMX93_CLK_SYS_PLL_PFD0_DIV2>;
> -				assigned-clock-rates =3D <100000000>, <250000000>;
> -				intf_mode =3D <&wakeupmix_gpr 0x28>;
> -				snps,clk-csr =3D <6>;
> -				nvmem-cells =3D <&eth_mac2>;
> -				nvmem-cell-names =3D "mac-address";
> -				status =3D "disabled";
> -			};
> -
> -			usdhc3: mmc@428b0000 {
> -				compatible =3D "fsl,imx93-usdhc", "fsl,imx8mm-usdhc";
> -				reg =3D <0x428b0000 0x10000>;
> -				interrupts =3D <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks =3D <&clk IMX93_CLK_BUS_WAKEUP>,
> -					 <&clk IMX93_CLK_WAKEUP_AXI>,
> -					 <&clk IMX93_CLK_USDHC3_GATE>;
> -				clock-names =3D "ipg", "ahb", "per";
> -				assigned-clocks =3D <&clk IMX93_CLK_USDHC3>;
> -				assigned-clock-parents =3D <&clk IMX93_CLK_SYS_PLL_PFD1>;
> -				assigned-clock-rates =3D <400000000>;
> -				bus-width =3D <4>;
> -				fsl,tuning-start-tap =3D <1>;
> -				fsl,tuning-step =3D <2>;
> -				status =3D "disabled";
> -			};
> -		};
> -
> -		gpio2: gpio@43810000 {
> -			compatible =3D "fsl,imx93-gpio", "fsl,imx8ulp-gpio";
> -			reg =3D <0x43810000 0x1000>;
> -			gpio-controller;
> -			#gpio-cells =3D <2>;
> -			interrupts =3D <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-controller;
> -			#interrupt-cells =3D <2>;
> -			clocks =3D <&clk IMX93_CLK_GPIO2_GATE>,
> -				 <&clk IMX93_CLK_GPIO2_GATE>;
> -			clock-names =3D "gpio", "port";
> -			gpio-ranges =3D <&iomuxc 0 4 30>;
> -			ngpios =3D <30>;
> -		};
> -
> -		gpio3: gpio@43820000 {
> -			compatible =3D "fsl,imx93-gpio", "fsl,imx8ulp-gpio";
> -			reg =3D <0x43820000 0x1000>;
> -			gpio-controller;
> -			#gpio-cells =3D <2>;
> -			interrupts =3D <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-controller;
> -			#interrupt-cells =3D <2>;
> -			clocks =3D <&clk IMX93_CLK_GPIO3_GATE>,
> -				 <&clk IMX93_CLK_GPIO3_GATE>;
> -			clock-names =3D "gpio", "port";
> -			gpio-ranges =3D <&iomuxc 0 84 8>, <&iomuxc 8 66 18>,
> -				      <&iomuxc 26 34 2>, <&iomuxc 28 0 4>;
> -			ngpios =3D <32>;
> -		};
> -
> -		gpio4: gpio@43830000 {
> -			compatible =3D "fsl,imx93-gpio", "fsl,imx8ulp-gpio";
> -			reg =3D <0x43830000 0x1000>;
> -			gpio-controller;
> -			#gpio-cells =3D <2>;
> -			interrupts =3D <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-controller;
> -			#interrupt-cells =3D <2>;
> -			clocks =3D <&clk IMX93_CLK_GPIO4_GATE>,
> -				 <&clk IMX93_CLK_GPIO4_GATE>;
> -			clock-names =3D "gpio", "port";
> -			gpio-ranges =3D <&iomuxc 0 38 28>, <&iomuxc 28 36 2>;
> -			ngpios =3D <30>;
> -		};
> -
> -		gpio1: gpio@47400000 {
> -			compatible =3D "fsl,imx93-gpio", "fsl,imx8ulp-gpio";
> -			reg =3D <0x47400000 0x1000>;
> -			gpio-controller;
> -			#gpio-cells =3D <2>;
> -			interrupts =3D <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-controller;
> -			#interrupt-cells =3D <2>;
> -			clocks =3D <&clk IMX93_CLK_GPIO1_GATE>,
> -				 <&clk IMX93_CLK_GPIO1_GATE>;
> -			clock-names =3D "gpio", "port";
> -			gpio-ranges =3D <&iomuxc 0 92 16>;
> -			ngpios =3D <16>;
> -		};
> -
> -		ocotp: efuse@47510000 {
> -			compatible =3D "fsl,imx93-ocotp", "syscon";
> -			reg =3D <0x47510000 0x10000>;
> -			#address-cells =3D <1>;
> -			#size-cells =3D <1>;
> -
> -			eth_mac1: mac-address@4ec {
> -				reg =3D <0x4ec 0x6>;
> -			};
> -
> -			eth_mac2: mac-address@4f2 {
> -				reg =3D <0x4f2 0x6>;
> -			};
> -
> -		};
> -
> -		s4muap: mailbox@47520000 {
> -			compatible =3D "fsl,imx93-mu-s4";
> -			reg =3D <0x47520000 0x10000>;
> -			interrupts =3D <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names =3D "tx", "rx";
> -			#mbox-cells =3D <2>;
> -		};
> -
> -		media_blk_ctrl: system-controller@4ac10000 {
> -			compatible =3D "fsl,imx93-media-blk-ctrl", "syscon";
> -			reg =3D <0x4ac10000 0x10000>;
> -			power-domains =3D <&mediamix>;
> -			clocks =3D <&clk IMX93_CLK_MEDIA_APB>,
> -				 <&clk IMX93_CLK_MEDIA_AXI>,
> -				 <&clk IMX93_CLK_NIC_MEDIA_GATE>,
> -				 <&clk IMX93_CLK_MEDIA_DISP_PIX>,
> -				 <&clk IMX93_CLK_CAM_PIX>,
> -				 <&clk IMX93_CLK_PXP_GATE>,
> -				 <&clk IMX93_CLK_LCDIF_GATE>,
> -				 <&clk IMX93_CLK_ISI_GATE>,
> -				 <&clk IMX93_CLK_MIPI_CSI_GATE>,
> -				 <&clk IMX93_CLK_MIPI_DSI_GATE>;
> -			clock-names =3D "apb", "axi", "nic", "disp", "cam",
> -				      "pxp", "lcdif", "isi", "csi", "dsi";
> -			#power-domain-cells =3D <1>;
> -			status =3D "disabled";
> -		};
> -
> -		usbotg1: usb@4c100000 {
> -			compatible =3D "fsl,imx93-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
> -			reg =3D <0x4c100000 0x200>;
> -			interrupts =3D <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks =3D <&clk IMX93_CLK_USB_CONTROLLER_GATE>,
> -				 <&clk IMX93_CLK_HSIO_32K_GATE>;
> -			clock-names =3D "usb_ctrl_root", "usb_wakeup";
> -			assigned-clocks =3D <&clk IMX93_CLK_HSIO>;
> -			assigned-clock-parents =3D <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
> -			assigned-clock-rates =3D <133000000>;
> -			phys =3D <&usbphynop1>;
> -			fsl,usbmisc =3D <&usbmisc1 0>;
> -			status =3D "disabled";
> -		};
> -
> -		usbmisc1: usbmisc@4c100200 {
> -			compatible =3D "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc",
> -				     "fsl,imx6q-usbmisc";
> -			reg =3D <0x4c100200 0x200>;
> -			#index-cells =3D <1>;
> -		};
> -
> -		usbotg2: usb@4c200000 {
> -			compatible =3D "fsl,imx93-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
> -			reg =3D <0x4c200000 0x200>;
> -			interrupts =3D <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks =3D <&clk IMX93_CLK_USB_CONTROLLER_GATE>,
> -				 <&clk IMX93_CLK_HSIO_32K_GATE>;
> -			clock-names =3D "usb_ctrl_root", "usb_wakeup";
> -			assigned-clocks =3D <&clk IMX93_CLK_HSIO>;
> -			assigned-clock-parents =3D <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
> -			assigned-clock-rates =3D <133000000>;
> -			phys =3D <&usbphynop2>;
> -			fsl,usbmisc =3D <&usbmisc2 0>;
> -			status =3D "disabled";
> -		};
> -
> -		usbmisc2: usbmisc@4c200200 {
> -			compatible =3D "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc",
> -				     "fsl,imx6q-usbmisc";
> -			reg =3D <0x4c200200 0x200>;
> -			#index-cells =3D <1>;
> -		};
> -
> -		memory-controller@4e300000 {
> -			compatible =3D "nxp,imx9-memory-controller";
> -			reg =3D <0x4e300000 0x800>, <0x4e301000 0x1000>;
> -			reg-names =3D "ctrl", "inject";
> -			interrupts =3D <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
> -			little-endian;
> -		};
> -
> -		ddr-pmu@4e300dc0 {
> -			compatible =3D "fsl,imx93-ddr-pmu";
> -			reg =3D <0x4e300dc0 0x200>;
> -			interrupts =3D <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
> -		};
> -	};
> -};
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2022,2025 NXP
> + */
> +
> +#include "imx91_93_common.dtsi"
> +
> +/{
> +	cm33: remoteproc-cm33 {
> +		compatible =3D "fsl,imx93-cm33";
> +		clocks =3D <&clk IMX93_CLK_CM33_GATE>;
> +		status =3D "disabled";
> +	};
> +
> +	thermal-zones {
> +		cpu-thermal {
> +			polling-delay-passive =3D <250>;
> +			polling-delay =3D <2000>;
> +
> +			thermal-sensors =3D <&tmu 0>;
> +
> +			trips {
> +				cpu_alert: cpu-alert {
> +					temperature =3D <80000>;
> +					hysteresis =3D <2000>;
> +					type =3D "passive";
> +				};
> +
> +				cpu_crit: cpu-crit {
> +					temperature =3D <90000>;
> +					hysteresis =3D <2000>;
> +					type =3D "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip =3D <&cpu_alert>;
> +					cooling-device =3D
> +						<&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&A55_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&aips1 {
> +	mu1: mailbox@44230000 {
> +		compatible =3D "fsl,imx93-mu", "fsl,imx8ulp-mu";
> +		reg =3D <0x44230000 0x10000>;
> +		interrupts =3D <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks =3D <&clk IMX93_CLK_MU1_B_GATE>;
> +		#mbox-cells =3D <2>;
> +		status =3D "disabled";
> +	};
> +
> +	tmu: tmu@44482000 {
> +		compatible =3D "fsl,qoriq-tmu";
> +		reg =3D <0x44482000 0x1000>;
> +		interrupts =3D <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks =3D <&clk IMX93_CLK_TMC_GATE>;
> +		#thermal-sensor-cells =3D <1>;
> +		little-endian;
> +		fsl,tmu-range =3D <0x800000da 0x800000e9
> +				 0x80000102 0x8000012a
> +				 0x80000166 0x800001a7
> +				 0x800001b6>;
> +		fsl,tmu-calibration =3D <0x00000000 0x0000000e
> +				       0x00000001 0x00000029
> +				       0x00000002 0x00000056
> +				       0x00000003 0x000000a2
> +				       0x00000004 0x00000116
> +				       0x00000005 0x00000195
> +				       0x00000006 0x000001b2>;
> +	};
> +};
> +
> +&aips2 {
> +	mu2: mailbox@42440000 {
> +		compatible =3D "fsl,imx93-mu", "fsl,imx8ulp-mu";
> +		reg =3D <0x42440000 0x10000>;
> +		interrupts =3D <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks =3D <&clk IMX93_CLK_MU2_B_GATE>;
> +		#mbox-cells =3D <2>;
> +		status =3D "disabled";
> +	};
> +};
> +
> +&cpus {
> +	A55_0: cpu@0 {
> +		device_type =3D "cpu";
> +		compatible =3D "arm,cortex-a55";
> +		reg =3D <0x0>;
> +		enable-method =3D "psci";
> +		#cooling-cells =3D <2>;
> +		cpu-idle-states =3D <&cpu_pd_wait>;
> +		i-cache-size =3D <32768>;
> +		i-cache-line-size =3D <64>;
> +		i-cache-sets =3D <128>;
> +		d-cache-size =3D <32768>;
> +		d-cache-line-size =3D <64>;
> +		d-cache-sets =3D <128>;
> +		next-level-cache =3D <&l2_cache_l0>;
> +	};
> +
> +	A55_1: cpu@100 {
> +		device_type =3D "cpu";
> +		compatible =3D "arm,cortex-a55";
> +		reg =3D <0x100>;
> +		enable-method =3D "psci";
> +		#cooling-cells =3D <2>;
> +		cpu-idle-states =3D <&cpu_pd_wait>;
> +		i-cache-size =3D <32768>;
> +		i-cache-line-size =3D <64>;
> +		i-cache-sets =3D <128>;
> +		d-cache-size =3D <32768>;
> +		d-cache-line-size =3D <64>;
> +		d-cache-sets =3D <128>;
> +		next-level-cache =3D <&l2_cache_l1>;
> +	};
> +
> +	l2_cache_l0: l2-cache-l0 {
> +		compatible =3D "cache";
> +		cache-size =3D <65536>;
> +		cache-line-size =3D <64>;
> +		cache-sets =3D <256>;
> +		cache-level =3D <2>;
> +		cache-unified;
> +		next-level-cache =3D <&l3_cache>;
> +	};
> +
> +	l2_cache_l1: l2-cache-l1 {
> +		compatible =3D "cache";
> +		cache-size =3D <65536>;
> +		cache-line-size =3D <64>;
> +		cache-sets =3D <256>;
> +		cache-level =3D <2>;
> +		cache-unified;
> +		next-level-cache =3D <&l3_cache>;
> +	};
> +
> +	l3_cache: l3-cache {
> +		compatible =3D "cache";
> +		cache-size =3D <262144>;
> +		cache-line-size =3D <64>;
> +		cache-sets =3D <256>;
> +		cache-level =3D <3>;
> +		cache-unified;
> +	};
> +};
> +
> +&src {
> +	mlmix: power-domain@44461800 {
> +		compatible =3D "fsl,imx93-src-slice";
> +		reg =3D <0x44461800 0x400>, <0x44464800 0x400>;
> +		clocks =3D <&clk IMX93_CLK_ML_APB>,
> +			 <&clk IMX93_CLK_ML>;
> +		#power-domain-cells =3D <0>;
> +	};
> +};
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



