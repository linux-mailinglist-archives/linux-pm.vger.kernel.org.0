Return-Path: <linux-pm+bounces-28166-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CE8ACF7B9
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jun 2025 21:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87ADD3AD71B
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jun 2025 19:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B41F1FDE33;
	Thu,  5 Jun 2025 19:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bjlumpkc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698E31C84CB;
	Thu,  5 Jun 2025 19:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749151195; cv=none; b=U7UCAWdYE3WkDO03OvfFYLEEQawhy1MemOAZaAckBNGh0PGEbcMbmiTN9ldQrwgE7q8ttyWJct6YEusFUzN2gcu2hWgXFAnFNilhKxFehAco9alqKBdCCF2l/wVEKuNkD68Y4yhOAFaTrjepf1rcVIASrOqkkTrUMiygCYIdro8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749151195; c=relaxed/simple;
	bh=lSr9p9W9TI5vl3SG4wGYglsTzCcYAqEITF2YFkTCPs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VNNlbrVyw+ENMpzphUqguTdMbcujSYzJOqw9kfVgUhbSGrRbjSLRgF95LOj9zHcr+6j5Uitc5eAS6t79nx4Wbb9PR3HA+0cz2E4mmM+ae2LTh5ACigj0Q8dxV2tIHFOfZiBWmfvt87nCvyyTGSxvufQjLiNXp3h9a47nh8816Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bjlumpkc; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a4bb155eb1so14706831cf.1;
        Thu, 05 Jun 2025 12:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749151192; x=1749755992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07Pr/3RW2zLHEhFDRanXb6IABI33Ahx5XZcAGV/Afqg=;
        b=Bjlumpkc9GnO5SS9YBjBsW0YZzUeki9nbSjg7ih8qJKJKqja4uBcl25EYrT74vXOO8
         ANRm7xOheplSDKBIQhNE4gWSmVDj1AWOpm1tkKN6Q+t6364fO2ySXuJT6hSCVHAoJYHN
         fpq9giqvFyw+UYgqMqgbvu4Qx3ECqHpQmAHChD9/X5FTOMBchlggUkvc1RsqcsYiJ3Hq
         cdMWiUPCdB5m0B7WYVo/YE4Ty+dCcsXowfzcugSN6crfSm9WUfDOIWaTTiTgpeuQ1bFh
         3Icw7s4QVPxqFZJoN82O4DAFxq4k1qFpnjc+Zh9Z1YrGHTeIXMtVsRSjjyIDYq5daTUS
         AZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749151192; x=1749755992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=07Pr/3RW2zLHEhFDRanXb6IABI33Ahx5XZcAGV/Afqg=;
        b=djXga1IIrUFiSNHL8mnz9UKCEhkQe9caTVeXVs7MRO2voyc/pchBmNWcYIVNwrY0OH
         aWq6Rwho3+vUu/lVAdnfNAU5uZHRlVsYHiAnm2dC/sGxxIjNIrrMW8VsOIn1bETMNfMN
         RnVAAkfwhkxg6YzNwcPQpnMZUn1asDLfF8oIMXnw3dIbDpFUeutQiciK5rmsIqfXs464
         J70q1AP8kr2dP+FYRrbAECf894t+SDcb4zRKe46ZdPT9uf+1ohhj7PZBEsH6kwPILC+r
         UwJBlNSd9NZ6mnToBAzz8Q3KKDjOMz27Xv925ONEmbV5BcBYZcliKFwlHYXqYEIFxEvk
         ZZkg==
X-Forwarded-Encrypted: i=1; AJvYcCUMlHbIZzB9AM7XCskzOVO458ufKuqMrFwL2qYMwJ7tuFh6CA2Wj/LaT5kpN2FO0ZDdn99ZO1KQ8ssyqAFn@vger.kernel.org, AJvYcCVGQpexBog2oJAhFggRJjCtN7Z830GCzyYU78F9K2z16pZgJLWUYktMAA92JxofMcf2uUJFFaXsKxSR@vger.kernel.org, AJvYcCXk5HcfwA6rHhM/LcEZU/uzHtCtP/pUJ871GinjvwZ6mG0YpG32IJ9zJqaL/PWhxTQ303HxV+/Rv9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ80KC6o3QeD+OdUEWvsptHOW6NywUEWw2xiCBfKdl+DS8aw3v
	LhJl7G4bylFGbLE6/NPqO6o3At3HB3V2YtT1f84WFRAjjRa0ZiYinJ3fouG9xuABiLeyE1k9NZV
	nelO/rRQIGCLqVjft1f7NjcA2OygChMg=
X-Gm-Gg: ASbGncuYPkzMWjf0EacxMifJRe7MyRTsq+bRVA4drRRd33oXD9dI4YGekH0iQskAsHZ
	/eg4jE3UnUmuhANogEAbcFhY0YTDYZlWtXPIWzu/6pBClesOI9OPYYl470RJWm2ROb26yI05Z/k
	MfnBita4Wh+tCmtjAAwY6Uqa2N350HVAK2IkZH6S/ya4jv
