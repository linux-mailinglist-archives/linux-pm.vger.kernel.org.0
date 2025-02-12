Return-Path: <linux-pm+bounces-21950-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF972A32356
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 11:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 741FF1664A3
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 10:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61613207E1E;
	Wed, 12 Feb 2025 10:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7dv0/Vh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4887A1E500C;
	Wed, 12 Feb 2025 10:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739355529; cv=none; b=BHe8uegBFTtOyfwcaclKSV0nXIsXSj1Qx6kV3AwD4nTl+anQ6/aJBJmI/lYPIIFYluWvvItU02aoOJu9Hl1etOLHRejGaH5zv7oWTxdq6xMaVQhe3RZ35OPVSsHo22RztrtWqZgpGm1cvg7IjGvRZcw1a30inDKIGtL6zJhVWUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739355529; c=relaxed/simple;
	bh=JQ3hUkVizyyC5PrH498KuKklwrEwcMwv0zzmt6N8YDU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=S9F56l0Tba+9HJFX4tq8Y3pN1coTZwEJUhJY2M0KMtNtNesO6p4J7/WBUu6iwa62wNKuoIMM+TqQoAYhmAiLhnAnAkvQ/ABrt1mTGqnoQV6IWXrUeDnGUDQPit3v4nGVvNlHomLclvwfsPZNe0+pCrKAhD5nj3mNyhvjn/bg+zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7dv0/Vh; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab7ca64da5dso131076866b.0;
        Wed, 12 Feb 2025 02:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739355525; x=1739960325; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWVlua/ySHVMeIr/pzJ7+6ofC41BpQURgsGblrbr2lM=;
        b=Z7dv0/Vh3Y9hL8RiD7yi65+z0MxHANtGCHxSNoomJEGkm2/a7WgoTird8+3U8IZnlV
         i5NxhsIUNsT6tKK7tdqt47W4TV6rvfbejgQYemsITkPyzi8qxBSwTzX6uKhtMR4cma/o
         WqDzMlrgTrNmQRlypIn9ExK0BFOerW3mKAAf8k26BS8Z6JikRt1TmAtbTSSfeIdgChbv
         x9zjzpgPQTL8UYYPjwhlYfvEy7kmou+sCDjO9qzYWpPODXudsH+dsg+NKL5n+d3cX+k8
         CASyPWn62J7fXbZ0k4JNVFNggTplAhwnpUaroDT9W9yn7eCDSJVs6Dut80gIgTokm36e
         CvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739355525; x=1739960325;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWVlua/ySHVMeIr/pzJ7+6ofC41BpQURgsGblrbr2lM=;
        b=n02vTlATn/FooeeEnq+MxtQXxRACo7mvEpUf8tVqAo3c33jDXreq/OG30R5OSF+q1U
         pZaZuzi5/mqYswBcGHWPvfL8zI+HYoO641B1ygSbCa7HHy3nYY1q9ze6gzVIHE0ylx/B
         OuHJ2w3g0P/O+aXZz/xj0bjiZ0imJcSCTxDnS9hNVXnKmUwLMPhplAC8CHesasnZFg//
         Ak1I2zMgzJvV8o/6dUQHKfaWjcSlibiuAA69Rq0TTRL6AqEtbmy64a4vi8vVkzng0N7c
         b9inaDYUYqJO44cyYSfqxFR6eJMFIYUM/P072dtlSK/VpdN1CPYm7jGaBdYUDORpd1A+
         7MNg==
X-Forwarded-Encrypted: i=1; AJvYcCUoLOp31FR+/Y3SSuUZIGK6N2c8EDikHSQCpyZI2e9OS5qcFLMC2jkQOBZXCyuBiDT7E5mDApBMoxYN@vger.kernel.org, AJvYcCUpqnvC7Pto/p2DNoUWSz6FPBeINyOJ1qBMaSeH7rHviD/LEdeg6lhDf7ZdhlqDQ8TGPj2SfugRZyHu@vger.kernel.org, AJvYcCVt9RFN9jmy7UgBKdDnO6qQu2pGUAk9yjK+IlQsmlEN+EkJXQfrf7F8oMImS5hHeqmlMS4wbo/b4/y4bKB+@vger.kernel.org, AJvYcCWpsdsXcTm0cuQ/Cv+dODdn40GEE2QYF5bCMvwZU+N6FXe07nJxblPezKyrlQwE7t+rqsi5MKoK40k=@vger.kernel.org, AJvYcCXelilkWfO7WB9NRq3xm2mizSY21hRWClFvJw0qenutbvt/qo+ySulyTQ1xkjd2NyDNomlcZM65n+2diQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcpdrdWPUcn8lSEqg7TAUKlpn9DgCPcEqgcr2PAEHzlcbQIpKN
	Bur4WJSiKJE9IXT1jRHg3Np4EhWGiXmrcLCGfhj7JnW9GZhy/OVp
