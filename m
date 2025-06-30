Return-Path: <linux-pm+bounces-29814-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE6AAED383
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 06:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1717B16F736
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 04:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F79C156F4A;
	Mon, 30 Jun 2025 04:46:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2A54A11;
	Mon, 30 Jun 2025 04:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751258770; cv=none; b=Bn+LSuLzD1y5AQ0RN/HRdZWCsgZBXNfFGnuv+wd0ZiPnpycAX0IdDWKSlchstB3BsAXESA1OgI2yLE15hUqEuN1RY1IH2i+BpXvBham/LtUtXRQmcgYhuGtf2FquGqfMcvYLTNJfmQjjYcYvRD5kWnIS2OQ8oriIwEhrcHPqNYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751258770; c=relaxed/simple;
	bh=jxXMn0hYszLMfuwlXDN1w+WsYqXbMqVNK5L0kCpbaHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SAQIArqowsY4+ptH8GQK5oeEOC4flBnmEnZkcF5mvFylPip8FCXdrE2MetSFS5QqUprp+b1XqwdJ8XQjq4lW9ZHbX6x2U35wVBe5MNYjF7ysnIIJVUjWo2uHXs/djlMKUVFk6xztJ4E3RP/ZhlxZUhTFsPdhqTwB5PgNvbXLciQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-32add56e9ddso15762201fa.2;
        Sun, 29 Jun 2025 21:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751258763; x=1751863563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cQM7nDGryU7B7FarIwhtY8mXOeTFvenOK1t/A6Vy+lo=;
        b=HPflED4CoEBjZf8XcRp/rNdpngsW9n+haKNp567jTXbHyHIhBKiau65tMDHFesMH+V
         gACBbr9696qb6vE65pFoc+NCdbZkU3+Bo12GTtQ4NQDHfNOIPZWDDUANEXUw5YOgdfET
         +/0PKZxCjqGS82wdiQ/r0F1Y5Dko8gpIBOQoz1g4toDvGeDBkCaqVwGBt8rapjiHyD/r
         N0VNBOsuELwIF4uBOHawrVsUkVi669OB2LLGlbAD0BpQEnKDG6sUnJ7zXwuRHKK/gI7w
         kStOAIGhXvvYInn/W/bqTHI+hrUqSywfTtuPILhWSWquBBrct7bzcv3CBqNXoCg9+HHX
         PcTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT04d+iOBqu4xjE3Nxq9cK0roUwGu89fHUmuRL1DJyIIeuvvRLoczbfnG+bi5vaMUMzKvKFWwTWm0=@vger.kernel.org, AJvYcCVMgWsLUuh3QaQc7GTXmoZjULqMMAzF2ps5PZ6z5UIKixWlOEokmvwQXW/pvRuIQX4mBM/yZQYb+t3uHsHO@vger.kernel.org, AJvYcCX6YjvZQH2E7nukKDb87/qf+bo+fS1BBEI+SfwfCk5YCsEeFYtZ1HNbElaF2dT7aAEqz9pB0UDIN26B@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6V6u5fAT3WOKDlsFLDjQPM9U9oDASm85yAG/u/Eg1dzTJhO7Z
	hb5fBeRV6rQe+tTdENgXk4NxxefeTeHYTzZvEG+LABedCabNECvnzvb1AlEP0gnF
X-Gm-Gg: ASbGnctFuycD1AHkZA46tRV41cCgcw6eN9zN6YaBx9IH6+KsO4suqg6fOiYFy2Fa+d6
	S64t7E1zwSWiW+odq6YKDB8oGDIV0I6+YiLL5Fb+NzjHaF2vsXv94mVWHnOdqu2TZtdYKayE/aF
	QOdLGLk1vHxeWeE67VufqUv4SyTudiUHFHrZQrWwnLoZr3IhrLdyZEs6XbTlnZK9DM6k5aUdVuA
	LxI9zJldWN0lLTgjh7OVQJ3ZBL9SxOi4gSADexGbSnPIDUGiPc7F1ot4BtMNITzUo9K3A+yvydh
	1+iqK3SS45his1zt7sCvSp7MYjBuhktSLmV4mPLEKrQr3RrMcPbcfGx3C93DIliKuSArvbOee5Q
	Z7LEpNOyTRjW8XrM=
