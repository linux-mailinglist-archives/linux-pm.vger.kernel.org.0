Return-Path: <linux-pm+bounces-22483-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45632A3C98B
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 21:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0727C17026C
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 20:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5B722DFA7;
	Wed, 19 Feb 2025 20:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AywmhPwh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24CC1BE251;
	Wed, 19 Feb 2025 20:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739996523; cv=none; b=JZtQfvxofNlQBfUUvpaKcPPqzqG5OFRgj+nU560U4Hv0HcZqGr/iXMBRBK5sY1hgbwnO+LOgpzTjM5fmIfqhcaTn0DbgqK2OgA6EeC7IXBIV4YKpDuqP/NBH7FT8V0XPfP/P7pG+Dhm5UaxgyL/eFX34EuHelgkNRzqjV3eULzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739996523; c=relaxed/simple;
	bh=1xw7FssT82oLITpLMpVSHw96t+nl3pNEWgg4H6F6Qp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aPUFzfyYduSwCt3LfM4a5wwrSrPgktNJ+oQjkSIBqJi3X27KkS6ogv+M6jFYxaQTlpm+ekSFRTdrgBgqNcrhpK6RIOanAFXKPiK07IR3/EHzJrKoSdcvp+KyWVTp7F/TGWcnPZFRwOjp15iDTwlRddpHvnDcRKP4LH2jLCCeC58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AywmhPwh; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4397e5d5d99so1010075e9.1;
        Wed, 19 Feb 2025 12:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739996518; x=1740601318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nid48bLhH/FBJHEXa989rxTIHzZsjgSmLvJWm4cud1Q=;
        b=AywmhPwhPCHjQlO5FlI2BrZoweoRgWpxnFlTjKCmjcvF0e3BOLaZebRw8t2tNXxdVt
         ntcIyxkZFcWHMa4RgEGuoG/lLkrPM02JsaOJL0bRmTBLQ2E892DHoCN0jYBqvW2tAM/c
         kpmEKi8I9Kqwx3lRx1fdvHUQZ+69YGItR6zubeur3rvcwQBG6wdRC1tzpdvGtQAH0Xe4
         8uV9MKermcgC6qiqmptQqjns/ry8AYT2L+tf+7RGEUTr21RjBU31fuMbQOH+pJyO8fgH
         Z5CDE69l90de0prKbUvd7qAlhNlkLcuCZxEVsTWVyUdwJWdK7WN2TGXr6MDU8jbS5aL4
         /c6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739996518; x=1740601318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nid48bLhH/FBJHEXa989rxTIHzZsjgSmLvJWm4cud1Q=;
        b=JCkG2uHtsGQT8Vy690ZA7oids4yjB+fEQXkWJavezPwboiAiLkfEEES/CqKuV/z1qH
         ZdSU2DPuLQGl1aAaSaYT+TOQbMTKlkGgywpCbompYQyczps1KDtKAqM/vHXqiVqVtUF3
         nbiavycZJ/lOBaGqa/eozHu3eS3WZxAV937fXD6ziae6Vhd/1cE25OaYwa6FYmGozKY8
         QQ6lK89dcwziY1UteYbwCeYuPIx+YYFgZNVaRo3yRhK6XujhzBeoFWVxWB/LSGgJKx6H
         GxsxvbDwSKNVYbJR70M7YVHPUtTVgXXHtY/my1LJAGHbOI+9i6CZ30ZYaE+pmRL5pkoY
         2hSA==
X-Forwarded-Encrypted: i=1; AJvYcCU+mjFO/Tn+vV9hVQjc+X4eRLTdoVRtw3FlafC9FfGazoJGz0c5/Cchs0iPx2hl9cvLWgCgoI4WZR7+WQ==@vger.kernel.org, AJvYcCURPxfM/Jmtra16uifrt8/yj4MNvU58h4uPIZBJuOpjzxLOmguN6fEgDnclVjPAfqvvbvf7DW+5ncmP@vger.kernel.org, AJvYcCUgbjM7kwyn/GEQpZlVvN1PXDODLnbkazsOL5BVOLpAjSiP+0HhEp7tJ+tkAThOB/CAY4IIiUCQqTG2@vger.kernel.org, AJvYcCXFOOSNdko702dTVvjsA/y3FuaTRn2/5BOwzm03hYT1faMWxELESsWAfba8InvrOowL5dx0joMIMwEwPO8W@vger.kernel.org, AJvYcCXP+/8Zrk5p+wB3OLjiR66wcVJK5OdpStTlzj+LDJfpmCjfVGYhlolIGKgkRLd0l+adwifY8zxL/WM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJi/exikiWfKUuoD35hhO2JALzojmzFTcAD30qobwDEnyzvS7J
	kIpsj4InkkT5h0WzmfW0226zC4W1BJvTFaTZQd6/gJlrOm4torAJ
X-Gm-Gg: ASbGncvKBPh9qm74VhTr1mP/IVLVK/2/pcnQdGpsyFqwZ6hqh4TvyEfzKeHVWJjh1rJ
	W9Q2LG5Iy6oP2tkxJv8s1fmNjoVW8gF6+wTNI4SqtOj1Z6f7wcOCckVvpwRVJBu15pjPmTZ4v5Q
	vn17fS/2W//ghQyqbsWbS81l/91NgKckG2AoL4ush/NUiWHzlTmpirT8+RkqiuyTIh71Bav/Nw8
	D+l6wabn+XPLOs9A9DXyOI87soFKxTCrL340oFt0aPgg4PgrlsENzhsGUUXzj0ZymYXRx5Gy7mA
	cYkwP++69QVpMB+Zz06jsctK7N9+spzY1S5ycSsLmoPe9Ewigd8IGqSTkegVJR1yUnQ=
X-Google-Smtp-Source: AGHT+IE6IeUem5aMOtu5jChHWDBa5MTCtBbguS6zGTJ5rDfVtK+EJKsOG90m0rn5aiIOqr+ekOeGNQ==
X-Received: by 2002:a05:600c:3b12:b0:439:96b2:e9b with SMTP id 5b1f17b1804b1-43996b212d9mr63124255e9.9.1739996517331;
        Wed, 19 Feb 2025 12:21:57 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d9be9sm19015747f8f.79.2025.02.19.12.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 12:21:56 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Maxime Ripard <mripard@kernel.org>,
 Andras Szemzo <szemzo.andras@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-gpio@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 04/10] clk: sunxi-ng: add CCU drivers for V853
Date: Wed, 19 Feb 2025 21:21:54 +0100
Message-ID: <3596612.V25eIC5XRa@jernej-laptop>
In-Reply-To: <20250205125225.1152849-5-szemzo.andras@gmail.com>
References:
 <20250205125225.1152849-1-szemzo.andras@gmail.com>
 <20250205125225.1152849-5-szemzo.andras@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne sreda, 5. februar 2025 ob 13:52:19 Srednjeevropski standardni =C4=8Das =
je Andras Szemzo napisal(a):
> V853 has similar gates/resets like existing Allwinner SOCs. Add support f=
or it's CCU and PRCM CCU.
>=20
> Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com>
> ---
>  drivers/clk/sunxi-ng/Kconfig            |   10 +
>  drivers/clk/sunxi-ng/Makefile           |    4 +
>  drivers/clk/sunxi-ng/ccu-sun8i-v853-r.c |  120 +++
>  drivers/clk/sunxi-ng/ccu-sun8i-v853-r.h |   14 +
>  drivers/clk/sunxi-ng/ccu-sun8i-v853.c   | 1145 +++++++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu-sun8i-v853.h   |   14 +
>  6 files changed, 1307 insertions(+)
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-v853-r.c
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-v853-r.h
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-v853.c
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-v853.h
>=20
> diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
> index b547198a2c65..e257373177e0 100644
> --- a/drivers/clk/sunxi-ng/Kconfig
> +++ b/drivers/clk/sunxi-ng/Kconfig
> @@ -12,6 +12,16 @@ config SUNIV_F1C100S_CCU
>  	default y
>  	depends on MACH_SUNIV || COMPILE_TEST
> =20
> +config SUN8I_V853_CCU
> +	tristate "Support for the Allwinner V853/V851s/V851SE CCU"
> +	default MACH_SUN8I
> +	depends on MACH_SUN8I || COMPILE_TEST
> +
> +config SUN8I_V853_R_CCU
> +	tristate "Support for the Allwinner V853/V851s/V851SE PRCM CCU"
> +	default MACH_SUN8I
> +	depends on MACH_SUN8I || COMPILE_TEST

Generally, this are two patches, one for each driver.

> +
>  config SUN20I_D1_CCU
>  	tristate "Support for the Allwinner D1/R528/T113 CCU"
>  	default y
> diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
> index 6b3ae2b620db..b87928462e15 100644
> --- a/drivers/clk/sunxi-ng/Makefile
> +++ b/drivers/clk/sunxi-ng/Makefile
> @@ -25,6 +25,8 @@ sunxi-ccu-y			+=3D ccu_mp.o
> =20
>  # SoC support
>  obj-$(CONFIG_SUNIV_F1C100S_CCU)	+=3D suniv-f1c100s-ccu.o
> +obj-$(CONFIG_SUN8I_V853_CCU)	+=3D sun8i-v853-ccu.o
> +obj-$(CONFIG_SUN8I_V853_R_CCU)	+=3D sun8i-v853-r-ccu.o

Put it to other sun8i drivers.

>  obj-$(CONFIG_SUN20I_D1_CCU)	+=3D sun20i-d1-ccu.o
>  obj-$(CONFIG_SUN20I_D1_R_CCU)	+=3D sun20i-d1-r-ccu.o
>  obj-$(CONFIG_SUN50I_A64_CCU)	+=3D sun50i-a64-ccu.o
> @@ -50,6 +52,8 @@ obj-$(CONFIG_SUN9I_A80_CCU)	+=3D sun9i-a80-de-ccu.o
>  obj-$(CONFIG_SUN9I_A80_CCU)	+=3D sun9i-a80-usb-ccu.o
> =20
>  suniv-f1c100s-ccu-y		+=3D ccu-suniv-f1c100s.o
> +sun8i-v853-ccu-y		+=3D ccu-sun8i-v853.o
> +sun8i-v853-r-ccu-y		+=3D ccu-sun8i-v853-r.o

