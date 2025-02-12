Return-Path: <linux-pm+bounces-21949-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 001FAA32352
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 11:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99A70162695
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 10:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70D2205E14;
	Wed, 12 Feb 2025 10:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HC6xNK5T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675221F03CC;
	Wed, 12 Feb 2025 10:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739355450; cv=none; b=fbCc1i23Yh6O4DjGb4YVwrJ8UNXOvYJpjKutnpKaHkINPCgmUjEb/rpL+Sm4jZVwC95IP+N2VANjxsC/h2y02PeA0OBgwbNPS3+LbnnZoQRhTvAhdjEDZqbLxGYIyBkuA97exfoH8iQc0YIUJIpsWty/axIVzHLD6NrXUawBFiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739355450; c=relaxed/simple;
	bh=gL/2m74l/wyHUrEOpQ7n7NflgnvPPPgeQ0J+VSqI+BM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=S+5hGBUA9WVAwcKDlYctLY7sjeeCbNH+7e+g/joV2Gw8W8zQEtilrdVJ8798AWFsGwv2YQH+si5kcB78gn5ijl0+M7CiEe27yLBGbjiWP37XgbG8B4Ob7z0VTbKUt67g5waGf/AHMnGoEhrgNUAP3ZGQaG1dh+YTPfKWraTLrwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HC6xNK5T; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab7d3bcf1ceso428944366b.3;
        Wed, 12 Feb 2025 02:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739355445; x=1739960245; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyQTSRUTEZln7LDV22hntSiQeYuhQXZ+LV2DSlHtWN0=;
        b=HC6xNK5THQkVqdMSy4GPj1rEf0jrMLJew7HE7PsaCues4CCHkRAYZY01dNmeY0pTzX
         qmKM8e/OBWPk4d8B/OxZ/mosE+QR1c9UXX6gx9+cfYrbHLrPfqKqiak96pdCPxfu4Mrx
         Vf5ZUx5U0r56kQOB7YRllU1YT9cTqsnLUNvNtQbXcPgC0Hr2axYl3kNftaA5fegIIKXP
         Syz5j8lSyoYFDoucMXdzv6VZgUWQu8iL2Gpo1x1cYSHKJ5SWtm/UaHtZAxNErtgCK3dq
         6+7FVJwywr/8o9UqlFJb4dsKgJbH5c8/RcZ5JP1NNVnzFfQzBiIbzE4Rb/0SASDgl/ip
         37sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739355445; x=1739960245;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyQTSRUTEZln7LDV22hntSiQeYuhQXZ+LV2DSlHtWN0=;
        b=K/8wq1fexyhEz9OnPUx/XDmag6LBO2kmiNT0Yq0Yn9V9wibMvGhIIBdF54PDsm3Frg
         1eO2mZMY8dCP9nlk0OCk6E09ix/FcaBZUauwACSj6cWyiDsLWPE/YK1iPq+pXa7xnr1/
         YR0Jv2+ijdk7MhZ+ORr3H8n6maEYqAzWvhwW28cVX7imeyHsQ23R70IIf4aarq0YJtmd
         kom6HDhUwfbZhzIzSSf9Bqbe9iu71nWs0C0QaaUjbCZHHl5LINzzhGhAASaNFwIedlaX
         62ak6V9KHqM1VnHDFVaIgd3XN7hYkcjowYqLfUCQ67zQV3FqhH6h6Io2TCaXASJc1Avz
         HI4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUpygggDuXKrYkaTVnHoTnXihz49AQ9kQLZBI4qkLgkiAp1ECsTah6EjxXNFh8gKqxOBHUcMf2F/Rya@vger.kernel.org, AJvYcCW9h7/SJAWt03vNL05F2jkx5YwOS3AnnNC5QhVvBcbf83416jMdOzVE50SHpCrffbyZFcqd8TTs5byI@vger.kernel.org, AJvYcCX7O9jyI+r6wyzDGxAVSCiHMgxxgezWWbT3nEJ2YxH7JuUVKN8R1n9HZCbooPucvUUZmg+ybc1Mu6j+oA==@vger.kernel.org, AJvYcCXIm2hyiZ/rCZ5FCHCfLy5LehY0WU6IVKDPizKymaJUbRjp/vXFWz1Zsqs28138rHkLA2rhFn9T5Qw=@vger.kernel.org, AJvYcCXtgv2rF4ZtEaxnWcz3dhwvD+hnmeWsNfErVKOGEoNKjWp/z+OBmNwpmyBlQ1br/zTCGjGHa38XhOHK94Zf@vger.kernel.org
X-Gm-Message-State: AOJu0YyUr2RLdlF/v7mOHiDvz4rstQVwCWBSnvHTLXFzISpkdwhcusIA
	o/umZd0qOdkGKjG5uG7XtUXTAKMUeFZsfLBbxpNnlZzs6rykMw1D
