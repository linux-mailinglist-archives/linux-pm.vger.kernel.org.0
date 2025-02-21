Return-Path: <linux-pm+bounces-22685-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A29A3FE6C
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 19:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21113168504
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 18:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB3C2512C3;
	Fri, 21 Feb 2025 18:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GV5rLdxj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3B924CEEE;
	Fri, 21 Feb 2025 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740161439; cv=none; b=CDIrc6eGHW5DULCM4XgnDDwSzfGHUX1WOBzCNFn8keGf9qZoo7WBgCY80PXIxN+ilOE0V77C3PxKz0zr4UHPinJZzwJyYOhfij6pFrksMU5yIz9I/CzyjaCD10BDaEnm+01wvJIM0Of4nAQTMpf9b5Y4UMof/KyvBt9w8Lfw5Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740161439; c=relaxed/simple;
	bh=+ZcMHBnhhXNPVn7E4e8zJcbGPO7AXLILZay5s+xm/Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qHLDxIDwNdmRM7TWzFLtL90j3lnNzDwVcLSInsFAh+AiqA2hJ70tFz0UMvoqZW8F54/8h6W3wXxLBr4o5J4WoLzfLpYRrbBjkrBa/gTkeRfm0j0gSTyxUHxxhu0+nUAjaeEcd/1SiQTDdSM7+E2l0+751bsn6wz7Z1YN5ami+cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GV5rLdxj; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so16381765e9.0;
        Fri, 21 Feb 2025 10:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740161435; x=1740766235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0r6iIPJ09XHFsPRsV0r11bvmeugmZ8633Hc5QQfZDM=;
        b=GV5rLdxjPF3CUwPA/QReRKoU9/f3+0gB0TX2NytbE6BMtPDNGCr7ZSe8QKrH5NDq//
         Bd6crwVR8+JuliWXNBUEMgYyhjnUSgjetp6vdiEzVZlVC7r3q4cUs1cSwDr7/DnBOc8I
         zpRmfLnqvzYdBtXXu5pGV0ELfiDtZE3zoBen58iBo4xCDf1KJiZTr7vYgBRzG48l+fpx
         rzxR0X8L8tkjir1Ol7bMGZ9TUD7ux1D0ulQ1dtxMt0cJofkXCar8Rfi1dJyFST/D+xOf
         1F6aqHgHm1y38DADopHhBlO2Fv6RDpxcv+FGg2yTo3wwRbdAITnU9JDzOt883RXkSUpx
         z1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740161435; x=1740766235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0r6iIPJ09XHFsPRsV0r11bvmeugmZ8633Hc5QQfZDM=;
        b=bDR9a9JtXt+rYPpgh2L9IsErTmjuXRkrUngqkdvxYTM36BHVhqjAgS1G7h/jb5r2An
         qKjmJx91baPTn7iC/CtTw4Hgivo8niUx8wZq0hfKGPzgkckbnjGYA7iBlNW13w+svHQ3
         ul/G6wPWWSNIost0OKQki8AJdOUDfdT4DhR5jvbYyudawI8xO9W0EIjZfer91hRS9oLz
         JRhwa0rAKfG9yBjSke+40IQsKv7FgbI2Vt6KkrECo9LQrQGuHIiKnfrAiO6FaDkoAHwd
         H1sSpWg97A3so8MJzuEvWQUL/K58hk3c0A4h6PPhjfbKe3EdkeKpNp/L4tUPjprEB46s
         +BvA==
X-Forwarded-Encrypted: i=1; AJvYcCW8wj9a36wCa31iBI6Ei2+jBkWZxdJzSKj0BMwJVjhN6SoF8hfdiSjs5g7Q4zN6AbCSGt3vwFKkK38=@vger.kernel.org, AJvYcCXgZRoIPhVZlGx8h32OWOF1qS1NcF0gr1GCktO35nW90hFokieNVwLsWBHJ1SzToTtaS5lAwEM/m9lh@vger.kernel.org
X-Gm-Message-State: AOJu0YyCZKXIR+BHSs3n0tSXViXc4BYDCg/r6dhRgS2tF5T2wo/lvqJB
	vWanF0eXj/3BWjhtrJFCEN449lrkNKTeLohTt1iN2EoZTnFxPamh
