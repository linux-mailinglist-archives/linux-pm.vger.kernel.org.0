Return-Path: <linux-pm+bounces-23136-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A04AAA48AFC
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 23:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 327957A61E8
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 21:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D4B271821;
	Thu, 27 Feb 2025 22:00:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94D32702D7;
	Thu, 27 Feb 2025 21:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740693606; cv=none; b=A/uoztrbNP0bUdvTnTq85bE3TNKcFuVkYIriHyKWbGXWrad9fJKHQQrSSfBjl4buhZJrgrR33bJoJscLH5fDL//JOuX0zSeqEmqBHACNMBL4rnkHoxGPIvbfcrRJ0F2y4VCwMCLPtevZqGm/EeveRULP3IWIpBYTKiBiZrz8i6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740693606; c=relaxed/simple;
	bh=CgxQyljhqVTXpgSL0JHUD5jTBBLWxifnrh+FlSuppPo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pfZ8eSp7Vt9YW6zy80ieyYiVhWN6lWQX7dhWbMRCev48h+mKZjt9WyAP/ytGF/hOfLFsdpayhDII7ZWhm3GDov/m+qW2h29dMyPR6EjirKsEi3okuCYVU+eSE5/qBO39XFhTATpojR5KMdRedAidnI4jeRAkq26cFv7uo7lh0Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BD021516;
	Thu, 27 Feb 2025 14:00:14 -0800 (PST)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A6013F5A1;
	Thu, 27 Feb 2025 13:59:55 -0800 (PST)
Date: Thu, 27 Feb 2025 21:57:32 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Andras Szemzo <szemzo.andras@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Linus Walleij <linus.walleij@linaro.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Maxime Ripard <mripard@kernel.org>, Vinod
 Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Ulf
 Hansson <ulf.hansson@linaro.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>, Florian
 Fainelli <florian.fainelli@broadcom.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-gpio@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 02/10] pinctrl: sunxi: add driver for Allwinner V853
Message-ID: <20250227215732.5f5753d9@minigeek.lan>
In-Reply-To: <20250205125225.1152849-3-szemzo.andras@gmail.com>
References: <20250205125225.1152849-1-szemzo.andras@gmail.com>
	<20250205125225.1152849-3-szemzo.andras@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Feb 2025 13:52:17 +0100
Andras Szemzo <szemzo.andras@gmail.com> wrote:

Hi,