X-Gm-Gg: ASbGnctD/xrwzfjlLKWZniWmMJlgSy+f5oUgvC35jQS6/b3yvZm9iPdr0EBgIVUdkll
	0CIMQfyCBQe9YJCOsVygHiyTnjZam6JYPG7NqosW/0pTdRLi0MsB++zAOXwEl+85I30Dp2KFccX
	ViPBZDgUt9EVfuY/LWLHAmCM07Gv3WsNztr+a0K7pFHv49OL0mMvom8ytJq1uPS6hgvrkEGkuVh
	WAqZjuL+hLcHTO0uA/ooU5n3z11+rYNcDUm0fKslxiycadiyGc8aXO8lVv28IftCj/AbEx7apc4
	d6VlXoahFe+lbgq733n+zEqwS6Mvhc005uXmyVDSbfCarLnQS/UBsA==
X-Google-Smtp-Source: AGHT+IHXhHYBhp/jwxugJOxSy8fbHAg4RaSJF+XHK6rh7pamhtjknOPXD7Wlf+ulQuEN06XXx7/uPg==
X-Received: by 2002:a17:907:2cc5:b0:ab7:d1d0:1a84 with SMTP id a640c23a62f3a-ab7f2e8a301mr221194166b.4.1739355525335;
        Wed, 12 Feb 2025 02:18:45 -0800 (PST)