X-Google-Smtp-Source: AGHT+IFCqGBmttXS2MNsvkjz2Oag4+7fLFaxxoaskycYOFPeR6iWx5WNapqSo9nz4/NLFcssJHKpXKF6je1fcsq0xWA=
X-Received: by 2002:a05:622a:581b:b0:4a4:4206:b6f3 with SMTP id
 d75a77b69052e-4a5b9e00ed4mr11050881cf.10.1749151192105; Thu, 05 Jun 2025
 12:19:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425-rk3576-tsadc-upstream-v5-0-0c840b99c30e@collabora.com> <20250425-rk3576-tsadc-upstream-v5-6-0c840b99c30e@collabora.com>
In-Reply-To: <20250425-rk3576-tsadc-upstream-v5-6-0c840b99c30e@collabora.com>
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 5 Jun 2025 23:19:39 +0400
X-Gm-Features: AX0GCFsHLRy0Dx5vZtQW6clXPjR-z7m8YaqdEawS_nTns43C_dVBSJ1PP5R5jWo
Message-ID: <CABjd4YwrraMC587sn1afA+pHGA-P25xhEMh7AJJQbQ5RwYJPsg@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] arm64: dts: rockchip: Add thermal nodes to RK3576
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Jonas Karlman <jonas@kwiboo.se>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, kernel@collabora.com, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On Thu, Jun 5, 2025 at 11:07=E2=80=AFPM Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> Add the TSADC node to the RK3576. Additionally, add everything the TSADC
> needs to function, i.e. thermal zones, their trip points and maps, as
> well as adjust the CPU cooling-cells property.
>
> The polling-delay properties are set to 0 as we do have interrupts for
> this TSADC on this particular SoC.
>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3576.dtsi | 164 +++++++++++++++++++++++++=
+++++-
>  1 file changed, 162 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/d=
ts/rockchip/rk3576.dtsi
> index a6bfef82d50bc9b0203a04324d61e0f232b61a65..1c07ad78c9230f1e46b0ef881=
7834f58b19eb86b 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> @@ -11,6 +11,7 @@
>  #include <dt-bindings/power/rockchip,rk3576-power.h>
>  #include <dt-bindings/reset/rockchip,rk3576-cru.h>
>  #include <dt-bindings/soc/rockchip,boot-mode.h>
> +#include <dt-bindings/thermal/thermal.h>
>
>  / {
>         compatible =3D "rockchip,rk3576";
> @@ -113,9 +114,9 @@ cpu_l0: cpu@0 {
>                         capacity-dmips-mhz =3D <485>;
>                         clocks =3D <&scmi_clk SCMI_ARMCLK_L>;
>                         operating-points-v2 =3D <&cluster0_opp_table>;
> -                       #cooling-cells =3D <2>;
>                         dynamic-power-coefficient =3D <120>;
>                         cpu-idle-states =3D <&CPU_SLEEP>;
> +                       #cooling-cells =3D <2>;
>                 };
>
>                 cpu_l1: cpu@1 {
> @@ -127,6 +128,7 @@ cpu_l1: cpu@1 {
>                         clocks =3D <&scmi_clk SCMI_ARMCLK_L>;
>                         operating-points-v2 =3D <&cluster0_opp_table>;
>                         cpu-idle-states =3D <&CPU_SLEEP>;
> +                       #cooling-cells =3D <2>;
>                 };
>
>                 cpu_l2: cpu@2 {
> @@ -138,6 +140,7 @@ cpu_l2: cpu@2 {
>                         clocks =3D <&scmi_clk SCMI_ARMCLK_L>;
>                         operating-points-v2 =3D <&cluster0_opp_table>;
>                         cpu-idle-states =3D <&CPU_SLEEP>;
> +                       #cooling-cells =3D <2>;
>                 };
>
>                 cpu_l3: cpu@3 {
> @@ -149,6 +152,7 @@ cpu_l3: cpu@3 {
>                         clocks =3D <&scmi_clk SCMI_ARMCLK_L>;
>                         operating-points-v2 =3D <&cluster0_opp_table>;
>                         cpu-idle-states =3D <&CPU_SLEEP>;
> +                       #cooling-cells =3D <2>;
>                 };
>
>                 cpu_b0: cpu@100 {
> @@ -159,9 +163,9 @@ cpu_b0: cpu@100 {
>                         capacity-dmips-mhz =3D <1024>;
>                         clocks =3D <&scmi_clk SCMI_ARMCLK_B>;
>                         operating-points-v2 =3D <&cluster1_opp_table>;
> -                       #cooling-cells =3D <2>;
>                         dynamic-power-coefficient =3D <320>;
>                         cpu-idle-states =3D <&CPU_SLEEP>;
> +                       #cooling-cells =3D <2>;
>                 };
>
>                 cpu_b1: cpu@101 {
> @@ -173,6 +177,7 @@ cpu_b1: cpu@101 {
>                         clocks =3D <&scmi_clk SCMI_ARMCLK_B>;
>                         operating-points-v2 =3D <&cluster1_opp_table>;
>                         cpu-idle-states =3D <&CPU_SLEEP>;
> +                       #cooling-cells =3D <2>;
>                 };
>
>                 cpu_b2: cpu@102 {
> @@ -184,6 +189,7 @@ cpu_b2: cpu@102 {
>                         clocks =3D <&scmi_clk SCMI_ARMCLK_B>;
>                         operating-points-v2 =3D <&cluster1_opp_table>;
>                         cpu-idle-states =3D <&CPU_SLEEP>;
> +                       #cooling-cells =3D <2>;
>                 };
>
>                 cpu_b3: cpu@103 {
> @@ -195,6 +201,7 @@ cpu_b3: cpu@103 {
>                         clocks =3D <&scmi_clk SCMI_ARMCLK_B>;
>                         operating-points-v2 =3D <&cluster1_opp_table>;
>                         cpu-idle-states =3D <&CPU_SLEEP>;
> +                       #cooling-cells =3D <2>;
>                 };
>
>                 idle-states {
> @@ -436,6 +443,143 @@ psci {
>                 method =3D "smc";
>         };
>
> +       thermal_zones: thermal-zones {
> +               /* sensor near the center of the SoC */
> +               package_thermal: package-thermal {
> +                       polling-delay-passive =3D <0>;
> +                       polling-delay =3D <0>;
> +                       thermal-sensors =3D <&tsadc 0>;
> +
> +                       trips {
> +                               package_crit: package-crit {
> +                                       temperature =3D <115000>;
> +                                       hysteresis =3D <0>;
> +                                       type =3D "critical";
> +                               };
> +                       };
> +               };
> +
> +               /* sensor for cluster1 (big Cortex-A72 cores) */
> +               bigcore_thermal: bigcore-thermal {
> +                       polling-delay-passive =3D <0>;

I've tried these on my board, and it seems that with a zero here it
never stops throttling the CPU even after it cools down. I believe you
need something like <100> here, which is what I used on RK3588 for
similar reasons.

I think it's because the TSADC only fires an interrupt when the
temperature crosses the trip point, but the thermal governor also
needs to observe temperature trends and step up / step down the
cooling states depending on whether the system is cooling sufficiently
or not. So it needs to poll the temperature once the cooling device is
activated (passive in this case).

> +                       polling-delay =3D <0>;
> +                       thermal-sensors =3D <&tsadc 1>;
> +
> +                       trips {
> +                               bigcore_alert: bigcore-alert {
> +                                       temperature =3D <85000>;
> +                                       hysteresis =3D <2000>;
> +                                       type =3D "passive";
> +                               };
> +
> +                               bigcore_crit: bigcore-crit {
> +                                       temperature =3D <115000>;
> +                                       hysteresis =3D <0>;
> +                                       type =3D "critical";
> +                               };
> +                       };
> +
> +                       cooling-maps {
> +                               map0 {
> +                                       trip =3D <&bigcore_alert>;
> +                                       cooling-device =3D
> +                                               <&cpu_b0 THERMAL_NO_LIMIT=
 THERMAL_NO_LIMIT>,
> +                                               <&cpu_b1 THERMAL_NO_LIMIT=
 THERMAL_NO_LIMIT>,
> +                                               <&cpu_b2 THERMAL_NO_LIMIT=
 THERMAL_NO_LIMIT>,
> +                                               <&cpu_b3 THERMAL_NO_LIMIT=
 THERMAL_NO_LIMIT>;
> +                               };
> +                       };
> +               };
> +
> +               /* sensor for cluster0 (little Cortex-A53 cores) */
> +               littlecore_thermal: littlecore-thermal {
> +                       polling-delay-passive =3D <0>;

polling-delay-passive =3D <100>;

> +                       polling-delay =3D <0>;
> +                       thermal-sensors =3D <&tsadc 2>;
> +
> +                       trips {
> +                               littlecore_alert: littlecore-alert {
> +                                       temperature =3D <85000>;
> +                                       hysteresis =3D <2000>;
> +                                       type =3D "passive";
> +                               };
> +
> +                               littlecore_crit: littlecore-crit {
> +                                       temperature =3D <115000>;
> +                                       hysteresis =3D <0>;
> +                                       type =3D "critical";
> +                               };
> +                       };
> +
> +                       cooling-maps {
> +                               map0 {
> +                                       trip =3D <&littlecore_alert>;
> +                                       cooling-device =3D
> +                                               <&cpu_l0 THERMAL_NO_LIMIT=
 THERMAL_NO_LIMIT>,
> +                                               <&cpu_l1 THERMAL_NO_LIMIT=
 THERMAL_NO_LIMIT>,
> +                                               <&cpu_l2 THERMAL_NO_LIMIT=
 THERMAL_NO_LIMIT>,
> +                                               <&cpu_l3 THERMAL_NO_LIMIT=
 THERMAL_NO_LIMIT>;
> +                               };
> +                       };
> +               };
> +
> +               gpu_thermal: gpu-thermal {
> +                       polling-delay-passive =3D <0>;

polling-delay-passive =3D <100>;

Best regards,
Alexey

