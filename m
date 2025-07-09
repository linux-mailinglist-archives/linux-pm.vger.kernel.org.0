Return-Path: <linux-pm+bounces-30452-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BBCAFE69B
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 12:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA19B7BFD4E
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 10:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E577290D85;
	Wed,  9 Jul 2025 10:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ztj/Y7XW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93BF2900A0
	for <linux-pm@vger.kernel.org>; Wed,  9 Jul 2025 10:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752058235; cv=none; b=pQdFR89y8YyjHS4Dei87/qcX5qZKaVw6/8qMSMUYaG3vt9GiqZSl19FpOGzas+WOLhfsJ2gONkjCoxOnx4LAPfVpfBJntBX3fPKQNz/SrI9CPvm/CMrgxDbVxK8KTkmXZAn8y8efY31FwdPga0V38TAh23G7KcQsrXAbFvBWthc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752058235; c=relaxed/simple;
	bh=20MhIzRY2AyJ9XJ1/eBU5b/g3UY03b/8twJbvERsAxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BTmuOq3pj9a1XGeskF/XHd2BIseYHzhLDvTvJuR/6C2VByJMfBmNSeLXbR3wpdtMSgpHM7NaASgrVWWtzhqxnPMRsl/rBDtd2v+uU3nmsg/yumdrj/spajP4qWwJ/5cpny/AsKMZDHtn/XHnulv2v59TwrXALkN5P0x3WEh44jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ztj/Y7XW; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e812c817de0so4227285276.0
        for <linux-pm@vger.kernel.org>; Wed, 09 Jul 2025 03:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752058233; x=1752663033; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H/pT7QtJ2y0Yr0sbQcrQgyeiPZXfJWqL9UzWbCaU/Ws=;
        b=Ztj/Y7XWTlt17C15XdqD4UbID3Ev3OweHn/254RhdrVXgM9tM8mUGymkb1z1gEdDul
         3XF/XhdYmpnu1LBy+rcZfWYTEGJinKf1QN/WRGyBeSkrefkSkQEz3nTrI9SgQkbvr0Ob
         zeTyvnWhoGS3BStBANIIJeujhOoMNJszNBXHnMLJJ3At2un+ZTzOIjibTGuHlzk0Z0Qh
         S5iR7tYPdUEoL39lTureok246R/BDIppFpL7IRSanrV76f5Je1w8JuZF5SKMpqvYycdZ
         SFjkuIw4hJtB4ikoCYcrAxCYwTkTY10CeMzVxT/+BNeiXGw8xFV1DItPCQe3Aa4xaG48
         b0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752058233; x=1752663033;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H/pT7QtJ2y0Yr0sbQcrQgyeiPZXfJWqL9UzWbCaU/Ws=;
        b=NXLghvFjGnYDngZXhNF1ymY7vIG04Z4TpwPWrSQR5xHQJsrtqrRkBE1D7bXOvShTZe
         V0gg+JamI3Dkz/8pch1gT6SPeBsnfAfxkbny46cxdmFNpi8xBrKcRSbgXNWzYmFwGaDE
         Imwx0kh8ov69gwyXqbe3W08qvF0Rwak5waVjJcMo4d8kRXRrmfI4GPBXcGdoKmZPYHQH
         l3pjPEP3llj0RtLZinWoJxihcGbupx0W8dVWOnzFbW22bBHyedFmmWSq9NvDwZ0kcTAf
         3vEgrVK/Y24oa8QJZtIXK+WDNW8KIONy7L7sOgdhd+SJ5b46naP8B6/VMHO3V7eByDoz
         fQtQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3TjDlH/yM2CtJdQf4RP++XK7d9UwP0Up0CwTcuCHbAtXEWoXAzNp5FezrInUmLYMaS2Imfri+TA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIY6TKgkj1u97mVm2rqbqwmjSzn87rQgyOdHTRIow3pcaaQ5jU
	9MsG3w5TLKggdr2yRicXpnlGs2NLkeEC+eKHnRI3dRkAc8AChCynOddGZFf15383OuXwBwF+iFD
	9tq7oyo7HJJG4P5SC3Ht3QqIl9ZNVeCk4ruXWWiKolw==