X-Gm-Gg: ASbGncu4Q+HaaG4R3MLJHhYLTOb0r/rOFs/1krNdeSIo6i8QTzdGHv4pmchv/+6KFuF
	kLTXfi3/dsEOXGLmPJiIO5XKNQiA+gzFGLD8cCMMXqfNPLQvql5l5BSipkamb+wFMGQ/6HBXnN6
	HwFcs/GdQtuLnFTsY9kUV4PrP1bLwx/Sbi7yCFQ97w5iSrG4k3+lAHtPQHCvuisPEHDZMO38Wri
	hFb8rzbMxSunM/HLqhvGYIqagO9FD5GAUt1esTLBNw+f1j4SBCDk7Wzbh6zHWixQzydomO2GoS1
	OyAJqCO6pw3cwFHZVIxdt2soam20KCuBsg0d0VSLru3O8r6vy8eDoKndF6PbsypOYbGHznfvto8
	kVQ==
X-Google-Smtp-Source: AGHT+IExFiU5Xc+fGk11eNldRJ1AiPN0u+agLLJYUKrZV6ShEZz487T/k3atzV3etCUhpG4ayKUuWw==
X-Received: by 2002:a05:600c:1906:b0:439:9c0e:3709 with SMTP id 5b1f17b1804b1-439aeafab74mr29474155e9.8.1740161434935;
        Fri, 21 Feb 2025 10:10:34 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02d684dsm24494145e9.16.2025.02.21.10.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 10:10:34 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Andre Przywara <andre.przywara@arm.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/5] pmdomain: sunxi: add H6 PRCM PPU driver
Date: Fri, 21 Feb 2025 19:10:33 +0100
Message-ID: <4987742.31r3eYUQgx@jernej-laptop>
In-Reply-To: <20250221005802.11001-3-andre.przywara@arm.com>
References:
 <20250221005802.11001-1-andre.przywara@arm.com>
 <20250221005802.11001-3-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne petek, 21. februar 2025 ob 01:57:59 Srednjeevropski standardni =C4=8Das=
 je Andre Przywara napisal(a):