Ditto.

>  sun20i-d1-ccu-y			+=3D ccu-sun20i-d1.o
>  sun20i-d1-r-ccu-y		+=3D ccu-sun20i-d1-r.o
>  sun50i-a64-ccu-y		+=3D ccu-sun50i-a64.o
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v853-r.c b/drivers/clk/sunxi-=
ng/ccu-sun8i-v853-r.c
> new file mode 100644
> index 000000000000..bd60e00cda7f
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-v853-r.c
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025 Andras Szemzo <szemzo.andras@gmail.com>
> + *
> + * Based on ccu-sun20i-d1-r.c by Samuel Holland.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include "ccu_common.h"
> +#include "ccu_reset.h"
> +
> +#include "ccu_gate.h"
> +#include "ccu_mp.h"
> +
> +#include "ccu-sun8i-v853-r.h"
> +
> +static const struct clk_parent_data r_ahb_apb0_parents[] =3D {
> +	{ .fw_name =3D "hosc" },
> +	{ .fw_name =3D "losc" },
> +	{ .fw_name =3D "iosc" },
> +	{ .fw_name =3D "pll-periph" },
> +	{ .fw_name =3D "pll-audio" }
> +};
> +
> +static SUNXI_CCU_MP_DATA_WITH_MUX(r_ahb_clk, "r-ahb",
> +				  r_ahb_apb0_parents, 0x000,
> +				  0, 5,		/* M */
> +				  8, 2,		/* P */
> +				  24, 3,	/* mux */
> +				  0);
> +static const struct clk_hw *r_ahb_hw =3D &r_ahb_clk.common.hw;
> +
> +static SUNXI_CCU_MP_DATA_WITH_MUX(r_apb0_clk, "r-apb0",
> +				  r_ahb_apb0_parents, 0x00c,
> +				  0, 5,		/* M */
> +				  8, 2,		/* P */
> +				  24, 3,	/* mux */
> +				  0);
> +static const struct clk_hw *r_apb0_hw =3D &r_apb0_clk.common.hw;

Where can I look for above clocks? There are not described in BSP driver.