> The V853 family has multiple package variants, from BGA to QFN88.
> The latter has co-packaged DRAM and fewer pins, and less features (pin muxes).
> All family members can be supported by a single driver, as the available pins
> with allowed muxes is the same across the devices.
> 
> This new pinctrl driver depends on the new sunxi device-tree based mux support
> patch series [1].
> 
> [1]: https://lore.kernel.org/linux-sunxi/20241111005750.13071-1-andre.przywara@arm.com/T/
> 
> Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com>
> ---
>  drivers/pinctrl/sunxi/Kconfig              |  5 ++
>  drivers/pinctrl/sunxi/Makefile             |  1 +
>  drivers/pinctrl/sunxi/pinctrl-sun8i-v853.c | 53 ++++++++++++++++++++++
>  3 files changed, 59 insertions(+)
>  create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun8i-v853.c
> 
> diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
> index a78fdbbdfc0c..fac9c61039e2 100644
> --- a/drivers/pinctrl/sunxi/Kconfig
> +++ b/drivers/pinctrl/sunxi/Kconfig
> @@ -81,6 +81,11 @@ config PINCTRL_SUN9I_A80_R
>  	default MACH_SUN9I
>  	select PINCTRL_SUNXI
>  
> +config PINCTRL_SUN8I_V853
> +	bool "Support for the Allwinner V853/V851S/V851SE PIO"
> +	default MACH_SUN8I
> +	select PINCTRL_SUNXI
> +
>  config PINCTRL_SUN20I_D1
>  	bool "Support for the Allwinner D1 PIO"
>  	default MACH_SUN8I || (RISCV && ARCH_SUNXI)
> diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
> index 2ff5a55927ad..8937b56b2ef4 100644
> --- a/drivers/pinctrl/sunxi/Makefile
> +++ b/drivers/pinctrl/sunxi/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_PINCTRL_SUN8I_A83T_R)	+= pinctrl-sun8i-a83t-r.o
>  obj-$(CONFIG_PINCTRL_SUN8I_H3)		+= pinctrl-sun8i-h3.o
>  obj-$(CONFIG_PINCTRL_SUN8I_H3_R)	+= pinctrl-sun8i-h3-r.o
>  obj-$(CONFIG_PINCTRL_SUN8I_V3S)		+= pinctrl-sun8i-v3s.o
> +obj-$(CONFIG_PINCTRL_SUN8I_V853)	+= pinctrl-sun8i-v853.o
>  obj-$(CONFIG_PINCTRL_SUN20I_D1)		+= pinctrl-sun20i-d1.o
>  obj-$(CONFIG_PINCTRL_SUN50I_H5)		+= pinctrl-sun50i-h5.o
>  obj-$(CONFIG_PINCTRL_SUN50I_H6)		+= pinctrl-sun50i-h6.o
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-v853.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-v853.c
> new file mode 100644
> index 000000000000..fb2112ee12d0
> --- /dev/null
> +++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-v853.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Allwinner V853 SoC pinctrl driver.
> + *
> + * Copyright (c) 2025 Andras Szemzo <szemzo.andras@gmail.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/pinctrl/pinctrl.h>
> +
> +#include "pinctrl-sunxi.h"
> +
> +static const u8 v853_nr_bank_pins[SUNXI_PINCTRL_MAX_BANKS] =
> +/*	  PA  PB  PC  PD  PE  PF  PG  PH  PI  */
> +	{ 22,  0, 12, 23, 18,  7,  8, 16,  5 };
> +
> +static const unsigned int v853_irq_bank_map[] = { 0, 2, 3, 4, 5, 6, 7, 8 };
> +
> +static const u8 v853_irq_bank_muxes[SUNXI_PINCTRL_MAX_BANKS] =
> +/*	  PA  PB  PC  PD  PE  PF  PG  PH  PI */
> +	{ 14,  0, 14, 14, 14, 14, 14, 14, 14 };
> +
> +static struct sunxi_pinctrl_desc v853_pinctrl_data = {
> +	.irq_banks = ARRAY_SIZE(v853_irq_bank_map),
> +	.irq_bank_map = v853_irq_bank_map,
> +	.io_bias_cfg_variant = BIAS_VOLTAGE_PIO_POW_MODE_SEL,
> +};
> +
> +static int v853_pinctrl_probe(struct platform_device *pdev)
> +{
> +	return sunxi_pinctrl_dt_table_init(pdev, v853_nr_bank_pins,
> +					   v853_irq_bank_muxes,
> +					   &v853_pinctrl_data,
> +					   SUNXI_PINCTRL_NEW_REG_LAYOUT |
> +					   SUNXI_PINCTRL_ELEVEN_BANKS);

This last flag doesn't apply: it would put the offset for the
POW_MOD_SEL registers at 0x380, but the manual says it's 0x340, as with
the previous SoCs.
I compared the rest against the A523 driver, and the V853 specific bits
against the manual: they match, so with that line removed:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> +}
> +
> +static const struct of_device_id v853_pinctrl_match[] = {
> +	{ .compatible = "allwinner,sun8i-v853-pinctrl", },
> +	{}
> +};
> +
> +static struct platform_driver v853_pinctrl_driver = {
> +	.probe	= v853_pinctrl_probe,
> +	.driver	= {
> +		.name		= "sun8i-v853-pinctrl",
> +		.of_match_table	= v853_pinctrl_match,
> +	},
> +};
> +builtin_platform_driver(v853_pinctrl_driver);