X-Google-Smtp-Source: AGHT+IETNnaMCkrFPtTefZbg2M/OhRG1fjS1NypWEWBYs0YOZbMwxz36dRVivBtUcA8NTdx8x1TXIA==
X-Received: by 2002:a05:651c:2205:b0:32a:8764:ecf1 with SMTP id 38308e7fff4ca-32cdc4346ddmr33207431fa.4.1751258763248;
        Sun, 29 Jun 2025 21:46:03 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32cd2e317bdsm11915511fa.46.2025.06.29.21.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jun 2025 21:46:02 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-553b6a349ccso1843183e87.0;
        Sun, 29 Jun 2025 21:46:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUbRHIv7kX6fETWBLm/VvRmWekGoQWiMr0Vfo4DxZXMXkxEiu8bCQIrH9D7Hqy/6pMqhKrV7XTY1n4=@vger.kernel.org, AJvYcCVXS3JWLJDnqQfZY4hinqo5n8feDSfPTdRCnDPlXHObZZjcl4SdbDAAA9ETtS/gSVm3vRrf23HQ3iwW@vger.kernel.org, AJvYcCWRAhQ0Rb4xyVGAWn9jpMAmWb5IUjp278MIvFINLzLN4Hp+aMFihoX7LVxGORGozCuI4ueGUiN3Fk8cehJy@vger.kernel.org
X-Received: by 2002:a05:6512:401d:b0:553:297b:3d4e with SMTP id
 2adb3069b0e04-5550b8db1dbmr4122373e87.52.1751258762118; Sun, 29 Jun 2025
 21:46:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411003827.782544-1-iuncuim@gmail.com> <20250411003827.782544-6-iuncuim@gmail.com>