> +
> +static SUNXI_CCU_GATE_HWS(bus_r_twd_clk, "bus-r-twd", &r_apb0_hw,=20
> +			  0x12c, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_r_ppu_clk, "bus-r-ppu", &r_apb0_hw,
> +			  0x1ac, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_r_rtc_clk, "bus-r-rtc", &r_ahb_hw,
> +			  0x20c, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_r_cpucfg_clk, "bus-r-cpucfg", &r_apb0_hw,
> +			  0x22c, BIT(0), 0);
> +
> +static struct ccu_common *sun8i_v853_r_ccu_clks[] =3D {
> +	&r_ahb_clk.common,
> +	&r_apb0_clk.common,
> +	&bus_r_twd_clk.common,
> +	&bus_r_ppu_clk.common,
> +	&bus_r_rtc_clk.common,
> +	&bus_r_cpucfg_clk.common,
> +};
> +
> +static struct clk_hw_onecell_data sun8i_v853_r_hw_clks =3D {
> +	.num	=3D CLK_NUMBER,
> +	.hws	=3D {
> +		[CLK_R_AHB]		=3D &r_ahb_clk.common.hw,
> +		[CLK_R_APB0]		=3D &r_apb0_clk.common.hw,
> +		[CLK_BUS_R_TWD]		=3D &bus_r_twd_clk.common.hw,
> +		[CLK_BUS_R_PPU]		=3D &bus_r_ppu_clk.common.hw,
> +		[CLK_BUS_R_RTC]		=3D &bus_r_rtc_clk.common.hw,
> +		[CLK_BUS_R_CPUCFG]	=3D &bus_r_cpucfg_clk.common.hw,
> +	},
> +};
> +
> +static const struct ccu_reset_map sun8i_v853_r_ccu_resets[] =3D {
> +	[RST_BUS_R_TWD]		=3D { 0x12c, BIT(16) },

Where did you get that? BSP driver that I checked doesn't mentions it.

> +	[RST_BUS_R_PPU]		=3D { 0x1ac, BIT(16) },
> +	[RST_BUS_R_RTC]		=3D { 0x20c, BIT(16) },
> +	[RST_BUS_R_CPUCFG]	=3D { 0x22c, BIT(16) },
> +};
> +
> +static const struct sunxi_ccu_desc sun8i_v853_r_ccu_desc =3D {
> +	.ccu_clks	=3D sun8i_v853_r_ccu_clks,
> +	.num_ccu_clks	=3D ARRAY_SIZE(sun8i_v853_r_ccu_clks),
> +
> +	.hw_clks	=3D &sun8i_v853_r_hw_clks,
> +
> +	.resets		=3D sun8i_v853_r_ccu_resets,
> +	.num_resets	=3D ARRAY_SIZE(sun8i_v853_r_ccu_resets),
> +};
> +
> +static int sun8i_v853_r_ccu_probe(struct platform_device *pdev)
> +{
> +	void __iomem *reg;
> +
> +	reg =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(reg))
> +		return PTR_ERR(reg);
> +
> +	return devm_sunxi_ccu_probe(&pdev->dev, reg, &sun8i_v853_r_ccu_desc);
> +}
> +
> +static const struct of_device_id sun8i_v853_r_ccu_ids[] =3D {
> +	{ .compatible =3D "allwinner,sun8i-v853-r-ccu" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, sun8i_v853_r_ccu_ids);
> +
> +static struct platform_driver sun8i_v853_r_ccu_driver =3D {
> +	.probe	=3D sun8i_v853_r_ccu_probe,
> +	.driver	=3D {
> +		.name			=3D "sun8i-v853-r-ccu",
> +		.suppress_bind_attrs	=3D true,
> +		.of_match_table		=3D sun8i_v853_r_ccu_ids,
> +	},
> +};
> +module_platform_driver(sun8i_v853_r_ccu_driver);
> +
> +MODULE_IMPORT_NS("SUNXI_CCU");
> +MODULE_DESCRIPTION("Support for the Allwinner V853 PRCM CCU");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v853-r.h b/drivers/clk/sunxi-=
ng/ccu-sun8i-v853-r.h
> new file mode 100644
> index 000000000000..2c6cc7b6f251
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-v853-r.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2025 Andras Szemzo <szemzo.andras@gmail.com>
> + */
> +
> +#ifndef _CCU_SUN8I_V853_R_H
> +#define _CCU_SUN8I_V853_R_H
> +
> +#include <dt-bindings/clock/allwinner,sun8i-v853-r-ccu.h>
> +#include <dt-bindings/reset/allwinner,sun8i-v853-r-ccu.h>
> +
> +#define CLK_NUMBER		(CLK_BUS_R_CPUCFG + 1)
> +
> +#endif
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v853.c b/drivers/clk/sunxi-ng=
/ccu-sun8i-v853.c
> new file mode 100644
> index 000000000000..4b32f3a913cf
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-v853.c
> @@ -0,0 +1,1145 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025 Andras Szemzo <szemzo.andras@gmail.com>
> + *
> + * Based on ccu-sun20i-d1.c by Samuel Holland.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include "../clk.h"
> +
> +#include "ccu_common.h"
> +#include "ccu_reset.h"
> +
> +#include "ccu_div.h"
> +#include "ccu_gate.h"
> +#include "ccu_mp.h"
> +#include "ccu_mult.h"
> +#include "ccu_nk.h"
> +#include "ccu_nkm.h"
> +#include "ccu_nkmp.h"
> +#include "ccu_nm.h"
> +
> +#include "ccu-sun8i-v853.h"
> +
> +static const struct clk_parent_data osc24M[] =3D {
> +	{ .fw_name =3D "hosc" }
> +};
> +
> +/*
> + * For the CPU PLL, the output divider is described as "only for testing"
> + * in the user manual. So it's not modelled and forced to 0.
> + */
> +#define SUN8I_V853_PLL_CPU_REG		0x000
> +
> +static struct ccu_mult pll_cpu_clk =3D {
> +	.enable		=3D BIT(27),
> +	.lock		=3D BIT(28),
> +	.mult		=3D _SUNXI_CCU_MULT_MIN(8, 8, 11),
> +	.common		=3D {
> +		.reg		=3D 0x000,
> +		.hw.init	=3D CLK_HW_INIT_PARENTS_DATA("pll-cpu", osc24M,
> +							   &ccu_mult_ops,
> +							   CLK_SET_RATE_GATE),
> +	},
> +};
> +
> +/* Some PLLs are input * N / div1 / P. Model them as NKMP with no K */
> +#define SUN8I_V853_PLL_DDR_REG		0x010
> +static struct ccu_nkmp pll_ddr_clk =3D {
> +	.enable		=3D BIT(27),
> +	.lock		=3D BIT(28),
> +	.n		=3D _SUNXI_CCU_MULT_MIN(8, 8, 11),
> +	.m		=3D _SUNXI_CCU_DIV(1, 1), /* input divider */
> +	.p		=3D _SUNXI_CCU_DIV(0, 1), /* output divider */
> +	.common		=3D {
> +		.reg		=3D 0x010,
> +		.hw.init	=3D CLK_HW_INIT_PARENTS_DATA("pll-ddr", osc24M,
> +							   &ccu_nkmp_ops,
> +							   CLK_SET_RATE_GATE),
> +	},
> +};
> +
> +#define SUN8I_V853_PLL_PERIPH_REG	0x020
> +static struct ccu_nm pll_periph_4x_clk =3D {
> +	.enable		=3D BIT(27),
> +	.lock		=3D BIT(28),
> +	.n		=3D _SUNXI_CCU_MULT_MIN(8, 8, 11),
> +	.m		=3D _SUNXI_CCU_DIV(1, 1), /* input divider */
> +	.common		=3D {
> +		.reg		=3D 0x020,
> +		.hw.init	=3D CLK_HW_INIT_PARENTS_DATA("pll-periph-4x", osc24M,
> +							   &ccu_nm_ops,
> +							   CLK_SET_RATE_GATE),
> +	},
> +};
> +
> +static const struct clk_hw *pll_periph_4x_hws[] =3D {
> +	&pll_periph_4x_clk.common.hw
> +};
> +
> +static SUNXI_CCU_M_HWS(pll_periph_2x_clk, "pll-periph-2x", pll_periph_4x=
_hws,
> +		       0x020, 16, 3, 0);
> +
> +static SUNXI_CCU_M_HWS(pll_periph_800M_clk, "pll-periph-800M", pll_perip=
h_4x_hws,
> +		       0x020, 20, 3, 0);
> +
> +static SUNXI_CCU_M_HWS(pll_periph_480M_clk, "pll-periph-480M", pll_perip=
h_4x_hws,
> +		       0x020, 2, 3, 0);
> +
> +static CLK_FIXED_FACTOR_HW(pll_periph_600M_clk, "pll-periph-600M",
> +			   &pll_periph_2x_clk.common.hw, 2, 1, 0);
> +
> +static CLK_FIXED_FACTOR_HW(pll_periph_400M_clk, "pll-periph-400M",
> +			   &pll_periph_2x_clk.common.hw, 3, 1, 0);
> +
> +static CLK_FIXED_FACTOR_HW(pll_periph_300M_clk, "pll-periph-300M",
> +			   &pll_periph_600M_clk.hw, 2, 1, 0);
> +
> +static CLK_FIXED_FACTOR_HW(pll_periph_200M_clk, "pll-periph-200M",
> +			   &pll_periph_400M_clk.hw, 2, 1, 0);
> +
> +static CLK_FIXED_FACTOR_HW(pll_periph_160M_clk, "pll-periph-160M",
> +			   &pll_periph_480M_clk.common.hw, 3, 1, 0);
> +
> +static CLK_FIXED_FACTOR_HW(pll_periph_150M_clk, "pll-periph-150M",
> +			   &pll_periph_300M_clk.hw, 2, 1, 0);
> +
> +/*
> + * For Video PLLs, the output divider is described as "only for testing"
> + * in the user manual.
> + */
> +#define SUN8I_V853_PLL_VIDEO_REG	0x040
> +static struct ccu_nkmp pll_video_4x_clk =3D {
> +	.enable		=3D BIT(27),
> +	.lock		=3D BIT(28),
> +	.n		=3D _SUNXI_CCU_MULT_MIN(8, 8, 11),
> +	.p		=3D _SUNXI_CCU_DIV(1, 1), /* input divider */
> +	.common		=3D {
> +		.reg		=3D 0x040,
> +		.hw.init	=3D CLK_HW_INIT_PARENTS_DATA("pll-video-4x", osc24M,
> +							   &ccu_nkmp_ops,
> +							   CLK_SET_RATE_GATE),
> +	},
> +};
> +
> +static const struct clk_hw *pll_video_4x_hws[] =3D {
> +	&pll_video_4x_clk.common.hw
> +};
> +static CLK_FIXED_FACTOR_HWS(pll_video_2x_clk, "pll-video-2x",
> +			    pll_video_4x_hws, 2, 1, CLK_SET_RATE_PARENT);
> +static CLK_FIXED_FACTOR_HWS(pll_video_1x_clk, "pll-video-1x",
> +			    pll_video_4x_hws, 4, 1, CLK_SET_RATE_PARENT);
> +
> +
> +/*
> + * For CSI PLLs, the output divider is described as "only for testing"
> + * in the user manual.
> + */
> +#define SUN8I_V853_PLL_CSI_REG		0x048
> +static struct ccu_nkmp pll_csi_4x_clk =3D {
> +	.enable		=3D BIT(27),
> +	.lock		=3D BIT(28),
> +	.n		=3D _SUNXI_CCU_MULT_MIN(8, 8, 11),
> +	.p		=3D _SUNXI_CCU_DIV(1, 1), /* input divider */
> +	.common		=3D {
> +		.reg		=3D 0x048,
> +		.hw.init	=3D CLK_HW_INIT_PARENTS_DATA("pll-csi-4x", osc24M,
> +							   &ccu_nkmp_ops,
> +							   CLK_SET_RATE_GATE),
> +	},
> +};
> +
> +static CLK_FIXED_FACTOR_HW(pll_csi_clk, "pll-csi",
> +			   &pll_csi_4x_clk.common.hw, 4, 1, CLK_SET_RATE_PARENT);
> +
> +
> +#define SUN8I_V853_PLL_AUDIO_REG	0x078
> +static struct ccu_sdm_setting pll_audio_div5_sdm_table[] =3D {
> +	{ .rate =3D 196608000, .pattern =3D 0xc001eb85, .m =3D 5, .n =3D 40 }, =
/* 24.576 */
> +	{ .rate =3D 67737600, .pattern =3D 0xc001288d, .m =3D 8, .n =3D 22 }, /=
* 22.5792 */
> +};
> +
> +static struct ccu_nm pll_audio_div5_clk =3D {
> +	.enable		=3D BIT(27),
> +	.lock           =3D BIT(28),
> +	.n              =3D _SUNXI_CCU_MULT(8, 8),
> +	.m              =3D _SUNXI_CCU_DIV(20, 3),
> +	.sdm            =3D _SUNXI_CCU_SDM(pll_audio_div5_sdm_table,
> +				    BIT(24), 0x0178, BIT(31)),
> +	.common         =3D {
> +		.reg            =3D 0x0078,
> +		.features       =3D CCU_FEATURE_SIGMA_DELTA_MOD,
> +		.hw.init        =3D CLK_HW_INIT_PARENTS_DATA("pll-audio-div5", osc24M,
> +							   &ccu_nm_ops,
> +							   CLK_SET_RATE_UNGATE),
> +	},
> +};
> +
> +static const struct clk_hw *pll_audio_div5_hws[] =3D {
> +	&pll_audio_div5_clk.common.hw
> +};
> +
> +static SUNXI_CCU_M_HWS(pll_audio_1x_clk, "pll-audio-1x", pll_audio_div5_=
hws,
> +		       0xe00, 0, 5, CLK_SET_RATE_PARENT);
> +
> +/* pll-audio-div2 and pll-audio-4x not used, because pll-audio-1x can co=
ver=20
> + * 22.5792M and 24.576M=20
> + */
> +static SUNXI_CCU_M(pll_audio_div2_clk, "pll-audio-div2", "pll-audio",
> +		   0x078, 16, 3, 0);
> +static SUNXI_CCU_M(pll_audio_4x_clk, "pll-audio-4x", "pll-audio-div2",
> +		   0xe00, 5, 5, 0);
> +
> +/*
> + * For the NPU PLL, the output divider is described as "only for testing"
> + * in the user manual.
> + */
> +#define SUN8I_V853_PLL_NPU_REG		0x080
> +static struct ccu_nkmp pll_npu_4x_clk =3D {
> +	.enable		=3D BIT(27),
> +	.lock		=3D BIT(28),
> +	.n		=3D _SUNXI_CCU_MULT_MIN(8, 8, 11),
> +	.p		=3D _SUNXI_CCU_DIV(1, 1), /* input divider */
> +	.common		=3D {
> +		.reg		=3D 0x080,
> +		.hw.init	=3D CLK_HW_INIT_PARENTS_DATA("pll-npu-4x", osc24M,
> +							   &ccu_nkmp_ops,
> +							   CLK_SET_RATE_UNGATE),
> +	},
> +};
> +
> +/*
> + * The CPU gate is not modelled - it is in a separate register (0x504)
> + * and has a special key field. The clock must not be gated anyway by
> + * the kernel.
> + */
> +static const struct clk_parent_data cpu_parents[] =3D {
> +	{ .fw_name =3D "hosc" },
> +	{ .fw_name =3D "losc" },
> +	{ .fw_name =3D "iosc" },
> +	{ .hw =3D &pll_cpu_clk.common.hw },
> +	{ .hw =3D &pll_periph_600M_clk.hw },
> +	{ .hw =3D &pll_periph_800M_clk.common.hw },
> +};
> +
> +/*
> + * There is a P factor (PLL_OUT_EXT_DIVP[17:16]) in this register, but i=
t is not modeled.
> + * The manual states that it should be used only, when the output clock =
is less than 288 MHz.
> + */
> +static SUNXI_CCU_MUX_DATA(cpu_clk, "cpu", cpu_parents,
> +			  0x500, 24, 3, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
> +
> +static const struct clk_hw *cpu_hws[] =3D { &cpu_clk.common.hw };
> +
> +static SUNXI_CCU_M_HWS(cpu_axi_clk, "cpu-axi", cpu_hws,
> +		       0x500, 0, 2, 0);
> +static SUNXI_CCU_M_HWS(cpu_apb_clk, "cpu-apb", cpu_hws,
> +		       0x500, 8, 2, 0);
> +
> +static const struct clk_parent_data ahb_parents[] =3D {
> +	{ .fw_name =3D "hosc" },
> +	{ .fw_name =3D "losc" },
> +	{ .fw_name =3D "iosc" },
> +	{ .hw =3D &pll_periph_600M_clk.hw },
> +};
> +static SUNXI_CCU_MP_DATA_WITH_MUX(ahb_clk, "ahb", ahb_parents, 0x510,
> +				  0, 5,		/* M */
> +				  8, 2,		/* P */
> +				  24, 2,	/* mux */
> +				  0);
> +
> +static SUNXI_CCU_MP_DATA_WITH_MUX(apb0_clk, "apb0", ahb_parents, 0x520,
> +				  0, 5,		/* M */
> +				  8, 2,		/* P */
> +				  24, 2,	/* mux */
> +				  0);
> +
> +static SUNXI_CCU_MP_DATA_WITH_MUX(apb1_clk, "apb1", ahb_parents, 0x524,
> +				  0, 5,		/* M */
> +				  8, 2,		/* P */
> +				  24, 2,	/* mux */
> +				  0);
> +
> +static const struct clk_hw *ahb_hws[] =3D { &ahb_clk.common.hw };
> +static const struct clk_hw *apb0_hws[] =3D { &apb0_clk.common.hw };
> +static const struct clk_hw *apb1_hws[] =3D { &apb1_clk.common.hw };
> +
> +
> +static const struct clk_hw *de_g2d_parents[] =3D {
> +	&pll_periph_300M_clk.hw,
> +	&pll_video_1x_clk.hw,
> +};
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(de_clk, "de", de_g2d_parents, 0x600,
> +				    0, 5,	/* M */
> +				    24, 1,	/* mux */
> +				    BIT(31),	/* gate */
> +				    CLK_SET_RATE_PARENT);
> +
> +static SUNXI_CCU_GATE_HWS(bus_de_clk, "bus-de", ahb_hws,
> +			  0x60c, BIT(0), 0);
> +
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(g2d_clk, "g2d", de_g2d_parents, 0x63=
0,
> +				    0, 5,	/* M */
> +				    24, 1,	/* mux */
> +				    BIT(31),	/* gate */
> +				    CLK_SET_RATE_PARENT);
> +
> +static SUNXI_CCU_GATE_HWS(bus_g2d_clk, "bus-g2d", ahb_hws,
> +			  0x63c, BIT(0), 0);
> +
> +
> +static const struct clk_parent_data ce_parents[] =3D {
> +	{ .fw_name =3D "hosc" },

Where this come from? V853 manual v1.1 doesn't have it.

> +	{ .hw =3D &pll_periph_400M_clk.hw, },
> +	{ .hw =3D &pll_periph_300M_clk.hw, }
> +};
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(ce_clk, "ce", ce_parents, 0x680,
> +				      0, 4,	/* M */
> +				      24, 3,	/* mux */
> +				      BIT(31),	/* gate */
> +				      CLK_SET_RATE_PARENT);

Set rate parent flag doesn't make sense on constant parents.

> +
> +static SUNXI_CCU_GATE_HWS(bus_ce_clk, "bus-ce", ahb_hws,
> +			  0x68c, BIT(0) | BIT(1), 0);
> +
> +static const struct clk_hw *ve_parents[] =3D {
> +	&pll_periph_300M_clk.hw,
> +	&pll_periph_400M_clk.hw,
> +	&pll_periph_480M_clk.common.hw,
> +	&pll_npu_4x_clk.common.hw,
> +	&pll_video_4x_clk.common.hw,
> +	&pll_csi_4x_clk.common.hw,
> +};
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(ve_clk, "ve", ve_parents, 0x690,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);

CLK_SET_RATE_PARENT flag? Cedrus driver set working clock at the beginning.

> +
> +static SUNXI_CCU_GATE_HWS(bus_ve_clk, "bus-ve", ahb_hws,
> +			  0x69c, BIT(0), 0);
> +
> +
> +static const struct clk_hw *npu_parents[] =3D {
> +	&pll_periph_480M_clk.common.hw,
> +	&pll_periph_600M_clk.hw,
> +	&pll_periph_800M_clk.common.hw,
> +	&pll_npu_4x_clk.common.hw,
> +};
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(npu_clk, "npu", npu_parents, 0x6e0,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);

I think CLK_SET_RATE_PARENT would also be beneficial here.

> +
> +static SUNXI_CCU_GATE_HWS(bus_npu_clk, "bus-npu", ahb_hws,
> +			  0x6ec, BIT(0), 0);
> +
> +static SUNXI_CCU_GATE_HWS(bus_dma_clk, "bus-dma", ahb_hws,
> +			  0x70c, BIT(0), 0);
> +
> +static SUNXI_CCU_GATE_HWS(bus_msgbox0_clk, "bus-msgbox0", ahb_hws,
> +			  0x71c, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_msgbox1_clk, "bus-msgbox1", ahb_hws,
> +			  0x71c, BIT(1), 0);
> +
> +static SUNXI_CCU_GATE_HWS(bus_spinlock_clk, "bus-spinlock", ahb_hws,
> +			  0x72c, BIT(0), 0);
> +
> +static SUNXI_CCU_GATE_HWS(bus_hstimer_clk, "bus-hstimer", ahb_hws,
> +			  0x73c, BIT(0), 0);
> +
> +static SUNXI_CCU_GATE_DATA(avs_clk, "avs", osc24M,
> +			   0x740, BIT(31), 0);
> +
> +static SUNXI_CCU_GATE_HWS(bus_dbg_clk, "bus-dbg", ahb_hws,
> +			  0x78c, BIT(0), 0);
> +
> +static SUNXI_CCU_GATE_HWS(bus_pwm_clk, "bus-pwm", apb0_hws,
> +			  0x7ac, BIT(0), 0);
> +
> +static SUNXI_CCU_GATE_HWS(bus_iommu_clk, "bus-iommu", ahb_hws,
> +			  0x7bc, BIT(0), 0);
> +
> +static const struct clk_hw *dram_parents[] =3D {
> +	&pll_ddr_clk.common.hw,
> +	&pll_periph_2x_clk.common.hw,
> +	&pll_periph_800M_clk.common.hw,
> +};
> +static SUNXI_CCU_MP_HW_WITH_MUX_GATE(dram_clk, "dram", dram_parents, 0x8=
00,
> +				     0, 5,	/* M */
> +				     8, 2,	/* P */
> +				     24, 3,	/* mux */
> +				     BIT(31), CLK_IS_CRITICAL);

This clock needs update field to be set to actually apply configuration. So
same comment as on A523 clock version, this needs new flag to be introduced
for such case.

> +
> +static CLK_FIXED_FACTOR_HW(mbus_clk, "mbus",
> +			   &dram_clk.common.hw, 4, 1, 0);
> +
> +static const struct clk_hw *mbus_hws[] =3D { &mbus_clk.hw };
> +
> +static SUNXI_CCU_GATE_HWS(mbus_dma_clk, "mbus-dma", mbus_hws,
> +			  0x804, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_ve_clk, "mbus-ve", mbus_hws,
> +			  0x804, BIT(1), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_ce_clk, "mbus-ce", mbus_hws,
> +			  0x804, BIT(2), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_csi_clk, "mbus-csi", mbus_hws,
> +			  0x804, BIT(8), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_isp_clk, "mbus-isp", mbus_hws,
> +			  0x804, BIT(9), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_g2d_clk, "mbus-g2d", mbus_hws,
> +			  0x804, BIT(10), 0);
> +
> +static SUNXI_CCU_GATE_HWS(bus_dram_clk, "bus-dram", ahb_hws,
> +			  0x80c, BIT(0), CLK_IS_CRITICAL);
> +
> +
> +static const struct clk_parent_data mmc0_mmc1_parents[] =3D {
> +	{ .fw_name =3D "hosc" },
> +	{ .hw =3D &pll_periph_400M_clk.hw, },
> +	{ .hw =3D &pll_periph_300M_clk.hw, },
> +};

Just mmc_parents.

> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(mmc0_clk, "mmc0", mmc0_mmc1_paren=
ts, 0x830,
> +				       0, 4,	/* M */
> +				       8, 2,	/* P */
> +				       24, 3,	/* mux */
> +				       BIT(31),	/* gate */
> +				       0);
> +
> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(mmc1_clk, "mmc1", mmc0_mmc1_paren=
ts, 0x834,
> +				       0, 4,	/* M */
> +				       8, 2,	/* P */
> +				       24, 3,	/* mux */
> +				       BIT(31),	/* gate */
> +				       0);
> +
> +static const struct clk_parent_data mmc2_parents[] =3D {
> +	{ .fw_name =3D "hosc" },
> +	{ .hw =3D &pll_periph_600M_clk.hw, },
> +	{ .hw =3D &pll_periph_400M_clk.hw, },
> +};
> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(mmc2_clk, "mmc2", mmc2_parents, 0=
x838,
> +				       0, 4,	/* M */
> +				       8, 2,	/* P */
> +				       24, 3,	/* mux */
> +				       BIT(31),	/* gate */
> +				       0);
> +
> +static SUNXI_CCU_GATE_HWS(bus_mmc0_clk, "bus-mmc0", ahb_hws,
> +			  0x84c, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_mmc1_clk, "bus-mmc1", ahb_hws,
> +			  0x84c, BIT(1), 0);
> +static SUNXI_CCU_GATE_HWS(bus_mmc2_clk, "bus-mmc2", ahb_hws,
> +			  0x84c, BIT(2), 0);
> +
> +static SUNXI_CCU_GATE_HWS(bus_uart0_clk, "bus-uart0", apb1_hws,
> +			  0x90c, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_uart1_clk, "bus-uart1", apb1_hws,
> +			  0x90c, BIT(1), 0);
> +static SUNXI_CCU_GATE_HWS(bus_uart2_clk, "bus-uart2", apb1_hws,
> +			  0x90c, BIT(2), 0);
> +static SUNXI_CCU_GATE_HWS(bus_uart3_clk, "bus-uart3", apb1_hws,
> +			  0x90c, BIT(3), 0);
> +
> +static SUNXI_CCU_GATE_HWS(bus_i2c0_clk, "bus-i2c0", apb1_hws,
> +			  0x91c, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_i2c1_clk, "bus-i2c1", apb1_hws,
> +			  0x91c, BIT(1), 0);
> +static SUNXI_CCU_GATE_HWS(bus_i2c2_clk, "bus-i2c2", apb1_hws,
> +			  0x91c, BIT(2), 0);
> +static SUNXI_CCU_GATE_HWS(bus_i2c3_clk, "bus-i2c3", apb1_hws,
> +			  0x91c, BIT(3), 0);
> +static SUNXI_CCU_GATE_HWS(bus_i2c4_clk, "bus-i2c4", apb1_hws,
> +			  0x91c, BIT(4), 0);
> +
> +static const struct clk_parent_data spi_parents[] =3D {
> +	{ .fw_name =3D "hosc" },
> +	{ .hw =3D &pll_periph_300M_clk.hw, },
> +	{ .hw =3D &pll_periph_200M_clk.hw, },
> +};
> +
> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(spi0_clk, "spi0", spi_parents, 0x=
940,
> +				       0, 4,	/* M */
> +				       8, 2,	/* P */
> +				       24, 3,	/* mux */
> +				       BIT(31),	/* gate */
> +				       0);
> +
> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(spi1_clk, "spi1", spi_parents, 0x=
944,
> +				       0, 4,	/* M */
> +				       8, 2,	/* P */
> +				       24, 3,	/* mux */
> +				       BIT(31),	/* gate */
> +				       0);
> +
> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(spi2_clk, "spi2", spi_parents, 0x=
948,
> +				       0, 4,	/* M */
> +				       8, 2,	/* P */
> +				       24, 3,	/* mux */
> +				       BIT(31),	/* gate */
> +				       0);
> +
> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(spi3_clk, "spi3", spi_parents, 0x=
94c,
> +				       0, 4,	/* M */
> +				       8, 2,	/* P */
> +				       24, 3,	/* mux */
> +				       BIT(31),	/* gate */
> +				       0);
> +
> +static SUNXI_CCU_GATE_HWS(bus_spi0_clk, "bus-spi0", ahb_hws,
> +			  0x96c, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_spi1_clk, "bus-spi1", ahb_hws,
> +			  0x96c, BIT(1), 0);
> +static SUNXI_CCU_GATE_HWS(bus_spi2_clk, "bus-spi2", ahb_hws,
> +			  0x96c, BIT(2), 0);
> +static SUNXI_CCU_GATE_HWS(bus_spi3_clk, "bus-spi3", ahb_hws,
> +			  0x96c, BIT(3), 0);
> +
> +
> +static const struct clk_parent_data spif_parents[] =3D {
> +	{ .fw_name =3D "hosc" },
> +	{ .hw =3D &pll_periph_400M_clk.hw, },
> +	{ .hw =3D &pll_periph_300M_clk.hw, },
> +};
> +
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(spif_clk, "spif", spif_parents, 0x=
0950,
> +				      0, 4,	/* M */
> +				      24, 3,	/* mux */
> +				      BIT(31),	/* gate */
> +				      CLK_SET_RATE_PARENT);

This is MP clock, P being at 9:8.

> +
> +static SUNXI_CCU_GATE_HWS(bus_spif_clk, "bus-spif", ahb_hws,
> +			  0x096c, BIT(4), 0);
> +
> +
> +static const struct clk_hw *pll_periph_150M_hws[] =3D { &pll_periph_150M=
_clk.hw };
> +static SUNXI_CCU_GATE_HWS_WITH_PREDIV(emac_25M_clk, "emac-25M", pll_peri=
ph_150M_hws,
> +				      0x970, BIT(31) | BIT(30), 6, 0);
> +
> +static SUNXI_CCU_GATE_HWS(bus_emac_clk, "bus-emac", ahb_hws,
> +			  0x97c, BIT(0), 0);
> +
> +static SUNXI_CCU_GATE_HWS(bus_gpadc_clk, "bus-gpadc", apb0_hws,
> +			  0x9ec, BIT(0), 0);
> +
> +static SUNXI_CCU_GATE_HWS(bus_ths_clk, "bus-ths", ahb_hws,
> +			  0x9fc, BIT(0), 0);
> +
> +
> +static const struct clk_hw *audio_parents[] =3D {
> +	&pll_audio_1x_clk.common.hw,
> +	&pll_audio_4x_clk.common.hw,
> +};
> +
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(i2s0_clk, "i2s0", audio_parents, 0xa=
10,
> +				    0, 4,	/* M */
> +				    24, 1,	/* mux */
> +				    BIT(31),	/* gate */
> +				    CLK_SET_RATE_PARENT);
> +
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(i2s1_clk, "i2s1", audio_parents, 0xa=
14,
> +				    0, 4,	/* M */
> +				    24, 1,	/* mux */
> +				    BIT(31),	/* gate */
> +				    CLK_SET_RATE_PARENT);
> +
> +static SUNXI_CCU_GATE_HWS(bus_i2s0_clk, "bus-i2s0", ahb_hws,
> +			  0xa20, BIT(0), 0);
> +
> +static SUNXI_CCU_GATE_HWS(bus_i2s1_clk, "bus-i2s1", ahb_hws,
> +			  0xa20, BIT(1), 0);
> +
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(dmic_clk, "dmic", audio_parents, 0xa=
40,
> +				    0, 4,	/* M */
> +				    24, 1,	/* mux */
> +				    BIT(31),	/* gate */
> +				    CLK_SET_RATE_PARENT);
> +
> +static SUNXI_CCU_GATE_HWS(bus_dmic_clk, "bus-dmic", ahb_hws,
> +			  0xa4c, BIT(0), 0);
> +
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(audio_codec_dac_clk, "audio-codec-da=
c",=20
> +				    audio_parents, 0xa50,
> +				    0, 4,	/* M */
> +				    24, 1,	/* mux */
> +				    BIT(31),	/* gate */
> +				    CLK_SET_RATE_PARENT);
> +
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(audio_codec_adc_clk, "audio-codec-ad=
c",=20
> +				    audio_parents, 0xa54,
> +				    0, 4,	/* M */
> +				    24, 1,	/* mux */
> +				    BIT(31),	/* gate */
> +				    CLK_SET_RATE_PARENT);
> +
> +static SUNXI_CCU_GATE_HWS(bus_audio_codec_clk, "bus-audio-codec", apb0_h=
ws,
> +			  0xa5c, BIT(0), 0);
> +
> +/*
> + * There are OHCI 12M clock source selection bits for the USB 2.0 port.
> + * We will force them to 0 (12M divided from 48M).
> + */
> +static CLK_FIXED_FACTOR_FW_NAME(osc12M_clk, "osc12M", "hosc", 2, 1, 0);
> +
> +#define SUN8I_V853_USB_CLK_REG		0xa70
> +
> +static SUNXI_CCU_GATE(usb_ohci_clk, "usb", "osc12M", 0x0a70, BIT(31), 0);
> +
> +static SUNXI_CCU_GATE_HWS(bus_ohci_clk, "bus-ohci", ahb_hws, 0xa8c, BIT(=
0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_ehci_clk, "bus-ehci", ahb_hws, 0xa8c, BIT(=
4), 0);
> +static SUNXI_CCU_GATE_HWS(bus_otg_clk, "bus-otg", ahb_hws, 0xa8c, BIT(8)=
, 0);
> +
> +static SUNXI_CCU_GATE_HWS(bus_dpss_top_clk, "bus-dpss-top", ahb_hws,
> +			  0xabc, BIT(0), 0);
> +
> +
> +static const struct clk_parent_data mipi_dsi_parents[] =3D {
> +	{ .fw_name =3D "hosc" },
> +	{ .hw =3D &pll_periph_200M_clk.hw },
> +	{ .hw =3D &pll_periph_150M_clk.hw },
> +};
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(mipi_dsi_clk, "mipi-dsi", mipi_dsi=
_parents,=20
> +				      0xb24,
> +				      0, 4,	/* M */
> +				      24, 3,	/* mux */
> +				      BIT(31),	/* gate */
> +				      CLK_SET_RATE_PARENT);

CLK_SET_RATE_PARENT doesn't do anything for constant clocks.

Best regards,
Jernej

> +
> +static SUNXI_CCU_GATE_HWS(bus_mipi_dsi_clk, "bus-mipi-dsi", ahb_hws,
> +			  0xb4c, BIT(0), 0);
> +
> +
> +static const struct clk_hw *tcon_lcd_parents[] =3D {
> +	&pll_video_4x_clk.common.hw,
> +	&pll_periph_2x_clk.common.hw,
> +	&pll_csi_4x_clk.common.hw,
> +};
> +static SUNXI_CCU_MP_HW_WITH_MUX_GATE(tcon_lcd_clk, "tcon-lcd", tcon_lcd_=
parents,=20
> +				     0xb60,
> +				     0, 4,	/* M */
> +				     8, 2,	/* P */
> +				     24, 3,	/* mux */
> +				     BIT(31),	/* gate */
> +				     CLK_SET_RATE_PARENT);
> +
> +static SUNXI_CCU_GATE_HWS(bus_tcon_lcd_clk, "bus-tcon-lcd", ahb_hws,
> +			  0xb7c, BIT(0), 0);
> +
> +
> +static const struct clk_hw *csi_top_parents[] =3D {
> +	&pll_periph_300M_clk.hw,
> +	&pll_periph_400M_clk.hw,
> +	&pll_video_4x_clk.common.hw,
> +	&pll_csi_4x_clk.common.hw,
> +};
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(csi_top_clk, "csi-top", csi_top_pare=
nts, 0xc04,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);
> +
> +
> +static const struct clk_parent_data csi_mclk_parents[] =3D {
> +	{ .fw_name =3D "hosc" },
> +	{ .hw =3D &pll_csi_4x_clk.common.hw },
> +	{ .hw =3D &pll_video_4x_clk.common.hw },
> +	{ .hw =3D &pll_periph_2x_clk.common.hw },
> +};
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(csi_mclk0_clk, "csi-mclk0", csi_mc=
lk_parents,=20
> +				      0xc08,
> +				      0, 5,	/* M */
> +				      24, 3,	/* mux */
> +				      BIT(31),	/* gate */
> +				      0);
> +
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(csi_mclk1_clk, "csi-mclk1", csi_mc=
lk_parents,=20
> +				      0xc0c,
> +				      0, 5,	/* M */
> +				      24, 3,	/* mux */
> +				      BIT(31),	/* gate */
> +				      0);
> +
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(csi_mclk2_clk, "csi-mclk2", csi_mc=
lk_parents,=20
> +				      0xc10,
> +				      0, 5,	/* M */
> +				      24, 3,	/* mux */
> +				      BIT(31),	/* gate */
> +				      0);

All CSI mclks should be MP type.

> +
> +static SUNXI_CCU_GATE_HWS(bus_csi_clk, "bus-csi", ahb_hws,
> +			  0xc2c, BIT(0), 0);
> +
> +
> +static SUNXI_CCU_GATE_HWS(bus_wiegand_clk, "bus-wiegand", ahb_hws,
> +			  0xc7c, BIT(0), 0);
> +
> +
> +static const struct clk_parent_data riscv_parents[] =3D {
> +	{ .fw_name =3D "hosc" },
> +	{ .fw_name =3D "losc" },
> +	{ .fw_name =3D "iosc" },
> +	{ .hw =3D &pll_periph_600M_clk.hw },
> +	{ .hw =3D &pll_periph_480M_clk.common.hw },
> +	{ .hw =3D &pll_cpu_clk.common.hw },
> +};
> +static SUNXI_CCU_M_DATA_WITH_MUX(riscv_clk, "riscv-cpu", riscv_parents, =
0xd00,
> +				 0, 5,	/* M */
> +				 24, 3,	/* mux */
> +				 CLK_SET_RATE_PARENT);
> +
> +/* The riscv-axi clk must be divided by at least 2. */
> +static struct clk_div_table riscv_axi_table[] =3D {
> +	{ .val =3D 1, .div =3D 2 },
> +	{ .val =3D 2, .div =3D 3 },
> +	{ .val =3D 3, .div =3D 4 },
> +	{ /* Sentinel */ }
> +};
> +static SUNXI_CCU_DIV_TABLE_HW(riscv_axi_clk, "riscv-axi", &riscv_clk.com=
mon.hw,
> +			      0xd00, 8, 2, riscv_axi_table, 0);
> +
> +static SUNXI_CCU_GATE_HWS_WITH_KEY(riscv_core_gate, "riscv-core-gate", a=
hb_hws,
> +				   0xd04, BIT(0), 0);
> +
> +static SUNXI_CCU_GATE_HWS(riscv_cfg_gate, "riscv-cfg-gate", ahb_hws,
> +			  0xd0c, BIT(0), 0);
> +
> +
> +static const struct clk_hw *pll_periph_160M_hws[] =3D {
> +	&pll_periph_160M_clk.hw,
> +};
> +
> +static SUNXI_CCU_GATE_DATA(fanout_24M_clk, "fanout-24M", osc24M,
> +			   0xf30, BIT(0), 0);
> +static SUNXI_CCU_GATE_DATA_WITH_PREDIV(fanout_12M_clk, "fanout-12M", osc=
24M,
> +				       0xf30, BIT(1), 2, 0);
> +static SUNXI_CCU_GATE_HWS_WITH_PREDIV(fanout_16M_clk, "fanout-16M", pll_=
periph_160M_hws,
> +				      0xf30, BIT(2), 10, 0);
> +static SUNXI_CCU_GATE_HWS_WITH_PREDIV(fanout_25M_clk, "fanout-25M", pll_=
periph_150M_hws,
> +				      0xf30, BIT(3), 6, 0);
> +
> +
> +/* This clock has a second divider that is not modelled and forced to 0.=
 */
> +#define SUN8I_V853_FANOUT_27M_REG	0xf34
> +static const struct clk_hw *fanout_27M_parents[] =3D {
> +	&pll_video_1x_clk.hw,
> +	&pll_csi_clk.hw,
> +	&pll_periph_300M_clk.hw,
> +};
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(fanout_27M_clk, "fanout-27M",=20
> +				    fanout_27M_parents, 0xf34,
> +				    0, 5,	/* M */
> +				    24, 2,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);
> +static SUNXI_CCU_M_HWS_WITH_GATE(fanout_pclk_clk, "fanout-pclk", apb0_hw=
s, 0xf38,
> +				 0, 5,		/* M */
> +				 BIT(31),	/* gate */
> +				 0);
> +
> +static const struct clk_parent_data fanout_parents[] =3D {
> +	{ .fw_name =3D "losc" },
> +	{ .hw =3D &fanout_12M_clk.common.hw },
> +	{ .hw =3D &fanout_16M_clk.common.hw },
> +	{ .hw =3D &fanout_24M_clk.common.hw },
> +	{ .hw =3D &fanout_25M_clk.common.hw },
> +	{ .hw =3D &fanout_27M_clk.common.hw },
> +	{ .hw =3D &fanout_pclk_clk.common.hw },
> +};
> +
> +static SUNXI_CCU_MUX_DATA_WITH_GATE(fanout0_clk, "fanout0", fanout_paren=
ts, 0xf3c,
> +				    0, 3,	/* mux */
> +				    BIT(21),	/* gate */
> +				    0);
> +static SUNXI_CCU_MUX_DATA_WITH_GATE(fanout1_clk, "fanout1", fanout_paren=
ts, 0xf3c,
> +				    3, 3,	/* mux */
> +				    BIT(22),	/* gate */
> +				    0);
> +static SUNXI_CCU_MUX_DATA_WITH_GATE(fanout2_clk, "fanout2", fanout_paren=
ts, 0xf3c,
> +				    6, 3,	/* mux */
> +				    BIT(23),	/* gate */
> +				    0);
> +
> +
> +static struct ccu_common *sun8i_v853_ccu_clks[] =3D {
> +	&pll_cpu_clk.common,
> +	&pll_ddr_clk.common,
> +	&pll_periph_4x_clk.common,
> +	&pll_periph_2x_clk.common,
> +	&pll_periph_800M_clk.common,
> +	&pll_periph_480M_clk.common,
> +	&pll_video_4x_clk.common,
> +	&pll_csi_4x_clk.common,
> +	&pll_audio_div2_clk.common,
> +	&pll_audio_div5_clk.common,
> +	&pll_audio_4x_clk.common,
> +	&pll_audio_1x_clk.common,
> +	&pll_npu_4x_clk.common,
> +	&cpu_clk.common,
> +	&cpu_axi_clk.common,
> +	&cpu_apb_clk.common,
> +	&ahb_clk.common,
> +	&apb0_clk.common,
> +	&apb1_clk.common,
> +	&de_clk.common,
> +	&bus_de_clk.common,
> +	&g2d_clk.common,
> +	&bus_g2d_clk.common,
> +	&ce_clk.common,
> +	&bus_ce_clk.common,
> +	&ve_clk.common,
> +	&bus_ve_clk.common,
> +	&npu_clk.common,
> +	&bus_npu_clk.common,
> +	&bus_dma_clk.common,
> +	&bus_msgbox0_clk.common,
> +	&bus_msgbox1_clk.common,
> +	&bus_spinlock_clk.common,
> +	&bus_hstimer_clk.common,
> +	&avs_clk.common,
> +	&bus_dbg_clk.common,
> +	&bus_pwm_clk.common,
> +	&bus_iommu_clk.common,
> +	&dram_clk.common,
> +	&mbus_dma_clk.common,
> +	&mbus_ve_clk.common,
> +	&mbus_ce_clk.common,
> +	&mbus_csi_clk.common,
> +	&mbus_isp_clk.common,
> +	&mbus_g2d_clk.common,
> +	&bus_dram_clk.common,
> +	&mmc0_clk.common,
> +	&mmc1_clk.common,
> +	&mmc2_clk.common,
> +	&bus_mmc0_clk.common,
> +	&bus_mmc1_clk.common,
> +	&bus_mmc2_clk.common,
> +	&bus_uart0_clk.common,
> +	&bus_uart1_clk.common,
> +	&bus_uart2_clk.common,
> +	&bus_uart3_clk.common,
> +	&bus_i2c0_clk.common,
> +	&bus_i2c1_clk.common,
> +	&bus_i2c2_clk.common,
> +	&bus_i2c3_clk.common,
> +	&bus_i2c4_clk.common,
> +	&spi0_clk.common,
> +	&spi1_clk.common,
> +	&spi2_clk.common,
> +	&spi3_clk.common,
> +	&bus_spi0_clk.common,
> +	&bus_spi1_clk.common,
> +	&bus_spi2_clk.common,
> +	&bus_spi3_clk.common,
> +	&spif_clk.common,
> +	&bus_spif_clk.common,
> +	&emac_25M_clk.common,
> +	&bus_emac_clk.common,
> +	&bus_gpadc_clk.common,
> +	&bus_ths_clk.common,
> +	&usb_ohci_clk.common,
> +	&bus_ohci_clk.common,
> +	&bus_ehci_clk.common,
> +	&bus_otg_clk.common,
> +	&i2s0_clk.common,
> +	&i2s1_clk.common,
> +	&bus_i2s0_clk.common,
> +	&bus_i2s1_clk.common,
> +	&dmic_clk.common,
> +	&bus_dmic_clk.common,
> +	&audio_codec_dac_clk.common,
> +	&audio_codec_adc_clk.common,
> +	&bus_audio_codec_clk.common,
> +	&bus_dpss_top_clk.common,
> +	&mipi_dsi_clk.common,
> +	&bus_mipi_dsi_clk.common,
> +	&tcon_lcd_clk.common,
> +	&bus_tcon_lcd_clk.common,
> +	&csi_top_clk.common,
> +	&csi_mclk0_clk.common,
> +	&csi_mclk1_clk.common,
> +	&csi_mclk2_clk.common,
> +	&bus_csi_clk.common,
> +	&bus_wiegand_clk.common,
> +	&riscv_clk.common,
> +	&riscv_axi_clk.common,
> +	&riscv_core_gate.common,
> +	&riscv_cfg_gate.common,
> +	&fanout_24M_clk.common,
> +	&fanout_12M_clk.common,
> +	&fanout_16M_clk.common,
> +	&fanout_25M_clk.common,
> +	&fanout_27M_clk.common,
> +	&fanout_pclk_clk.common,
> +	&fanout0_clk.common,
> +	&fanout1_clk.common,
> +	&fanout2_clk.common,
> +};
> +
> +static struct clk_hw_onecell_data sun8i_v853_hw_clks =3D {
> +	.num	=3D CLK_NUMBER,
> +	.hws	=3D {
> +		[CLK_OSC12M]            =3D &osc12M_clk.hw,
> +		[CLK_PLL_CPU]		=3D &pll_cpu_clk.common.hw,
> +		[CLK_PLL_DDR]		=3D &pll_ddr_clk.common.hw,
> +		[CLK_PLL_PERIPH_4X]	=3D &pll_periph_4x_clk.common.hw,
> +		[CLK_PLL_PERIPH_2X]	=3D &pll_periph_2x_clk.common.hw,
> +		[CLK_PLL_PERIPH_800M]	=3D &pll_periph_800M_clk.common.hw,
> +		[CLK_PLL_PERIPH_480M]	=3D &pll_periph_480M_clk.common.hw,
> +		[CLK_PLL_PERIPH_600M]	=3D &pll_periph_600M_clk.hw,
> +		[CLK_PLL_PERIPH_400M]	=3D &pll_periph_400M_clk.hw,
> +		[CLK_PLL_PERIPH_300M]	=3D &pll_periph_300M_clk.hw,
> +		[CLK_PLL_PERIPH_200M]	=3D &pll_periph_200M_clk.hw,
> +		[CLK_PLL_PERIPH_160M]	=3D &pll_periph_160M_clk.hw,
> +		[CLK_PLL_PERIPH_150M]	=3D &pll_periph_150M_clk.hw,
> +		[CLK_PLL_VIDEO_4X]	=3D &pll_video_4x_clk.common.hw,
> +		[CLK_PLL_VIDEO_2X]	=3D &pll_video_2x_clk.hw,
> +		[CLK_PLL_VIDEO_1X]	=3D &pll_video_1x_clk.hw,
> +		[CLK_PLL_CSI_4X]	=3D &pll_csi_4x_clk.common.hw,
> +		[CLK_PLL_AUDIO_DIV2]	=3D &pll_audio_div2_clk.common.hw,
> +		[CLK_PLL_AUDIO_DIV5]	=3D &pll_audio_div5_clk.common.hw,
> +		[CLK_PLL_AUDIO_4X]	=3D &pll_audio_4x_clk.common.hw,
> +		[CLK_PLL_AUDIO_1X]	=3D &pll_audio_1x_clk.common.hw,
> +		[CLK_PLL_NPU_4X]	=3D &pll_npu_4x_clk.common.hw,
> +		[CLK_CPU]		=3D &cpu_clk.common.hw,
> +		[CLK_CPU_AXI]		=3D &cpu_axi_clk.common.hw,
> +		[CLK_CPU_APB]		=3D &cpu_apb_clk.common.hw,
> +		[CLK_AHB]		=3D &ahb_clk.common.hw,
> +		[CLK_APB0]		=3D &apb0_clk.common.hw,
> +		[CLK_APB1]		=3D &apb1_clk.common.hw,
> +		[CLK_MBUS]		=3D &mbus_clk.hw,
> +		[CLK_DE]		=3D &de_clk.common.hw,
> +		[CLK_BUS_DE]		=3D &bus_de_clk.common.hw,
> +		[CLK_G2D]		=3D &g2d_clk.common.hw,
> +		[CLK_BUS_G2D]		=3D &bus_g2d_clk.common.hw,
> +		[CLK_CE]		=3D &ce_clk.common.hw,
> +		[CLK_BUS_CE]		=3D &bus_ce_clk.common.hw,
> +		[CLK_VE]		=3D &ve_clk.common.hw,
> +		[CLK_BUS_VE]		=3D &bus_ve_clk.common.hw,
> +		[CLK_NPU]		=3D &npu_clk.common.hw,
> +		[CLK_BUS_NPU]		=3D &bus_npu_clk.common.hw,
> +		[CLK_BUS_DMA]		=3D &bus_dma_clk.common.hw,
> +		[CLK_BUS_MSGBOX0]	=3D &bus_msgbox0_clk.common.hw,
> +		[CLK_BUS_MSGBOX1]	=3D &bus_msgbox1_clk.common.hw,
> +		[CLK_BUS_SPINLOCK]	=3D &bus_spinlock_clk.common.hw,
> +		[CLK_BUS_HSTIMER]	=3D &bus_hstimer_clk.common.hw,
> +		[CLK_AVS]		=3D &avs_clk.common.hw,
> +		[CLK_BUS_DBG]		=3D &bus_dbg_clk.common.hw,
> +		[CLK_BUS_PWM]		=3D &bus_pwm_clk.common.hw,
> +		[CLK_BUS_IOMMU]		=3D &bus_iommu_clk.common.hw,
> +		[CLK_DRAM]		=3D &dram_clk.common.hw,
> +		[CLK_MBUS_DMA]		=3D &mbus_dma_clk.common.hw,
> +		[CLK_MBUS_VE]		=3D &mbus_ve_clk.common.hw,
> +		[CLK_MBUS_CE]		=3D &mbus_ce_clk.common.hw,
> +		[CLK_MBUS_CSI]		=3D &mbus_csi_clk.common.hw,
> +		[CLK_MBUS_ISP]		=3D &mbus_isp_clk.common.hw,
> +		[CLK_MBUS_G2D]		=3D &mbus_g2d_clk.common.hw,
> +		[CLK_BUS_DRAM]		=3D &bus_dram_clk.common.hw,
> +		[CLK_MMC0]		=3D &mmc0_clk.common.hw,
> +		[CLK_MMC1]		=3D &mmc1_clk.common.hw,
> +		[CLK_MMC2]		=3D &mmc2_clk.common.hw,
> +		[CLK_BUS_MMC0]		=3D &bus_mmc0_clk.common.hw,
> +		[CLK_BUS_MMC1]		=3D &bus_mmc1_clk.common.hw,
> +		[CLK_BUS_MMC2]		=3D &bus_mmc2_clk.common.hw,
> +		[CLK_BUS_UART0]		=3D &bus_uart0_clk.common.hw,
> +		[CLK_BUS_UART1]		=3D &bus_uart1_clk.common.hw,
> +		[CLK_BUS_UART2]		=3D &bus_uart2_clk.common.hw,
> +		[CLK_BUS_UART3]		=3D &bus_uart3_clk.common.hw,
> +		[CLK_BUS_I2C0]		=3D &bus_i2c0_clk.common.hw,
> +		[CLK_BUS_I2C1]		=3D &bus_i2c1_clk.common.hw,
> +		[CLK_BUS_I2C2]		=3D &bus_i2c2_clk.common.hw,
> +		[CLK_BUS_I2C3]		=3D &bus_i2c3_clk.common.hw,
> +		[CLK_BUS_I2C4]		=3D &bus_i2c4_clk.common.hw,
> +		[CLK_SPI0]		=3D &spi0_clk.common.hw,
> +		[CLK_SPI1]		=3D &spi1_clk.common.hw,
> +		[CLK_SPI2]		=3D &spi2_clk.common.hw,
> +		[CLK_SPI3]		=3D &spi3_clk.common.hw,
> +		[CLK_BUS_SPI0]		=3D &bus_spi0_clk.common.hw,
> +		[CLK_BUS_SPI1]		=3D &bus_spi1_clk.common.hw,
> +		[CLK_BUS_SPI2]		=3D &bus_spi2_clk.common.hw,
> +		[CLK_BUS_SPI3]		=3D &bus_spi3_clk.common.hw,
> +		[CLK_SPIF]		=3D &spif_clk.common.hw,
> +		[CLK_BUS_SPIF]		=3D &bus_spif_clk.common.hw,
> +		[CLK_EMAC_25M]		=3D &emac_25M_clk.common.hw,
> +		[CLK_BUS_EMAC]		=3D &bus_emac_clk.common.hw,
> +		[CLK_BUS_GPADC]		=3D &bus_gpadc_clk.common.hw,
> +		[CLK_BUS_THS]		=3D &bus_ths_clk.common.hw,
> +		[CLK_I2S0]		=3D &i2s0_clk.common.hw,
> +		[CLK_I2S1]		=3D &i2s1_clk.common.hw,
> +		[CLK_BUS_I2S0]		=3D &bus_i2s0_clk.common.hw,
> +		[CLK_BUS_I2S1]		=3D &bus_i2s1_clk.common.hw,
> +		[CLK_DMIC]		=3D &dmic_clk.common.hw,
> +		[CLK_BUS_DMIC]		=3D &bus_dmic_clk.common.hw,
> +		[CLK_AUDIO_CODEC_DAC]	=3D &audio_codec_dac_clk.common.hw,
> +		[CLK_AUDIO_CODEC_ADC]	=3D &audio_codec_adc_clk.common.hw,
> +		[CLK_BUS_AUDIO_CODEC]	=3D &bus_audio_codec_clk.common.hw,
> +		[CLK_USB_OHCI]		=3D &usb_ohci_clk.common.hw,
> +		[CLK_BUS_OHCI]		=3D &bus_ohci_clk.common.hw,
> +		[CLK_BUS_EHCI]		=3D &bus_ehci_clk.common.hw,
> +		[CLK_BUS_OTG]		=3D &bus_otg_clk.common.hw,
> +		[CLK_BUS_DPSS_TOP]	=3D &bus_dpss_top_clk.common.hw,
> +		[CLK_MIPI_DSI]		=3D &mipi_dsi_clk.common.hw,
> +		[CLK_BUS_MIPI_DSI]	=3D &bus_mipi_dsi_clk.common.hw,
> +		[CLK_TCON_LCD]		=3D &tcon_lcd_clk.common.hw,
> +		[CLK_BUS_TCON_LCD]	=3D &bus_tcon_lcd_clk.common.hw,
> +		[CLK_CSI_TOP]		=3D &csi_top_clk.common.hw,
> +		[CLK_CSI_MCLK0]		=3D &csi_mclk0_clk.common.hw,
> +		[CLK_CSI_MCLK1]		=3D &csi_mclk1_clk.common.hw,
> +		[CLK_CSI_MCLK2]		=3D &csi_mclk2_clk.common.hw,
> +		[CLK_BUS_CSI]		=3D &bus_csi_clk.common.hw,
> +		[CLK_BUS_WIEGAND]	=3D &bus_wiegand_clk.common.hw,
> +		[CLK_RISCV]		=3D &riscv_clk.common.hw,
> +		[CLK_RISCV_AXI]		=3D &riscv_axi_clk.common.hw,
> +		[CLK_RISCV_CORE_GATE]   =3D &riscv_core_gate.common.hw,
> +		[CLK_RISCV_CFG_GATE]    =3D &riscv_cfg_gate.common.hw,
> +		[CLK_FANOUT_24M]	=3D &fanout_24M_clk.common.hw,
> +		[CLK_FANOUT_16M]	=3D &fanout_16M_clk.common.hw,
> +		[CLK_FANOUT_12M]	=3D &fanout_12M_clk.common.hw,
> +		[CLK_FANOUT_25M]	=3D &fanout_25M_clk.common.hw,
> +		[CLK_FANOUT_27M]	=3D &fanout_27M_clk.common.hw,
> +		[CLK_FANOUT_PCLK]	=3D &fanout_pclk_clk.common.hw,
> +		[CLK_FANOUT0]		=3D &fanout0_clk.common.hw,
> +		[CLK_FANOUT1]		=3D &fanout1_clk.common.hw,
> +		[CLK_FANOUT2]		=3D &fanout2_clk.common.hw,
> +	},
> +};
> +
> +static struct ccu_reset_map sun8i_v853_ccu_resets[] =3D {
> +	[RST_MBUS]		=3D { 0x540, BIT(30) },
> +	[RST_BUS_DE]		=3D { 0x60c, BIT(16) },
> +	[RST_BUS_G2D]		=3D { 0x63c, BIT(16) },
> +	[RST_BUS_CE]		=3D { 0x68c, BIT(16) | BIT(17)},
> +	[RST_BUS_VE]		=3D { 0x69c, BIT(16) },
> +	[RST_BUS_NPU]		=3D { 0x6ec, BIT(16) },
> +	[RST_BUS_DMA]		=3D { 0x70c, BIT(16) },
> +	[RST_BUS_MSGBOX0]	=3D { 0x71c, BIT(16) },
> +	[RST_BUS_MSGBOX1]	=3D { 0x71c, BIT(17) },
> +	[RST_BUS_SPINLOCK]	=3D { 0x72c, BIT(16) },
> +	[RST_BUS_HSTIMER]	=3D { 0x73c, BIT(16) },
> +	[RST_BUS_DBG]		=3D { 0x78c, BIT(16) },
> +	[RST_BUS_PWM]		=3D { 0x7ac, BIT(16) },
> +	[RST_BUS_DRAM]		=3D { 0x80c, BIT(16) },
> +	[RST_BUS_MMC0]		=3D { 0x84c, BIT(16) },
> +	[RST_BUS_MMC1]		=3D { 0x84c, BIT(17) },
> +	[RST_BUS_MMC2]		=3D { 0x84c, BIT(18) },
> +	[RST_BUS_UART0]		=3D { 0x90c, BIT(16) },
> +	[RST_BUS_UART1]		=3D { 0x90c, BIT(17) },
> +	[RST_BUS_UART2]		=3D { 0x90c, BIT(18) },
> +	[RST_BUS_UART3]		=3D { 0x90c, BIT(19) },
> +	[RST_BUS_I2C0]		=3D { 0x91c, BIT(16) },
> +	[RST_BUS_I2C1]		=3D { 0x91c, BIT(17) },
> +	[RST_BUS_I2C2]		=3D { 0x91c, BIT(18) },
> +	[RST_BUS_I2C3]		=3D { 0x91c, BIT(19) },
> +	[RST_BUS_I2C4]		=3D { 0x91c, BIT(20) },
> +	[RST_BUS_SPI0]		=3D { 0x96c, BIT(16) },
> +	[RST_BUS_SPI1]		=3D { 0x96c, BIT(17) },
> +	[RST_BUS_SPI2]		=3D { 0x96c, BIT(18) },
> +	[RST_BUS_SPI3]		=3D { 0x96c, BIT(19) },
> +	[RST_BUS_SPIF]		=3D { 0x96c, BIT(20) },
> +	[RST_BUS_EMAC]		=3D { 0x97c, BIT(16) },
> +	[RST_BUS_GPADC]		=3D { 0x9ec, BIT(16) },
> +	[RST_BUS_THS]		=3D { 0x9fc, BIT(16) },
> +	[RST_BUS_I2S0]		=3D { 0xa20, BIT(16) },
> +	[RST_BUS_I2S1]		=3D { 0xa20, BIT(17) },
> +	[RST_BUS_DMIC]		=3D { 0xa4c, BIT(16) },
> +	[RST_BUS_AUDIO_CODEC]	=3D { 0xa5c, BIT(16) },
> +	[RST_USB_PHY]		=3D { 0xa70, BIT(30) },
> +	[RST_BUS_OHCI]		=3D { 0xa8c, BIT(16) },
> +	[RST_BUS_EHCI]		=3D { 0xa8c, BIT(20) },
> +	[RST_BUS_OTG]		=3D { 0xa8c, BIT(24) },
> +	[RST_BUS_DPSS_TOP]	=3D { 0xabc, BIT(16) },
> +	[RST_BUS_MIPI_DSI]	=3D { 0xb4c, BIT(16) },
> +	[RST_BUS_TCON_LCD]	=3D { 0xb7c, BIT(16) },
> +	[RST_BUS_CSI]		=3D { 0xc2c, BIT(16) },
> +	[RST_BUS_WIEGAND]	=3D { 0xc7c, BIT(16) },
> +	[RST_RISCV_SYS_APB]	=3D { 0xd04, BIT(2), CCU_FEATURE_KEY_FIELD },
> +	[RST_RISCV_SOFT]	=3D { 0xd04, BIT(1), CCU_FEATURE_KEY_FIELD },
> +	[RST_RISCV_CFG]		=3D { 0xd0c, BIT(16) }
> +};
> +
> +static const struct sunxi_ccu_desc sun8i_v853_ccu_desc =3D {
> +	.ccu_clks	=3D sun8i_v853_ccu_clks,
> +	.num_ccu_clks	=3D ARRAY_SIZE(sun8i_v853_ccu_clks),
> +
> +	.hw_clks	=3D &sun8i_v853_hw_clks,
> +
> +	.resets		=3D sun8i_v853_ccu_resets,
> +	.num_resets	=3D ARRAY_SIZE(sun8i_v853_ccu_resets),
> +};
> +
> +static const u32 pll_regs[] =3D {
> +	SUN8I_V853_PLL_CPU_REG,
> +	SUN8I_V853_PLL_DDR_REG,
> +	SUN8I_V853_PLL_PERIPH_REG,
> +	SUN8I_V853_PLL_VIDEO_REG,
> +	SUN8I_V853_PLL_CSI_REG,
> +	SUN8I_V853_PLL_AUDIO_REG,
> +	SUN8I_V853_PLL_NPU_REG,
> +};
> +
> +static int sun8i_v853_ccu_probe(struct platform_device *pdev)
> +{
> +	void __iomem *reg;
> +	u32 val;
> +	int i, ret;
> +
> +	reg =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(reg))
> +		return PTR_ERR(reg);
> +
> +	/* Enable the enable, LDO, and lock bits on all PLLs. */
> +	for (i =3D 0; i < ARRAY_SIZE(pll_regs); i++) {
> +		val =3D readl(reg + pll_regs[i]);
> +		val |=3D BIT(31) | BIT(30) | BIT(29);
> +		writel(val, reg + pll_regs[i]);
> +	}
> +
> +	/* Force PLL_CPU factor M to 0. */
> +	val =3D readl(reg + SUN8I_V853_PLL_CPU_REG);
> +	val &=3D ~GENMASK(1, 0);
> +	writel(val, reg + SUN8I_V853_PLL_CPU_REG);
> +
> +	/*
> +	 * Force OHCI 12M clock source to 00 (12MHz divided from 48MHz)
> +	 *
> +	 * This clock mux is still mysterious, and the code just enforces
> +	 * it to have a valid clock parent.
> +	 */
> +	val =3D readl(reg + SUN8I_V853_USB_CLK_REG);
> +	val &=3D ~GENMASK(25, 24);
> +	writel(val, reg + SUN8I_V853_USB_CLK_REG);
> +
> +	/* Force fanout-27M factor N to 0. */
> +	val =3D readl(reg + SUN8I_V853_FANOUT_27M_REG);
> +	val &=3D ~GENMASK(9, 8);
> +	writel(val, reg + SUN8I_V853_FANOUT_27M_REG);
> +
> +	ret =3D devm_sunxi_ccu_probe(&pdev->dev, reg, &sun8i_v853_ccu_desc);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sun8i_v853_ccu_ids[] =3D {
> +	{ .compatible =3D "allwinner,sun8i-v853-ccu" },
> +	{ }
> +};
> +
> +static struct platform_driver sun8i_v853_ccu_driver =3D {
> +	.probe	=3D sun8i_v853_ccu_probe,
> +	.driver	=3D {
> +		.name			=3D "sun8i-v853-ccu",
> +		.suppress_bind_attrs	=3D true,
> +		.of_match_table		=3D sun8i_v853_ccu_ids,
> +	},
> +};
> +module_platform_driver(sun8i_v853_ccu_driver);
> +
> +MODULE_IMPORT_NS("SUNXI_CCU");
> +MODULE_DESCRIPTION("Support for the Allwinner V853 CCU");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v853.h b/drivers/clk/sunxi-ng=
/ccu-sun8i-v853.h
> new file mode 100644
> index 000000000000..f1b2a4d0bcd3
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-v853.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2024 Andras Szemzo <szemzo.andras@gmail.com>
> + */
> +
> +#ifndef _CCU_SUN8I_V853_H_
> +#define _CCU_SUN8I_V853_H_
> +
> +#include <dt-bindings/clock/allwinner,sun8i-v853-ccu.h>
> +#include <dt-bindings/reset/allwinner,sun8i-v853-ccu.h>
> +
> +#define CLK_NUMBER		(CLK_FANOUT2 + 1)
> +
> +#endif
>=20