> The Allwinner Power Reset Clock Management (RPCM) block contains a few
> bits that control some power domains. The most prominent one is the one
> for the Mali GPU. On the Allwinner H6 this domain is enabled at reset, so
> we didn't care about it so far, but the H616 defaults to it being disable=
d.
>=20
> Add a power domain driver for those bits. Some BSP code snippets and
> some spare documentation describe three bits, slightly different between
> the H6 and H616, so add three power domains for each SoC, connected to
> their compatible string.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/pmdomain/sunxi/Kconfig              |  10 +
>  drivers/pmdomain/sunxi/Makefile             |   1 +
>  drivers/pmdomain/sunxi/sun50i-h6-prcm-ppu.c | 191 ++++++++++++++++++++
>  3 files changed, 202 insertions(+)
>  create mode 100644 drivers/pmdomain/sunxi/sun50i-h6-prcm-ppu.c
>=20
> diff --git a/drivers/pmdomain/sunxi/Kconfig b/drivers/pmdomain/sunxi/Kcon=
fig
> index 17781bf8d86d7..43eecb3ea9819 100644
> --- a/drivers/pmdomain/sunxi/Kconfig
> +++ b/drivers/pmdomain/sunxi/Kconfig
> @@ -8,3 +8,13 @@ config SUN20I_PPU
>  	help
>  	  Say y to enable the PPU power domain driver. This saves power
>  	  when certain peripherals, such as the video engine, are idle.
> +
> +config SUN50I_H6_PRCM_PPU
> +	tristate "Allwinner H6 PRCM power domain driver"
> +	depends on ARCH_SUNXI || COMPILE_TEST
> +	depends on PM
> +	select PM_GENERIC_DOMAINS
> +	help
> +	  Say y to enable the Allwinner H6/H616 PRCM power domain driver.
> +	  This is required to enable the Mali GPU in the H616 SoC, it is
> +	  optional for the H6.
> diff --git a/drivers/pmdomain/sunxi/Makefile b/drivers/pmdomain/sunxi/Mak=
efile
> index ec1d7a2fb21db..c1343e1237599 100644
> --- a/drivers/pmdomain/sunxi/Makefile
> +++ b/drivers/pmdomain/sunxi/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_SUN20I_PPU)		+=3D sun20i-ppu.o
> +obj-$(CONFIG_SUN50I_H6_PRCM_PPU)	+=3D sun50i-h6-prcm-ppu.o
> diff --git a/drivers/pmdomain/sunxi/sun50i-h6-prcm-ppu.c b/drivers/pmdoma=
in/sunxi/sun50i-h6-prcm-ppu.c
> new file mode 100644
> index 0000000000000..1c6b0c78b222d
> --- /dev/null
> +++ b/drivers/pmdomain/sunxi/sun50i-h6-prcm-ppu.c
> @@ -0,0 +1,191 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) Arm Ltd. 2024
> + *
> + * Allwinner H6/H616 PRCM power domain driver.
> + * This covers a few registers inside the PRCM (Power Reset Clock Manage=
ment)
> + * block that control some power rails, most prominently for the Mali GP=
U.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/reset.h>
> +
> +/*
> + * The PRCM block covers multiple devices, starting with some clocks,
> + * then followed by the power rails.
> + * The clocks are covered by a different driver, so this driver's MMIO r=
ange
> + * starts later in the PRCM MMIO frame, not at the beginning of it.
> + * To keep the register offsets consistent with other PRCM documentation,
> + * express the registers relative to the beginning of the whole PRCM, and
> + * subtract the PPU offset this driver is bound to.
> + */
> +#define PD_H6_PPU_OFFSET		0x250
> +#define PD_H6_VDD_SYS_REG		0x250
> +#define PD_H616_ANA_VDD_GATE			BIT(4)
> +#define PD_H6_CPUS_VDD_GATE			BIT(3)
> +#define PD_H6_AVCC_VDD_GATE			BIT(2)
> +#define PD_H6_GPU_REG			0x254
> +#define PD_H6_GPU_GATE				BIT(0)
> +
> +struct sun50i_h6_ppu_pd {
> +	struct generic_pm_domain	genpd;
> +	void __iomem			*reg;
> +	u32				gate_mask;
> +	bool				negated;
> +};
> +
> +#define FLAG_PPU_ALWAYS_ON	BIT(0)
> +#define FLAG_PPU_NEGATED	BIT(1)
> +
> +struct sun50i_h6_ppu_desc {
> +	const char *name;
> +	u32 offset;
> +	u32 mask;
> +	unsigned int flags;
> +};
> +
> +struct sun50i_h6_ppu_desc sun50i_h6_ppus[] =3D {
> +	{ "AVCC", PD_H6_VDD_SYS_REG, PD_H6_AVCC_VDD_GATE },
> +	{ "CPUS", PD_H6_VDD_SYS_REG, PD_H6_CPUS_VDD_GATE },
> +	{ "GPU", PD_H6_GPU_REG, PD_H6_GPU_GATE },
> +	{}
> +};
> +
> +struct sun50i_h6_ppu_desc sun50i_h616_ppus[] =3D {
> +	{ "PLL", PD_H6_VDD_SYS_REG, PD_H6_AVCC_VDD_GATE,
> +		FLAG_PPU_ALWAYS_ON | FLAG_PPU_NEGATED },
> +	{ "ANA", PD_H6_VDD_SYS_REG, PD_H616_ANA_VDD_GATE, FLAG_PPU_ALWAYS_ON },
> +	{ "GPU", PD_H6_GPU_REG, PD_H6_GPU_GATE, FLAG_PPU_NEGATED },
> +	{}
> +};
> +#define to_sun50i_h6_ppu_pd(_genpd) \
> +	container_of(_genpd, struct sun50i_h6_ppu_pd, genpd)
> +
> +static bool sun50i_h6_ppu_power_status(const struct sun50i_h6_ppu_pd *pd)
> +{
> +	bool bit =3D readl(pd->reg) & pd->gate_mask;
> +
> +	return bit ^ pd->negated;
> +}
> +
> +static int sun50i_h6_ppu_pd_set_power(const struct sun50i_h6_ppu_pd *pd,
> +				      bool set_bit)
> +{
> +	u32 reg =3D readl(pd->reg);
> +
> +	if (set_bit)
> +		writel(reg | pd->gate_mask, pd->reg);
> +	else
> +		writel(reg & ~pd->gate_mask, pd->reg);
> +
> +	return 0;
> +}
> +
> +static int sun50i_h6_ppu_pd_power_on(struct generic_pm_domain *genpd)
> +{
> +	const struct sun50i_h6_ppu_pd *pd =3D to_sun50i_h6_ppu_pd(genpd);
> +
> +	return sun50i_h6_ppu_pd_set_power(pd, !pd->negated);
> +}
> +
> +static int sun50i_h6_ppu_pd_power_off(struct generic_pm_domain *genpd)
> +{
> +	const struct sun50i_h6_ppu_pd *pd =3D to_sun50i_h6_ppu_pd(genpd);
> +
> +	return sun50i_h6_ppu_pd_set_power(pd, pd->negated);
> +}
> +
> +static int sun50i_h6_ppu_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct genpd_onecell_data *ppu;
> +	struct sun50i_h6_ppu_pd *pds;
> +	const struct sun50i_h6_ppu_desc *desc;
> +	void __iomem *base;
> +	int ret, i, count;
> +
> +	desc =3D of_device_get_match_data(dev);
> +	if (!desc)
> +		return -EINVAL;
> +
> +	for (count =3D 0; desc[count].name; count++)
> +		;
> +
> +	pds =3D devm_kcalloc(dev, count, sizeof(*pds), GFP_KERNEL);
> +	if (!pds)
> +		return -ENOMEM;
> +
> +	ppu =3D devm_kzalloc(dev, sizeof(*ppu), GFP_KERNEL);
> +	if (!ppu)
> +		return -ENOMEM;
> +
> +	ppu->num_domains =3D count;
> +	ppu->domains =3D devm_kcalloc(dev, count, sizeof(*ppu->domains),
> +				    GFP_KERNEL);
> +	if (!ppu->domains)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, ppu);
> +
> +	base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	for (i =3D 0; i < count; i++) {
> +		struct sun50i_h6_ppu_pd *pd =3D &pds[i];
> +
> +		pd->genpd.name		=3D desc[i].name;
> +		pd->genpd.power_off	=3D sun50i_h6_ppu_pd_power_off;
> +		pd->genpd.power_on	=3D sun50i_h6_ppu_pd_power_on;
> +		if (desc[i].flags & FLAG_PPU_ALWAYS_ON)
> +			pd->genpd.flags =3D GENPD_FLAG_ALWAYS_ON;
> +		pd->negated		=3D !!(desc[i].flags & FLAG_PPU_NEGATED);
> +		pd->reg			=3D base + desc[i].offset - PD_H6_PPU_OFFSET;
> +		pd->gate_mask		=3D desc[i].mask;
> +
> +		ret =3D pm_genpd_init(&pd->genpd, NULL,
> +				    !sun50i_h6_ppu_power_status(pd));
> +		if (ret) {
> +			dev_warn(dev, "Failed to add GPU power domain: %d\n", ret);

I suppose you want to replace "GPU" with desc[i].name.

Otherwise it looks good to me, but I'd like to hear a comment from genpd ma=
intainers.

Best regards,
Jernej

> +			return ret;
> +		}
> +		ppu->domains[i] =3D &pd->genpd;
> +	}
> +
> +	ret =3D of_genpd_add_provider_onecell(dev->of_node, ppu);
> +	if (ret)
> +		dev_warn(dev, "Failed to add provider: %d\n", ret);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sun50i_h6_ppu_of_match[] =3D {
> +	{ .compatible	=3D "allwinner,sun50i-h6-prcm-ppu",
> +	  .data		=3D &sun50i_h6_ppus },
> +	{ .compatible	=3D "allwinner,sun50i-h616-prcm-ppu",
> +	  .data		=3D &sun50i_h616_ppus },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, sun50i_h6_ppu_of_match);
> +
> +static struct platform_driver sun50i_h6_ppu_driver =3D {
> +	.probe	=3D sun50i_h6_ppu_probe,
> +	.driver	=3D {
> +		.name			=3D "sun50i-h6-prcm-ppu",
> +		.of_match_table		=3D sun50i_h6_ppu_of_match,
> +		/* Power domains cannot be removed while they are in use. */
> +		.suppress_bind_attrs	=3D true,
> +	},
> +};
> +module_platform_driver(sun50i_h6_ppu_driver);
> +
> +MODULE_AUTHOR("Andre Przywara <andre.przywara@arm.com>");
> +MODULE_DESCRIPTION("Allwinner H6 PRCM power domain driver");
> +MODULE_LICENSE("GPL");
>=20





