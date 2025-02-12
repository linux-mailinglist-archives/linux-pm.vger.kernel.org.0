Return-Path: <linux-pm+bounces-21947-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9B0A32339
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 11:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92B761644A7
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 10:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0829B207DFA;
	Wed, 12 Feb 2025 10:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/3Lg9If"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C17D2B9BC;
	Wed, 12 Feb 2025 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739354875; cv=none; b=juekprwUQcIhRPbzOKIrBO6j2tCm0myzZJaIr714PeSj4xo511ipLYg5xiOoQ4N1vPAPlOa/Xf/EKd9lbDuZiKipePchxu16B21H44YuHD1pVEFkC5R/km/8TNAtTkLSZoaaoOuPGVCWKNrqMm/KuvFjzgb2Tfn8tsxEvUatGDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739354875; c=relaxed/simple;
	bh=z06n+8M6XH3U1NxhQZ7fMR2oQNDt7WtqhaCqYX9NeX4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=vGWkmSKLRZSbbEZsZTFho199W6JHwwT3pgvY4pxILK8yyTRR0J9Jjzlna/hcYoEsp6u77jhN1hDKkrPUSl8gPVkyga6JEE3KEd9ClN2nfBwxCqfY0jldfxE+b32wXWhqsfdGMZ5UM9WEbNTV0ae9k12ltYL870H0rgCyn+eayKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/3Lg9If; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso1135644466b.1;
        Wed, 12 Feb 2025 02:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739354871; x=1739959671; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7raU3jxlxf9m9YsM8gyXW3wWqEhQoovh+ulChmxjhI=;
        b=V/3Lg9If/rzTTw4v/WkJRuHAjgHrjUeFXdiJWJUuoXntpyboRg9Nr6Gyb68P8F8tXf
         VKrMooUO/8BV/TNk/K64FF06908skxBEOGb8V4YDp1WOxazl/aFIIr5/hDd67JP9IHjt
         EoWbTZ9X3I/Ryvr9N2DDnqnI5Dh5n8ayb+WzSG3nPRRxNdVCq1+w0rV4q9jiAEohe6hb
         hYq1688NQ4rbQed5iYqrQp6FjrNcBriu/R8tTZbXGJs6LI/EZkJp8tYXxb6HoKNzVqEP
         fwD529OKmgvf6ZTUs6kF1InRI6Si1UtGMFJ77N1u9/4JbsOy2bBXbSc9iWhWh3adC0AV
         +ALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739354871; x=1739959671;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7raU3jxlxf9m9YsM8gyXW3wWqEhQoovh+ulChmxjhI=;
        b=BjEnQ3QpOhaQhUfO9tdlXUiKRk/TuhPBym3GD8QmPOadc02jWt2+yz/Eq2JjaMVioA
         TzKAyYo4dHp07U8V/g8ZrI0j0aXaqgH9f2uXTNfbKs70e5FyOvXRb3Au3HgXeXh+6Fs3
         egXu9//ZAzjha2WaAZdwHi/6A1WJmAYvxVNqkwSnv7itSd0oJbTjXW3JtJVj2UlagzFL
         aN5O9+kr319rJSlXgU8DgPIDKa+0Sf5fcD+7eG0cA+0Vx7RWGYVF+i5O9LJrom1S0CDF
         zr3BYXN4WjMZ5CiECztXOx0IdEUeckyubtgILPkrDVR+oc8FhKOVCZQzD6PLxy/ZyFDB
         Iweg==
X-Forwarded-Encrypted: i=1; AJvYcCU0lUjzUHwtmJIRXNk2RrOzWaSyU4GXhAArUH6d21WzWMv2KiHiTCe3AoKgkAJsjtl6vmiT9ytyrWdQ@vger.kernel.org, AJvYcCUS/xZb1m74HvP5rAV4HfEvywnG8GKHoz4UwNogFl+aeu4tGFSCkNYMUEt0S8SmbUY+bh3MEjUtT3A=@vger.kernel.org, AJvYcCX0qfD2FO907ufUnkxcxe5TQKJAKru3xtn1lmhCeXBbqQUlDP+7hv2eSZc+b6fFmiod69KODYHPiOj4cw==@vger.kernel.org, AJvYcCXj4/HjexIh/v7NbZs8ULsnVKQvACCGsge2fjTr9xnXVqK6mgOGITGCknmlc3oam633HHxaTRweCwKi+F18@vger.kernel.org, AJvYcCXuYByhFaNlz3lumVu29waxM8nicNswYDww42Rmo0Ivt//83ttAXglWnbyg5QO/Ifr24zGZLRgg1Oxk@vger.kernel.org
X-Gm-Message-State: AOJu0YysjTNPoyrz77QE1R/U5ik9GuPapJc28hm2lAo0xHL1T5yLdwWm
	uCVoD+j+nRhVzD8ZJOJscr10Sc6SjUNflgBMhPsAtN1j6FtAiuTW