X-Gm-Gg: ASbGncuV9Dz/Lan6DTyoXf8aZPKAJOlX6RA+dDv2h942PRGkwl9Ae5QsF+nBLQ5kXT2
	lXO5l7u+6jOoTugWTZ6wMHgCeI1ax8GwMY8o5NH7GVWIzdGtD02GdTohm7mmeGNoTmORSk0i9af
	eAfhGszE4BmEjfWpSR3L2omgNGwvilmfwCny+3/fy4Uq+2
X-Google-Smtp-Source: AGHT+IHAPAQxqp/QmTpsCbt8oJ83U9lsBh3ufrR1BZRofloQKbNtdV7YaGBiyqejPkvhxc8BDmk63wAJKW/bpKUN3RQ=
X-Received: by 2002:a05:690c:9a8b:b0:710:e8a8:771d with SMTP id
 00721157ae682-717b1984909mr29729677b3.24.1752058232542; Wed, 09 Jul 2025
 03:50:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627152918.2606728-1-wens@kernel.org> <20250627152918.2606728-4-wens@kernel.org>
In-Reply-To: <20250627152918.2606728-4-wens@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Jul 2025 12:49:56 +0200
X-Gm-Features: Ac12FXyZZo_gyxde5PGaFmAK7RtmqIBsI-DO5q6_JvOlmtCvpbCBgiSF25u2wFY
Message-ID: <CAPDyKFpqjd-KapYizxPD_=6TmNd7ZHZQVtVTPq_3u+ZutiO0pg@mail.gmail.com>
Subject: Re: [PATCH 3/4] pmdomain: sunxi: add driver for Allwinner A523's
 PCK-600 power controller
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej@kernel.org>, 
	Samuel Holland <samuel@sholland.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andre Przywara <andre.przywara@arm.com>, linux-sunxi@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Jun 2025 at 17:29, Chen-Yu Tsai <wens@kernel.org> wrote:
>
> From: Chen-Yu Tsai <wens@csie.org>
>
> Allwinner A523 family has a second power controller, named PCK-600 in
> the datasheets and BSP. It is likely based on ARM's PCK-600 hardware
> block, with some additional delay controls. The only documentation for
> this hardware is the BSP driver. The standard registers defined in ARM's
> Power Policy Unit Architecture Specification line up. Some extra delay
> controls are found in the reserved range of registers.
>
> Add a driver for this power controller. Delay control register values
> and power domain names are from the BSP driver.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

FYI, this looks good to me.

Kind regards
Uffe

