Return-Path: <linux-pm+bounces-28188-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DBCACFE58
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 10:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB37C7AA978
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 08:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D25B27D77A;
	Fri,  6 Jun 2025 08:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="KRFSflEU"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1275D1C861D;
	Fri,  6 Jun 2025 08:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749198707; cv=pass; b=P1nd+l3YzNAPjer/0t7gifDT9YB53dJS3ltxCxpFL0T+Ed4fZ2qnXxRpjfcMcR2MQtDmrYXeYlZeEna9b9tWyWLkb9C8PEzx4l+FU2CQ1JDVrHfxMYHrsW0/LiZ/TxJykZe73QQUGADImP7NEGvOLSQ3ImNsblNHAF6HenD9sm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749198707; c=relaxed/simple;
	bh=ErLmJhVn4QAUnKv5ZTvKBfWmiSxEPldyafoLzI0VyrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OYJ+3eTjH/T1c63j7rflil5xzvnW5htQmYAkAceB1uuYKrfZM4RP+xL4XeJZlzeddJUj8hAQf1sMLUzOWkL+9C02XYYTQOcYCBUUJCre4k03V4SJEwCRjdoKb109Ygm/K/XCAutX15nPNE0iZqvgkU9RmjqD9eoI9vYpVwHFY0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=KRFSflEU; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1749198678; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HIyyKYnUOxeCtpNB8W9sCxYALrq0N55a65L0wqg2z9q0dYV7VZt3pyxAAliuANRZvShYordAvWf15N+188V4QaUd25KDIRcy4nGXvuLB3EJTFK8nSi4Xv43GpmZOBrkt+XO9vBwNxpURmgWE6J5nK4xJ946kxXrPLPpTt5giFsw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749198678; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sRk5wAd8hyWXbE60JMWVdo9yqvvwrUsmbz/uBn+epe0=; 
	b=EUgOCE21rlt5geURNVWicY558R5aZrojdY+SG3F1mN5XcNp3uW7ZccMuf+B2NyNqh511ixkmldyy0f4wcGLTSf53cwJM6RL6GKRsUd05JzSpM72gMyUT55k/IAnq++DGtM5PyHZJOCpT/ATGOhMlljzkdo7MN6uV8R7DOcr5zqk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749198678;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=sRk5wAd8hyWXbE60JMWVdo9yqvvwrUsmbz/uBn+epe0=;
	b=KRFSflEUokqfhdFotwJLk80GuhWjg0lX7o3n/PG5O9YJXTs7adWeTYHs8ZJ70jMO
	cJkgxONNpCzBczeSHCEUtldPq2fCwUGvjI+OF0dw85e+XobY9tAtj1b2eKgPlupHG9Z
	5vQHhTVdO6jbwqW2V7m7kiIcVfE+Wh0glpbXgjDk=
Received: by mx.zohomail.com with SMTPS id 1749198677646331.17372961499655;
	Fri, 6 Jun 2025 01:31:17 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Alexey Charkov <alchark@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>, kernel@collabora.com,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/7] arm64: dts: rockchip: Add thermal nodes to RK3576
Date: Fri, 06 Jun 2025 10:31:12 +0200
Message-ID: <8702624.EvYhyI6sBW@workhorse>
In-Reply-To:
 <CABjd4YwrraMC587sn1afA+pHGA-P25xhEMh7AJJQbQ5RwYJPsg@mail.gmail.com>
References:
 <20250425-rk3576-tsadc-upstream-v5-0-0c840b99c30e@collabora.com>
 <20250425-rk3576-tsadc-upstream-v5-6-0c840b99c30e@collabora.com>
 <CABjd4YwrraMC587sn1afA+pHGA-P25xhEMh7AJJQbQ5RwYJPsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Alexey,