Received: from smtpclient.apple (185.174.17.62.zt.hu. [185.174.17.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7d6acd8f1sm381126966b.50.2025.02.12.02.18.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Feb 2025 02:18:44 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH v2 03/10] dt-bindings: clock: sunxi-ng: add compatibles
 for V853
From: =?utf-8?B?QW5kcsOhcyBTemVtesWR?= <szemzo.andras@gmail.com>
In-Reply-To: <20250211210215.GA1160917-robh@kernel.org>
Date: Wed, 12 Feb 2025 11:18:32 +0100
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
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
Message-Id: <6B18CA59-65CE-4C7A-A9A6-769157BB73A9@gmail.com>
References: <20250205125225.1152849-1-szemzo.andras@gmail.com>
 <20250205125225.1152849-4-szemzo.andras@gmail.com>
 <20250211210215.GA1160917-robh@kernel.org>
To: Rob Herring <robh@kernel.org>
X-Mailer: Apple Mail (2.3776.700.51)

Thanks for your review, I=E2=80=99ll change and explain it better.

> On 11 Feb 2025, at 22:02, Rob Herring <robh@kernel.org> wrote:
>=20
> On Wed, Feb 05, 2025 at 01:52:18PM +0100, Andras Szemzo wrote:
>> V853 has 2 CCUs, add compatible strings for it.
>>=20
>> Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com>
>> ---
>> .../clock/allwinner,sun4i-a10-ccu.yaml        |   3 +
>> .../clock/allwinner,sun8i-v853-ccu.h          | 132 =
++++++++++++++++++
>> .../clock/allwinner,sun8i-v853-r-ccu.h        |  16 +++
>> .../reset/allwinner,sun8i-v853-ccu.h          |  60 ++++++++
>> .../reset/allwinner,sun8i-v853-r-ccu.h        |  14 ++
>> 5 files changed, 225 insertions(+)
>> create mode 100644 =
include/dt-bindings/clock/allwinner,sun8i-v853-ccu.h
>> create mode 100644 =
include/dt-bindings/clock/allwinner,sun8i-v853-r-ccu.h
>> create mode 100644 =
include/dt-bindings/reset/allwinner,sun8i-v853-ccu.h
>> create mode 100644 =
include/dt-bindings/reset/allwinner,sun8i-v853-r-ccu.h
>>=20
>> diff --git =
a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml =
b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
>> index 1690b9d99c3d..9369d62284ed 100644
>> --- =
a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
>> +++ =
b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
>> @@ -33,6 +33,8 @@ properties:
>>       - allwinner,sun8i-r40-ccu
>>       - allwinner,sun8i-v3-ccu
>>       - allwinner,sun8i-v3s-ccu
>> +      - allwinner,sun8i-v853-ccu
>> +      - allwinner,sun8i-v853-r-ccu
>=20
> Please explain the difference between these in the commit message.
>=20
>>       - allwinner,sun9i-a80-ccu
>>       - allwinner,sun20i-d1-ccu
>>       - allwinner,sun20i-d1-r-ccu
>> @@ -103,6 +105,7 @@ else:
>>       compatible:
>>         enum:
>>           - allwinner,sun20i-d1-ccu
>> +          - allwinner,sun8i-v853-ccu
>>           - allwinner,sun50i-a100-ccu
>>           - allwinner,sun50i-h6-ccu
>>           - allwinner,sun50i-h616-ccu
>> diff --git a/include/dt-bindings/clock/allwinner,sun8i-v853-ccu.h =
b/include/dt-bindings/clock/allwinner,sun8i-v853-ccu.h
>> new file mode 100644
>> index 000000000000..cf56c168e1cd
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/allwinner,sun8i-v853-ccu.h
>> @@ -0,0 +1,132 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>=20
> Dual license.
>=20
>> +/*
>> + * Copyright (C) 2024 Andras Szemzo <szemzo.andras@gmail.com.com>
>> + */
>> +
>> +#ifndef _DT_BINDINGS_CLK_ALLWINNER_SUN8I_V85X_CCU_H_
>> +#define _DT_BINDINGS_CLK_ALLWINNER_SUN8I_V85X_CCU_H_
>> +
>> +#define CLK_OSC12M		0
>> +#define CLK_PLL_CPU		1
>> +#define CLK_PLL_DDR		2
>> +#define CLK_PLL_PERIPH_4X	3
>> +#define CLK_PLL_PERIPH_2X	4
>> +#define CLK_PLL_PERIPH_800M	5
>> +#define CLK_PLL_PERIPH_480M	6
>> +#define CLK_PLL_PERIPH_600M	7
>> +#define CLK_PLL_PERIPH_400M	8
>> +#define CLK_PLL_PERIPH_300M	9
>> +#define CLK_PLL_PERIPH_200M	10
>> +#define CLK_PLL_PERIPH_160M	11
>> +#define CLK_PLL_PERIPH_150M	12
>> +#define CLK_PLL_VIDEO_4X	13
>> +#define CLK_PLL_VIDEO_2X	14
>> +#define CLK_PLL_VIDEO_1X	15
>> +#define CLK_PLL_CSI_4X		16
>> +#define CLK_PLL_AUDIO_DIV2	17
>> +#define CLK_PLL_AUDIO_DIV5	18
>> +#define CLK_PLL_AUDIO_4X	19
>> +#define CLK_PLL_AUDIO_1X	20
>> +#define CLK_PLL_NPU_4X		21
>> +#define CLK_CPU			22
>> +#define CLK_CPU_AXI		23
>> +#define CLK_CPU_APB		24
>> +#define CLK_AHB			25
>> +#define CLK_APB0		26
>> +#define CLK_APB1		27
>> +#define CLK_MBUS		28
>> +#define CLK_DE			29
>> +#define CLK_BUS_DE		30
>> +#define CLK_G2D			31
>> +#define CLK_BUS_G2D		32
>> +#define CLK_CE			33
>> +#define CLK_BUS_CE		34
>> +#define CLK_VE			35
>> +#define CLK_BUS_VE		36
>> +#define CLK_NPU			37
>> +#define CLK_BUS_NPU		38
>> +#define CLK_BUS_DMA		39
>> +#define CLK_BUS_MSGBOX0		40
>> +#define CLK_BUS_MSGBOX1		41
>> +#define CLK_BUS_SPINLOCK	42
>> +#define CLK_BUS_HSTIMER		43
>> +#define CLK_AVS			44
>> +#define CLK_BUS_DBG		45
>> +#define CLK_BUS_PWM		46
>> +#define CLK_BUS_IOMMU		47
>> +#define CLK_DRAM		48
>> +#define CLK_MBUS_DMA		49
>> +#define CLK_MBUS_VE		50
>> +#define CLK_MBUS_CE		51
>> +#define CLK_MBUS_CSI		52
>> +#define CLK_MBUS_ISP		53
>> +#define CLK_MBUS_G2D		54
>> +#define CLK_BUS_DRAM		55
>> +#define CLK_MMC0		56
>> +#define CLK_MMC1		57
>> +#define CLK_MMC2		58
>> +#define CLK_BUS_MMC0		59
>> +#define CLK_BUS_MMC1		60
>> +#define CLK_BUS_MMC2		61
>> +#define CLK_BUS_UART0		62
>> +#define CLK_BUS_UART1		63
>> +#define CLK_BUS_UART2		64
>> +#define CLK_BUS_UART3		65
>> +#define CLK_BUS_I2C0		66
>> +#define CLK_BUS_I2C1		67
>> +#define CLK_BUS_I2C2		68
>> +#define CLK_BUS_I2C3		69
>> +#define CLK_BUS_I2C4		70
>> +#define CLK_SPI0		71
>> +#define CLK_SPI1		72
>> +#define CLK_SPI2		73
>> +#define CLK_SPI3		74
>> +#define CLK_BUS_SPI0		75
>> +#define CLK_BUS_SPI1		76
>> +#define CLK_BUS_SPI2		77
>> +#define CLK_BUS_SPI3		78
>> +#define CLK_SPIF		79
>> +#define CLK_BUS_SPIF		80
>> +#define CLK_EMAC_25M		81
>> +#define CLK_BUS_EMAC		82
>> +#define CLK_BUS_GPADC		83
>> +#define CLK_BUS_THS		84
>> +#define CLK_I2S0		85
>> +#define CLK_I2S1		86
>> +#define CLK_BUS_I2S0		87
>> +#define CLK_BUS_I2S1		88
>> +#define CLK_DMIC		89
>> +#define CLK_BUS_DMIC		90
>> +#define CLK_AUDIO_CODEC_DAC	91
>> +#define CLK_AUDIO_CODEC_ADC	92
>> +#define CLK_BUS_AUDIO_CODEC	93
>> +#define CLK_USB_OHCI		94
>> +#define CLK_BUS_OHCI		95
>> +#define CLK_BUS_EHCI		96
>> +#define CLK_BUS_OTG		97
>> +#define CLK_BUS_DPSS_TOP	98
>> +#define CLK_MIPI_DSI		99
>> +#define CLK_BUS_MIPI_DSI	100
>> +#define CLK_TCON_LCD		101
>> +#define CLK_BUS_TCON_LCD	102
>> +#define CLK_CSI_TOP		103
>> +#define CLK_CSI_MCLK0		104
>> +#define CLK_CSI_MCLK1		105
>> +#define CLK_CSI_MCLK2		106
>> +#define CLK_BUS_CSI		107
>> +#define CLK_BUS_WIEGAND		108
>> +#define CLK_RISCV		109
>> +#define CLK_RISCV_AXI		110
>> +#define CLK_RISCV_CORE_GATE	111
>> +#define CLK_RISCV_CFG_GATE	112
>> +#define CLK_FANOUT_24M		113
>> +#define CLK_FANOUT_12M		114
>> +#define CLK_FANOUT_16M		115
>> +#define CLK_FANOUT_25M		116
>> +#define CLK_FANOUT_27M		117
>> +#define CLK_FANOUT_PCLK		118
>> +#define CLK_FANOUT0		119
>> +#define CLK_FANOUT1		120
>> +#define CLK_FANOUT2		121
>> +
>> +#endif
>> diff --git a/include/dt-bindings/clock/allwinner,sun8i-v853-r-ccu.h =
b/include/dt-bindings/clock/allwinner,sun8i-v853-r-ccu.h
>> new file mode 100644
>> index 000000000000..48fe598b7bd8
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/allwinner,sun8i-v853-r-ccu.h
>> @@ -0,0 +1,16 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (C) 2025 Andras Szemzo <szemzo.andras@gmail.com>
>> + */
>> +
>> +#ifndef _DT_BINDINGS_CLK_ALLWINNER_SUN8I_V853_R_CCU_H_
>> +#define _DT_BINDINGS_CLK_ALLWINNER_SUN8I_V853_R_CCU_H_
>> +
>> +#define CLK_R_AHB		0
>> +#define CLK_R_APB0		1
>> +#define CLK_BUS_R_TWD		2
>> +#define CLK_BUS_R_PPU		3
>> +#define CLK_BUS_R_RTC		4
>> +#define CLK_BUS_R_CPUCFG	5
>> +
>> +#endif
>> diff --git a/include/dt-bindings/reset/allwinner,sun8i-v853-ccu.h =
b/include/dt-bindings/reset/allwinner,sun8i-v853-ccu.h
>> new file mode 100644
>> index 000000000000..e258117518aa
>> --- /dev/null
>> +++ b/include/dt-bindings/reset/allwinner,sun8i-v853-ccu.h
>> @@ -0,0 +1,60 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (C) 2024 Andras Szemzo <szemzo.andras@gmail.com>
>> + */
>> +
>> +#ifndef _DT_BINDINGS_RST_ALLWINNER_SUN8I_V85X_CCU_H_
>> +#define _DT_BINDINGS_RST_ALLWINNER_SUN8I_V85X_CCU_H_
>> +
>> +#define RST_MBUS		0
>> +#define RST_BUS_DE		1
>> +#define RST_BUS_G2D		2
>> +#define RST_BUS_CE		3
>> +#define RST_BUS_VE		4
>> +#define RST_BUS_NPU		5
>> +#define RST_BUS_DMA		6
>> +#define RST_BUS_MSGBOX0		7
>> +#define RST_BUS_MSGBOX1		8
>> +#define RST_BUS_SPINLOCK	9
>> +#define RST_BUS_HSTIMER		10
>> +#define RST_BUS_DBG		11
>> +#define RST_BUS_PWM		12
>> +#define RST_BUS_DRAM		13
>> +#define RST_BUS_MMC0		14
>> +#define RST_BUS_MMC1		15
>> +#define RST_BUS_MMC2		16
>> +#define RST_BUS_UART0		17
>> +#define RST_BUS_UART1		18
>> +#define RST_BUS_UART2		19
>> +#define RST_BUS_UART3		20
>> +#define RST_BUS_I2C0		21
>> +#define RST_BUS_I2C1		22
>> +#define RST_BUS_I2C2		23
>> +#define RST_BUS_I2C3		24
>> +#define RST_BUS_I2C4		25
>> +#define RST_BUS_SPI0		26
>> +#define RST_BUS_SPI1		27
>> +#define RST_BUS_SPI2		28
>> +#define RST_BUS_SPI3		29
>> +#define RST_BUS_SPIF		30
>> +#define RST_BUS_EMAC		31
>> +#define RST_BUS_GPADC		32
>> +#define RST_BUS_THS		33
>> +#define RST_BUS_I2S0		34
>> +#define RST_BUS_I2S1		35
>> +#define RST_BUS_DMIC		36
>> +#define RST_BUS_AUDIO_CODEC	37
>> +#define RST_USB_PHY		38
>> +#define RST_BUS_OHCI		39
>> +#define RST_BUS_EHCI		40
>> +#define RST_BUS_OTG		41
>> +#define RST_BUS_DPSS_TOP	42
>> +#define RST_BUS_MIPI_DSI	43
>> +#define RST_BUS_TCON_LCD	44
>> +#define RST_BUS_CSI		45
>> +#define RST_BUS_WIEGAND		46
>> +#define RST_RISCV_SYS_APB	47
>> +#define RST_RISCV_SOFT		48
>> +#define RST_RISCV_CFG		49
>> +
>> +#endif
>> diff --git a/include/dt-bindings/reset/allwinner,sun8i-v853-r-ccu.h =
b/include/dt-bindings/reset/allwinner,sun8i-v853-r-ccu.h
>> new file mode 100644
>> index 000000000000..57629d635115
>> --- /dev/null
>> +++ b/include/dt-bindings/reset/allwinner,sun8i-v853-r-ccu.h
>> @@ -0,0 +1,14 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (C) 2025 Andras Szemzo <szemzo.andras@gmail.com>
>> + */
>> +
>> +#ifndef _DT_BINDINGS_RST_ALLWINNER_SUN8I_V853_R_CCU_H_
>> +#define _DT_BINDINGS_RST_ALLWINNER_SUN8I_V853_R_CCU_H_
>> +
>> +#define RST_BUS_R_TWD		0
>> +#define RST_BUS_R_PPU		1
>> +#define RST_BUS_R_RTC		2
>> +#define RST_BUS_R_CPUCFG	3
>> +
>> +#endif
>> --=20
>> 2.39.5
>>=20