> ---
>  drivers/pmdomain/sunxi/Kconfig         |   8 +
>  drivers/pmdomain/sunxi/Makefile        |   1 +
>  drivers/pmdomain/sunxi/sun55i-pck600.c | 225 +++++++++++++++++++++++++
>  3 files changed, 234 insertions(+)
>  create mode 100644 drivers/pmdomain/sunxi/sun55i-pck600.c
>
> diff --git a/drivers/pmdomain/sunxi/Kconfig b/drivers/pmdomain/sunxi/Kconfig
> index 43eecb3ea981..3e2b77cd9a2b 100644
> --- a/drivers/pmdomain/sunxi/Kconfig
> +++ b/drivers/pmdomain/sunxi/Kconfig
> @@ -18,3 +18,11 @@ config SUN50I_H6_PRCM_PPU
>           Say y to enable the Allwinner H6/H616 PRCM power domain driver.
>           This is required to enable the Mali GPU in the H616 SoC, it is
>           optional for the H6.
> +
> +config SUN55I_PCK600
> +       bool "Allwinner A523 PCK-600 power domain driver"
> +       depends on PM
> +       select PM_GENERIC_DOMAINS
> +       help
> +         Say y to enable the PCK-600 power domain driver. This saves power
> +         when certain peripherals, such as the video engine, are idle.
> diff --git a/drivers/pmdomain/sunxi/Makefile b/drivers/pmdomain/sunxi/Makefile
> index c1343e123759..e344b232fc9f 100644
> --- a/drivers/pmdomain/sunxi/Makefile
> +++ b/drivers/pmdomain/sunxi/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_SUN20I_PPU)               += sun20i-ppu.o
>  obj-$(CONFIG_SUN50I_H6_PRCM_PPU)       += sun50i-h6-prcm-ppu.o
> +obj-$(CONFIG_SUN55I_PCK600)            += sun55i-pck600.o
> diff --git a/drivers/pmdomain/sunxi/sun55i-pck600.c b/drivers/pmdomain/sunxi/sun55i-pck600.c
> new file mode 100644
> index 000000000000..7248f6113665
> --- /dev/null
> +++ b/drivers/pmdomain/sunxi/sun55i-pck600.c
> @@ -0,0 +1,225 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Allwinner PCK-600 power domain support
> + *
> + * Copyright (c) 2025 Chen-Yu Tsai <wens@csie.org>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/container_of.h>
> +#include <linux/device.h>
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +#include <linux/string_choices.h>
> +
> +#define PPU_PWPR    0x0
> +#define PPU_PWSR    0x8
> +#define        PPU_DCDR0   0x170
> +#define PPU_DCDR1   0x174
> +
> +#define PPU_PWSR_PWR_STATUS    GENMASK(3, 0)
> +#define PPU_POWER_MODE_ON      0x8
> +#define PPU_POWER_MODE_OFF     0x0
> +
> +#define PPU_REG_SIZE   0x1000
> +
> +struct sunxi_pck600_desc {
> +       const char * const *pd_names;
> +       unsigned int num_domains;
> +       u32 logic_power_switch0_delay_offset;
> +       u32 logic_power_switch1_delay_offset;
> +       u32 off2on_delay_offset;
> +       u32 device_ctrl0_delay;
> +       u32 device_ctrl1_delay;
> +       u32 logic_power_switch0_delay;
> +       u32 logic_power_switch1_delay;
> +       u32 off2on_delay;
> +};
> +
> +struct sunxi_pck600_pd {
> +       struct generic_pm_domain genpd;
> +       struct sunxi_pck600 *pck;
> +       void __iomem *base;
> +};
> +
> +struct sunxi_pck600 {
> +       struct device *dev;
> +       struct genpd_onecell_data genpd_data;
> +       struct sunxi_pck600_pd pds[];
> +};
> +
> +#define to_sunxi_pd(gpd) container_of(gpd, struct sunxi_pck600_pd, genpd)
> +
> +static int sunxi_pck600_pd_set_power(struct sunxi_pck600_pd *pd, bool on)
> +{
> +       struct sunxi_pck600 *pck = pd->pck;
> +       struct generic_pm_domain *genpd = &pd->genpd;
> +       int ret;
> +       u32 val, reg;
> +
> +       val = on ? PPU_POWER_MODE_ON : PPU_POWER_MODE_OFF;
> +
> +       reg = readl(pd->base + PPU_PWPR);
> +       FIELD_MODIFY(PPU_PWSR_PWR_STATUS, &reg, val);
> +       writel(reg, pd->base + PPU_PWPR);
> +
> +       /* push write out to hardware */
> +       reg = readl(pd->base + PPU_PWPR);
> +
> +       ret = readl_poll_timeout_atomic(pd->base + PPU_PWSR, reg,
> +                                       FIELD_GET(PPU_PWSR_PWR_STATUS, reg) == val,
> +                                       0, 10000);
> +       if (ret)
> +               dev_err(pck->dev, "failed to turn domain \"%s\" %s: %d\n",
> +                       genpd->name, str_on_off(on), ret);
> +
> +       return ret;
> +}
> +
> +static int sunxi_pck600_power_on(struct generic_pm_domain *domain)
> +{
> +       struct sunxi_pck600_pd *pd = to_sunxi_pd(domain);
> +
> +       return sunxi_pck600_pd_set_power(pd, true);
> +}
> +
> +static int sunxi_pck600_power_off(struct generic_pm_domain *domain)
> +{
> +       struct sunxi_pck600_pd *pd = to_sunxi_pd(domain);
> +
> +       return sunxi_pck600_pd_set_power(pd, false);
> +}
> +
> +static void sunxi_pck600_pd_setup(struct sunxi_pck600_pd *pd,
> +                                 const struct sunxi_pck600_desc *desc)
> +{
> +       writel(desc->device_ctrl0_delay, pd->base + PPU_DCDR0);
> +       writel(desc->device_ctrl1_delay, pd->base + PPU_DCDR1);
> +       writel(desc->logic_power_switch0_delay,
> +              pd->base + desc->logic_power_switch0_delay_offset);
> +       writel(desc->logic_power_switch1_delay,
> +              pd->base + desc->logic_power_switch1_delay_offset);
> +       writel(desc->off2on_delay, pd->base + desc->off2on_delay_offset);
> +}
> +
> +static int sunxi_pck600_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       const struct sunxi_pck600_desc *desc;
> +       struct genpd_onecell_data *genpds;
> +       struct sunxi_pck600 *pck;
> +       struct reset_control *rst;
> +       struct clk *clk;
> +       void __iomem *base;
> +       int i, ret;
> +
> +       desc = of_device_get_match_data(dev);
> +
> +       pck = devm_kzalloc(dev, struct_size(pck, pds, desc->num_domains), GFP_KERNEL);
> +       if (!pck)
> +               return -ENOMEM;
> +
> +       pck->dev = &pdev->dev;
> +       platform_set_drvdata(pdev, pck);
> +
> +       genpds = &pck->genpd_data;
> +       genpds->num_domains = desc->num_domains;
> +       genpds->domains = devm_kcalloc(dev, desc->num_domains,
> +                                      sizeof(*genpds->domains), GFP_KERNEL);
> +       if (!genpds->domains)
> +               return -ENOMEM;
> +
> +       base = devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
> +       rst = devm_reset_control_get_exclusive_released(dev, NULL);
> +       if (IS_ERR(rst))
> +               return dev_err_probe(dev, PTR_ERR(rst), "failed to get reset control\n");
> +
> +       clk = devm_clk_get_enabled(dev, NULL);
> +       if (IS_ERR(clk))
> +               return dev_err_probe(dev, PTR_ERR(clk), "failed to get clock\n");
> +
> +       for (i = 0; i < desc->num_domains; i++) {
> +               struct sunxi_pck600_pd *pd = &pck->pds[i];
> +
> +               pd->genpd.name = desc->pd_names[i];
> +               pd->genpd.power_off = sunxi_pck600_power_off;
> +               pd->genpd.power_on = sunxi_pck600_power_on;
> +               pd->base = base + PPU_REG_SIZE * i;
> +
> +               sunxi_pck600_pd_setup(pd, desc);
> +               ret = pm_genpd_init(&pd->genpd, NULL, false);
> +               if (ret) {
> +                       dev_err_probe(dev, ret, "failed to initialize power domain\n");
> +                       goto err_remove_pds;
> +               }
> +
> +               genpds->domains[i] = &pd->genpd;
> +       }
> +
> +       ret = of_genpd_add_provider_onecell(dev_of_node(dev), genpds);
> +       if (ret) {
> +               dev_err_probe(dev, ret, "failed to add PD provider\n");
> +               goto err_remove_pds;
> +       }
> +
> +       return 0;
> +
> +err_remove_pds:
> +       for (i--; i >= 0; i--)
> +               pm_genpd_remove(genpds->domains[i]);
> +
> +       return ret;
> +}
> +
> +static const char * const sun55i_a523_pck600_pd_names[] = {
> +       "VE", "GPU", "VI", "VO0", "VO1", "DE", "NAND", "PCIE"
> +};
> +
> +static const struct sunxi_pck600_desc sun55i_a523_pck600_desc = {
> +       .pd_names = sun55i_a523_pck600_pd_names,
> +       .num_domains = ARRAY_SIZE(sun55i_a523_pck600_pd_names),
> +       .logic_power_switch0_delay_offset = 0xc00,
> +       .logic_power_switch1_delay_offset = 0xc04,
> +       .off2on_delay_offset = 0xc10,
> +       .device_ctrl0_delay = 0xffffff,
> +       .device_ctrl1_delay = 0xffff,
> +       .logic_power_switch0_delay = 0x8080808,
> +       .logic_power_switch1_delay = 0x808,
> +       .off2on_delay = 0x8
> +};
> +
> +static const struct of_device_id sunxi_pck600_of_match[] = {
> +       {
> +               .compatible     = "allwinner,sun55i-a523-pck-600",
> +               .data           = &sun55i_a523_pck600_desc,
> +       },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, sunxi_pck600_of_match);
> +
> +static struct platform_driver sunxi_pck600_driver = {
> +       .probe = sunxi_pck600_probe,
> +       .driver = {
> +               .name   = "sunxi-pck-600",
> +               .of_match_table = sunxi_pck600_of_match,
> +               /* Power domains cannot be removed if in use. */
> +               .suppress_bind_attrs = true,
> +       },
> +};
> +module_platform_driver(sunxi_pck600_driver);
> +
> +MODULE_DESCRIPTION("Allwinner PCK-600 power domain driver");
> +MODULE_AUTHOR("Chen-Yu Tsai <wens@csie.org>");
> +MODULE_LICENSE("GPL");
> --
> 2.39.5
>