In-Reply-To: <20250411003827.782544-6-iuncuim@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 30 Jun 2025 12:45:50 +0800
X-Gmail-Original-Message-ID: <CAGb2v67kxeF86iHJ3GsOVJT8FOyeM37D1Vdf1Kpdcb64jns_ng@mail.gmail.com>
X-Gm-Features: Ac12FXxCbl4LCury_E8IWa8MmYXdlGFWiz9aT6U77XKyQePtnslVgYEzqe88Heg
Message-ID: <CAGb2v67kxeF86iHJ3GsOVJT8FOyeM37D1Vdf1Kpdcb64jns_ng@mail.gmail.com>
Subject: Re: [PATCH 5/6] arm64: dts: allwinner: A523: Add thermal sensors and zones
To: iuncuim <iuncuim@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Andre Przywara <andre.przywara@arm.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 8:40=E2=80=AFAM iuncuim <iuncuim@gmail.com> wrote:
>
> From: Mikhail Kalashnikov <iuncuim@gmail.com>
>
> The A523 processor has two temperature controllers, THS0 and THS1.
> THS0 has only one temperature sensor, which is located in the DRAM.
>
> THS1 does have 3 sensors:
> ths1_0 - "big" cores
> ths1_1 - "little" cores
> ths1_2 - gpu
>
> Add the thermal sensor configuration and the thermal zones
>
> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
> ---
>  .../arm64/boot/dts/allwinner/sun55i-a523.dtsi | 138 ++++++++++++++++++
>  1 file changed, 138 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/=
boot/dts/allwinner/sun55i-a523.dtsi
> index d626612bb..4f36032b2 100644
> --- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> @@ -7,6 +7,7 @@
>  #include <dt-bindings/clock/sun55i-a523-r-ccu.h>
>  #include <dt-bindings/reset/sun55i-a523-ccu.h>
>  #include <dt-bindings/reset/sun55i-a523-r-ccu.h>
> +#include <dt-bindings/thermal/thermal.h>
>
>  / {
>         interrupt-parent =3D <&gic>;
> @@ -22,6 +23,7 @@ cpu0: cpu@0 {
>                         device_type =3D "cpu";
>                         reg =3D <0x000>;
>                         enable-method =3D "psci";
> +                       #cooling-cells =3D <2>;
>                 };
>
>                 cpu1: cpu@100 {
> @@ -29,6 +31,7 @@ cpu1: cpu@100 {
>                         device_type =3D "cpu";
>                         reg =3D <0x100>;
>                         enable-method =3D "psci";
> +                       #cooling-cells =3D <2>;
>                 };
>
>                 cpu2: cpu@200 {
> @@ -36,6 +39,7 @@ cpu2: cpu@200 {
>                         device_type =3D "cpu";
>                         reg =3D <0x200>;
>                         enable-method =3D "psci";
> +                       #cooling-cells =3D <2>;
>                 };
>
>                 cpu3: cpu@300 {
> @@ -43,6 +47,7 @@ cpu3: cpu@300 {
>                         device_type =3D "cpu";
>                         reg =3D <0x300>;
>                         enable-method =3D "psci";
> +                       #cooling-cells =3D <2>;
>                 };
>
>                 cpu4: cpu@400 {
> @@ -50,6 +55,7 @@ cpu4: cpu@400 {
>                         device_type =3D "cpu";
>                         reg =3D <0x400>;
>                         enable-method =3D "psci";
> +                       #cooling-cells =3D <2>;
>                 };
>
>                 cpu5: cpu@500 {
> @@ -57,6 +63,7 @@ cpu5: cpu@500 {
>                         device_type =3D "cpu";
>                         reg =3D <0x500>;
>                         enable-method =3D "psci";
> +                       #cooling-cells =3D <2>;
>                 };
>
>                 cpu6: cpu@600 {
> @@ -64,6 +71,7 @@ cpu6: cpu@600 {
>                         device_type =3D "cpu";
>                         reg =3D <0x600>;
>                         enable-method =3D "psci";
> +                       #cooling-cells =3D <2>;
>                 };
>
>                 cpu7: cpu@700 {
> @@ -71,6 +79,7 @@ cpu7: cpu@700 {
>                         device_type =3D "cpu";
>                         reg =3D <0x700>;
>                         enable-method =3D "psci";
> +                       #cooling-cells =3D <2>;
>                 };
>         };
>
> @@ -171,11 +180,39 @@ ccu: clock-controller@2001000 {
>                         #reset-cells =3D <1>;
>                 };
>
> +               ths1: thermal-sensor@2009400 {
> +                       compatible =3D "allwinner,sun55i-a523-ths1";
> +                       reg =3D <0x02009400 0x400>;
> +                       interrupts =3D <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks =3D <&ccu CLK_BUS_THS>, <&ccu CLK_GPADC1>;
> +                       clock-names =3D "bus", "gpadc";
> +                       resets =3D <&ccu RST_BUS_THS>;
> +                       nvmem-cells =3D <&ths_calibration>;
> +                       nvmem-cell-names =3D "calibration";
> +                       #thermal-sensor-cells =3D <1>;
> +               };
> +
> +               ths0: thermal-sensor@200a000 {
> +                       compatible =3D "allwinner,sun55i-a523-ths0";
> +                       reg =3D <0x0200a000 0x400>;
> +                       interrupts =3D <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks =3D <&ccu CLK_BUS_THS>, <&ccu CLK_GPADC0>;
> +                       clock-names =3D "bus", "gpadc";
> +                       resets =3D <&ccu RST_BUS_THS>;
> +                       nvmem-cells =3D <&ths_calibration>;
> +                       nvmem-cell-names =3D "calibration";
> +                       #thermal-sensor-cells =3D <0>;
> +               };
> +
>                 sid: efuse@3006000 {
>                         compatible =3D "allwinner,sun50i-a523-sid", "allw=
inner,sun50i-a64-sid";
>                         reg =3D <0x03006000 0x1000>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
> +
> +                       ths_calibration: thermal-sensor-calibration@38 {
> +                               reg =3D <0x38 0x14>;

Including unrelated bits is probably not correct. Instead I think it should
be two cells. The thermal driver then has to stitch them together or someth=
ing.

> +                       };
>                 };
>
>                 mmc0: mmc@4020000 {
> @@ -602,4 +639,105 @@ rtc: rtc@7090000 {
>                         #clock-cells =3D <1>;
>                 };
>         };
> +
> +       thermal-zones {
> +               cpu0_thermal: cpu0-thermal {
> +                       polling-delay-passive =3D <500>;
> +                       polling-delay =3D <1000>;
> +                       thermal-sensors =3D <&ths1 1>;
> +                       sustainable-power =3D <1200>;

Please describe in the commit log how the sustainable power values were
derived or sourced.

> +
> +                       trips {
> +                               cpu0_threshold: cpu-trip-0 {
> +                                       temperature =3D <70000>;
> +                                       type =3D "passive";
> +                                       hysteresis =3D <0>;
> +                               };
> +                               cpu0_target: cpu-trip-1 {
> +                                       temperature =3D <90000>;
> +                                       type =3D "passive";
> +                                       hysteresis =3D <0>;
> +                               };
> +                               cpu0_critical: cpu-trip-2 {
> +                                       temperature =3D <110000>;
> +                                       type =3D "critical";
> +                                       hysteresis =3D <0>;
> +                               };
> +                       };
> +
> +                       cooling-maps {
> +                               map0 {
> +                                       trip =3D <&cpu0_target>;
> +                                       cooling-device =3D <&cpu0 THERMAL=
_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&cpu1 THERMAL_N=
O_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&cpu2 THERMAL_N=
O_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&cpu3 THERMAL_N=
O_LIMIT THERMAL_NO_LIMIT>;
> +                               };
> +                       };
> +               };
> +
> +               cpu4_thermal: cpu4-thermal {
> +                       polling-delay-passive =3D <500>;
> +                       polling-delay =3D <1000>;
> +                       thermal-sensors =3D <&ths1 0>;
> +                       sustainable-power =3D <1600>;
> +
> +                       trips {
> +                               cpu4_threshold: cpu-trip-0 {
> +                                       temperature =3D <70000>;
> +                                       type =3D "passive";
> +                                       hysteresis =3D <0>;
> +                               };
> +                               cpu4_target: cpu-trip-1 {
> +                                       temperature =3D <90000>;
> +                                       type =3D "passive";
> +                                       hysteresis =3D <0>;
> +                               };
> +                               cpu4_critical: cpu-trip-2 {
> +                                       temperature =3D <110000>;
> +                                       type =3D "critical";
> +                                       hysteresis =3D <0>;
> +                               };
> +                       };
> +
> +                       cooling-maps {
> +                               map0 {
> +                                       trip =3D <&cpu4_target>;
> +                                       cooling-device =3D <&cpu4 THERMAL=
_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&cpu5 THERMAL_N=
O_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&cpu6 THERMAL_N=
O_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&cpu7 THERMAL_N=
O_LIMIT THERMAL_NO_LIMIT>;
> +                               };
> +                       };
> +               };
> +
> +               gpu-thermal {
> +                       polling-delay-passive =3D <500>;
> +                       polling-delay =3D <1000>;
> +                       thermal-sensors =3D <&ths1 2>;
> +                       sustainable-power =3D <2400>;
> +
> +                       trips {

We could have passive trip points here as well so thermal throttling of
the GPU could work.


ChenYu

> +                               gpu_temp_critical: gpu-trip-0 {
> +                                       temperature =3D <110000>;
> +                                       type =3D "critical";
> +                                       hysteresis =3D <0>;
> +                               };
> +                       };
> +               };
> +
> +               ddr-thermal {
> +                       polling-delay-passive =3D <0>;
> +                       polling-delay =3D <0>;
> +                       thermal-sensors =3D <&ths0>;
> +
> +                       trips {
> +                               ddr_temp_critical: ddr-trip-0 {
> +                                       temperature =3D <110000>;
> +                                       type =3D "critical";
> +                                       hysteresis =3D <0>;
> +                               };
> +                       };
> +               };
> +       };
>  };
> --
> 2.49.0
>