X-Gm-Gg: ASbGncvZnhD6Oij/Hf2P9hrYWoZnGeQBK2e+9f8MNKC7Ahb3GZ3eXAo96dwialhj4kl
	slJBlNZJkFsW68sWUjXoEVMUejxMtkQ2tDhYnoVgpwdvqg+JeOMYu+F/moqHlsDjq4oMdi5qK5t
	tOklN2NieZUJMA6w7269lUTI+Uoc0q+5iBYuJ7s3YK0GbiDKWEDEdiJVN5K0B5XxobDRrr8cq3a
	5oFx8fhF71KTNrhGBtzKNFsXn9wrCUQIet+vSjqzBwIfGJw233Igbpcvde9Vt0veG588X1SzaLa
	5IYMMkCObatFh15UT/iBxB+cvwlxA2yf5CyA6lEJDcmvG5Gu542HVg==
X-Google-Smtp-Source: AGHT+IHX1kHoLAt6ZZdnsRgcYSqmq7cQdVlk5JmQSbJ9zhjAYKeqHsrY9eFHOkLjVA4AlJ3tuP4J3Q==
X-Received: by 2002:a17:907:1c1a:b0:aaf:1183:e9be with SMTP id a640c23a62f3a-ab7f3714990mr243361266b.2.1739355445101;
        Wed, 12 Feb 2025 02:17:25 -0800 (PST)