X-Gm-Gg: ASbGncuCfF7qTS5zXRJWoOocpxd9BG89P34prbCZQN4Awq2YIPRky07jRwIIsILLazN
	/ge7ivBlzGKbI7y0FQo9KXRoVdz7loDU7iQymWsOb7jdyIQ1ncEF3t+8dc7jUBQ0LlfBVhxYf55
	bEn9z6e4hj02dTjlZyI7DSHU4xiyoXBs2fMpBRrKvDMEtEvjziDeOxowMi/khWy4NdbIUu4twX0
	M+VJcGm6IieG3bAfR0HpccpRQoHy6BcESMXFFqJp+i5H4VI0fBfLf8GLQ8JvjB5Ih4Yl8eCwh+m
	7EkxrjCHtQcGV8kornVvpY+xPFREv1gkJrFZmXnG0kNSrG5VoKsM6w==
X-Google-Smtp-Source: AGHT+IGxLPAauHVK2s+DzzOXD7zTX93+sf4uDMkVN6GPU8MVIyb4hkft2lhqEwwdYQNefaB3cPwpdw==
X-Received: by 2002:a17:907:1909:b0:ab3:85f2:ff67 with SMTP id a640c23a62f3a-ab7f339c7f8mr256456066b.16.1739354870213;
        Wed, 12 Feb 2025 02:07:50 -0800 (PST)
Received: from smtpclient.apple (185.174.17.62.zt.hu. [185.174.17.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7d18e006csm428383666b.52.2025.02.12.02.07.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Feb 2025 02:07:49 -0800 (PST)
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
In-Reply-To: <20250206161958.1ae885db@donnerap.manchester.arm.com>
Date: Wed, 12 Feb 2025 11:07:35 +0100
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
Message-Id: <B220CF49-1717-491C-AFD9-D8C4FD2DEF88@gmail.com>
References: <20250205125225.1152849-1-szemzo.andras@gmail.com>
 <20250205125225.1152849-10-szemzo.andras@gmail.com>
 <20250206161958.1ae885db@donnerap.manchester.arm.com>
To: Andre Przywara <andre.przywara@arm.com>
X-Mailer: Apple Mail (2.3776.700.51)

Hi,

Thanks for your review!

> On 6 Feb 2025, at 17:19, Andre Przywara <andre.przywara@arm.com> =
wrote:
>=20
> On Wed,  5 Feb 2025 13:52:24 +0100
> Andras Szemzo <szemzo.andras@gmail.com> wrote:
>=20
> Hi,
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
>=20
> What's people's opinion about the node name? Traditionally we call =
this
> "osc24M", in all the other SoCs except D1 and A100. So is this the new
> black?
>=20

I renamed it because node names can=E2=80=99t contain capital letters, =
and D1/A100 already use
dcxo.

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
>> + reg =3D <0>;
>> + clocks =3D <&ccu CLK_CPU>;
>> + clock-names =3D "cpu";
>> + clock-frequency =3D <912000000>;
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
>> + interrupt-parent =3D <&gic>;
>=20
> Please move interrupt-parent to the root node, as the first property. =
Then
> you can lose it here, and in the timer and soc node.
>=20

ok.

>> + };
>> +
>> + timer {
>> + compatible =3D "arm,armv7-timer";
>> + interrupts =3D <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | =
IRQ_TYPE_LEVEL_LOW)>,
>> +     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
>> +     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
>> +     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
>> + clock-frequency =3D <24000000>;
>=20
> Please remove this, and let the firmware set CNTFRQ. U-Boot does this
> automatically (in nonsec_virt.S), and it should be just a few lines to =
add
> to awboot's arch/arm32/arch_timer.c.
>=20

I actually already did that.

> Or, even better: provide proper U-Boot support ;-)
>=20
>> + interrupt-parent =3D <&gic>;
>> + arm,cpu-registers-not-fw-configured;
>=20
> Same here, please fix your firmware to configure the non-secure world
> correctly, and remove this property.
> I am happy to help you with that.
>=20