On Thursday, 5 June 2025 21:19:39 Central European Summer Time Alexey Chark=
ov wrote:
> Hi Nicolas,
>=20
> On Thu, Jun 5, 2025 at 11:07=E2=80=AFPM Nicolas Frattaroli
> <nicolas.frattaroli@collabora.com> wrote:
> >
> > Add the TSADC node to the RK3576. Additionally, add everything the TSADC
> > needs to function, i.e. thermal zones, their trip points and maps, as
> > well as adjust the CPU cooling-cells property.
> >
> > The polling-delay properties are set to 0 as we do have interrupts for
> > this TSADC on this particular SoC.
> >
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3576.dtsi | 164 +++++++++++++++++++++++=
+++++++-
> >  1 file changed, 162 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot=
/dts/rockchip/rk3576.dtsi
> > index a6bfef82d50bc9b0203a04324d61e0f232b61a65..1c07ad78c9230f1e46b0ef8=
817834f58b19eb86b 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> > @@ -11,6 +11,7 @@
> >  #include <dt-bindings/power/rockchip,rk3576-power.h>
> >  #include <dt-bindings/reset/rockchip,rk3576-cru.h>
> >  #include <dt-bindings/soc/rockchip,boot-mode.h>
> > +#include <dt-bindings/thermal/thermal.h>
> >
> >  / {
> >         compatible =3D "rockchip,rk3576";
> > @@ -113,9 +114,9 @@ cpu_l0: cpu@0 {
> >                         capacity-dmips-mhz =3D <485>;
> >                         clocks =3D <&scmi_clk SCMI_ARMCLK_L>;
> >                         operating-points-v2 =3D <&cluster0_opp_table>;
> > -                       #cooling-cells =3D <2>;
> >                         dynamic-power-coefficient =3D <120>;
> >                         cpu-idle-states =3D <&CPU_SLEEP>;
> > +                       #cooling-cells =3D <2>;
> >                 };
> >
> >                 cpu_l1: cpu@1 {
> > @@ -127,6 +128,7 @@ cpu_l1: cpu@1 {
> >                         clocks =3D <&scmi_clk SCMI_ARMCLK_L>;
> >                         operating-points-v2 =3D <&cluster0_opp_table>;
> >                         cpu-idle-states =3D <&CPU_SLEEP>;
> > +                       #cooling-cells =3D <2>;
> >                 };
> >
> >                 cpu_l2: cpu@2 {
> > @@ -138,6 +140,7 @@ cpu_l2: cpu@2 {
> >                         clocks =3D <&scmi_clk SCMI_ARMCLK_L>;
> >                         operating-points-v2 =3D <&cluster0_opp_table>;
> >                         cpu-idle-states =3D <&CPU_SLEEP>;
> > +                       #cooling-cells =3D <2>;
> >                 };
> >
> >                 cpu_l3: cpu@3 {
> > @@ -149,6 +152,7 @@ cpu_l3: cpu@3 {
> >                         clocks =3D <&scmi_clk SCMI_ARMCLK_L>;
> >                         operating-points-v2 =3D <&cluster0_opp_table>;
> >                         cpu-idle-states =3D <&CPU_SLEEP>;
> > +                       #cooling-cells =3D <2>;
> >                 };
> >
> >                 cpu_b0: cpu@100 {
> > @@ -159,9 +163,9 @@ cpu_b0: cpu@100 {
> >                         capacity-dmips-mhz =3D <1024>;
> >                         clocks =3D <&scmi_clk SCMI_ARMCLK_B>;
> >                         operating-points-v2 =3D <&cluster1_opp_table>;
> > -                       #cooling-cells =3D <2>;
> >                         dynamic-power-coefficient =3D <320>;
> >                         cpu-idle-states =3D <&CPU_SLEEP>;
> > +                       #cooling-cells =3D <2>;
> >                 };
> >
> >                 cpu_b1: cpu@101 {
> > @@ -173,6 +177,7 @@ cpu_b1: cpu@101 {
> >                         clocks =3D <&scmi_clk SCMI_ARMCLK_B>;
> >                         operating-points-v2 =3D <&cluster1_opp_table>;
> >                         cpu-idle-states =3D <&CPU_SLEEP>;
> > +                       #cooling-cells =3D <2>;
> >                 };
> >
> >                 cpu_b2: cpu@102 {
> > @@ -184,6 +189,7 @@ cpu_b2: cpu@102 {
> >                         clocks =3D <&scmi_clk SCMI_ARMCLK_B>;
> >                         operating-points-v2 =3D <&cluster1_opp_table>;
> >                         cpu-idle-states =3D <&CPU_SLEEP>;
> > +                       #cooling-cells =3D <2>;
> >                 };
> >
> >                 cpu_b3: cpu@103 {
> > @@ -195,6 +201,7 @@ cpu_b3: cpu@103 {
> >                         clocks =3D <&scmi_clk SCMI_ARMCLK_B>;
> >                         operating-points-v2 =3D <&cluster1_opp_table>;
> >                         cpu-idle-states =3D <&CPU_SLEEP>;
> > +                       #cooling-cells =3D <2>;
> >                 };
> >
> >                 idle-states {
> > @@ -436,6 +443,143 @@ psci {
> >                 method =3D "smc";
> >         };
> >
> > +       thermal_zones: thermal-zones {
> > +               /* sensor near the center of the SoC */
> > +               package_thermal: package-thermal {
> > +                       polling-delay-passive =3D <0>;
> > +                       polling-delay =3D <0>;
> > +                       thermal-sensors =3D <&tsadc 0>;
> > +
> > +                       trips {
> > +                               package_crit: package-crit {
> > +                                       temperature =3D <115000>;
> > +                                       hysteresis =3D <0>;
> > +                                       type =3D "critical";
> > +                               };
> > +                       };
> > +               };
> > +
> > +               /* sensor for cluster1 (big Cortex-A72 cores) */
> > +               bigcore_thermal: bigcore-thermal {
> > +                       polling-delay-passive =3D <0>;
>=20
> I've tried these on my board, and it seems that with a zero here it
> never stops throttling the CPU even after it cools down. I believe you
> need something like <100> here, which is what I used on RK3588 for
> similar reasons.
>=20
> I think it's because the TSADC only fires an interrupt when the
> temperature crosses the trip point, but the thermal governor also
> needs to observe temperature trends and step up / step down the
> cooling states depending on whether the system is cooling sufficiently
> or not. So it needs to poll the temperature once the cooling device is
> activated (passive in this case).

Thanks, good catch. I struggled to make the CPU throttle at all in my
case, so I never managed to catch this.

I'll fix it in v6, which I'll send out next week based on v6.16-rc1.

>=20
> > +                       polling-delay =3D <0>;
> > +                       thermal-sensors =3D <&tsadc 1>;
> > +
> > +                       trips {
> > +                               bigcore_alert: bigcore-alert {
> > +                                       temperature =3D <85000>;
> > +                                       hysteresis =3D <2000>;
> > +                                       type =3D "passive";
> > +                               };
> > +
> > +                               bigcore_crit: bigcore-crit {
> > +                                       temperature =3D <115000>;
> > +                                       hysteresis =3D <0>;
> > +                                       type =3D "critical";
> > +                               };
> > +                       };
> > +
> > +                       cooling-maps {
> > +                               map0 {
> > +                                       trip =3D <&bigcore_alert>;
> > +                                       cooling-device =3D
> > +                                               <&cpu_b0 THERMAL_NO_LIM=
IT THERMAL_NO_LIMIT>,
> > +                                               <&cpu_b1 THERMAL_NO_LIM=
IT THERMAL_NO_LIMIT>,
> > +                                               <&cpu_b2 THERMAL_NO_LIM=
IT THERMAL_NO_LIMIT>,
> > +                                               <&cpu_b3 THERMAL_NO_LIM=
IT THERMAL_NO_LIMIT>;
> > +                               };
> > +                       };
> > +               };
> > +
> > +               /* sensor for cluster0 (little Cortex-A53 cores) */
> > +               littlecore_thermal: littlecore-thermal {
> > +                       polling-delay-passive =3D <0>;
>=20
> polling-delay-passive =3D <100>;

Will change as well, thank you

>=20
> > +                       polling-delay =3D <0>;
> > +                       thermal-sensors =3D <&tsadc 2>;
> > +
> > +                       trips {
> > +                               littlecore_alert: littlecore-alert {
> > +                                       temperature =3D <85000>;
> > +                                       hysteresis =3D <2000>;
> > +                                       type =3D "passive";
> > +                               };
> > +
> > +                               littlecore_crit: littlecore-crit {
> > +                                       temperature =3D <115000>;
> > +                                       hysteresis =3D <0>;
> > +                                       type =3D "critical";
> > +                               };
> > +                       };
> > +
> > +                       cooling-maps {
> > +                               map0 {
> > +                                       trip =3D <&littlecore_alert>;
> > +                                       cooling-device =3D
> > +                                               <&cpu_l0 THERMAL_NO_LIM=
IT THERMAL_NO_LIMIT>,
> > +                                               <&cpu_l1 THERMAL_NO_LIM=
IT THERMAL_NO_LIMIT>,
> > +                                               <&cpu_l2 THERMAL_NO_LIM=
IT THERMAL_NO_LIMIT>,
> > +                                               <&cpu_l3 THERMAL_NO_LIM=
IT THERMAL_NO_LIMIT>;
> > +                               };
> > +                       };
> > +               };
> > +
> > +               gpu_thermal: gpu-thermal {
> > +                       polling-delay-passive =3D <0>;
>=20
> polling-delay-passive =3D <100>;

Will change as well, thank you

>=20
> Best regards,
> Alexey
>=20

Best regards,
Nicolas Frattaroli