Received: from smtpclient.apple (185.174.17.62.zt.hu. [185.174.17.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7bae59ae6sm639107366b.169.2025.02.12.02.17.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Feb 2025 02:17:24 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH v2 09/10] ARM: dts: sun8i: add DTSI file for V853
From: =?utf-8?B?QW5kcsOhcyBTemVtesWR?= <szemzo.andras@gmail.com>
In-Reply-To: <20250207010202.63bb5ac6@minigeek.lan>
Date: Wed, 12 Feb 2025 11:17:12 +0100
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maxime Ripard <mripard@kernel.org>,
 Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org,
 linux-gpio@vger.kernel.org,
 linux-pm@vger.kernel.org,
 linux-riscv@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C21A3AB4-C37B-4096-8EB2-1CBFB817F2B8@gmail.com>
References: <20250205125225.1152849-1-szemzo.andras@gmail.com>
 <20250205125225.1152849-10-szemzo.andras@gmail.com>
 <20250207010202.63bb5ac6@minigeek.lan>
To: Andre Przywara <andre.przywara@arm.com>
X-Mailer: Apple Mail (2.3776.700.51)



> On 7 Feb 2025, at 02:02, Andre Przywara <andre.przywara@arm.com> =
wrote:
>=20
> On Wed,  5 Feb 2025 13:52:24 +0100
> Andras Szemzo <szemzo.andras@gmail.com> wrote:
>=20
> Hi,
>=20
> those comments go on top of those in my previous reply:
>=20
>> V853/V851 is a new SoC by Allwinner. Add a basic dtsi file for it.
>>=20
>> Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com>
>> ---
>> arch/arm/boot/dts/allwinner/sun8i-v853.dtsi | 656 =
++++++++++++++++++++
>> 1 file changed, 656 insertions(+)
>> create mode 100644 arch/arm/boot/dts/allwinner/sun8i-v853.dtsi
>>=20
>> diff --git a/arch/arm/boot/dts/allwinner/sun8i-v853.dtsi =
b/arch/arm/boot/dts/allwinner/sun8i-v853.dtsi
>> new file mode 100644
>> index 000000000000..8b82b8783127
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/allwinner/sun8i-v853.dtsi
>> @@ -0,0 +1,656 @@
>> +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
>> +// Copyright (C) 2024 Andras Szemzo <szemzo.andras@gmail.com>
>> +
>> +#include <dt-bindings/clock/sun6i-rtc.h>
>> +#include <dt-bindings/clock/allwinner,sun8i-v853-r-ccu.h>
>> +#include <dt-bindings/reset/allwinner,sun8i-v853-r-ccu.h>
>> +#include <dt-bindings/clock/allwinner,sun8i-v853-ccu.h>
>> +#include <dt-bindings/reset/allwinner,sun8i-v853-ccu.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/power/allwinner,sun8i-v853-ppu.h>
>> +
>> +/ {
>> + #address-cells =3D <1>;
>> + #size-cells =3D <1>;
>> +
>> + dcxo: dcxo-clk {
>> + compatible =3D "fixed-clock";
>> + clock-output-names =3D "osc24M";
>> + #clock-cells =3D <0>;
>> + };
>> +
>> + cpus {
>> + #address-cells =3D <1>;
>> + #size-cells =3D <0>;
>> +
>> + cpu0: cpu@0 {
>> + device_type =3D "cpu";
>> + compatible =3D "arm,cortex-a7","arm,armv7";
>=20
> The binding says to only give the CPU name, so just the first string,
> no fallback.
>=20

ok

>> + reg =3D <0>;
>> + clocks =3D <&ccu CLK_CPU>;
>> + clock-names =3D "cpu";
>> + clock-frequency =3D <912000000>;
>=20
> Please remove this, it only makes sense for a constant frequency, =
which
> is contradicted by the previous two properties.
>=20

ok

>> + clock-latency =3D <200000>;
>> + cooling-min-level =3D <5>;
>> + cooling-max-level =3D <0>;
>> + #cooling-cells =3D <2>; /* min followed by max */
>> + dynamic-power-coefficient =3D <142>;
>> + };
>> + };
>> +
>> + pmu {
>> + compatible =3D "arm,cortex-a7-pmu";
>> + interrupts =3D <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>,
>> +     <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
>=20
> What's the second interrupt for? I'd assume that's for a second core?
> Can you check that? Use "perf record" (perf stat does not trigger
> interrupts), and then check the counter in /proc/interrupts.
>=20

I don't know what is the second IRQ, but the datasheet says C0_PMU0 and =
CO_PMU1 on the GIC section.
With perf record the IRQ#204 is triggering. Maybe this is a copy/paste =
error in the datasheet?

>> + interrupt-parent =3D <&gic>;
>> + };
>> +
>> + timer {
>> + compatible =3D "arm,armv7-timer";
>> + interrupts =3D <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | =
IRQ_TYPE_LEVEL_LOW)>,
>=20
> This should be GIC_CPU_MASK_SIMPLE(1) for a single core CPU.
>=20

Sure

>> +     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
>> +     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
>> +     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
>> + clock-frequency =3D <24000000>;
>> + interrupt-parent =3D <&gic>;
>> + arm,cpu-registers-not-fw-configured;
>> + arm,no-tick-in-suspend;
>> + };
>> +
>> + soc {
>> + compatible =3D "simple-bus";
>> + ranges;
>> + interrupt-parent =3D <&gic>;
>> + #address-cells =3D <1>;
>> + #size-cells =3D <1>;
>> + dma-noncoherent;
>> +
>> + pio: pinctrl@2000000 {
>> + compatible =3D "allwinner,sun8i-v853-pinctrl";
>> + reg =3D <0x2000000 0x800>;
>> + interrupts =3D <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
>> +     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
>> +     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
>> +     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
>> +     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
>> +     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
>> +     <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
>> +     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
>> + clocks =3D <&ccu CLK_APB0>, <&dcxo>, <&rtc CLK_OSC32K>;
>> + clock-names =3D "apb", "hosc", "losc";
>> + gpio-controller;
>> + interrupt-controller;
>> + #gpio-cells =3D <3>;
>> + #interrupt-cells =3D <3>;
>> +
>> + /omit-if-no-ref/
>> + uart0_ph9_pins: uart0-ph9-pins {
>> + pins =3D "PH9", "PH10";
>> + function =3D "uart0";
>> + allwinner,pinmux =3D <5>;
>> + };
>> +
>> + /omit-if-no-ref/
>> + uart2_pe12_pins: uart2-pe12-pins {
>=20
> There is only one set of UART2 pins in PortE, so drop the pin number:
> uart2_pe_pins: uart-pe-pins {
>=20

ok

>> + pins =3D "PE12", "PE13";
>> + function =3D "uart2";
>> + allwinner,pinmux =3D <6>;
>> + };
>> +
>> + /omit-if-no-ref/
>> + dsi_2lane_pins: dsi-2lane-pins {
>> + pins =3D "PD1", "PD2", "PD3", "PD4", "PD5", "PD6";
>> + function =3D "dsi";
>> + allwinner,pinmux =3D <5>;
>> + };
>> +
>> + /omit-if-no-ref/
>> + spi0_pins: spi0-pins {
>=20
> SPI0 can be muxed to PortF as well, so please use spi0_pc_pins.
>=20
>> + pins =3D "PC0", "PC1", "PC2", "PC3", "PC4", "PC5";
>=20
> This includes the optional WP and HOLD pins, I think they should be
> separate? So add a second node, with just PC4 and PC5, and then
> reference both nodes in your SPI flash node, in the board .dts.
> The base pins should be untagged, but the optional pins should carry
> the omit-if-no-ref tag.
>=20

What is your opinion about something like this?

                        spi0_pc_pins: spi0-pc-pins {
                                pins =3D "PC0", "PC2", "PC3";
                                function =3D "spi0";
                                allwinner,pinmux =3D <4>;
                        };

                        spi0_pc_cs0_pin: spi0-pc-cs0-pin {
                                pins =3D "PC1";
                                function =3D "spi0";
                                allwinner,pinmux =3D <4>;
                        };

                        /omit-if-no-ref/
                        spi0_pc_cs1_pin: spi0-pc-cs1-pin {
                                pins =3D "PC6";
                                function =3D "spi0";
                                allwinner,pinmux =3D <4>;
                        };

>> + function =3D "spi0";
>> + allwinner,pinmux =3D <4>;
>> + };
>> +
>> + /omit-if-no-ref/
>> + spi3_pins: spi3-pins {
>> + pins =3D "PH11", "PH12", "PH13", "PH14";
>> + function =3D "spi3";
>> + allwinner,pinmux =3D <6>;
>> + };
>> +
>> + /omit-if-no-ref/
>> + i2c2_ph11_pins: i2c2-ph11-pins {
>> + pins =3D "PH11", "PH12";
>> + function =3D "i2c2";
>> + allwinner,pinmux =3D <5>;
>> + };
>> +
>> + /omit-if-no-ref/
>> + i2c3_ph13_pins: i2c3-ph13-pins {
>> + pins =3D "PH13", "PH14";
>> + function =3D "i2c3";
>> + allwinner,pinmux =3D <5>;
>> + };
>> +
>> + /omit-if-no-ref/
>> + mmc0_pins: mmc0-pins {
>> + pins =3D "PF0", "PF1", "PF2", "PF3", "PF4", "PF5";
>> + function =3D "sdc0";
>> + allwinner,pinmux =3D <2>;
>> + drive-strength =3D <30>;
>> + bias-pull-up;
>> + };
>> +
>> + /omit-if-no-ref/
>> + mmc1_pins: mmc1-pins {
>=20
> mmc1_pe_pins
>=20

ok

>> + pins =3D "PE0", "PE1", "PE2", "PE3", "PE4", "PE5";
>> + function =3D "sdc1";
>> + allwinner,pinmux =3D <6>;
>> + drive-strength =3D <30>;
>> + bias-pull-up;
>> + };
>> +
>> + /omit-if-no-ref/
>> + rmii_pe_pins: rmii-pe-pins {
>> + pins =3D "PE0", "PE1", "PE2", "PE3", "PE4",
>> +       "PE5", "PE6", "PE7", "PE8", "PE9";
>> + function =3D "emac";
>> + allwinner,pinmux =3D <3>;
>> + };
>> + };
>=20
> Verified that the pin numbers and the pinmux match the function in the
> manual.
>=20
>> +
>> + ccu: clock-controller@2001000 {
>> + compatible =3D "allwinner,sun8i-v853-ccu";
>> + reg =3D <0x2001000 0x1000>;
>> + clocks =3D <&dcxo>,
>> + <&rtc CLK_IOSC>,
>> + <&rtc CLK_OSC32K>;
>> + clock-names =3D "hosc", "iosc", "losc";
>> + #clock-cells =3D <1>;
>> + #reset-cells =3D <1>;
>> + };
>> +
>> + gpadc: adc@2009000 {
>> + compatible =3D "allwinner,sun20i-d1-gpadc";
>> + reg =3D <0x2009000 0x0400>;
>> + clocks =3D <&ccu CLK_BUS_GPADC>;
>> + resets =3D <&ccu RST_BUS_GPADC>;
>> + interrupts =3D <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
>> + status =3D "disabled";
>> + #io-channel-cells =3D <1>;
>> + };
>> +
>> + i2s0: i2s@2032000 {
>> + compatible =3D "allwinner,sun50i-r329-i2s";
>> + reg =3D <0x2032000 0x1000>;
>> + interrupts =3D <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
>> + clocks =3D <&ccu CLK_BUS_I2S0>,
>> + <&ccu CLK_I2S0>;
>> + clock-names =3D "apb", "mod";
>> + resets =3D <&ccu RST_BUS_I2S0>;
>> + dmas =3D <&dma 3>, <&dma 3>;
>> + dma-names =3D "rx", "tx";
>> + status =3D "disabled";
>> + #sound-dai-cells =3D <0>;
>> + };
>> +
>> + i2s1: i2s@2033000 {
>> + compatible =3D "allwinner,sun50i-r329-i2s";
>> + reg =3D <0x2033000 0x1000>;
>> + interrupts =3D <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
>> + clocks =3D <&ccu CLK_BUS_I2S1>,
>> + <&ccu CLK_I2S1>;
>> + clock-names =3D "apb", "mod";
>> + resets =3D <&ccu RST_BUS_I2S1>;
>> + dmas =3D <&dma 4>, <&dma 4>;
>> + dma-names =3D "rx", "tx";
>> + status =3D "disabled";
>> + #sound-dai-cells =3D <0>;
>> + };
>> +
>> + timer: timer@2050000 {
>> + compatible =3D "allwinner,sun20i-d1-timer",
>> +     "allwinner,sun8i-a23-timer";
>> + reg =3D <0x2050000 0xa0>;
>> + interrupts =3D <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
>> +     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
>=20
> Shouldn't there be four interrupts, for the four timers?
>=20

Sure

>> + clocks =3D <&dcxo>;
>> + };
>> +
>> + wdt: watchdog@20500a0 {
>> + compatible =3D "allwinner,sun20i-d1-wdt-reset",
>> +     "allwinner,sun20i-d1-wdt";
>> + reg =3D <0x20500a0 0x20>;
>> + interrupts =3D <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
>> + clocks =3D <&dcxo>, <&rtc CLK_OSC32K>;
>> + clock-names =3D "hosc", "losc";
>> + status =3D "reserved";
>=20
> Who is this reserved for? Should be "okay", no?
>=20

yes

>> + };
>> +
>> + uart0: serial@2500000 {
>> + compatible =3D "snps,dw-apb-uart";
>> + reg =3D <0x2500000 0x400>;
>> + reg-io-width =3D <4>;
>> + reg-shift =3D <2>;
>> + interrupts =3D <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
>> + clocks =3D <&ccu CLK_BUS_UART0>;
>> + resets =3D <&ccu RST_BUS_UART0>;
>> + dmas =3D <&dma 14>, <&dma 14>;
>> + dma-names =3D "rx", "tx";
>> + status =3D "disabled";
>> + };
>> +
>> + uart1: serial@2500400 {
>> + compatible =3D "snps,dw-apb-uart";
>> + reg =3D <0x2500400 0x400>;
>> + reg-io-width =3D <4>;
>> + reg-shift =3D <2>;
>> + interrupts =3D <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
>> + clocks =3D <&ccu CLK_BUS_UART1>;
>> + resets =3D <&ccu RST_BUS_UART1>;
>> + dmas =3D <&dma 15>, <&dma 15>;
>> + dma-names =3D "rx", "tx";
>> + status =3D "disabled";
>> + };
>> +
>> + uart2: serial@2500800 {
>> + compatible =3D "snps,dw-apb-uart";
>> + reg =3D <0x2500800 0x400>;
>> + reg-io-width =3D <4>;
>> + reg-shift =3D <2>;
>> + interrupts =3D <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
>> + clocks =3D <&ccu CLK_BUS_UART2>;
>> + resets =3D <&ccu RST_BUS_UART2>;
>> + dmas =3D <&dma 16>, <&dma 16>;
>> + dma-names =3D "rx", "tx";
>> + status =3D "disabled";
>> + };
>> +
>> + uart3: serial@2500c00 {
>> + compatible =3D "snps,dw-apb-uart";
>> + reg =3D <0x2500c00 0x400>;
>> + reg-io-width =3D <4>;
>> + reg-shift =3D <2>;
>> + interrupts =3D <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
>> + clocks =3D <&ccu CLK_BUS_UART3>;
>> + resets =3D <&ccu RST_BUS_UART3>;
>> + dmas =3D <&dma 17>, <&dma 17>;
>> + dma-names =3D "rx", "tx";
>> + status =3D "disabled";
>> + };
>> +
>> + i2c0: i2c@2502000 {
>> + compatible =3D "allwinner,sun8i-v536-i2c",
>> +     "allwinner,sun6i-a31-i2c";
>> + reg =3D <0x2502000 0x400>;
>> + interrupts =3D <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
>> + clocks =3D <&ccu CLK_BUS_I2C0>;
>> + resets =3D <&ccu RST_BUS_I2C0>;
>> + dmas =3D <&dma 43>, <&dma 43>;
>> + dma-names =3D "rx", "tx";
>> + status =3D "disabled";
>> + #address-cells =3D <1>;
>> + #size-cells =3D <0>;
>> + };
>> +
>> + i2c1: i2c@2502400 {
>> + compatible =3D "allwinner,sun8i-v536-i2c",
>> +     "allwinner,sun6i-a31-i2c";
>> + reg =3D <0x2502400 0x400>;
>> + interrupts =3D <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
>> + clocks =3D <&ccu CLK_BUS_I2C1>;
>> + resets =3D <&ccu RST_BUS_I2C1>;
>> + dmas =3D <&dma 44>, <&dma 44>;
>> + dma-names =3D "rx", "tx";
>> + status =3D "disabled";
>> + #address-cells =3D <1>;
>> + #size-cells =3D <0>;
>> + };
>> +
>> + i2c2: i2c@2502800 {
>> + compatible =3D "allwinner,sun8i-v536-i2c",
>> +     "allwinner,sun6i-a31-i2c";
>> + reg =3D <0x2502800 0x400>;
>> + interrupts =3D <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
>> + clocks =3D <&ccu CLK_BUS_I2C2>;
>> + resets =3D <&ccu RST_BUS_I2C2>;
>> + dmas =3D <&dma 45>, <&dma 45>;
>> + dma-names =3D "rx", "tx";
>> + status =3D "disabled";
>> + #address-cells =3D <1>;
>> + #size-cells =3D <0>;
>> + };
>> +
>> + i2c3: i2c@2502c00 {
>> + compatible =3D "allwinner,sun8i-v536-i2c",
>> +     "allwinner,sun6i-a31-i2c";
>> + reg =3D <0x2502c00 0x400>;
>> + interrupts =3D <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
>> + clocks =3D <&ccu CLK_BUS_I2C3>;
>> + resets =3D <&ccu RST_BUS_I2C3>;
>> + dmas =3D <&dma 46>, <&dma 46>;
>> + dma-names =3D "rx", "tx";
>> + status =3D "disabled";
>> + #address-cells =3D <1>;
>> + #size-cells =3D <0>;
>> + };
>> +
>> + i2c4: i2c@2503000 {
>> + compatible =3D "allwinner,sun8i-v536-i2c",
>> +     "allwinner,sun6i-a31-i2c";
>> + reg =3D <0x2503000 0x400>;
>> + interrupts =3D <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
>> + clocks =3D <&ccu CLK_BUS_I2C4>;
>> + resets =3D <&ccu RST_BUS_I2C4>;
>> + dmas =3D <&dma 47>, <&dma 47>;
>> + dma-names =3D "rx", "tx";
>> + status =3D "disabled";
>> + #address-cells =3D <1>;
>> + #size-cells =3D <0>;
>> + };
>> +
>> + syscon: syscon@3000000 {
>> + compatible =3D "allwinner,sun8i-h3-system-control";
>> + reg =3D <0x3000000 0x1000>;
>> + ranges;
>> + #address-cells =3D <1>;
>> + #size-cells =3D <1>;
>> +
>> + sram_c: sram@20000 {
>> + compatible =3D "mmio-sram";
>> + reg =3D <0x00020000 0x21000>;
>> + #address-cells =3D <1>;
>> + #size-cells =3D <1>;
>> + ranges =3D <0 0x00020000 0x21000>;
>> +
>> + ve_sram: sram-section@0 {
>=20
> The manual says "Using ISP SRAM". Do you know what it really is?
>=20

I didn=E2=80=99t had a chance to try this, but it can maybe be used by =
the ISP or VE?
I can rename it.

>> +    compatible =3D "allwinner,sun8i-v3s-sram-c",=20
>> + "allwinner,sun4i-a10-sram-c1";
>> +    reg =3D <0x000000 0x21000>;
>> + };
>> + };
>> + };
>> +
>> + dma: dma-controller@3002000 {
>> + compatible =3D "allwinner,sun20i-d1-dma";
>> + reg =3D <0x3002000 0x1000>;
>> + interrupts =3D <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
>> + clocks =3D <&ccu CLK_BUS_DMA>, <&ccu CLK_MBUS_DMA>;
>> + clock-names =3D "bus", "mbus";
>> + resets =3D <&ccu RST_BUS_DMA>;
>> + dma-channels =3D <16>;
>> + dma-requests =3D <48>;
>> + #dma-cells =3D <1>;
>> + };
>> +
>> + hwspinlock: hwlock@3005000 {
>> +    compatible =3D "allwinner,sun6i-a31-hwspinlock";
>> + reg =3D <0x3005000 0x1000>;
>> + clocks =3D <&ccu CLK_BUS_SPINLOCK>;
>> + clock-names =3D "ahb";
>> + resets =3D <&ccu RST_BUS_SPINLOCK>;
>> + reset-names =3D "ahb";
>> + interrupts =3D <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
>> + };
>> +
>> + sid: efuse@3006000 {
>> + compatible =3D "allwinner,sun20i-d1-sid";
>> + reg =3D <0x3006000 0x1000>;
>> + #address-cells =3D <1>;
>> + #size-cells =3D <1>;
>> +
>> + ths_calib: ths-calib@14 {
>> + reg =3D <0x14 0x8>;
>> + };
>> + };
>> +
>> + hstimer@3008000 {
>> + compatible =3D "allwinner,sun7i-a20-hstimer";
>> + reg =3D <0x03008000 0x1000>;
>> + interrupts =3D <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
>> +     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
>> + clocks =3D <&ccu CLK_BUS_HSTIMER>;
>> + };
>> +
>> + gic: interrupt-controller@3021000 {
>> + compatible =3D "arm,gic-400";
>> + reg =3D <0x03021000 0x1000>, /* GIC Dist */
>> +      <0x03022000 0x2000>, /* GIC CPU */
>> +      <0x03024000 0x2000>, /* GIC VCPU Control */
>> +      <0x03026000 0x2000>; /* GIC VCPU */
>> + interrupts =3D <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | =
IRQ_TYPE_LEVEL_HIGH)>;
>=20
> GIC_CPU_MASK_SIMPLE(1)
>=20

yes

>> + interrupt-controller;
>> + #interrupt-cells =3D <3>;
>> + };
>> +
>> + mbus: dram-controller@3102000 {
>> + compatible =3D "allwinner,sun20i-d1-mbus";
>> + reg =3D <0x3102000 0x1000>,
>> +      <0x3103000 0x1000>;
>> + reg-names =3D "mbus", "dram";
>> + interrupts =3D <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
>> + clocks =3D <&ccu CLK_MBUS>,
>> + <&ccu CLK_DRAM>,
>> + <&ccu CLK_BUS_DRAM>;
>> + clock-names =3D "mbus", "dram", "bus";
>> + dma-ranges =3D <0 0x40000000 0x80000000>;
>> + #address-cells =3D <1>;
>> + #size-cells =3D <1>;
>> + #interconnect-cells =3D <1>;
>> + };
>> +
>> + mmc0: mmc@4020000 {
>> + compatible =3D "allwinner,sun20i-d1-mmc";
>> + reg =3D <0x4020000 0x1000>;
>> + interrupts =3D <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
>> + clocks =3D <&ccu CLK_BUS_MMC0>, <&ccu CLK_MMC0>;
>> + clock-names =3D "ahb", "mmc";
>> + resets =3D <&ccu RST_BUS_MMC0>;
>> + reset-names =3D "ahb";
>> + no-sdio;
>> + no-mmc;
>> + cap-sd-highspeed;
>> + max-frequency =3D <150000000>;
>> + mmc-ddr-1_8v;
>> + status =3D "disabled";
>> + #address-cells =3D <1>;
>> + #size-cells =3D <0>;
>> + };
>> +
>> + mmc1: mmc@4021000 {
>> + compatible =3D "allwinner,sun20i-d1-mmc";
>> + reg =3D <0x4021000 0x1000>;
>> + interrupts =3D <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
>> + clocks =3D <&ccu CLK_BUS_MMC1>, <&ccu CLK_MMC1>;
>> + clock-names =3D "ahb", "mmc";
>> + resets =3D <&ccu RST_BUS_MMC1>;
>> + reset-names =3D "ahb";
>> + cap-sd-highspeed;
>> + cap-mmc-highspeed;
>> + max-frequency =3D <150000000>;
>> + mmc-ddr-1_8v;
>> + status =3D "disabled";
>> + #address-cells =3D <1>;
>> + #size-cells =3D <0>;
>> + };
>> +
>> + mmc2: mmc@4022000 {
>> + compatible =3D "allwinner,sun20i-d1-mmc";
>> + reg =3D <0x4022000 0x1000>;
>> + interrupts =3D <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
>> + clocks =3D <&ccu CLK_BUS_MMC2>, <&ccu CLK_MMC2>;
>> + clock-names =3D "ahb", "mmc";
>> + resets =3D <&ccu RST_BUS_MMC2>;
>> + reset-names =3D "ahb";
>> + no-sdio;
>> + no-sd;
>> + cap-mmc-highspeed;
>> + max-frequency =3D <150000000>;
>> + mmc-ddr-1_8v;
>> + mmc-ddr-3_3v;
>> + status =3D "disabled";
>> + #address-cells =3D <1>;
>> + #size-cells =3D <0>;
>> + };
>> +
>> + spi0: spi@4025000 {
>> + compatible =3D "allwinner,sun50i-r329-spi";
>> + reg =3D <0x4025000 0x1000>;
>> + interrupts =3D <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
>> + clocks =3D <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
>> + clock-names =3D "ahb", "mod";
>> + resets =3D <&ccu RST_BUS_SPI0>;
>> + dmas =3D <&dma 22>, <&dma 22>;
>> + dma-names =3D "rx", "tx";
>> + num-cs =3D <1>;
>> + status =3D "disabled";
>> + #address-cells =3D <1>;
>> + #size-cells =3D <0>;
>> + };
>> +
>> + spi1: spi@4026000 {
>> + compatible =3D "allwinner,sun50i-r329-spi-dbi",
>> +     "allwinner,sun50i-r329-spi";
>> + reg =3D <0x4026000 0x1000>;
>> + interrupts =3D <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
>> + clocks =3D <&ccu CLK_BUS_SPI1>, <&ccu CLK_SPI1>;
>> + clock-names =3D "ahb", "mod";
>> + resets =3D <&ccu RST_BUS_SPI1>;
>> + dmas =3D <&dma 23>, <&dma 23>;
>> + dma-names =3D "rx", "tx";
>> + num-cs =3D <1>;
>> + status =3D "disabled";
>> + #address-cells =3D <1>;
>> + #size-cells =3D <0>;
>> + };
>> +
>> + spi2: spi@4027000 {
>> + compatible =3D "allwinner,sun50i-r329-spi";
>> + reg =3D <0x4027000 0x1000>;
>> + interrupts =3D <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
>> + clocks =3D <&ccu CLK_BUS_SPI2>, <&ccu CLK_SPI2>;
>> + clock-names =3D "ahb", "mod";
>> + resets =3D <&ccu RST_BUS_SPI2>;
>> + dmas =3D <&dma 24>, <&dma 24>;
>> + dma-names =3D "rx", "tx";
>> + num-cs =3D <1>;
>> + status =3D "disabled";
>> + #address-cells =3D <1>;
>> + #size-cells =3D <0>;
>> + };
>> +
>> + spi3: spi@4028000 {
>> + compatible =3D "allwinner,sun50i-r329-spi";
>> + reg =3D <0x4028000 0x1000>;
>> + interrupts =3D <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
>> + clocks =3D <&ccu CLK_BUS_SPI3>, <&ccu CLK_SPI3>;
>> + clock-names =3D "ahb", "mod";
>> + resets =3D <&ccu RST_BUS_SPI3>;
>> + dmas =3D <&dma 25>, <&dma 25>;
>> + dma-names =3D "rx", "tx";
>> + num-cs =3D <1>;
>> + status =3D "disabled";
>> + #address-cells =3D <1>;
>> + #size-cells =3D <0>;
>> + };
>> +
>> + usb_otg: usb@4100000 {
>> + compatible =3D "allwinner,sun8i-a33-musb";
>> + reg =3D <0x4100000 0x400>;
>> + interrupts =3D <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
>> + interrupt-names =3D "mc";
>> + clocks =3D <&ccu CLK_BUS_OTG>;
>> + resets =3D <&ccu RST_BUS_OTG>;
>> + extcon =3D <&usbphy 0>;
>> + phys =3D <&usbphy 0>;
>> + phy-names =3D "usb";
>> + status =3D "disabled";
>> + };
>> +
>> + usbphy: phy@4100400 {
>> + compatible =3D "allwinner,sun8i-v853-usb-phy";
>> + reg =3D <0x4100400 0x100>,
>> +      <0x4101800 0x100>;
>> + reg-names =3D "phy_ctrl",
>> +    "pmu0";
>> + clocks =3D <&ccu CLK_USB_OHCI>;
>> + clock-names =3D "usb0_phy";
>> + resets =3D <&ccu RST_USB_PHY>;
>> + reset-names =3D "usb0_reset";
>> + status =3D "disabled";
>> + #phy-cells =3D <1>;
>> + };
>> +
>> + ehci0: usb@4101000 {
>> + compatible =3D "generic-ehci";
>> + reg =3D <0x4101000 0x100>;
>> + interrupts =3D <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
>> + clocks =3D <&ccu CLK_BUS_OHCI>,
>> + <&ccu CLK_BUS_EHCI>,
>> + <&ccu CLK_USB_OHCI>;
>> + resets =3D <&ccu RST_BUS_OHCI>,
>> + <&ccu RST_BUS_EHCI>;
>> + phys =3D <&usbphy 0>;
>> + phy-names =3D "usb";
>> + status =3D "disabled";
>> + };
>> +
>> + ohci0: usb@4101400 {
>> + compatible =3D "generic-ohci";
>> + reg =3D <0x4101400 0x100>;
>> + interrupts =3D <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
>> + clocks =3D <&ccu CLK_BUS_OHCI>,
>> + <&ccu CLK_USB_OHCI>;
>> + resets =3D <&ccu RST_BUS_OHCI>;
>> + phys =3D <&usbphy 0>;
>> + phy-names =3D "usb";
>> + status =3D "disabled";
>> + };
>> +
>> + ppu: power-controller@7001000 {
>> + compatible =3D "allwinner,sun8i-v853-ppu";
>> + reg =3D <0x7001000 0x400>;
>> + clocks =3D <&r_ccu CLK_BUS_R_PPU>;
>> + resets =3D <&r_ccu RST_BUS_R_PPU>;
>> + #power-domain-cells =3D <1>;
>> + };
>> +
>> + r_ccu: clock-controller@7010000 {
>> + compatible =3D "allwinner,sun8i-v853-r-ccu";
>> + reg =3D <0x7010000 0x230>;
>> + clocks =3D <&dcxo>,
>> + <&rtc CLK_IOSC>,
>> + <&rtc CLK_OSC32K>,
>> + <&ccu CLK_PLL_PERIPH_200M>,
>> + <&ccu CLK_PLL_AUDIO_4X>;
>> + clock-names =3D "hosc",
>> +      "iosc",
>> +      "losc",
>> +      "pll-periph",
>> +      "pll-audio";
>> + #clock-cells =3D <1>;
>> + #reset-cells =3D <1>;
>> + };
>> +
>> + nmi_intc: intc-nmi@7010320 {
>> + compatible =3D "allwinner,sun9i-a80-nmi";
>> + interrupt-parent =3D <&gic>;
>> + #interrupt-cells =3D <2>;
>> + #address-cells =3D <0>;
>> + interrupt-controller;
>> + reg =3D <0x07010320 0xc>;
>> + interrupts =3D <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
>> + };
>> +
>> + rtc: rtc@7090000 {
>> + compatible =3D "allwinner,sun50i-r329-rtc";
>> + reg =3D <0x7090000 0x400>;
>> + interrupts =3D <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
>> + clocks =3D <&r_ccu CLK_BUS_R_RTC>;
>> + clock-names =3D "bus";
>> + resets =3D <&r_ccu RST_BUS_R_RTC>;
>> + wakeup-source;
>> + #clock-cells =3D <1>;
>> + };
>=20
> Verified that all MMIO base addresses, DMA channels and interrupts are
> matching the manual.
>=20
> Cheers,
> Andre
>=20
>> + };
>> +};
>=20