ok and thanks.

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
>=20
> You don't need omit-if-no-ref for *all* nodes, just the more obscure =
ones,
> which are only used by one or two boards.
> Here I'd say, just have it for: uart2, dsi, spi3, i2c3, and remove =
that
> tag for the others.
>=20

ok

>> + uart0_ph9_pins: uart0-ph9-pins {
>> + pins =3D "PH9", "PH10";
>> + function =3D "uart0";
>> + allwinner,pinmux =3D <5>;
>> + };
>> +
>> + /omit-if-no-ref/
>> + uart2_pe12_pins: uart2-pe12-pins {
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
>> + pins =3D "PC0", "PC1", "PC2", "PC3", "PC4", "PC5";
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
>=20
> Please use a fallback notation:
> compatible =3D "allwinner,sun8i-v853-gpadc",
>     "allwinner,sun20i-d1-gpadc";
>=20
> This allows to later add quirks should we need some for this SoC.=20
> And this requires a binding patch.
>=20

ok for all the compatibles below.

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
>=20
> Same here, fallback compatible.
>=20
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
>=20
> This should be allwinner,sun8i-v853-timer.
>=20
>> +     "allwinner,sun8i-a23-timer";
>> + reg =3D <0x2050000 0xa0>;
>> + interrupts =3D <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
>> +     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
>> + clocks =3D <&dcxo>;
>> + };
>> +
>> + wdt: watchdog@20500a0 {
>> + compatible =3D "allwinner,sun20i-d1-wdt-reset",
>> +     "allwinner,sun20i-d1-wdt";
>=20
> Same here, use a more specific compatible, then the sun20i as a =
fallback.
>=20
>> + reg =3D <0x20500a0 0x20>;
>> + interrupts =3D <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
>> + clocks =3D <&dcxo>, <&rtc CLK_OSC32K>;
>> + clock-names =3D "hosc", "losc";
>> + status =3D "reserved";
>> + };
>> +
>> + uart0: serial@2500000 {
>> + compatible =3D "snps,dw-apb-uart";
>=20
> The UART is an exception, it's just the generic Synopsis name, so this =
is
> fine.
>=20
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
>=20
> This needs three compatible strings:
> compatible =3D "allwinner,sun8i-v853-i2c",
>     "allwinner,sun8i-v536-i2c",
>     "allwinner,sun6i-a31-i2c";
>=20
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
>=20
> I think you got the idea by now, fallbacks ... and for the others =
below as
> well.
>=20
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
>=20
> (no fallbacks needed here, it's an actual GIC-400)
>=20
>> + reg =3D <0x03021000 0x1000>, /* GIC Dist */
>> +      <0x03022000 0x2000>, /* GIC CPU */
>> +      <0x03024000 0x2000>, /* GIC VCPU Control */
>> +      <0x03026000 0x2000>; /* GIC VCPU */
>> + interrupts =3D <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | =
IRQ_TYPE_LEVEL_HIGH)>;
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
>=20
> I don't think we use those two properties in mainline?
>=20

yes, it=E2=80=99s remained from the BSP, I=E2=80=99ll remove.

>> + cap-sd-highspeed;
>> + max-frequency =3D <150000000>;
>> + mmc-ddr-1_8v;
>=20
> This looks wrong here, definitely you should not have voltage =
dependent
> properties in the SoC .dtsi.
>=20
> And you can add the pinctrl properties already here, since there is =
only
> one set of pins for MMC0.
>=20

ok

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
>=20
> same here, please remove.
>=20
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
>=20
> Please leave that to the board DTs to set, they know which voltage =
PortC is
> running on.
>=20
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
>=20
> Is that so? I see SPI0_CS0, SPI0_CS1, SPI1_CS0, SPI1_CS1 pins.
>=20

Sure, I implemented it from v851s datasheet, where there is no xCS1.

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
>=20
> not needed
>=20

ok

>> + #interrupt-cells =3D <2>;
>> + #address-cells =3D <0>;
>> + interrupt-controller;
>> + reg =3D <0x07010320 0xc>;
>> + interrupts =3D <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
>=20
> reg and interrupts typically come right after compatible
>=20

ok

> That's it for now, I will check all the numbers against the manual =
later,
> and verify the clock names and such.
>=20
> Cheers,
> Andre
>=20
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
>> + };
>> +};
>=20


